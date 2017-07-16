-- GENERAL QUERIES
.print ''
.print 'change in balance by month'
select date(date, 'start of month'),SUM(amount) from transactions GROUP BY date(date, 'start of month');
.print ''
.print 'AVG/MIN/MAX balance by month'
select avg(balance),min(balance),max(balance) from transactions GROUP BY date(date, 'start of month') ORDER BY date(date, 'start of month') DESC LIMIT 5; 

-- CATEGORY BASED QUERIES
-- break down category spending by week/month
.print ''
.print 'spending totals by category by week:'
SELECT category,SUM(amount) FROM transactions where date >= date('now', 'weekday 0', '-14 days') and date < date('now', 'weekday 0', '-7 days') GROUP BY category;
.print ''
.print 'spending totals by category by month:'
SELECT category,SUM(amount) FROM transactions where date >= date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY category;


-- express categories as percentage of total per week/month
.print ''
.print 'spending percentages by category by week:'
SELECT category,100*SUM(amount)/(SELECT SUM(amount) FROM transactions WHERE amount<0 AND date >= date('now', 'weekday 0', '-14 days') and date < date('now', 'weekday 0', '-7 days')) FROM transactions where date >= date('now', 'weekday 0', '-14 days') and date < date('now', 'weekday 0', '-7 days') GROUP BY category;
.print ''
.print 'spending percentages by category by month:'
SELECT category,100*SUM(amount)/(SELECT SUM(amount) FROM transactions WHERE amount<0 AND date > date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month')) FROM transactions where date > date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY category;

-- category queries comparing agsint yearly averages
.print ''
.print 'difference between last month and yearly average:' 
SELECT transactions.category,(total/12 - SUM(amount)) FROM transactions JOIN totals on totals.category = transactions.category where date >= date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY transactions.category;
.print ''
.print 'last months spending as a ratio of yearly averages:'
SELECT transactions.category,(SUM(amount)/(total/12)) FROM transactions JOIN totals on totals.category = transactions.category where date >= date('now', 'start of month', '-2 month') and date < date('now', 'start of month', '-1 month') GROUP BY transactions.category;

-- travel spending over 2/3 months
.print ''
.print 'difference between last 2 months travel spending and yearly average:' 
SELECT (total/6 - SUM(amount)) FROM transactions JOIN totals on totals.category = transactions.category where date >= date('now', 'start of month', '-3 month') and date < date('now', 'start of month', '-1 month') and transactions.category='travel';
.print ''
.print 'difference between last 3 months travel spending and yearly average:' 
SELECT (total/4 - SUM(amount)) FROM transactions JOIN totals on totals.category = transactions.category where date >= date('now', 'start of month', '-4 month') and date < date('now', 'start of month', '-1 month') and transactions.category='travel';
.print ''
.print 'last 2 months travel spending as a ratio of yearly averages:'
SELECT (SUM(amount)/(total/6)) FROM transactions JOIN totals on totals.category = transactions.category where date >= date('now', 'start of month', '-3 month') and date < date('now', 'start of month', '-1 month') and transactions.category='travel';
.print ''
.print 'last 3 months travel spending as a ratio of yearly averages:'
SELECT (SUM(amount)/(total/4)) FROM transactions JOIN totals on totals.category = transactions.category where date >= date('now', 'start of month', '-4 month') and date < date('now', 'start of month', '-1 month') and transactions.category='travel';

-- TIME BASED QUERIES
-- by week
.print ''
.print 'num transactions/avg by transaction by week for coffee'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM transactions WHERE category='coffee' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
.print ''
.print 'num transactions/avg by transaction by week for breakfast'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM transactions WHERE category='breakfast' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
.print ''
.print 'num transactions/avg by transaction by week for lunch'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM transactions WHERE category='lunch' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
.print ''
.print 'num transactions/avg by transaction by week for tfl'
SELECT date(date, 'weekday 0'),COUNT(*),AVG(amount) FROM transactions WHERE category='tfl' GROUP BY date(date, 'weekday 0') ORDER BY date(date, 'weekday 0') DESC LIMIT 5;
