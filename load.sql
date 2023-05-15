SET GLOBAL local_infile=1;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_aliases.csv'
INTO TABLE imdb.aliases
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_types.csv'
INTO TABLE imdb.types
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_attrs.csv'
INTO TABLE imdb.attrs
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_titles.csv'
INTO TABLE imdb.titles
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_genres.csv'
INTO TABLE imdb.genres
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_jobs.csv'
INTO TABLE imdb.jobs
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_ratings.csv'
INTO TABLE imdb.ratings
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_persons.csv'
INTO TABLE imdb.persons
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_known_for_jobs.csv'
INTO TABLE imdb.known_for_jobs
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE  '/src/data_clean/imdb_known_for_titles.csv'
INTO TABLE imdb.known_for_titles
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SET GLOBAL local_infile=0;