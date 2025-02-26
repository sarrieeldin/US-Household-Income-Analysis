# U.S Household Income Data Analysis

This project analyzes U.S household income data from two  U.S Public datasets: `us_household_income` and `us_household_income_statistics`. The first dataset includes geographic details such as states, cities, area types, and land and water areas. The second dataset provides income details like average and median earnings, linked by an ID. The aim was to uncover patterns between geography and income and identify the highest and lowest earning cities. Despite some data issues, the findings reveal useful trends about wealth and location.

## Table of Contents

- [1. Methodology](#1-methodology)
  - [A. Data Cleaning](#a-data-cleaning)
  - [B. Analysis](#b-analysis)
- [2. Key Findings](#2-key-findings)
  - [A. Land and Water Areas](#a-land-and-water-areas)
  - [B. Income by State](#b-income-by-state)
  - [C. Income by Area Type](#c-income-by-area-type)
  - [D. Top and Bottom Earning Cities](#d-top-and-bottom-earning-cities)
- [3. Recommendations](#3-recommendations)
- [Important Note :](#important-note-)

---

## 1. Methodology

### A. Data Cleaning

To ensure accuracy, the following steps were taken:

- Renamed a garbled ID (`ï»¿id`) to `id` for consistency.
- Removed six duplicate rows from `us_household_income`.
- Fixed spelling errors in states (e.g., 'georia' to 'Georgia') and area types (e.g., 'CPD' to 'CDP').
- Filled one missing place name using city and county information.
- Confirmed land and water area data were complete.

**Note:** 240 rows lacked income data, which slightly impacted results.

### B. Analysis

SQL was used to investigate:

- Total land and water areas by state.
- Average incomes by state and area type.
- The highest and lowest earning cities and states.

---

## 2. Key Findings

### A. Land and Water Areas

- **Land Area:** Texas and California dominate, followed by Missouri, Minnesota, and Illinois.
- **Water Area:** Michigan leads, followed by Texas, Florida, Minnesota, and Louisiana.

### B. Income by State

- **Top 5 States:** District of Columbia, Connecticut, New Jersey, Maryland, Massachusetts.
- **Bottom 5 States:** Puerto Rico, Mississippi, Arkansas, West Virginia, Alabama.

### C. Income by Area Type

- **'Track' Areas:** Most frequent, with strong income levels.
- **'Communities':** Less common, with lower incomes, suggesting economic struggles.
- Other area types had too little data to draw conclusions.

### D. Top and Bottom Earning Cities

- **Highest:** Delta Junction (Alaska), Short Hills (New Jersey), Narberth (Pennsylvania), Chevy Chase (Maryland), Darien (Connecticut).
- **Lowest:** Center (Colorado), Estancia (New Mexico), Corsica (North Dakota), Mount Olivet (Kentucky), Fordville (North Dakota).

---

## 3. Recommendations

The survey data revealed key insights about income disparities, representation gaps, and data quality issues. Below are actionable recommendations to address these findings:

- **Investigate economic disparities in low-income areas:** The survey showed significant income differences, especially in underrepresented areas like 'Communities', so conducting targeted studies or follow-up surveys to uncover underlying causes—such as limited access to jobs or resources—can help shape effective policies to reduce these gaps.
- **Prioritize resources for underrepresented area types:** Since the data included limited information on certain area types like 'Communities', future efforts should direct economic support or resources to these regions, using survey insights to pinpoint where attention is most needed for fairer outcomes.
- **Expand future surveys with additional variables:** With extreme income variations between top- and bottom-earning cities lacking explanation, adding questions about education, employment types, or living costs to future surveys would offer a clearer picture of what drives these differences and improve decision-making.
- **Enhance the survey process to reduce errors and gaps:** The analysis was impacted by issues like misspelled state names and missing income data for 240 rows, so introducing standardized forms with dropdown options and a follow-up system for incomplete entries would ensure cleaner, more reliable data moving forward.

### Important Note :  
The repository includes:  
- Two Excel files containing the raw data.  
- SQL files for data cleaning and exploratory data analysis.
