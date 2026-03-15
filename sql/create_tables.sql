
-- Drop existing tables 
DROP TABLE rt_reviews PURGE;
DROP TABLE box_office PURGE;
DROP TABLE movie_genres PURGE;
DROP TABLE movies PURGE;

PURGE RECYCLEBIN;

-- Create movies table
CREATE TABLE movies (
    tconst CHAR(10) PRIMARY KEY,
    norm_title VARCHAR2(255) NOT NULL,
    start_year INTEGER NOT NULL,
    runtime_minutes INTEGER,
    imdb_rating FLOAT);

-- Create movie genres table 
CREATE TABLE movie_genres (
    tconst CHAR(10) NOT NULL,
    genre VARCHAR2(100),
    PRIMARY KEY (tconst, genre),
    FOREIGN KEY (tconst) REFERENCES movies(tconst) ON DELETE CASCADE);

-- Create box office table
CREATE TABLE box_office (
    box_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    norm_title VARCHAR2(255),
    year INTEGER,
    worldwide_revenue FLOAT);

-- Create rotten tomato reviews table 
CREATE TABLE rt_reviews (
    review_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    norm_title VARCHAR2(255),
    tomatometer_rating INTEGER,
    critics_consensus VARCHAR2(4000));
