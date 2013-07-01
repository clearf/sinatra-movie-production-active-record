DROP TABLE tasks;
DROP TABLE movies;
DROP TABLE people;

CREATE TABLE tasks
(
	id SERIAL PRIMARY KEY,
	task VARCHAR(255),
	details VARCHAR(255),
	due VARCHAR(30),
	urgent BOOLEAN,
	complete BOOLEAN DEFAULT FALSE,
	director_id INT REFERENCES people(id)
	movie_id INT REFERENCES movies(id)
);

CREATE TABLE movies
(
	id SERIAL PRIMARY KEY,
	title VARCHAR(255),
	description TEXT,
	director_id INT REFERENCES people(id)
);

CREATE TABLE people
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	email VARCHAR(255)
);
