import pandas as pd


def clean_title_akas():

    df = pd.read_csv("data_raw/title.akas.tsv",
        dtype={
            "titleId": "str",
            "ordering": "int",
            "title": "str",
            "region": "str",
            "language": "str",
            "types": "str",
            "attributes": "str",
            "isOriginalTitle": "Int64"
        },
        sep="\t", na_values="\\N", quoting=3)

    df = df.rename(columns={
        "titleId" : "title_id",
        "isOriginalTitle" : "is_original_title",
        "types" : "type", # for later
        "attributes" : "attr" # for later
    })

    df["is_original_title"] = df["is_original_title"].dropna().astype("bool")
    df = df.dropna()

    # Segregate
    aliases = df[["title_id", "ordering", "title", "region", "language", "is_original_title"]]
    types = df[["title_id", "ordering", "type"]]
    attrs = df[["title_id", "ordering", "attr"]]

    # Expand and refresh indexing
    types = types.assign(type=types.type.str.split(" ")).explode("type").reset_index(drop=True)
    attrs = attrs.assign(attr=attrs.attr.str.split(" ")).explode("attr").reset_index(drop=True)

    print("  >> Writing data_clean/imdb_aliases.csv")
    aliases.to_csv("data_clean/imdb_aliases.csv", index=False, na_rep=r"", sep=",")
    print("  >> Writing data_clean/imdb_types.csv")
    types.to_csv("data_clean/imdb_types.csv", index=False, na_rep=r"", sep=",")
    print("  >> Writing data_clean/imdb_attrs.csv")
    attrs.to_csv("data_clean/imdb_attrs.csv", index=False, na_rep=r"", sep=",")



def clean_title_basics():

    df = pd.read_csv("data_raw/title.basics.tsv",
        dtype={
            "tconst": "str",
            "titleType": "str",
            "primaryTitle": "str",
            "originalTitle": "str",
            "isAdult": "str",
            "startYear": "Int64",
            "endYear": "Int64",
            "runtimeMinutes": "Int64",
            "genres": "str",
        },
        sep="\t", na_values="\\N", quoting=3)

    # Drop all adult titles and then drop the label entirely
    df = df.drop(df[df.isAdult != "0"].index)
    df = df.drop("isAdult", axis=1)

    df = df.rename(columns={
        "tconst" : "title_id",
        "titleType" : "title_type",
        "primaryTitle" : "primary_title", 
        "originalTitle" : "original_title",
        "startYear": "start_year",
        "endYear": "end_year",
        "runtimeMinutes": "runtime_minutes",
        "genres": "genre" # for later
    })

    titles = df[["title_id", "title_type", "primary_title", "original_title", "start_year", "end_year", "runtime_minutes"]]
    genres = df[["title_id", "genre"]]

    genres = genres.assign(genre=genres.genre.str.split(",")).explode("genre").reset_index(drop=True)

    print("  >> Writing data_clean/imdb_titles.csv")
    titles.to_csv("data_clean/imdb_titles.csv", index=False, na_rep=r"", sep=",")
    print("  >> Writing data_clean/imdb_genres.csv")
    genres.to_csv("data_clean/imdb_genres.csv", index=False, na_rep=r"", sep=",")



def clean_title_principals():
    df = pd.read_csv("data_raw/title.principals.tsv",
        dtype={
            "tconst": "str",
            "ordering": "int",
            "nconst": "str",
            "category": "str",
            "job": "str",
            "characters": "str"
        },
        sep="\t", na_values="\\N", quoting=3)
    
    df= df.rename(columns={
        "tconst": "title_id",
        "nconst": "person_id",
        "job": "title",
        # "characters": "characters" # for later
    })

    # jobs = df[["title_id", "ordering", "person_id", "category", "title"]]
    # characters = df[["title_id", "person_id", "characters"]]

    # Uses too much memory!
    # characters["name"] = characters["name"].str.split(",").explode("name", ignore_index=True)

    print("  >> Writing data_clean/imdb_jobs.csv")
    df.to_csv("data_clean/imdb_jobs.csv", index=False, na_rep=r"", sep=",")
    # jobs.to_csv("data_clean/imdb_jobs.csv", index=False, na_rep=r"", sep=",")
    # print("  >> Writing data_clean/imdb_characters.csv")
    # characters.to_csv("data_clean/imdb_characters.csv", index=False, na_rep=r"", sep=",")



def clean_title_ratings():
    df = pd.read_csv("data_raw/title.ratings.tsv",
        dtype={
            "tconst": "str",
            "averageRating": "float",
            "numVotes": "int"
        },
        sep="\t", na_values="\\N", quoting=3)
    
    ratings = df.rename(columns={
        "tconst": "title_id",
        "averageRating": "avg_rating",
        "numVotes": "num_votes"
    })

    print("  >> Writing data_clean/imdb_ratings.csv")
    ratings.to_csv("data_clean/imdb_ratings.csv", index=False, na_rep=r"", sep=",")



def clean_name_basics():
    df = pd.read_csv("data_raw/name.basics.tsv",
        dtype={
            "nconst": "str",
            "primaryName": "str",
            "birthYear": "Int64",
            "deathYear": "Int64",
            "primaryProfession": "str",
            "knownForTitles": "str"
        },
        sep="\t", na_values="\\N", quoting=3)
    
    df = df.rename(columns={
        "nconst": "person_id",
        "primaryName": "name",
        "birthYear": "birth_year",
        "deathYear": "death_year",
        "primaryProfession": "job", # for later
        "knownForTitles": "title_id" # for later
    })

    # split into first and last name
    df = df.join(df["name"].str.split(" ", n=1, expand=True).rename(columns={0: "first_name", 1: "last_name"}))
    df = df.drop("name", axis=1)

    persons = df[["person_id", "first_name", "last_name", "birth_year", "death_year"]]
    known_for_jobs = df[["person_id", "job"]]
    known_for_titles = df[["person_id", "title_id"]]

    known_for_jobs = known_for_jobs.assign(job=known_for_jobs.job.str.split(",")).explode("job").reset_index(drop=True)
    known_for_titles = known_for_titles.assign(title_id=known_for_titles.title_id.str.split(",")).explode("title_id").reset_index(drop=True)

    print("  >> Writing data_clean/imdb_persons.csv")
    persons.to_csv("data_clean/imdb_persons.csv", index=False, na_rep=r"", sep=",")
    print("  >> Writing data_clean/imdb_known_for_jobs.csv")
    known_for_jobs.to_csv("data_clean/imdb_known_for_jobs.csv", index=False, na_rep=r"", sep=",")
    print("  >> Writing data_clean/imdb_known_for_titles.csv")
    known_for_titles.to_csv("data_clean/imdb_known_for_titles.csv", index=False, na_rep=r"", sep=",")



if __name__ == "__main__":
    print("Cleaning data_raw/name.basics.tsv")
    clean_name_basics()
    print("Cleaning data_raw/title.akas.tsv")
    clean_title_akas()
    print("Cleaning data_raw/title.basics.tsv")
    clean_title_basics()
    print("Cleaning data_raw/title.principals.tsv")
    clean_title_principals()
    print("Cleaning data_raw/title.ratings.tsv")
    clean_title_ratings()
    print("Done!")
