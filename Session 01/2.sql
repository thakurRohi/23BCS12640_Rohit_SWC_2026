select
    transaction_date,
    sum(revenue) as daily_net_revenue
from (
    select
        p.transaction_date,
        p.amount as revenue
    from product_sales p
    where p.product_id = 'prod-2891'
      and p.country = 'us'
      and p.type = 'purchase'
      and p.status = 'completed'
      and p.transaction_date between '2025-04-15' and '2025-04-28'

    union all

    select
        r.transaction_date,
        -r.amount as revenue
    from product_sales r
    join product_sales p
      on r.original_transaction_id = p.transaction_id
    where p.product_id = 'prod-2891'
      and p.country = 'us'
      and p.type = 'purchase'
      and p.status = 'completed'
      and p.transaction_date between '2025-04-15' and '2025-04-28'
      and r.type = 'refund'
      and r.status = 'completed'
) t
group by transaction_date
order by transaction_date;