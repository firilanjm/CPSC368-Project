
-- Drop tables if they exist
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE rt_reviews PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE box_office PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE movies PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Drop tables if they exist
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE movie_genres PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Create movies table
CREATE TABLE movies (
    tconst VARCHAR2(20) PRIMARY KEY,
    primary_title VARCHAR2(4000) NOT NULL,
    norm_title VARCHAR2(4000) NOT NULL,
    title_type VARCHAR2(50),
    start_year NUMBER(4),
    runtime_minutes NUMBER,
    imdb_rating NUMBER(3,1)
);

-- Movie genres table (1-to-many relationship)
CREATE TABLE movie_genres (
    tconst VARCHAR2(20) NOT NULL,
    genre VARCHAR2(100) NOT NULL,
    FOREIGN KEY (tconst) REFERENCES movies(tconst) ON DELETE CASCADE
);

-- Create box_office table
CREATE TABLE box_office (
    norm_title VARCHAR2(4000) NOT NULL,
    genre VARCHAR2(100),
    year NUMBER(4) NOT NULL,
    worldwide_revenue NUMBER,
    PRIMARY KEY (norm_title, year)
);

-- Create rt_reviews table
CREATE TABLE rt_reviews (
    norm_title VARCHAR2(4000) NOT NULL,
    year NUMBER(4) NOT NULL,
    critics_consensus VARCHAR2(4000) NOT NULL,
    review_date DATE NOT NULL,
    tomatometer_rating NUMBER,
    PRIMARY KEY (norm_title, year, review_date)
);
