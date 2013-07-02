DROP TABLE tasks;
DROP TABLE movies;
DROP TABLE people;


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20)
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  person_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  description VARCHAR(100),
  movie_id INT REFERENCES movies(id),
  person_id INT REFERENCES people(id)
);


-- ADD PEOPLE
INSERT INTO people (name) VALUES ('name_1');
INSERT INTO people (name) VALUES ('name_2');
INSERT INTO people (name) VALUES ('name_3');
INSERT INTO people (name) VALUES ('name_4');
INSERT INTO people (name) VALUES ('name_5');

-- ADD movie
INSERT INTO movies (name, person_id) VALUES ('Movie_1', 1);
INSERT INTO movies (name, person_id) VALUES ('Movie_2', 2);
INSERT INTO movies (name, person_id) VALUES ('Movie_3', 3);
INSERT INTO movies (name, person_id) VALUES ('Movie_4', 4);
INSERT INTO movies (name, person_id) VALUES ('Movie_5', 5);

-- ADD tasks
INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('Task_1', 'Desc_1', 1, 1);
INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('Task_2', 'Desc_2', 2, 2);
INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('Task_3', 'Desc_3', 3, 3);
INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('Task_4', 'Desc_4', 4, 4);
INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('Task_5', 'Desc_5', 5, 5);