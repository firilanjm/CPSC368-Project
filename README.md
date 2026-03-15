# Movie Analytics Research Project

## 1. Research Questions
1. Are certain genres associated with significantly different IMDb user ratings and worldwide box office revenue?  
2. For movies, is runtime length associated with higher or lower average IMDb user ratings and box office revenue?  
3. What themes in Rotten Tomatoes do critics emphasize in highly rated versus low-rated movies?

---

## 2. Motivation
Online ratings strongly shape viewing decisions, yet audiences, critics, and financial performance metrics are often compared without accounting for differences in format, runtime, and genre. IMDb ratings reflect audience sentiment, Rotten Tomatoes aggregates professional reviews, and box office revenue captures commercial demand.  

This project investigates how content characteristics systematically relate to audience ratings, critic evaluations, and revenue. The question is interesting because it clarifies whether observed differences reflect true quality or structural attributes of the content itself.  

**Benefits include:**  
- **Viewers:** more accurate interpretation of ratings  
- **Digital platforms:** fairer ranking and recommendation systems  
- **Content creators and studios:** clearer benchmarks for evaluating performance relative to similar films  
- **Broader research:** demonstrates how integrating large-scale media datasets can reveal patterns in audience behaviour, critical evaluation, and market outcomes

---

## 3. Data Evaluation

### Research Question 1: Genre Differences
- Normalize multi-genre entries by splitting into separate rows  
- Join IMDb and box office datasets  
- Group by genre and compute:  
  - Average IMDb rating per genre  
  - Average revenue per genre  

### Research Question 2: Runtime and Ratings/Revenue
- Filter IMDb data to include only movies  
- Remove entries with missing runtime  
- Join IMDb with box office data using normalized movie title and release year  
- Create runtime bins and compute:  
  - Average IMDb rating per runtime bin  
  - Average and total worldwide revenue per runtime bin  
- Statistical tests:  
  - One-way ANOVA to test differences in mean ratings across runtime categories  
  - Correlation analysis between runtime and rating  
  - Linear regression with runtime as a continuous predictor  

### Research Question 3: Critic Themes
- Classify movies into high-rated and low-rated using `tomatometer_rating`  
- Extract `critics_consensus` text and perform:  
  - Text preprocessing (cleaning, tokenization)  
  - Keyword frequency analysis  
  - Optional topic modeling  
- Compare themes across groups to identify patterns in critic language

---

## 4. Hypotheses
- **RQ1:** Average worldwide box office revenue and ratings differ across genres; action and adventure will have higher mean revenue and ratings than drama and biography  
- **RQ2:** Runtime is positively associated with average IMDb user ratings and box office revenue  
- **RQ3:** High-rated films emphasize positive terms such as “character development,” “emotional depth,” and “strong performances,” while low-rated films emphasize negative terms such as “predictable,” “weak plot,” or “uninspired”

---

## 5. Datasets

### Dataset 1: IMDb Non-Commercial Datasets
- **Source:** [IMDb Datasets](https://datasets.imdbws.com/)  
- **Files:** `title.basics.tsv.gz`, `title.ratings.tsv.gz`  
- **Description:** Covers films, television, videos, shorts, and episodes  
- **Size:** 12,291,947 records in `title.basics.tsv.gz`, 1,635,266 records in `title.ratings.tsv.gz`  
- **Variables:**  
  - `tconst` – title ID  
  - `titleType` – format of title  
  - `startYear` – release year  
  - `runtimeMinutes` – runtime in minutes  
  - `genres` – up to three genres  
- **Reliability:** Official IMDb dataset for personal research use

### Dataset 2: Global Box Office Performance (2000–2024)
- **Source:** [Kaggle](https://www.kaggle.com/datasets/aditya126/movies-box-office-dataset-2000-2024)  
- **File:** `enhanced_box_office_data(2000-2024).csv`  
- **Size:** 4,955 unique movies  
- **Variables:**  
  - `Release group` – movie title or series  
  - `$Worldwide` – worldwide box office revenue  
  - `Year` – release year  
  - `Genres` – genres associated with the movie  
- **Reliability:** Kaggle usability score 10.00; compiled from publicly available sources

### Dataset 3: Rotten Tomatoes Movies and Critic Reviews
- **Source:** [Kaggle](https://www.kaggle.com/datasets/stefanoleone992/rotten-tomatoes-movies-and-critic-reviews-dataset)  
- **Files:** `rotten_tomatoes_movies.csv`, `rotten_tomatoes_critic_review.csv`  
- **Size:** 17,712 movie links  
- **Variables:**  
  - `Review_type`, `Review_score`, `Review_date`, `Review_content`, `Critics_consensus`, `Movie_title`  
- **Reliability:** Derived from Rotten Tomatoes; Kaggle usability score 10.00

---
## Getting Set Up

### Raw Data
The raw data files are not included in this repository due to file size. Download them and place them in `data/raw/`:

| File | Source |
|------|--------|
| `title.basics.tsv` | [IMDb Datasets](https://datasets.imdbws.com/) — unzip `title.basics.tsv.gz` |
| `title.ratings.tsv` | [IMDb Datasets](https://datasets.imdbws.com/) — unzip `title.ratings.tsv.gz` |
| `enhanced_box_office_data(2000-2024).csv` | [Kaggle](https://www.kaggle.com/datasets/aditya126/movies-box-office-dataset-2000-2024) |
| `rotten_tomatoes_movies.csv` | [Kaggle](https://www.kaggle.com/datasets/stefanoleone992/rotten-tomatoes-movies-and-critic-reviews-dataset) |
| `rotten_tomatoes_critic_reviews.csv` | [Kaggle](https://www.kaggle.com/datasets/stefanoleone992/rotten-tomatoes-movies-and-critic-reviews-dataset) |

Once the files are in place, run the notebooks in order:
1. `notebooks/data_cleaning.ipynb`
2. `notebooks/data_inserts.ipynb`
