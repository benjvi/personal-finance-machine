
.print ''
.print 'overall profit/loss by month'
select strftime('%Y-%m', date),SUM(amount) 
    from ( select date, amount, description from cc_tx
            UNION
            select date, amount, description from nw_tx 
            UNION
            select date, amount, description from fcc_tx )
    GROUP BY date(date, 'start of month')
    ORDER BY date(date, 'start of month') DESC;
.print ''

.print 'AVG/MIN/MAX balance by month'
select avg(balance),min(balance),max(balance) 
    from nw_tx 
    GROUP BY date(date, 'start of month') 
    ORDER BY date(date, 'start of month') DESC; 