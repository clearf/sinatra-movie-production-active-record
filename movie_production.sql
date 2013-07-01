-- DROP TABLE movies;
-- DROP TABLE people;
-- DROP TABLE tasks;

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  movie_name VARCHAR(255),
  release_date VARCHAR(255)
);

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  person_name VARCHAR(255),
  role VARCHAR(255),
  movie_name INT REFERENCES movies(id)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task_name VARCHAR(255),
  description VARCHAR(255),
  person_id INT REFERENCES people(id),
  movie_name INT REFERENCES movies(id)
);

-- make a person
-- INSERT INTO people (person_name)