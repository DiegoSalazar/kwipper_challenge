BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS users(
  id serial PRIMARY KEY,
  username VARCHAR (50) UNIQUE NOT NULL,
  email VARCHAR (355) UNIQUE NOT NULL,
  hashed_password VARCHAR (255) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  last_login TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sessions(
  id serial PRIMARY KEY,
  session_id VARCHAR (255) UNIQUE NOT NULL,
  user_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS posts(
  id serial PRIMARY KEY,
  user_id INTEGER NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS comments(
  id serial PRIMARY KEY,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS post_favorites(
  id serial PRIMARY KEY,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS submissions(
  id serial PRIMARY KEY,
  user_id INTEGER NOT NULL,
  repo VARCHAR (255) NOT NULL,
  created_at TIMESTAMP NOT NULL
);

COMMIT;
