
-- Drop tables if they exist 
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE rt_reviews PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE box_office PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE movie_genres PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE movies PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

PURGE RECYCLEBIN;

-- Create movies table
CREATE TABLE movies (
    tconst VARCHAR2(20) PRIMARY KEY,
    norm_title VARCHAR2(255),
    title_type VARCHAR2(50),
    start_year NUMBER(4),
    runtime_minutes NUMBER,
    imdb_rating NUMBER(3,1)
);

-- Movie genres table (1-to-many relationship)
CREATE TABLE movie_genres (
    tconst VARCHAR2(20) NOT NULL,
    genre VARCHAR2(100),
    PRIMARY KEY (tconst, genre),
    FOREIGN KEY (tconst) REFERENCES movies(tconst) ON DELETE CASCADE
);

-- Create box_office table
CREATE TABLE box_office (
    box_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    norm_title VARCHAR2(255),
    start_year NUMBER(4),
    worldwide_gross NUMBER
);

-- Create rt_reviews table
CREATE TABLE rt_reviews (
    review_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    norm_title VARCHAR2(255),
    tomatometer_rating NUMBER,
    critics_consensus VARCHAR2(4000)
);
