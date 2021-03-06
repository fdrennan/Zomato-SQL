-- drop view dishes
-- drop view cuisines
-- drop view main_table
create view main_table as (
    select cast(id as int),
           url,
           address,
           name,
           case
               when online_order = 'Yes' then true
               when online_order = 'No' then false
               end as online_order,
           case
               when book_table = 'Yes' then true
               when book_table = 'No' then false
               end as book_table,
           rate,
           votes,
           phone,
           location,
           rest_type,
           dish_liked,
           cuisines,
           two_people_cost,
           reviews_list,
           menu_item,
           listed_in_type,
           listed_in_city
    from zomato
    order by id
)