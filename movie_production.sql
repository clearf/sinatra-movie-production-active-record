DROP TABLE movies;
DROP TABLE people;
DROP TABLE tasks;


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  person_name VARCHAR(255)
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  movie_name VARCHAR(255),
  release_date VARCHAR(255),
  director_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task_name VARCHAR(255),
  description VARCHAR(255),
  movie_id INT REFERENCES movies(id),
  person_id INT REFERENCES people(id)
);