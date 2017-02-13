#!/bin/bash
export LANG="en_US.UTF-8"
companyid=$1
adverid=$2
cateid=$3
desc=$1_$3


sql="INSERT INTO advertiser_audience_tag  VALUES ('null', 0, SYSDATE(), SYSDATE(), 0,1,'$adverid', '$companyid', '$desc', '$cateid', '', '$desc')"
function run_239_optimus()
{
mysql \
        --default-character-set=utf8 \
        -h 192.168.144.239 \
        -u data -p'PIN239!@#$%^&8' \
        -D amp \
	-e "$sql"
}
run_239_optimus;
