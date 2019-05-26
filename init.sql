/* can't run this through python, dot commands are cli-only */

/* init tables */
create table nw_tx (date string, type string, description string, amount integer, balance integer, name string, account string, category string);
create table cc_tx (date string, description string, category string, amount integer);
create table fcc_tx (date string, description string, card string, payee string, category string, unknown_field string, amount integer);

create table all_tx (date string, description string, amount integer, category string);

/* Import the data */
.separator ","
.import bank-transactions.csv nw_tx
.import cc-transactions.csv cc_tx
.import foreign-cc-transactions.csv fcc_tx

/* remove card payments 
 This is about tracking spending, not cashflow */
delete from nw_tx where description like '%american express%';
delete from nw_tx where description like '%B/CARD PLAT VISA%';
delete from cc_tx where description like 'PAYMENT RECEIVED%';
delete from fcc_tx where description like '%Payment By %';

/* standardize with spending negative and payments positive */
update cc_tx set amount = -1 * amount;
update fcc_tx set amount = -1 * amount;

.read categorise.sql

create table totals (category string, total number);
INSERT INTO totals SELECT category,SUM(amount) FROM nw_tx GROUP BY category;
