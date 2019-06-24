create view cuisines as (
    select id,
           trim(cuisine_type) as cuisine_type
    from (
             SELECT id,
                    s.cuisine_type
             FROM main_table t,
                  unnest(string_to_array(t.cuisines, ',')) s(cuisine_type)
             where s.cuisine_type != 'NA'
         ) x
    order by id, cuisine_type
)
