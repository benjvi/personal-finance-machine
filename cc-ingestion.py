#!/usr/bin/env python3
import xlrd
import csv
import sys
import datetime

amex_xls_file=sys.argv[1]

with xlrd.open_workbook(amex_xls_file) as wb:
    sh = wb.sheet_by_index(0) 
    with open('cc-transactions.csv', 'w', newline="") as f:
        c = csv.writer(f)
        # first eleven lines are not relevant here
        # exclude column headers for import
        for r in range(12, sh.nrows):
            row = sh.row_values(r)
            # need to remove currency symbol from amount
            row[3] = row[3].replace('£','')
            # need to reformat date string
            row[0] = datetime.datetime.strptime(row[0], "%d %b %Y").strftime('%Y-%m-%d')
            c.writerow(row)