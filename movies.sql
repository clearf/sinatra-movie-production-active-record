CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255)
  -- person_id INT REFERENCES people(id),
  -- movie_id INT REFERENCES movies(id)
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  release_date INT
  -- director INT REFERENCES people(id)
);

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  movie INT REFERENCES movies(id),
  task INT REFERENCES tasks(id)
);