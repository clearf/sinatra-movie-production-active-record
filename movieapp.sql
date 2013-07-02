DROP TABLE todo;
DROP TABLE people;
DROP TABLE movies;

CREATE TABLE todo
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255),
  contact VARCHAR(255),
  movie VARCHAR(255)
);


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  movie VARCHAR(255),
  task VARCHAR(255)
);

CREATE TABLE movies
(
  release_date VARCHAR(255),
  title VARCHAR(255),
  director VARCHAR(255)
);

INSERT INTO todo (contact) VALUES ('Terrance A. Master');

INSERT INTO people (name) VALUES ('Wynona Leader');

INSERT INTO movies (director) VALUES ('John Woo')