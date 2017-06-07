now_day=$1
hive<<EOF

use wlservice;
insert overwrite table t_wrt_znk_othercat
select t2.user_id,
case when t2.cat_id in
(
50003470,
122644010,
121970005,
50023749,
122340001,
122368003
)then "拐杖"
when t2.cat_id in
(
50020822,
121964004,
122334003,
50003469,
50010610,
122644011
)then "轮椅"
when t2.cat_id in
(
50018996,
50018994
)then "卷筒纸"
when t2.cat_id in
(
50023296,
50023292,
121396029,
213202,
50025721,
50014337,
50009294,
50009295,
50025162
)then "洗发水"
when t2.cat_id in
(
213205,
50013973,
50009290,
121386011,
121366036,
121484010,
50025163
)then "沐浴乳"
when t2.cat_id in
(
50014004,
50018977,
50009296
)then "洗衣液"
when t2.cat_id in
(
50022648,
50003459,
50025787,
50025788
)then "拖把"
when t2.cat_id = "50014008"
then "消毒液"
when
(
t2.cat_id in (50012081,1512)
and t2.title like '%老年%'
)
then "老年机"
when
(
t2.cat_id in (50000852,123334002,50016587,162703,50022728,50001748,50003509)
and t2.title like '%老年%'
)
then "老年服装"
else "-"
end,
t2.dsn
from
(select user_id from t_wrt_znk_development_data where ds = '$now_day' group by  user_id)t1
join
(select user_id,cat_id,dsn,title from wl_base.t_base_ec_record_dev_new where ds = 'true' and
(
cat_id in
(
50003470,
122644010,
121970005,
50023749,
122340001,
122368003,
50020822,
121964004,
122334003,
50003469,
50010610,
122644011,
50018996,
50018994,
50023296,
50023292,
121396029,
213202,
50025721,
50014337,
50009294,
50009295,
50025162,
213205,
50013973,
50009290,
121386011,
121366036,
121484010,
50025163,
50014004,
50018977,
50009296,
50022648,
50003459,
50025787,
50025788,
50014008
)
OR
(
cat_id in
(
50012081,
1512,
50000852,
123334002,
50016587,
162703,
50022728,
50001748,
50003509
)
and
title like '%老年%'
)
)
)t2
on
t1.user_id = t2.user_id;
EOF