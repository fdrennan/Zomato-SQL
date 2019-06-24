create view rating_text as (
    with unnested_data as (
        select id,
               unnest(rl) as rl
        from (
                 select id,
                        string_to_array(
                                reviews_list, '), (') as rl
                 from main_table
             ) x
    ),
         replaced_data as (
             select *,
                    row_number() over () as comment_id
             from (
                      select id,
                             regexp_replace(
                                     regexp_replace(rl, '[\[][\(]', ''),
                                     '[\)][\]]',
                                     ''
                                 ) as review
                      from unnested_data
                  ) x
         ),
         unnested_comment_id as (
             select *,
                    row_number() over () as type
             from (
                      SELECT id,
                             comment_id,
                             s.dish
                      FROM replaced_data t,
                           unnest(string_to_array(t.review, 'RATED\n')) s(dish)
                      where s.dish != 'NA'
                  ) x
         ),
         create_is_rating as (
             select *
             from (
                      select id,
                             comment_id,
                             dish,
                             row_number() over (partition by id, comment_id order by type) as is_rating
                      from unnested_comment_id
                  ) x
         ),
         rating_to_numeric as (
             select id,
                    comment_id,
                    dish,
                    is_rating = 1 as is_rating
             from create_is_rating
         )

    select id,
           comment_id,
           dish as rating_text
    from rating_to_numeric
    where is_rating is false
)
