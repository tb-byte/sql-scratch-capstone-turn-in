select count(distinct utm_campaign) as 'campaign_count'
from page_visits;

select count(distinct utm_source) as 'source_count'
from page_visits;

select distinct utm_campaign as campaign, utm_source as source
from page_visits;

select count(distinct page_name) as 'page_count'
from page_visits;

select distinct page_name as page
from page_visits;

with first_touch as (select user_id,
 min(timestamp) as first_touch_at
from page_visits
group by user_id),
ft_attr as (select ft.user_id, ft.first_touch_at, pv.utm_source, pv.utm_campaign
from first_touch ft 
join page_visits pv
on ft.user_id = pv.user_id
and ft.first_touch_at = pv.timestamp
)
select ft_attr.utm_source, ft_attr.utm_campaign, count(*) as 'count'
from ft_attr
group by 1, 2
order by 3 desc;

with last_touch as (select user_id,
 max(timestamp) as last_touch_at
from page_visits
group by user_id),
lt_attr as (select lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
from last_touch lt 
join page_visits pv
on lt.user_id = pv.user_id
and lt.last_touch_at = pv.timestamp
)
select lt_attr.utm_source, lt_attr.utm_campaign, count(*) as 'count'
from lt_attr
group by 1, 2
order by 3 desc;

select count(distinct user_id) as 'purchase_page_visit_count'
from page_visits
where page_name = '4 - purchase';

with last_touch as (select user_id,
 max(timestamp) as last_touch_at
from page_visits
where page_name = '4 - purchase'
group by user_id),
lt_attr as (select lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
from last_touch lt 
join page_visits pv
on lt.user_id = pv.user_id
and lt.last_touch_at = pv.timestamp
)
select lt_attr.utm_source, lt_attr.utm_campaign, count(*) as 'count'
from lt_attr
group by 1, 2
order by 3 desc;