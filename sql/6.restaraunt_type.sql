create view restaraunt_type as (
    select id,
           trim(r_type) as r_type
    from (
             SELECT id,
                    s.r_type
             FROM main_table t,
                  unnest(string_to_array(t.rest_type, ',')) s(r_type)
             where s.r_type != 'NA'
         ) x
    order by id, r_type
)
