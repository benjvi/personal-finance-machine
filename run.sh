#!/bin/sh

python format-date.py $1
sqlite3 -init init.sql transactions.db < query.sql
