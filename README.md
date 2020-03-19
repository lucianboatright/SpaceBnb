## SpaceBnB
An Airbnb style web app.

The website allows users to sign into an account where they can add a listing to be rented or they can rent a listing.

## Collaborators 
Ilias Marios Grigoropoulos
Alicia Merlino
Tomas Ratcliffe
Niki Mandeldaki
Lucian Boatright Roberts

## Setting up the database
```
$ psql postgres
$ CREATE DATABASE makersbnb;
$ \c makersbnb
$ CREATE TABLE users(user_id SERIAL PRIMARY KEY, first_name VARCHAR(60), last_name VARCHAR(60), email VARCHAR(60), password VARCHAR(60));
$ CREATE TABLE spaces(space_id SERIAL PRIMARY KEY, name VARCHAR(60), price VARCHAR(60), description VARCHAR(400));
$ CREATE TABLE bookings(id SERIAL PRIMARY KEY, start_date DATE, finish_date DATE);
$ ALTER TABLE bookings ADD COLUMN user_id INT REFERENCES users(id);
$ ALTER TABLE bookings ADD COLUMN space_id INT REFERENCES spaces(id);
$ ALTER TABLE spaces ADD COLUMN image VARCHAR(200);

$ ALTER TABLE spaces RENAME COLUMN id TO space_id;
$ ALTER TABLE users RENAME COLUMN id TO space_id;
```

## Setting up a test database
```
$ psql postgres
$ CREATE DATABASE makersbnb_test;
$ \c makersbnb_test
$ CREATE TABLE users(user_id SERIAL PRIMARY KEY, first_name VARCHAR(60), last_name VARCHAR(60), email VARCHAR(60), password VARCHAR(60));
$ CREATE TABLE spaces(space_id SERIAL PRIMARY KEY, name VARCHAR(60), price VARCHAR(60), description VARCHAR(400));
$ CREATE TABLE bookings(id SERIAL PRIMARY KEY, start_date DATE, finish_date DATE);
$ ALTER TABLE bookings ADD COLUMN user_id INT REFERENCES users(id);
$ ALTER TABLE bookings ADD COLUMN space_id INT REFERENCES spaces(id);
$ ALTER TABLE spaces ADD COLUMN image VARCHAR(200);

$ ALTER TABLE spaces RENAME COLUMN id TO space_id;
$ ALTER TABLE users RENAME COLUMN id TO space_id;
```
