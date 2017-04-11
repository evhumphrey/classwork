DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  f_name VARCHAR(255) NOT NULL,
  l_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(160) NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  body VARCHAR(160) NOT NULL,

  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(f_name, l_name)
VALUES
  ("Elliot", "Humphrey"),
  ("Ahmed", "Elzeiny"),
  ("Jaden", "Smith");

INSERT INTO
  questions(title, body, user_id)
VALUES
(
  "How many cats do I have",
  "Hey guys, this is a really critical question",
  (SELECT id FROM users WHERE f_name = 'Elliot')
),
(
  "How much wood would a woodchuck chuck?",
  "If a woodchuck could chuck wood?",
  (SELECT id FROM users WHERE f_name = 'Elliot')
),
(
  "How many apples would you have to eat",
  "a day to get the same nutritional value as an apple from 1950",
  (SELECT id FROM users WHERE f_name = 'Jaden')
),
(
  "How can mirrors be real if our eyes aren't real",
  "get on my lvl folks",
  (SELECT id FROM users WHERE f_name = 'Jaden')
),
(
  "If A Cup Cake Falls From A Tree How Far Away Will It Be From Down",
  "what does this evn mean?",
  (SELECT id FROM users WHERE f_name = 'Jaden')
);

INSERT INTO
  question_follows(question_id, user_id)
VALUES
  (1, 1), -- Elliot follows his own question
  (2, 1), -- ""
  (3, 3), -- Jaden follows his own questin
  (3, 4),
  (3, 5),
  (3, 2);-- Ahmed (2) replied/followed to Question (3)

INSERT INTO
  replies(parent_id, question_id, user_id, body)
VALUES
  (NULL, 3, 2, "5"),
  (1, 3, 1, "hi 5");

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (3, 3),
  (3, 4),
  (3, 5);
