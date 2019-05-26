#!/usr/bin/env python3
import sys
import csv
import datetime

raw_csv_file=sys.argv[1]
CSV_SEP=","
transaction_rows = []
with open(raw_csv_file) as f:
    reader=csv.reader(f)
    for row in reader:
        transaction_rows.append(row)

for row in transaction_rows:
    row[0] = datetime.datetime.strptime(row[0], "%d %b %y").strftime('%Y-%m-%d')

with open('foreign-cc-transactions.csv', 'w', newline="") as f:
    wr = csv.writer(f)
    for t in transaction_rows:
        wr.writerow(t)