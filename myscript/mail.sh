#!/bin/bash
source base.sh
title=$1
content=$2
mailname=$3
java -cp $LOCAL/lib/sendmailudf:$LOCAL/lib/sendmailudf/* com.ipinyou.sendmail.Send "$title" "$content" "$mailname"
