-- DROP old views first 
DROP VIEW IF EXISTS 
  total_donations_per_fund,
  donations_over_time,
  top_10_donors,
  donations_by_state,
  yearly_totals_with_pct_change,
  donor_retention,
  avg_donation_per_fund,
  avg_donation_per_donor_by_state,
  fund_popularity;

-- Create the cleaned table in one shot:
-- Renames columns
-- Filters bad rows
-- Converts donation_date to DATE immediately

DROP TABLE IF EXISTS cleaned_donations;

CREATE TABLE cleaned_donations AS
SELECT
  name AS donor_name,
  recipname AS fund_name,
  TO_DATE(date, 'MM/DD/YYYY') AS donation_date,
  amnt AS donation_amount,
  city AS donor_city,
  state AS donor_state,
  zip AS donor_zip
FROM raw_campaign_contributions
WHERE amnt > 0 AND name IS NOT NULL;



-- Report A: Total donations grouped by each fund
CREATE VIEW total_donations_per_fund AS
SELECT 
  fund_name,                      -- The fund receiving the donations
  COUNT(*) AS num_donations,      -- How many individual donations it received
  SUM(donation_amount) AS total_donated  -- Total dollar amount donated to this fund
FROM 
  cleaned_donations               -- Use your cleaned table
GROUP BY 
  fund_name                       -- Group results by fund name
ORDER BY 
  total_donated DESC;             -- Show the largest total donations first


-- Report B: Total donations per month (trend)
CREATE VIEW donations_over_time AS
SELECT 
  DATE_TRUNC('month', donation_date) AS month,
  SUM(donation_amount) AS total_donated
FROM 
  cleaned_donations
GROUP BY 
  month
ORDER BY 
  month;


-- Report C: Find the top 10 individual donors by total contribution amount
CREATE VIEW top_10_donors AS
SELECT 
  donor_name,                          -- Donor's name
  SUM(donation_amount) AS total_donated -- Total amount they donated
FROM 
  cleaned_donations
GROUP BY 
  donor_name                           -- Group by donor name
ORDER BY 
  total_donated DESC                   -- Sort by biggest donor first
LIMIT 10;                              -- Only return top 10 rows



-- Report D: Summary of donations by donor's state (good for maps!)
CREATE VIEW donations_by_state AS
SELECT 
  donor_state,                         -- US State
  COUNT(*) AS num_donations,           -- How many donations came from this state
  SUM(donation_amount) AS total_donated -- Total dollar amount from this state
FROM 
  cleaned_donations
GROUP BY 
  donor_state                          -- Group by state
ORDER BY 
  total_donated DESC;                  -- Show states with highest donations first



-- Report E: Year-over-Year donation totals with % change 

CREATE VIEW yearly_totals_with_pct_change AS
WITH yearly_totals AS (
  SELECT
    EXTRACT(YEAR FROM donation_date)::INT AS donation_year,
    SUM(donation_amount) AS total_donated
  FROM
    cleaned_donations
  GROUP BY
    donation_year
)
SELECT
  donation_year,
  total_donated,
  LAG(total_donated) OVER (ORDER BY donation_year) AS prev_year_total,
  ROUND(
    100.0 * (total_donated - LAG(total_donated) OVER (ORDER BY donation_year))
    / NULLIF(LAG(total_donated) OVER (ORDER BY donation_year), 0), 2
  ) AS pct_change
FROM
  yearly_totals
ORDER BY
  donation_year;


-- Report F: Donors retention: donors who gave in consecutive calendar years 
CREATE VIEW donor_retention AS
WITH donor_years AS (
  SELECT DISTINCT 
    donor_name, 
    EXTRACT(YEAR FROM donation_date)::INT AS donation_year
  FROM 
    cleaned_donations
),
repeat_donors AS (
  SELECT 
    d1.donor_name,
    d1.donation_year AS year,
    d2.donation_year AS next_year
  FROM 
    donor_years d1
    JOIN donor_years d2 
      ON d1.donor_name = d2.donor_name
      AND d2.donation_year = d1.donation_year + 1
)
SELECT 
  year,
  COUNT(DISTINCT donor_name) AS repeat_donor_count
FROM 
  repeat_donors
GROUP BY 
  year
ORDER BY 
  year;

-- Report G: Average donation amount per fund
CREATE VIEW avg_donation_per_fund AS
SELECT 
  fund_name,
  COUNT(*) AS num_donations,
  SUM(donation_amount) AS total_donated,
  ROUND(AVG(donation_amount), 2) AS avg_donation
FROM 
  cleaned_donations
GROUP BY 
  fund_name
ORDER BY 
  avg_donation DESC;


-- Report H: Average donation per donor by state
CREATE VIEW avg_donation_per_donor_by_state AS
SELECT 
  donor_state,
  COUNT(DISTINCT donor_name) AS num_unique_donors,
  SUM(donation_amount) AS total_donated,
  ROUND(SUM(donation_amount) / NULLIF(COUNT(DISTINCT donor_name),0), 2) AS avg_per_donor
FROM 
  cleaned_donations
GROUP BY 
  donor_state
ORDER BY 
  avg_per_donor DESC;

-- Report I: Total and unique donors per fund

CREATE VIEW fund_popularity AS
SELECT 
  fund_name,
  COUNT(*) AS num_donations,
  COUNT(DISTINCT donor_name) AS unique_donors,
  SUM(donation_amount) AS total_donated
FROM 
  cleaned_donations
GROUP BY 
  fund_name
ORDER BY 
  total_donated DESC;






