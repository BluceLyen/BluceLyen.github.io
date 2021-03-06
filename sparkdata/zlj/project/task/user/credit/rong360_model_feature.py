#coding:utf-8

__author__ = 'zlj'
import sys

reload(sys)
sys.setdefaultencoding('utf8')

from pyspark import SparkContext
from pyspark.sql import *
from pyspark.sql.types import *
from pyspark import SparkConf
# import rapidjson as json
conf = SparkConf()
conf.set("spark.hadoop.validateOutputSpecs", "false")
conf.set("spark.kryoserializer.buffer.mb", "1024")
conf.set("spark.akka.frameSize", "100")
conf.set("spark.network.timeout", "1000s")
conf.set("spark.driver.maxResultSize", "8g")

sc = SparkContext(appName="user_cattags", conf=conf)

sqlContext = SQLContext(sc)
hiveContext = HiveContext(sc)
from pyspark.mllib.util import MLUtils
from pyspark.mllib.stat import Statistics
from pyspark.mllib.feature import ChiSqSelector
from pyspark.mllib.linalg import Vectors
from pyspark.mllib.regression import LabeledPoint


chi_index=set([26,
31,
107,
143,
266,
312,
404,
591,
657,
663,
845,
906,
922,
927,
1061,
1118,
1152,
1215,
1241,
1363,
1401,
1403,
1410,
1450,
1455,
1548,
1549,
1557,
1569,
1667,
1682,
1689,
1796,
1840,
1843,
1863,
1887,
1953,
1983,
2097,
2140,
2141,
2162,
2186,
2255,
2298,
2320,
2406,
2439,
2507,
2558,
2579,
2664,
2802,
2995,
3094,
3105,
3117,
3137,
3173,
3200,
3283,
3303,
3342,
3397,
3512,
3553,
3599,
3631,
3682,
3729,
3968,
3972,
4067,
4135,
4171,
4286,
4295,
4381,
4384,
4462,
4562,
4620,
4624,
4638,
4820,
4829,
4872,
4902,
4933,
4937,
4949,
5070,
5101,
5124,
5243,
5282,
5293,
5330,
5397,
5400,
5447,
5456,
5619,
5655,
5661,
5768,
5776,
5819,
5861,
5867,
5922,
5978,
5995,
6001,
6024,
6144,
6159,
6169,
6226,
6229,
6368,
6411,
6420,
6425,
6460,
6521,
6618,
6645,
6671,
6686,
6701,
6734,
6738,
6768,
6809,
6829,
6831,
6862,
6931,
6937,
6938,
7076,
7262,
7275,
7350,
7593,
7714,
7813,
7884,
7947,
7955,
7994,
8076,
8156,
8204,
8232,
8287,
8605,
8899,
8991,
9223,
9321,
9381,
9527,
9790,
9791,
9944,
10060,
10074,
10229,
10328,
10339,
10491,
10503,
10544,
10658,
10708,
10853,
10896,
11067,
11150,
11254,
11324,
11593,
11672,
11755,
11767,
11768,
11772,
11777,
11943,
11959,
11965,
11967,
11975,
12034,
12047,
12065,
12066,
12073,
12098,
12103,
12198,
12212,
12226,
12234,
12266,
12336,
12367,
12383,
12408,
12409,
12421,
12483,
12500,
12558,
12564,
12573,
12596,
12710,
12714,
12765,
12796,
12798,
12817,
12937,
12986,
13037,
13053,
13108,
13128,
13248,
13290,
13488,
13489,
13571,
13621,
13655,
13686,
13766,
13910,
13931,
13952,
13996,
14006,
14189,
14195,
14197,
14285,
14293,
14300,
14331,
14408,
14439,
14524,
14525,
14550,
14600,
14673,
14712,
14756,
14885,
14889,
14948,
14973,
15008,
15032,
15083,
15121,
15362,
15386,
15407,
15470,
15548,
15618,
15641,
15691,
15747,
15776,
15837,
15863,
16061,
16118,
16230,
16377,
16387,
16528,
16544,
16681,
16972,
16981,
17141,
17248,
17334,
17461,
17522,
17604,
17702,
17726,
17962,
18283,
18378,
18417,
18560,
18576,
18794,
18858,
18922,
18960,
19025,
19100,
19152,
19294,
19309,
19533,
19591,
19648,
19683,
19740,
19832,
19859,
19867,
19892,
19907,
19921,
19939,
20037,
20123,
20128,
20153,
20159,
20164,
20175,
20192,
20229,
20234,
20262,
20280,
20312,
20316,
20340,
20356,
20408,
20416,
20451,
20456,
20469,
20495,
20497,
20507,
20545,
20670,
20679,
20718,
20847,
20868,
20913,
20955,
20983,
20987,
21152,
21205,
21227,
21241,
21249,
21264,
21321,
21339,
21379,
21391,
21424,
21439,
21568,
21577,
21587,
21622,
21656,
21720,
21740,
21776,
21861,
21867,
21939,
21991,
22003,
22013,
22052,
22074,
22097,
22196,
22260,
22280,
22285,
22302,
22383,
22392,
22409,
22477,
22577,
22600,
22609,
22635,
22642,
22684,
22723,
22791,
23030,
23095,
23126,
23201,
23224,
23387,
23486,
23515,
23587,
23616,
23641,
23691,
23720,
23781,
23883,
23987,
24165,
24326,
24925,
24954,
24993,
25183,
25190,
25240,
25248,
25367,
25594,
25607,
25702,
25788,
25802,
25939,
26102,
26109,
26147,
26209,
26221,
26226,
26246,
26255,
26343,
26359,
26387,
26393,
26399,
26432,
26485,
26489,
26536,
26538,
26543,
26559,
26627,
26672,
26709,
26771,
26776,
26812,
26827,
26854,
26870,
26955,
26972,
26990,
27026,
27093,
27094,
27104,
27158,
27218,
27228,
27245,
27247,
27299,
27315,
27471,
27559,
27574,
27613,
27623,
27775,
27803,
27805,
27879,
28016,
28050,
28213,
28254,
28261,
28270,
28327,
28371,
28410 ])
'''
  35049_4:18.9 35049_5:18.9 35049_6:0.0 35034_1:16.9 35034_2:1
返回: 特征名字
'''
def get_feature_name(line):
    return set([ i.split(':')[0] for i in line.split()])

'''
35049_1:18.9 35049_2:1 35049_3:18.9
return:1:18.9 2:1 3:18.9
'''
def get_feature_index(line ,dic):
    ls=[(dic[i.split(':')[0]],i.split(':')[1] )for i in line.split() if float(i.split(':')[1])>0.5]
    sort_data=sorted(ls,key=lambda x:x[0])
    return ' '.join([str(k)+':'+str(float(v)) for k,v in sort_data])

def get_feature_index_fiter(line ,dic,chi_index_value):
    lv=[(dic[i.split(':')[0]],i.split(':')[1] )for i in line.split() if float(i.split(':')[1])>0.5]
    ls=[(k,v) for k,v in  lv if k in chi_index_value ]
    sort_data=sorted(ls,key=lambda x:x[0])
    return ' '.join([str(k)+':'+str(float(v)) for k,v in sort_data])


# hiveContext.sql('use wlbase_dev')

rdd= hiveContext.sql('''select t2.tel ,t2.label,t1.feature
from wlservice.t_zlj_tmp_rong360_1w_record_level3_feature   t1 join (SELECT  tel,'8000_c' as class , id1 as label,id3 as gender,id4 as age
   from
   wlfinance.t_zlj_base_match where ds="ygz_part"
   ) t2 on t1.tel=t2.tel
''')

featurs=rdd[['feature']].map(lambda x:get_feature_name(x.feature)).flatMap(lambda x:x).distinct().collect()
featur_index={v:index for index,v in enumerate(featurs,1)}
featur_index_value = sc.broadcast(featur_index).value

chi_index_map={v:index for index,v in enumerate(chi_index,1)}
chi_index_value=sc.broadcast(chi_index_map).value

rdd.map(lambda x:x.label+' '+get_feature_index(x.feature,featur_index_value)).saveAsTextFile('/user/zlj/tmp/cat3_libsvm')
rdd.map(lambda x:x.tel+' '+get_feature_index(x.feature,featur_index_value)).saveAsTextFile('/user/zlj/tmp/cat3_libsvm_tel')

lp=rdd.map(lambda x:x.label+' '+get_feature_index(x.feature,featur_index_value))\
    .map(lambda x:MLUtils._parse_libsvm_line(x))\
    .map(lambda x:LabeledPoint(x[0],Vectors.sparse(40000, x[1], x[2])))

model=ChiSqSelector(100).fit(lp)

lp.map(lambda x:(x[0],model.transform(x[1])))
model.transform(lp)



sc.parallelize(sc.textFile('/user/zlj/tmp/cat3_libsvm/part-00092').take(30)[0]).saveAsTextFile('/user/zlj/tmp/test1')


values=MLUtils._parse_libsvm_line(t1.take(20)[3])[1]
def check(value):
    size=len(value)
    for  i in xrange(size):
        if i+1<size and value[i]>value[i+1]:
            print '-----'


for i,v in enumerate(values):
    if v> values[i+1]: print '----'
# .saveAsTextFile('/user/zlj/tmp/featue')

# rdd['f']rdd[['_c1']].map(lambda x:MLUtils._parse_libsvm_line('1 '+get_feature_index(x._c1,featur_index_value)))
#
# rdd.withColumn('f_spare',MLUtils._parse_libsvm_line('1 '+get_feature_index(rdd._c1,featur_index_value)))

# MLUtils._parse_libsvm_line()