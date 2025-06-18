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
Key Insight: Highlights key donors whose large contributions can significantly influence fundraising totals. Useful to spot potential major backers and repeat high-value supporters.

2. Total Donations per Fund
What it shows: How much money each political fund or candidate has raised in total.
Key Insight: Makes it easy to see which campaigns attract the most financial support. Helps identify the top-performing funds and where donor money is concentrated.

3. Donation Trend Over Time
What it shows: Donations by month/year to spot seasonal or campaign cycle peaks.
Key Insight: Reveal clear spikes during election years and fundraising drives. Shows how public engagement and donor enthusiasm shift over time.

4. % Change Year Over Year
What it shows: The growth or decline in total donations compared to the previous year.
Key Insight: Tracks whether overall fundraising is gaining momentum or losing steam. Helps spot exceptional growth years or drops that could signal political or economic shifts.

5. Fund Popularity
What it shows: How many unique donors contribute to each fund.
Key Insight: Highlights which funds have broad community support versus those reliant on a few major donors. Useful to understand grassroots backing versus big-donor dependence.

6. Average Donation per Fund
What it shows: The average size of a donation for each fund.
Key Insight: Shows whether a fund raises money mainly through small donations from many people or larger contributions from fewer donors.

7. Donations by State
What it shows: Geographic distribution of contributions across the U.S.
Key Insight: Maps out which states contribute the most. Reveals regional hotspots of political giving and potential target areas for campaign outreach.

8. Donor Retention
What it shows: How many donors gave in consecutive years.
Key Insight: Measures donor loyalty and repeat support.

# How to Use

- Run the SQL scripts (Donation.sql) in your PostgreSQL environment to create tables and views.
- Open the Tableau workbook (.twbx) and connect to your local or extracted data.
- Or, view the live dashboard directly
