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
  director BOOLEAN,
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

-- make a movie
INSERT INTO movies (movie_name, release_date) VALUES ('Django Unchained', '12/25/12');

-- make a person_name
INSERT INTO people (person_name, director, movie_name) VALUES ('Quentin Tarantino', true, 1);

-- make a task
INSERT INTO tasks (task_name, description, person_id, movie_name) VALUES ('Brad Pitt', 'get Brad Pitt to sign contract', 1, 1);