A setup for conducting data science interviews using the [IMDB dataset](https://www.kaggle.com/datasets/ashirwadsangwan/imdb-dataset).

Components:
- Data cleaning script
- MySQL database schemas
- Jupyter notebook for exercises

## Prerequistes

- Python 3 and packages in `requirements.txt`
- Docker (technically optional, but this tutorial MySQL setup uses Docker)

## Setup

Create additional directories `data_raw/` and `data_clean/`. Download the [IMDB dataset](https://www.kaggle.com/datasets/ashirwadsangwan/imdb-dataset) and format it accordingly as below.
```
eval
├── ...
├── data_clean/
└── data_raw/
    ├── name.basics.tsv
    ├── title.akas.tsv
    ├── title.basics.tsv
    ├── title.principals.tsv
    └── titles.ratings.tsv
```

You can then run the Python script that will process the data and output it to `data_clean/`.
```sh
$ python clean.py
```

Replace `/path/to/this/repo/` with the absolute path to this cloned repository on your machine. You can change the password to whatever you want.
```sh
$ docker run --name imdb1 -e MYSQL_ROOT_PASSWORD="pass" -v /path/to/this/repo/:/src/:ro -d mysql:8.0
```

Enter the MySQL container.
```sh
$ docker exec -it imdb1 bash
$ mysql --local-infile=1 -uroot -p'pass'
```

Run the SQL to create the tables, load the data, create constraints and index.
```sh
mysql> SOURCE /src/init.sql
mysql> SOURCE /src/load.sql
mysql> SOURCE /src/constraints.sql
mysql> SOURCE /src/index.sql
```
