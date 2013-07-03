
CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  title VARCHAR(255),
  phone VARCHAR(255),
  idiot BOOLEAN
);

INSERT INTO people (name, title, phone, idiot) VALUES ('Ned Stark', 'The Dead Kings Hand', '1800-i-am-dead', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Robb Stark', 'King in the North', '1800-red-wedding', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Sansa Stark', 'The Kidnapped', '1800-hate-joeffery', true);
INSERT INTO people (name, title, phone, idiot) VALUES ('Arya Stark', 'The Roundface', '1800-jeoffery-must-die', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Bran Stark', 'The Builder', '1800-cannot-walk', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Tywin Lannister', 'Puppet Master', '1800-i-kill-em-all', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Cersei Lannister', 'The Queen', '1800-i-fucked-my-bro', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Ser Jaime Lannister', 'The Kingslayer', '1800-i-fucked-my-sis', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Tyrion Lannister', 'The Imp', '1800-i-love-whores', false);
INSERT INTO people (name, title, phone, idiot) VALUES ('Daenerys Targaryen', 'Mother of Dragons', '1800-my-boobs-rule', false);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  title TEXT,
  year TEXT,
  company TEXT,
  genres TEXT,
  length TEXT,
  director TEXT,
  mpaa_rating TEXT,
  poster TEXT
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  todo VARCHAR(255),
  note VARCHAR(255),
  status BOOLEAN DEFAULT false,
  assigned_to INT REFERENCES people(id),
  related_to INT REFERENCES movies(id)
);




