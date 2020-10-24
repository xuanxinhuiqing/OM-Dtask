SELECT date_format(from_unixtime(ts / 1000,'UTC'), '%Y-%m-%d')  AS day,
       date_format(from_unixtime(ts / 1000, 'UTC'), '%H') AS hour,
       country,
       coalesce(plat, -1)                                 AS platform,
       coalesce(publisherId, 0)                           AS publisher_id,
       coalesce(pubAppId, 0)                              AS pub_app_id,
       coalesce(pid, 0)                                   AS placement_id,
       coalesce(iid, 0)                                   AS instance_id,
       coalesce(scene, 0)                                 AS scene_id,
       coalesce(mid, 0)                                   AS adn_id,
       coalesce(abt, 0)                                   AS abt,
       coalesce(bid, 0)                                   AS bid,
       sum(if(type = 2, 1, 0))                            AS waterfall_request,
       sum(if(type = 3, 1, 0))                            AS waterfall_filled,
       sum(if(type = 4, 1, 0))                            AS instance_request,
       sum(if(type = 5, 1, 0))                            AS instance_filled,
       sum(if(type = 8, 1, 0))                            AS video_start,
       sum(if(type = 9, 1, 0))                            AS video_complete,
       sum(if(type = 501, 1, 0))                          AS called_show,
       sum(if(type = 502, 1, 0))                          AS is_ready_true,
       sum(if(type = 503, 1, 0))                          AS is_ready_false,
       sum(if(type = 7, 1, 0))                            AS click,
       sum(if(type = 6, 1, 0))                            AS impr,
       sum(if(type = 270, 1, 0))                          AS bid_req,
       sum(if(type = 271, 1, 0))                          AS bid_resp,
       sum(if(type = 271, coalesce(price, 0), 0))         AS bid_resp_price,
       sum(if(type = 273, 1, 0))                          AS bid_win,
       sum(if(type = 273, coalesce(price, 0), 0))         AS bid_win_price
FROM [(${tableName})]
WHERE
    ts IS NOT NULL
    AND y='[(${year})]'
    AND m='[(${month})]'
    AND d='[(${day})]'
    AND h='[(${hour})]'
GROUP BY
    date_format(from_unixtime(ts / 1000, 'UTC'), '%Y-%m-%d'),
    date_format(from_unixtime(ts / 1000, 'UTC'), '%H'),
    country,
    coalesce(plat, -1),
    coalesce(publisherId, 0),
    coalesce(pubAppId, 0),
    coalesce(pid, 0),
    coalesce(iid, 0),
    coalesce(scene, 0),
    coalesce(mid, 0),
    coalesce(abt, 0),
    coalesce(bid, 0)
;
