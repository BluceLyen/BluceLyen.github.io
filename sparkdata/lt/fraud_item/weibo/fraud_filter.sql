--#关键词更新0510
'''
1)贷款类:
放款|下款|套现|急用钱|提额|薅羊毛|撸羊毛|51人品|利息低|网赚教程|玩转信用卡|网贷技术|等额本息|缺钱找我|费率|金融一体机|蓝牙POS|银行小贷|当天下款|极速放款|当天放款|提额技术|半小时下款|大额贷款|信用卡t现|白条T现|小额代款|养卡神器|养卡专家|专业放款|大额放款|快速放款|小额放款|放款快|信用k

底费率|低费率|刷卡|Tao现|银联POS|poss机|pos机|手机刷卡器|刷卡器|一清机|瑞刷|刷卡机|微粒贷|团贷网|有用分期|宜人贷|钱宝网|平安易贷|你我贷|微贷网|分期贷|翼龙贷|卡融|养K|养ka|借贷宝|消费贷|友信|花呗|借呗|白条|任性付|大学生贷款|京东白条|唯品会额度|分期乐|趣分期|学历贷|p2p|信用贷|宜信|普惠|借款宝|贷呗宝|极速贷|温州贷|玖富|精英贷|社保贷|平安普惠|好贷|陆金所|红岭创投|拍拍贷|人人贷|易贷网|小微贷|百度钱包|极速贷|手机贷|现金贷|丽人贷|拿去花|有利网|诺诺镑客|随心贷|今借到|公积金贷|下卡|网贷|借贷|借款|低息|利率|避税|刷现|放贷|刷现|代办|代刷|互刷|代还|典当|口子|额度|车贷|提额|养卡|提现|借钱|黑户|白户|二手房|房贷|办理|信贷|放款|放米|下款|信用卡|担保|投资理财|理财投资|融资|提现|质押|抵押|贷款|贷款咨询|贷款资讯|二手房买卖|理财咨询师|银行贷款|债权追讨|买车买房|专业贷款|贷款公司|企业贷款|企业融资|银行抵押|资金需要|低息贷款|金融机构|投资理财|金融贷款|房产抵押|土地抵押|贷款指南|信用借款|小额贷款|小额借款|快速贷款|信用贷款|急用钱|应急贷款|包装贷款|贷款包装|大额空放|过桥解压|民间贷款|贷款找我|按揭贷款|公积金贷款|利息低|刷卡贷款|消费贷款|个人贷款|小额信贷|投资贷款|网络贷款|资金需求|要贷款的来找我|各类贷款|贷款软件|平安贷款|二手房过户|贷款数据库|民间借贷|专业车贷|平安车贷|汽车贷款|急需钱|金融服务|债务催收|个人借款|身份证借款|资金周转|借款咨询|秒借|借款服务|私人借款|利信借款|学生借款|闪电借款|撸白菜|挖白菜|撸钱口子|急需资金|银行放款|养卡服务|专业养卡|养卡神器|精养卡|贷款技术|积分机|银行信贷|专业放贷|不看征信|无视黑白|银行放贷|小额放贷|小额信贷|极速放贷|小额借贷|诚信贷|投标助手|无需担保|新新贷|小贷口子|金融口子|找我|联系我|办卡|贷款详询|资金短缺|缺钱|秒到|裸贷|捷信|拆借|贷款需求


2)造假类
社保挂靠|盗取QQ号密码|手机监听|信用卡不良记录|代做银行流水|淘宝刷信誉|彩票游戏|开房记录查|代接银行回访电话

营销软件|电话回访|注册补量|回访电话|网站注册|注册回访|赚钱|兼职|兼职推广|解套赚钱|投资项目|网络兼职|淘宝刷单|淘宝兼职|网赚|日赚|暴利项目|偏门|网上兼职|工资日结|薪水日结|博彩公司|娱乐游戏|网上博彩|技巧|真人百家乐|专业网上博彩|刷单套利|双色球|重庆时时彩|时时彩|时时彩改单软件

正常词:
下卡拉卡|助学贷款|奔放|款待|负二代|款号|款爷|成套|好戏|无房|无车|无贷款|有房|有车|贷款买房


'''

CREATE TABLE  if not exists wl_service.t_lt_weibo_filter_user_py (
id STRING  COMMENT  '微博用户id',
name  STRING   COMMENT '用户昵称',
description STRING  COMMENT '用户个人描述',
fscore_1 BIGINT ,
fscore_11 BIGINT ,
fscore_2 BIGINT ,
d_fscore_1 BIGINT ,
d_fscore_11 BIGINT ,
d_fscore_2 BIGINT ,
keywords string,
d_keywords STRING,
normal_w string
)
COMMENT '微博异常用户筛选初表'
PARTITIONED by (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001'  LINES TERMINATED BY '\n' stored as textfile;


load data INPATH '/user/lt/weibo/0510/part*' into TABLE wl_service.t_lt_weibo_filter_user_py PARTITION (ds='20170510');


--=====规则筛选===
insert overwrite TABLE wl_service.t_lt_weibo_fraud_user_week
SELECT id,name,description,(fscore_1+fscore_11+fscore_2) as fraud_score_name,
(d_fscore_1+d_fscore_11+d_fscore_2) as fraud_score_desc,keywords as keywords_name,
d_keywords as keywords_desc from
(SELECT * from wl_service.t_lt_weibo_filter_user_py
where (fscore_1>0 or  fscore_11>1 or fscore_2>1) and keywords not in ('提额','放款','下款','费率','营销软件')
and length(regexp_replace(name,'下卡拉卡|助学贷款|负二代',''))=length(name)
union all
SELECT * from wl_service.t_lt_weibo_filter_user_py
where (d_fscore_1>0 or d_fscore_11>1 or d_fscore_2>1)
and length(regexp_replace(description,'下卡拉卡|助学贷款|奔放|款待|款号|款爷|成套|好戏',''))=length(description)
union all
SELECT * from wl_service.t_lt_weibo_filter_user_py
where d_fscore_1=1 and fscore_1=1
union ALL
SELECT * from wl_service.t_lt_weibo_filter_user_py
where d_keywords in ('贷款','POS机')
and length(regexp_replace(description,'助学贷款|奔放|款待|无房|无车|无贷款|有房|有车|贷款买房',''))=length(description)
)t
group by id,name,description,fscore_1,fscore_11,fscore_2,d_fscore_1,d_fscore_11,d_fscore_2,keywords,d_keywords












--analysis


--1.all friends of fraud weibo user
create table wl_service.t_lt_weibo_fruad_id_follows as
SELECT snwb,friend from
(SELECT t2.* from
(SELECT id from wl_analysis.t_lt_weibo_fraud_usr)t1
join
(SELECT * FROM wl_service.t_lt_weibo_usr_fri_multline)t2
on t1.id=t2.snwb
union all
SELECT t2.* from
(SELECT id from wl_analysis.t_lt_weibo_fraud_usr)t1
join
(SELECT * FROM wl_service.t_lt_weibo_usr_fri_multline)t2
on t1.id=t2.friend)t
group by snwb,friend

--bifollow users's info
create table t_lt_weibo_fraud_usr_tmp as
SELECT t1.*,t2.name as name_a,t2.description as description_a,
t2.keywords_name as keywords_a,t2.keywords_disc as desc_key_a from
(SELECT * FROM wl_service.t_lel_weibo_abnomal_fri) t1
left join
(SELECT * from wl_analysis.t_lt_weibo_fraud_usr) t2
on t1.ida=t2.id

drop table t_lt_weibo_fraud_usr_bifollow_info;
create table t_lt_weibo_fraud_usr_bifollow_info as
SELECT t1.*,t2.name as name_b,t2.description as description_b,
t2.keywords_name as keywords_b,t2.keywords_disc as desc_key_b from
(SELECT * FROM wl_analysis.t_lt_weibo_fraud_usr_tmp) t1
left join
(SELECT * from wl_analysis.t_lt_weibo_fraud_usr) t2
on t1.idb=t2.id

drop table t_lt_weibo_fraud_usr_tmp;

