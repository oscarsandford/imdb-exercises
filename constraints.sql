-- PKs

ALTER TABLE aliases ADD CONSTRAINT aliases_pk PRIMARY KEY (title_id, ordering);
ALTER TABLE types ADD CONSTRAINT types_pk PRIMARY KEY (title_id, ordering);
ALTER TABLE attrs ADD CONSTRAINT types_pk PRIMARY KEY (title_id, ordering);

ALTER TABLE titles ADD CONSTRAINT titles_pk PRIMARY KEY (title_id);
ALTER TABLE genres ADD CONSTRAINT genres_pk PRIMARY KEY (title_id, genre);

ALTER TABLE jobs ADD CONSTRAINT jobs_pk PRIMARY KEY (title_id, ordering, person_id);

ALTER TABLE ratings ADD CONSTRAINT ratings_pk PRIMARY KEY (title_id);

ALTER TABLE persons ADD CONSTRAINT persons_pk PRIMARY KEY (person_id);

ALTER TABLE known_for_jobs ADD CONSTRAINT known_for_jobs_pk PRIMARY KEY (person_id, job);
ALTER TABLE known_for_titles ADD CONSTRAINT known_for_titles_pk PRIMARY KEY (person_id, title_id);

-- FKs

SET foreign_key_checks = 0;

ALTER TABLE aliases ADD CONSTRAINT aliases_fk FOREIGN KEY (title_id) REFERENCES titles(title_id);
ALTER TABLE types ADD CONSTRAINT types_fk FOREIGN KEY (title_id) REFERENCES aliases(title_id);
ALTER TABLE attrs ADD CONSTRAINT attrs_fk FOREIGN KEY (title_id) REFERENCES aliases(title_id);

ALTER TABLE genres ADD CONSTRAINT genres_fk FOREIGN KEY (title_id) REFERENCES titles(title_id);

ALTER TABLE jobs ADD CONSTRAINT jobs_title_fk FOREIGN KEY (title_id) REFERENCES titles(title_id);
ALTER TABLE jobs ADD CONSTRAINT jobs_person_fk FOREIGN KEY (person_id) REFERENCES persons(person_id);

ALTER TABLE ratings ADD CONSTRAINT ratings_fk FOREIGN KEY (title_id) REFERENCES titles(title_id);

ALTER TABLE known_for_jobs ADD CONSTRAINT known_for_jobs_fk FOREIGN KEY (person_id) REFERENCES persons(person_id);
ALTER TABLE known_for_titles ADD CONSTRAINT known_for_titles_person_fk FOREIGN KEY (person_id) REFERENCES persons(person_id);
ALTER TABLE known_for_titles ADD CONSTRAINT known_for_titles_title_fk FOREIGN KEY (title_id) REFERENCES titles(title_id);

SET foreign_key_checks = 1;
