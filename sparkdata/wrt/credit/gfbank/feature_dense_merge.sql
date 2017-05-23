--密集表合并
drop table wlcredit.t_wrt_gfbank_dense_features;
create table wlcredit.t_wrt_gfbank_dense_features as
SELECT
tt1.*,
tt2.alipay_flag,
tt2.buycnt,
tt2.verify_level,
tt2.regtime_month,
tt2.buy_freq,
tt2.model_predict_gender
from
(
select
--由于是left join 所以某些特征值会生成null，后面python处理会处理掉。
t1.tel_index,
t1.monthall_price_sum,
t1.monthall_buy_count,
t1.monthall_price_avg,
t1.monthall_price_max,
t1.monthall_price_min,
t1.monthall_price_std,
t1.monthall_price_median,
t1.monthall_price_cross,
t1.monthall_price_025,
t1.monthall_price_075,
t1.monthall_price_010,
t1.monthall_annoy_num,
t1.monthall_annoy_ratio,
t1.monthall_brand_id_num,
t1.monthall_root_cat_id_num,
t1.monthall_b_bc_type_num,
t1.monthall_b_bc_type_num_ratio,
t1.monthall_b_bc_price_ratio,
t1.monthall_brand_effec_price_ratio,
t1.monthall_brand_effec_num_ratio,
t1.monthall_b50_num_ratio,
t1.monthall_b50_ratio,
t1.monthall_b30_num_ratio,
t1.monthall_b30_ratio,
t1.monthall_b10_num_ratio,
t1.monthall_b10_ratio,
t1.monthall_b5_num_ratio,
t1.monthall_b5_ratio,
t1.monthall_b50_10_num_ratio,
t1.monthall_b50_9_num_ratio,
t1.monthall_b50_8_num_ratio,
t1.monthall_b50_7_num_ratio,
t1.monthall_b50_6_num_ratio,
t1.monthall_b50_5_num_ratio,
t1.monthall_b50_4_num_ratio,
t1.monthall_b50_3_num_ratio,
t1.monthall_b50_2_num_ratio,
t1.monthall_b50_1_num_ratio,
t1.monthall_b50_0_num_ratio,
t1.monthall_b50_10_ratio,
t1.monthall_b50_9_ratio,
t1.monthall_b50_8_ratio,
t1.monthall_b50_7_ratio,
t1.monthall_b50_6_ratio,
t1.monthall_b50_5_ratio,
t1.monthall_b50_4_ratio,
t1.monthall_b50_3_ratio,
t1.monthall_b50_2_ratio,
t1.monthall_b50_1_ratio,
t1.monthall_b50_0_ratio,
t1.monthall_active_score,
t2.month6_price_sum,
t2.month6_buy_count,
t2.month6_price_avg,
t2.month6_price_max,
t2.month6_price_min,
t2.month6_price_std,
t2.month6_price_median,
t2.month6_price_cross,
t2.month6_price_025,
t2.month6_price_075,
t2.month6_price_010,
t2.month6_annoy_num,
t2.month6_annoy_ratio,
t2.month6_brand_id_num,
t2.month6_root_cat_id_num,
t2.month6_b_bc_type_num,
t2.month6_b_bc_type_num_ratio,
t2.month6_b_bc_price_ratio,
t2.month6_brand_effec_price_ratio,
t2.month6_brand_effec_num_ratio,
t2.month6_b50_num_ratio,
t2.month6_b50_ratio,
t2.month6_b30_num_ratio,
t2.month6_b30_ratio,
t2.month6_b10_num_ratio,
t2.month6_b10_ratio,
t2.month6_b5_num_ratio,
t2.month6_b5_ratio,
t2.month6_b50_10_num_ratio,
t2.month6_b50_9_num_ratio,
t2.month6_b50_8_num_ratio,
t2.month6_b50_7_num_ratio,
t2.month6_b50_6_num_ratio,
t2.month6_b50_5_num_ratio,
t2.month6_b50_4_num_ratio,
t2.month6_b50_3_num_ratio,
t2.month6_b50_2_num_ratio,
t2.month6_b50_1_num_ratio,
t2.month6_b50_0_num_ratio,
t2.month6_b50_10_ratio,
t2.month6_b50_9_ratio,
t2.month6_b50_8_ratio,
t2.month6_b50_7_ratio,
t2.month6_b50_6_ratio,
t2.month6_b50_5_ratio,
t2.month6_b50_4_ratio,
t2.month6_b50_3_ratio,
t2.month6_b50_2_ratio,
t2.month6_b50_1_ratio,
t2.month6_b50_0_ratio,
t2.month6_active_score,
t3.month1_price_sum,
t3.month1_buy_count,
t3.month1_price_avg,
t3.month1_price_max,
t3.month1_price_min,
t3.month1_price_std,
t3.month1_price_median,
t3.month1_price_cross,
t3.month1_price_025,
t3.month1_price_075,
t3.month1_price_010,
t3.month1_annoy_num,
t3.month1_annoy_ratio,
t3.month1_brand_id_num,
t3.month1_root_cat_id_num,
t3.month1_b_bc_type_num,
t3.month1_b_bc_type_num_ratio,
t3.month1_b_bc_price_ratio,
t3.month1_brand_effec_price_ratio,
t3.month1_brand_effec_num_ratio,
t3.month1_b50_num_ratio,
t3.month1_b50_ratio,
t3.month1_b30_num_ratio,
t3.month1_b30_ratio,
t3.month1_b10_num_ratio,
t3.month1_b10_ratio,
t3.month1_b5_num_ratio,
t3.month1_b5_ratio,
t3.month1_b50_10_num_ratio,
t3.month1_b50_9_num_ratio,
t3.month1_b50_8_num_ratio,
t3.month1_b50_7_num_ratio,
t3.month1_b50_6_num_ratio,
t3.month1_b50_5_num_ratio,
t3.month1_b50_4_num_ratio,
t3.month1_b50_3_num_ratio,
t3.month1_b50_2_num_ratio,
t3.month1_b50_1_num_ratio,
t3.month1_b50_0_num_ratio,
t3.month1_b50_10_ratio,
t3.month1_b50_9_ratio,
t3.month1_b50_8_ratio,
t3.month1_b50_7_ratio,
t3.month1_b50_6_ratio,
t3.month1_b50_5_ratio,
t3.month1_b50_4_ratio,
t3.month1_b50_3_ratio,
t3.month1_b50_2_ratio,
t3.month1_b50_1_ratio,
t3.month1_b50_0_ratio,
t3.month1_active_score,
t4.month3_price_sum,
t4.month3_buy_count,
t4.month3_price_avg,
t4.month3_price_max,
t4.month3_price_min,
t4.month3_price_std,
t4.month3_price_median,
t4.month3_price_cross,
t4.month3_price_025,
t4.month3_price_075,
t4.month3_price_010,
t4.month3_annoy_num,
t4.month3_annoy_ratio,
t4.month3_brand_id_num,
t4.month3_root_cat_id_num,
t4.month3_b_bc_type_num,
t4.month3_b_bc_type_num_ratio,
t4.month3_b_bc_price_ratio,
t4.month3_brand_effec_price_ratio,
t4.month3_brand_effec_num_ratio,
t4.month3_b50_num_ratio,
t4.month3_b50_ratio,
t4.month3_b30_num_ratio,
t4.month3_b30_ratio,
t4.month3_b10_num_ratio,
t4.month3_b10_ratio,
t4.month3_b5_num_ratio,
t4.month3_b5_ratio,
t4.month3_b50_10_num_ratio,
t4.month3_b50_9_num_ratio,
t4.month3_b50_8_num_ratio,
t4.month3_b50_7_num_ratio,
t4.month3_b50_6_num_ratio,
t4.month3_b50_5_num_ratio,
t4.month3_b50_4_num_ratio,
t4.month3_b50_3_num_ratio,
t4.month3_b50_2_num_ratio,
t4.month3_b50_1_num_ratio,
t4.month3_b50_0_num_ratio,
t4.month3_b50_10_ratio,
t4.month3_b50_9_ratio,
t4.month3_b50_8_ratio,
t4.month3_b50_7_ratio,
t4.month3_b50_6_ratio,
t4.month3_b50_5_ratio,
t4.month3_b50_4_ratio,
t4.month3_b50_3_ratio,
t4.month3_b50_2_ratio,
t4.month3_b50_1_ratio,
t4.month3_b50_0_ratio,
t4.month3_active_score,
t5.month12_price_sum,
t5.month12_buy_count,
t5.month12_price_avg,
t5.month12_price_max,
t5.month12_price_min,
t5.month12_price_std,
t5.month12_price_median,
t5.month12_price_cross,
t5.month12_price_025,
t5.month12_price_075,
t5.month12_price_010,
t5.month12_annoy_num,
t5.month12_annoy_ratio,
t5.month12_brand_id_num,
t5.month12_root_cat_id_num,
t5.month12_b_bc_type_num,
t5.month12_b_bc_type_num_ratio,
t5.month12_b_bc_price_ratio,
t5.month12_brand_effec_price_ratio,
t5.month12_brand_effec_num_ratio,
t5.month12_b50_num_ratio,
t5.month12_b50_ratio,
t5.month12_b30_num_ratio,
t5.month12_b30_ratio,
t5.month12_b10_num_ratio,
t5.month12_b10_ratio,
t5.month12_b5_num_ratio,
t5.month12_b5_ratio,
t5.month12_b50_10_num_ratio,
t5.month12_b50_9_num_ratio,
t5.month12_b50_8_num_ratio,
t5.month12_b50_7_num_ratio,
t5.month12_b50_6_num_ratio,
t5.month12_b50_5_num_ratio,
t5.month12_b50_4_num_ratio,
t5.month12_b50_3_num_ratio,
t5.month12_b50_2_num_ratio,
t5.month12_b50_1_num_ratio,
t5.month12_b50_0_num_ratio,
t5.month12_b50_10_ratio,
t5.month12_b50_9_ratio,
t5.month12_b50_8_ratio,
t5.month12_b50_7_ratio,
t5.month12_b50_6_ratio,
t5.month12_b50_5_ratio,
t5.month12_b50_4_ratio,
t5.month12_b50_3_ratio,
t5.month12_b50_2_ratio,
t5.month12_b50_1_ratio,
t5.month12_b50_0_ratio,
t5.month12_active_score
from
wlcredit.t_gfbank_record_feature t1
left JOIN
wlcredit.t_gfbank_record_feature_6month t2
ON
t1.tel_index = t2.tel_index
left JOIN
wlcredit.t_gfbank_record_feature_1month t3
ON
t1.tel_index = t3.tel_index
LEFT JOIN
wlcredit.t_gfbank_record_feature_3month t4
ON
t1.tel_index = t4.tel_index
left JOIN
wlcredit.t_gfbank_record_feature_12month t5
ON
t1.tel_index = t5.tel_index
)tt1
left JOIN
wlcredit.t_credit_user_profile_feature tt2
ON
tt1.tel_index = tt2.tel_index;