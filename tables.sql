DROP TABLE tasks;
DROP TABLE movies;
DROP TABLE people;


CREATE TABLE people
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	email VARCHAR(255)
);

CREATE TABLE movies
(
	id SERIAL PRIMARY KEY,
	title VARCHAR(255),
	description TEXT,
	director_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
	id SERIAL PRIMARY KEY,
	task VARCHAR(255),
	details VARCHAR(255),
	due VARCHAR(30),
	urgent BOOLEAN,
	complete BOOLEAN DEFAULT FALSE,
	director_id INT REFERENCES people(id),
	movie_id INT REFERENCES movies(id)
);

INSERT INTO tasks (task, details, due, urgent) VALUES ('film forest scene', 'grab actors after lunch and go film the scene', 'yesterday', 'true');
INSERT INTO tasks (task, details, due, urgent) VALUES ('settle budget conflict', 'meet with business manager', '07/22/2013', 'false');
