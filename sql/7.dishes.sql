create view dishes as (
    select id,
           trim(dish) as dish
    from (
             SELECT id,
                    s.dish
             FROM main_table t,
                  unnest(string_to_array(t.dish_liked, ',')) s(dish)
             where s.dish != 'NA'
         ) x
    order by id, dish
)
