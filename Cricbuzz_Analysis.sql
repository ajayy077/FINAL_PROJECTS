-- ==========================================
-- Cricbuzz Advanced Analysis Queries
-- Run in MySQL Workbench after loading cricbuzz_db
-- ==========================================

USE cricbuzz_db;

-- 1. Top 5 Run Scorers
SELECT p.full_name, SUM(b.runs) AS total_runs
FROM batting b
JOIN players p ON b.player_id = p.player_id
GROUP BY p.full_name
ORDER BY total_runs DESC
LIMIT 5;

-- 2. Top 5 Wicket Takers
SELECT p.full_name, SUM(bw.wickets) AS total_wickets
FROM bowling bw
JOIN players p ON bw.player_id = p.player_id
GROUP BY p.full_name
ORDER BY total_wickets DESC
LIMIT 5;

-- 3. Team Win Count
SELECT t.name AS team, COUNT(*) AS wins
FROM matches m
JOIN teams t ON m.winner_team_id = t.team_id
GROUP BY t.name
ORDER BY wins DESC;

-- 4. Average Runs per Match (per Player)
SELECT p.full_name, AVG(b.runs) AS avg_runs
FROM batting b
JOIN players p ON b.player_id = p.player_id
GROUP BY p.full_name
ORDER BY avg_runs DESC;

-- 5. Best Bowling Economy
SELECT p.full_name, MIN(bw.economy) AS best_economy
FROM bowling bw
JOIN players p ON bw.player_id = p.player_id
GROUP BY p.full_name
ORDER BY best_economy ASC
LIMIT 5;

-- 6. Highest Partnerships
SELECT p1.full_name AS striker, p2.full_name AS non_striker, pr.runs AS partnership_runs
FROM partnerships pr
JOIN players p1 ON pr.striker_id = p1.player_id
JOIN players p2 ON pr.non_striker_id = p2.player_id
ORDER BY pr.runs DESC
LIMIT 5;

-- 7. Match Results Summary
SELECT m.match_id, t1.name AS team1, t2.name AS team2, t3.name AS winner
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id
JOIN teams t3 ON m.winner_team_id = t3.team_id;

-- 8. Players with Hundreds
SELECT p.full_name, SUM(ps.hundreds) AS total_hundreds
FROM player_format_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.full_name
ORDER BY total_hundreds DESC;

-- 9. Most Catches by Fielders
SELECT p.full_name, SUM(f.catches) AS total_catches
FROM fielding f
JOIN players p ON f.player_id = p.player_id
GROUP BY p.full_name
ORDER BY total_catches DESC
LIMIT 5;

-- 10. Toss Decision Impact (Win Count)
SELECT m.toss_decision, COUNT(*) AS wins_after_toss
FROM matches m
WHERE m.winner_team_id = m.toss_winner_id
GROUP BY m.toss_decision;
