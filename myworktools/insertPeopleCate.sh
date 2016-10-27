#!/bin/bash
export LANG="en_US.UTF-8"
companyid=$1
cateid=$2
desc=$1_$2


function run_239_optimus()
{
/usr/bin/mysql \
        --default-character-set=utf8 \
        -h 192.168.144.239 \
        -u data -p'PIN239!@#$%^&8' \
        -D optimus \
        -e "INSERT INTO advertiser_audience_classify VALUES (NULL, 1, SYSDATE(), SYSDATE(), $companyid, '$desc', $cateid, 1, 0, '$desc', 0, NULL)"
}
run_239_optimus;
