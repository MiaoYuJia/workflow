#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import json
from pyspark import SparkConf, SparkContext
from pyspark.sql import HiveContext

sql=""
ip=""
db_name=""
table_name=""
user=""
password=""
hdfs_dir=""
url=""

fin = open(sys.argv[1]).read()
print("fin : "+fin)
js=json.loads(fin)
ip=js["ip"]
sql=js["sql"]
db_name=js["db_name"]
table_name=js["table_name"]
user=js["username"]
password=js["password"]
hdfs_dir=js["hdfs_dir"]
AppName=js["AppName"]

conf = SparkConf().setAppName(AppName)
sc = SparkContext(conf = conf)

conf.set("spark.executor.memory","2g")
#conf.set("spark.dynamicAllocation.enabled","false")
conf.set("spark.default.parallelism","100")
conf.set("spark.yarn.max.executor.failures","300")
conf.set("queue","normal")



sqlContext = HiveContext(sc)
result=sqlContext.sql(sql)
resultRDD = result.map(lambda row: [(isinstance(c, int) or c==None or isinstance(c, float)) and str(c) or str(c.encode('utf-8')) for c in row]).map(lambda line : "\t".join(line))
resultRDD = resultRDD.coalesce(1000)
resultRDD.repartition(10).saveAsTextFile(hdfs_dir)
#resultRDD.saveAsTextFile(hdfs_dir)

if ip != "" and db_name != "" and table_name != "" and user != "" and password != "" :
	url="jdbc:mysql://"+ip+"/"+db_name+"?useUnicode=true&characterEncoding=utf-8"
	try :
		sqoop="sqoop export -D mapreduce.job.queuename=important --connect '"+url+"' --username "+user+" --password '"+password+"' -m 1 --table "+table_name+" --export-dir "+hdfs_dir+"/p*"+" --input-fields-terminated-by '\\t'"
		print("sqoop = "+sqoop)
		os.system(sqoop)
	except :
		print("insert database failure")

else :
	print("There's no ip input!")


print("program finish!")
# SparkContext shutdown
sc.stop()
