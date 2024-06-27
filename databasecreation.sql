-- create a db and a user
CREATE DATABASE nexgen;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

GRANT ALL PRIVILEGES ON nexgen.* TO 'admin'@'localhost';

FLUSH PRIVILEGES;
