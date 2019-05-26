#!/bin/sh

rm transactions.db
python3 bank-ingestion.py $1
python3 cc-ingestion.py $2
python3 foreign-cc-ingestion.py $3
python3 render-sql-templates.py
sqlite3 -init init.sql transactions.db < query-balance.sql
sqlite3 transactions.db < query-spending.sql
