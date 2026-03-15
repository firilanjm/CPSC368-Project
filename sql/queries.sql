-- Research Question #1: Are certain genres associated with significantly 
-- different IMDb user ratings and worldwide box office revenue?

SELECT mg.genre,
    COUNT(DISTINCT m.tconst) AS movie_count,
    AVG(m.imdb_rating) AS avg_imdb_rating,
    AVG(bo.worldwide_revenue) AS avg_revenue
FROM movies m
    JOIN movie_genres mg ON m.tconst = mg.tconst
    JOIN box_office bo ON m.norm_title = bo.norm_title
WHERE bo.worldwide_revenue IS NOT NULL
GROUP BY mg.genre
ORDER BY avg_revenue DESC;

-- Research Question #2: For movies, is the runtime length associated with 
-- higher or lower average IMDb user ratings and box office revenue?

CREATE VIEW short_films AS
    SELECT m.runtime_minutes, m.imdb_rating, bo.worldwide_revenue, 'Short' AS runtime_bin
    FROM movies m
    JOIN box_office bo ON m.norm_title = bo.norm_title
    WHERE m.runtime_minutes < 90
    AND bo.worldwide_revenue IS NOT NULL;

CREATE VIEW medium_films AS
    SELECT m.runtime_minutes, m.imdb_rating, bo.worldwide_revenue, 'Medium' AS runtime_bin
    FROM movies m
    JOIN box_office bo ON m.norm_title = bo.norm_title
    WHERE m.runtime_minutes BETWEEN 90 AND 120
    AND bo.worldwide_revenue IS NOT NULL;

CREATE VIEW long_films AS
    SELECT m.runtime_minutes, m.imdb_rating, bo.worldwide_revenue, 'Long' AS runtime_bin
    FROM movies m
    JOIN box_office bo ON m.norm_title = bo.norm_title
    WHERE m.runtime_minutes > 120
    AND bo.worldwide_revenue IS NOT NULL;

SELECT runtime_bin, COUNT(*) AS movie_count, 
    AVG(imdb_rating) AS avg_imdb_rating,
    AVG(worldwide_revenue) AS avg_revenue, 
    SUM(worldwide_revenue) AS total_revenue
FROM (SELECT * FROM short_films
      UNION SELECT * FROM medium_films
      UNION SELECT * FROM long_films)
GROUP BY runtime_bin
ORDER BY runtime_bin;

-- Research Question #3: What themes in Rotten Tomatoes do critics 
-- emphasize in highly rated versus low-rated movies?

CREATE VIEW high_rated AS
    SELECT norm_title, tomatometer_rating, critics_consensus, 'High' AS rating_group
    FROM rt_reviews
    WHERE tomatometer_rating >= 60
    AND critics_consensus IS NOT NULL;

CREATE VIEW low_rated AS
    SELECT norm_title, tomatometer_rating, critics_consensus, 'Low' AS rating_group
    FROM rt_reviews
    WHERE tomatometer_rating < 60
    AND critics_consensus IS NOT NULL;

SELECT rating_group, critics_consensus
FROM (SELECT * FROM high_rated
      UNION SELECT * FROM low_rated)
ORDER BY rating_group;