/* init tables */
create table nw_tx (date string, type string, description string, amount integer, balance integer, name string, account string, category string);
create table amex_tx (date string, description string, category string, amount integer);
create table bcard_tx (date string, description string, card string, payee string, category string, unknown_field string, amount integer);

create table all_tx (date string, description string, amount integer, category string);

/* Import the data */
.separator ","
.import nw-transactions.csv nw_tx
.import amex-transactions.csv amex_tx
.import barclaycard-transactions.csv bcard_tx

/* remove card payments 
 This is about tracking spending, not cashflow */
delete from nw_tx where description like '%american express%';
delete from nw_tx where description like '%B/CARD PLAT VISA%';
delete from amex_tx where description like 'PAYMENT RECEIVED%';
delete from bcard_tx where description like '%Payment By %';

/* standardize with spending negative and payments positive */
update amex_tx set amount = -1 * amount;
update bcard_tx set amount = -1 * amount;

.read categorise.sql

create table totals (category string, total number);
INSERT INTO totals SELECT category,SUM(amount) FROM nw_tx GROUP BY category;
