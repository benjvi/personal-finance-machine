import sys
import csv

raw_csv_file=sys.argv[1]
CSV_SEP=","
transaction_rows = []
with open(raw_csv_file) as f:
    reader=csv.reader(f)
    for row in reader:
        transaction_rows.append(row)

transaction_outputs=[]
# remove header rows
for line in transaction_rows[3:]:
    date = line[0].split('/')
    day = date[0]
    month = date[1]
    year = date[2]
    
    datestring="-".join([year, month, day])
    new_tr = [datestring]+line[1:9]

    transaction_outputs.append(new_tr)

with open('bank-transactions.csv', 'w+') as f:
    wr = csv.writer(f)
    for t in transaction_outputs:
        wr.writerow(t)
