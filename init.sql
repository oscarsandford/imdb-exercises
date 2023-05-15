-- Delete imdb database if necessary
DROP DATABASE IF EXISTS imdb;

-- Create imdb database

CREATE DATABASE imdb;

-- Use imdb database

USE imdb;

-- Character set
-- want to be able to distinguish text with accents
ALTER DATABASE imdb CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- 
-- title.akas.tsv.gz
-- 

CREATE TABLE aliases (
  title_id           VARCHAR(255) NOT NULL, -- pk
  ordering           INTEGER NOT NULL, -- not null bc PK
  title              TEXT,
  region             CHAR(4),
  language           CHAR(4),
  is_original_title  BOOLEAN
);
-- refs aliases
CREATE TABLE types (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  ordering			INTEGER NOT NULL, -- not null bc PK
  type				  VARCHAR(255) NOT NULL-- Only stored if not null
);
-- refs aliases
CREATE TABLE attrs (
  title_id			VARCHAR(255) NOT NULL, -- not null bc PK
  ordering			INTEGER NOT NULL, -- not null bc PK
  attr			    VARCHAR(255) NOT NULL -- only stored if not null
);

-- 
-- title.basics.tsv.gz
-- 

CREATE table titles (
  title_id         VARCHAR(255) NOT NULL,
  title_type       VARCHAR(255),
  primary_title    TEXT,
  original_title   TEXT,
  start_year       INTEGER,
  end_year         INTEGER,
  runtime_minutes  INTEGER
);
-- refs titles
CREATE TABLE genres (
  title_id   VARCHAR(255) NOT NULL, -- not null bc PK
  genre      VARCHAR(255) NOT NULL
);

-- 
-- title.principals.tsv.gz - Contains the principal cast/crew for titles
-- 

CREATE TABLE jobs (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  ordering			INTEGER NOT NULL, -- not null bc PK
  person_id     VARCHAR(255) NOT NULL, -- PK
  category      TEXT,
  job           VARCHAR(255),
  characters    TEXT
);

-- CREATE TABLE characters (
--   title_id         VARCHAR(255) NOT NULL, -- PK
--   person_id        VARCHAR(255) NOT NULL, -- PK
--   characters       TEXT
-- );

-- 
-- title.ratings.tsv.gz
-- 

CREATE TABLE ratings (
  title_id 			  VARCHAR(255) NOT NULL, -- not null bc PK
  average_rating	FLOAT,
  num_votes			  INTEGER
);

-- 
-- name.basics.tsv.gz
-- 

CREATE TABLE persons (
  person_id        VARCHAR(255) NOT NULL,
  first_name       TEXT,
  last_name        TEXT,
  birth_year       INTEGER,
  death_year       INTEGER
);

CREATE TABLE known_for_jobs (
  person_id        VARCHAR(255) NOT NULL, -- ref person
  job              VARCHAR(255) NOT NULL
);

CREATE TABLE known_for_titles (
  person_id        VARCHAR(255) NOT NULL,
  title_id         VARCHAR(255) NOT NULL
);