
-- list of products with a base price greater than 500 and that are featured in promo type of 'BOGOF (Buy One Get One Free)' --
select 
	product_name,
	base_price,
	promo_type
from 
	fact_events
join dim_products
on dim_products.product_code=fact_events.product_code
where 
	base_price > 500 and
	promo_type='BOGOF'
order by
	base_price



-- an overview of the number of stores in each city --
select
	city,
	count(store_id) as number_of_stores
from	
	dim_stores
group by 
	city
order by 
	number_of_stores desc



--report that displays each campaign along with the total revenue generated before and after the campaign --
select sum(BS_quantity) as total_revenue
from fact_events

select sum(AS_quantity) as total_revenue
from fact_events

select campaign_id,sum(BS_quantity) as TRBS,sum(AS_quantity) as TRAS
from fact_events
where campaign_id='CAMP_SAN_01'
group by campaign_id;

select campaign_id,sum(BS_quantity) as TRBS,sum(AS_quantity) as TRAS
from fact_events
where campaign_id='CAMP_DIW_01'
group by campaign_id;



--A report that calculates the Incremental Sold Quantity (ISU%) for each category during the Diwali campaign --
select 
	dim_campaigns.campaign_id,
	category,
	ISU
from	
	fact_events
join dim_products
on dim_products.product_code=fact_events.product_code
join dim_campaigns
on dim_campaigns.campaign_id=fact_events.campaign_id
where 
	dim_campaigns.campaign_id='CAMP_DIW_01'	
order by
	ISU desc



-- A report featuring the Top 5 products, ranked by Incremental Revenue Percentage (IR%), across all campaigns --
select top 5
	product_name,
	category,
	IR  
from 
	fact_events
join dim_products
on dim_products.product_code=fact_events.product_code
order by 
	IR desc


select top 10
	store_id,
	sum(ISU) as total
from fact_events
group by 
	store_id
order by 
	total 
