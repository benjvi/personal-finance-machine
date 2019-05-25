#!/bin/sh

python nw-ingestion.py $1
python3 amex-ingestion.py $2
python3 bcard-ingestion.py $3
sqlite3 -init init.sql transactions.db < query.sql
