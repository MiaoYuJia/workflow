#!/bin/bash
tname=$1
tcol=$2
tlocation=$3

if [ "${#@}" != 3 ];then
        echo "Error : $(basename $0) 请输入4个参数：tname, tcol, tlocaltion"
        exit -1
fi 


tcols=`echo $2 | awk 'BEGIN {FS="#"; OFS="\n"}  END{ for(i=1;i<=NF;i++)  if(i!=NF)  {print $i " string," } else {print $i " string"}  }'`

sql="use yujia;CREATE EXTERNAL TABLE $tname(
 $tcols )
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\t'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  '$tlocation'"

echo $sql
hive -e "use yujia;$sql"
