DROP TABLE people;
DROP TABLE tasks;
DROP TABLE movies;

CREATE TABLE people
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	email VARCHAR(255)
);

CREATE TABLE tasks
(
	id SERIAL PRIMARY KEY,
	task VARCHAR(255),
	details VARCHAR(255),
	person_id INT REFERENCES people(id),
	movie_id INT REFERENCES movies(id) 
);

CREATE TABLE movies
(
	id SERIAL PRIMARY KEY,
	title VARCHAR(255),
	description TEXT,
	release_date VARCHAR(30),
);

#sql
INSERT INTO people (name, email) VALUES ('Hoboken Joe', 'joe@hobokenmovies.com');
INSERT INTO people (name, email) VALUES ('Tiffany Thomas', 'tiffany.thomas@gmail.com');
INSERT INTO people (name, email) VALUES ('Viva Bam', 'viva_bam@yahoo.com');

INSERT INTO tasks (task, details, person_id, movie_id) VALUES ('Casting Call', 'Round up the usual suspects.', 1, 1);
INSERT INTO tasks (task, details, person_id, movie_id) VALUES ('Set Design', 'Draft mockup for setting and stages.', 2, 1);
INSERT INTO tasks (task, details, person_id, movie_id) VALUES ('Stunts Demo', 'Need to demo all stunts, indoor and out.', 3, 1);

INSERT INTO movies (title, description) VALUES ('Jersey Shore Girls', 'Low Budget');
INSERT INTO movies (title, description) VALUES ('Wham Bam Thank You Maam', 'Low Budget');
INSERT INTO movies (title, description) VALUES ('Untitled Movie', 'Low Budget');