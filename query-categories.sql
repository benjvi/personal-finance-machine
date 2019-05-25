-- break down category spending by week/month
.print ''
.print 'spending totals by category by week:'
SELECT category,SUM(amount) FROM nw_tx where date >= date('now', 'weekday 0', '-14 days') and date < date('now', 'weekday 0', '-7 days') GROUP BY category;
.print ''
.print 'spending totals by category by month:'
SELECT category,SUM(amount) FROM nw_tx where date >= date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY category;


-- express categories as percentage of total per week/month
.print ''
.print 'spending percentages by category by week:'
SELECT category,100*SUM(amount)/(SELECT SUM(amount) FROM nw_tx WHERE amount<0 AND date >= date('now', 'weekday 0', '-14 days') and date < date('now', 'weekday 0', '-7 days')) FROM nw_tx where date >= date('now', 'weekday 0', '-14 days') and date < date('now', 'weekday 0', '-7 days') GROUP BY category;
.print ''
.print 'spending percentages by category by month:'
SELECT category,100*SUM(amount)/(SELECT SUM(amount) FROM nw_tx WHERE amount<0 AND date > date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month')) FROM nw_tx where date > date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY category;

-- category queries comparing agsint yearly averages
.print ''
.print 'difference between last month and yearly average:' 
SELECT nw_transactions.category,(total/12 - SUM(amount)) FROM nw_tx JOIN totals on totals.category = nw_transactions.category where date >= date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY nw_transactions.category;
.print ''
.print 'last months spending as a ratio of yearly averages:'
SELECT nw_transactions.category,(SUM(amount)/(total/12)) FROM nw_tx JOIN totals on totals.category = nw_transactions.category where date >= date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY nw_transactions.category;

-- travel spending over 2/3 months
.print ''
.print 'difference between last 2 months travel spending and yearly average:' 
SELECT (total/6 - SUM(amount)) FROM nw_tx JOIN totals on totals.category = nw_transactions.category where date >= date('now', 'start of month', '-3 month') and date < date('now', 'start of month', '-1 month') and nw_transactions.category='travel';
.print ''
.print 'difference between last 3 months travel spending and yearly average:' 
SELECT (total/4 - SUM(amount)) FROM nw_tx JOIN totals on totals.category = nw_transactions.category where date >= date('now', 'start of month', '-4 month') and date < date('now', 'start of month', '-1 month') and nw_transactions.category='travel';
.print ''
.print 'last 2 months travel spending as a ratio of yearly averages:'
SELECT (SUM(amount)/(total/6)) FROM nw_tx JOIN totals on totals.category = nw_transactions.category where date >= date('now', 'start of month', '-3 month') and date < date('now', 'start of month', '-1 month') and nw_transactions.category='travel';
.print ''
.print 'last 3 months travel spending as a ratio of yearly averages:'
SELECT (SUM(amount)/(total/4)) FROM nw_tx JOIN totals on totals.category = nw_transactions.category where date >= date('now', 'start of month', '-4 month') and date < date('now', 'start of month', '-1 month') and nw_transactions.category='travel';

-- TIME BASED QUERIES
-- by week
.print ''
.print 'num transactions/avg by transaction by week for coffee'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM nw_tx WHERE category='coffee' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
.print ''
.print 'num transactions/avg by transaction by week for breakfast'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM nw_tx WHERE category='breakfast' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
.print ''
.print 'num transactions/avg by transaction by week for lunch'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM nw_tx WHERE category='lunch' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
.print ''
.print 'num transactions/avg by transaction by week for tfl'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM nw_tx WHERE category='tfl' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
