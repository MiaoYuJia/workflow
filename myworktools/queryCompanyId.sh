#!/bin/bash
export LANG="en_US.UTF-8"
name=$1
echo 'query company name:'  $name
sql2csv  --db 'mysql://data:PIN239!@#$%^&8@192.168.156.39/amp?charset=utf8' --query "select distinct id, company_id, name from advertiser where name like '%%$name%%' " -v |csvlook
