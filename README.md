# NYC-Campaign-Contribution
This project explores NYC campaign donations using:
- PostgreSQL for data cleaning and transformation
- SQL queries for meaningful reports
- Tableau for interactive visuals highlighting top donors, fund trends, donation growth, and US state distribution.

# [View the Live Dashboard](https://public.tableau.com/app/profile/narayani.bakhati6251/viz/NYC_Campaign_Contribution_dashboard/Dashboard2?publish=yes)

# Data Background

The dataset comes from NYC Open Data’s public **Campaign Contributions** table (https://data.cityofnewyork.us/City-Government/Campaign-Contributions/rjkp-yttg/about_data), which contains detailed donation records including:
- Donor Name, City, State, ZIP
- Recipient (Fund Name)
- Contribution Date
- Contribution Amount

For this project, the raw data was imported into **PostgreSQL**, cleaned and transformed using SQL queries to:
- Standardize column names
- Filter out invalid records (negative or null donations)
- Convert dates to proper date formats
- Prepare summary tables for reporting

# Key Analysis Queries
- Total donations per fund
- Donation trends over time
- Top 10 individual donors
- Donations summarized by state
- Year-over-Year % change
- Donor retention — donors who gave in consecutive years
- Average donation per fund
- Fund popularity (unique donors per fund)

These were implemented as SQL Views in PostgreSQL, then connected to Tableau.

# Dashboard Reports & Insights

1. Top 10 Donors
What it shows: Who contributed the most money overall.
Key Insight: Highlights major individual donors and their total contributions.

2. Total Donations per Fund
What it shows: How much each political fund or candidate received.
Key Insight: Ranks funds by total donations to identify popular campaigns.

3. Donation Trend Over Time
What it shows: Donations by month/year to spot seasonal or campaign cycle peaks.
Key Insight: Shows spikes during election years and fundraising drives.

4. % Change Year Over Year
What it shows: How donations grew or shrank each year.
Key Insight: Reveals fundraising momentum and possible political sentiment changes.

5. Fund Popularity
What it shows: Number of unique donors per fund.
Key Insight: Distinguishes between funds that rely on few large donors vs broad donor bases.

6. Average Donation per Fund
What it shows: Mean donation amount per fund.
Key Insight: Shows whether funds receive mostly large or small donations.

7. Donations by State
What it shows: Geographic distribution of contributions across the U.S.
Key Insight: Identifies states with the highest donor activity.

8. Donor Retention
What it shows: How many donors gave in consecutive years.
Key Insight: Measures donor loyalty and repeat support.

# How to Use

- Run the SQL scripts (Donation.sql) in your PostgreSQL environment to create tables and views.
- Open the Tableau workbook (.twbx) and connect to your local or extracted data.
- Or, view the live dashboard directly
