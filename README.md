
# Personal Finance Machine

Simple code I use to keep track of personal finance by running SQL queries. Download a set of transaction data at the start of the month, then run this.

## Pre-reqs

Primarily this depends on the format of the csv you get with the transactions. I don't know how similar those from different banks are so there may be modifications required.

- Downloaded csv file containing transaction data from the last year
- CSV rows + order matching that in init.sql
- Date formatted as expected by format-date.py

## Categorise

Categorisation not included here. Write your own statements to populate the *category* column for each transaction in *categorise.sql*. Most queries defined rely on categories - if yours are different than mine then the queries at the end won't work.

## Run

`./run.sh <transactions csv file>`

This initialises the database in *transactions.db* and runs the queries. This is so you can run more queries afterwards! E.g. `sqlite3 transactions.db < query.sql`. Otherwise, you should clean up the database after you run this
