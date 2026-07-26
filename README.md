# Olist E-commerce Analytics

An end-to-end business analytics project based on the Brazilian
E-Commerce Public Dataset by Olist.

## Project objectives

This project demonstrates:

- Data ingestion from multiple CSV files
- Data profiling and cleaning using Python and Pandas
- Relational database development with PostgreSQL
- SQL-based business analysis
- Analytical data modelling
- Interactive dashboard development with Power BI
- Cloud data warehousing with Snowflake

## Dataset

The project uses the Brazilian E-Commerce Public Dataset by Olist,
available on Kaggle.

The source contains nine related CSV files covering:

- Customers
- Orders
- Order items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product category translations

The raw dataset is not stored in this GitHub repository. Download it
from Kaggle and place the CSV files inside `data/raw/`.

## Technologies

- Python
- Pandas
- PostgreSQL
- SQL
- Power BI
- Snowflake
- Matplotlib
- Seaborn
- Git and GitHub

## Project structure

```text
data/raw/         Original Kaggle CSV files
data/processed/   Cleaned and transformed files
notebooks/        Data exploration and analysis notebooks
sql/              PostgreSQL and analytical SQL scripts
src/              Reusable Python scripts
powerbi/          Power BI dashboard and screenshots