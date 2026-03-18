-- Music Re-engagement Analysis: SQL Validation Queries
-- Compatible with BigQuery, Redshift, and Snowflake

-- Query 1: Re-engagement rate by product surface
SELECT
    source_system_tab,
    COUNT(*) AS total_events,
    SUM(target) AS replays,
    ROUND(SUM(target) * 100.0 / COUNT(*), 2) AS reengagement_rate_pct
FROM events
GROUP BY source_system_tab
ORDER BY reengagement_rate_pct DESC;


-- Query 2: User segment distribution and behavioural profile
SELECT
    segment,
    COUNT(*) AS total_users,
    ROUND(AVG(reengagement_rate), 2) AS avg_reengagement_rate,
    ROUND(AVG(total_events), 1) AS avg_events,
    ROUND(AVG(library_pct), 2) AS avg_library_pct,
    ROUND(AVG(tenure_days), 0) AS avg_tenure_days
FROM user_segments
GROUP BY segment
ORDER BY avg_reengagement_rate DESC;


-- Query 3: Top 10 artists by re-engagement rate (min 10,000 events)
SELECT
    s.artist_name,
    COUNT(*) AS total_events,
    SUM(e.target) AS replays,
    ROUND(SUM(e.target) * 100.0 / COUNT(*), 2) AS reengagement_rate_pct
FROM events e
JOIN songs s ON e.song_id = s.song_id
GROUP BY s.artist_name
HAVING total_events >= 10000
ORDER BY reengagement_rate_pct DESC
LIMIT 10;


-- Query 4: Re-engagement rate by registration channel
SELECT
    m.registered_via,
    COUNT(DISTINCT e.msno) AS total_users,
    COUNT(*) AS total_events,
    SUM(e.target) AS replays,
    ROUND(SUM(e.target) * 100.0 / COUNT(*), 2) AS reengagement_rate_pct
FROM events e
JOIN members m ON e.msno = m.msno
GROUP BY m.registered_via
ORDER BY reengagement_rate_pct DESC;


-- Query 5: Event share and engagement profile by user segment
SELECT
    us.segment,
    ROUND(AVG(us.reengagement_rate), 2) AS avg_reengagement_rate,
    ROUND(AVG(us.library_pct), 2) AS avg_library_pct,
    ROUND(AVG(us.tenure_days), 0) AS avg_tenure_days,
    COUNT(DISTINCT e.msno) AS active_users,
    COUNT(*) AS total_events,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_total_events
FROM events e
JOIN user_segments us ON e.msno = us.msno
GROUP BY us.segment
ORDER BY avg_reengagement_rate DESC;
