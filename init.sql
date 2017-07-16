/* init table */
create table transactions (date string, type string, description string, amount integer, balance integer, name string, account string, category string);
/* Import the data */
.separator ","
.import formatted-transactions.csv transactions

.read categorise.sql

create table totals (category string, total number);
INSERT INTO totals SELECT category,SUM(amount) FROM transactions GROUP BY category;
