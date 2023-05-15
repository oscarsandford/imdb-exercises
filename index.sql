CREATE INDEX aliases_index ON alises(title_id);
CREATE INDEX attrs_index ON attrs(title_id);
CREATE INDEX types_index ON types(title_id);

CREATE INDEX titles_index ON titles(title_id);
CREATE INDEX genres_index ON genres(title_id);

CREATE INDEX jobs_title_index ON jobs(title_id);
CREATE INDEX jobs_person_index ON jobs(person_id);

CREATE INDEX ratings_index ON ratings(title_id);

CREATE INDEX persons_index ON persons(person_id);
CREATE INDEX known_for_jobs_index ON known_for_jobs(person_id);
CREATE INDEX known_for_titles_index ON known_for_titles(person_id);