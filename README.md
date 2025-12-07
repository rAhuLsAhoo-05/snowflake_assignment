Python Requirements


snowflake-connector-python
pandas
numpy
scikit-learn
matplotlib
python-dotenv

Package	Purpose
snowflake-connector-python	Connect Jupyter Notebook to Snowflake
pandas	Data loading + preprocessing
numpy	Required by pandas & sklearn
scikit-learn	ML model training (Logistic Regression)
matplotlib	Optional: Confusion matrix / visualizations
python-dotenv	Store Snowflake credentials safely

Install them using:

pip install -r requirements.txt

Snowflake Requirements

Inside Snowflake, you need:

A running warehouse (e.g., COMPUTE_WH)

A database ASSIGNMENT_DB

A schema FEATURES

Permissions to run basic SQL (CREATE TABLE, SELECT)

The SQL file included in this repo (snowflake/feature_engineering.sql) creates everything automatically.

🛠 Installation Guide

Follow these steps to set up your environment.

1️-Clone the Repository
git clone https://github.com/<your-username>/feature-engineering-snowflake-ml.git
cd feature-engineering-snowflake-ml

2️-Install Python Packages
pip install -r requirements.txt

3️- Set Up Snowflake Credentials

Create a .env file (optional but recommended):

SNOWFLAKE_USER=your_username
SNOWFLAKE_PASSWORD=your_password
SNOWFLAKE_ACCOUNT=your_account_identifier
SNOWFLAKE_WAREHOUSE=COMPUTE_WH
SNOWFLAKE_DATABASE=ASSIGNMENT_DB
SNOWFLAKE_SCHEMA=FEATURES

4️- Run the Snowflake SQL Setup

Open Snowflake → Worksheets → Run everything in:

snowflake/feature_engineering.sql


This script will:
  Load TPCH sample data
  Perform feature engineering
  Create the order_features table
  Generate rule-based predictions
  Evaluate accuracy, precision, recall

How to Run the Jupyter Notebook (Model Training)

Open VS Code or Jupyter Notebook

Start the notebook:

jupyter notebook


Open:

notebook/model_training.ipynb


Run all cells:

Connects to Snowflake

Loads engineered features

Trains Logistic Regression model

Prints evaluation metrics (accuracy, precision, recall)


ChatGPT can make mistak
