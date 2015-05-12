BEGIN TRANSACTION;

DROP TABLE users;
DROP TABLE sessions;
DROP TABLE posts;
DROP TABLE comments;
DROP TABLE post_favorites;
DROP TABLE submissions;
DROP TABLE pages;

COMMIT;
