CREATE EXTERNAL TABLE  if not exists t_base_ec_item_sale_dev_new (
item_id	 STRING  COMMENT  '商品id',
r_price    float COMMENT '原价',
s_price   float COMMENT '售价',
quantity  BIGINT	COMMENT '库存',
total_sold  BIGINT COMMENT '总销量',
order_cost  BIGINT COMMENT '',
ts	  STRING COMMENT '采集时间戳'
)
COMMENT '电商商品用户销量状态表'
PARTITIONED BY  (ds STRING )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' LINES TERMINATED BY '\n' ;
-- stored as textfile location '/hive/external/wlbase_dev/t_base_ec_item_sale_dev/';
-- 补充title
