# Music Re-engagement Analysis: What Brings Users Back to KKBOX?

## Overview
A product analytics case study examining 7.4 million listening events from KKBOX,
Asia's leading music streaming platform. This project combines behavioral event data
with Spotify audio features to identify which product surfaces, user segments, and
content types drive re-engagement — defined as replaying a track within 30 days.
A production scoring pipeline scores 2.56 million unseen events to generate a
ranked at-risk user list ready for CRM intervention.

## Business Question
Which product surfaces and content types drive re-engagement, and what should the
product team prioritize to improve retention?

## Key Findings
1. My library drives 62% re-engagement vs 22% for radio — a 40 percentage point gap
2. Discover has a volume-retention mismatch: 2.18M events but only 41.6% re-engagement
3. Discover Chart is the only discovery surface clearing the 50% baseline
4. Power users spend 70.5% of listening time in library vs 28.1% for at-risk users
5. At-risk users average 1,015 days tenure — churn is behavioural, not demographic
6. K-pop (56.7%) and dance/EDM (54-55%) are the highest re-engaging genres
7. LightGBM model achieves AUC 0.74 — library usage and tenure are top predictors
8. Audio features alone are weak predictors — product surface drives re-engagement more than content type

## Top Recommendations
- P0: Redesign onboarding to drive library-building in the first session
- P0: Deploy re-engagement model to flag and recover at-risk users (8,154 identified)
- P1: Consolidate Discover around chart-driven recommendations
- P1: Invest in K-pop and dance content depth and playlist curation
- P2: Incorporate song length as a quality signal in recommendations

## Analysis Phases
1. EDA and data preparation
2. Feature adoption analysis — re-engagement by product surface and screen
3. User segmentation — 4 behavioral segments across 30,755 users
4. Content and audio feature analysis — genre and audio profile vs re-engagement
5. Re-engagement prediction model — Logistic Regression baseline + LightGBM (AUC 0.74)
6. Product recommendations — 5 prioritised PM-style interventions
7. SQL validation — 5 warehouse-ready queries validated against Python results
8. Production scoring — 2.56M events scored, 8,154 at-risk users ranked for intervention

## Model Performance
| Model | AUC-ROC | Accuracy |
|---|---|---|
| Logistic Regression | 0.6822 | 64% |
| LightGBM | 0.7425 | 68% |

## Dataset
- KKBOX Music Recommendation Challenge (Kaggle) — 7.4M events, 34K users, 2.3M songs
- Spotify Tracks Dataset (Kaggle) — 114K tracks with audio features

## Tech Stack
Python, Pandas, NumPy, Scikit-learn, LightGBM, Matplotlib, Seaborn, SQLite

## Project Structure
```
music-reengagement-analysis/
├── notebooks/
│   └── 01_eda_and_feature_analysis.ipynb
├── data/
│   ├── train.csv
│   ├── members.csv
│   ├── songs.csv
│   ├── song_extra_info.csv
│   ├── test.csv
│   └── spotify_audio_features.csv
├── brief/
│   ├── 01_target_distribution.png
│   ├── 02_reengagement_by_tab.png
│   ├── 03_reengagement_by_screen.png
│   ├── 04_user_segments.png
│   ├── 05_audio_features_comparison.png
│   ├── 06_reengagement_by_genre.png
│   ├── 07_model_comparison.png
│   └── at_risk_users_scored.csv
├── sql/
│   └── validation_queries.sql
└── README.md
```

## Author
Prasanna Pingale | github.com/Prasanna1377
