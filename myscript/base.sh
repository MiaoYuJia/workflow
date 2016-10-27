#! /bin/sh
#
# Script Name : 
# Description : 
# Author      : 
# Created     : 

export LANG=en_US.UTF-8

#自定义函数区域，定义了log()、 BeginRunning()、EndRunning()、CheckIfError()、CheckAndMail()函数，
#分别用于在运行日志里记录运行时间，开始运行时间、结束运行时间，程序验错、程序出错后邮件提醒。

# ------ BEG : define function -------------------------------------------------
log(){
	echo "`date +%Y%m%d-%H:%M:%S` : $@" >> ${RUNLOG}   #在运行日志里记录时间以及错误代码，格式：年月日-时：分：秒  ： 错误代码
}

BeginRunning(){
	echo "`date +%Y%m%d-%H:%M:%S` : ====== BEG ==================================================" >> ${RUNLOG}
}

EndRunning(){
	echo "`date +%Y%m%d-%H:%M:%S` : ====== END ==================================================" >> ${RUNLOG}
	echo "`date +%Y%m%d-%H:%M:%S`" >> ${RUNLOG}
}

# error log : param1:error_content
CheckIfError(){
	if [ $? != 0 ];then
		log " Error : $1"
		echo -e "$1" | mail -s "${FILENAME} fail" "yujia.miao@ipinyou.com"
		exit -1
	fi
}

#检查程序是否成功运行，若失败，进行错误记录，并把运行失败的文件名发到指定邮箱，若成功，发邮件通知maillist里的邮箱检查数据
CheckAndMail(){
	if [ $? != 0 ];then
		log " Error : $1"
		echo -e "$1 fail" | mail -s "${FILENAME} fail" "yujia.miao@ipinyou.com"
		exit -1
	else
		title="${FILENAME}"
		echo "excute ${FILENAME} success, please!" | mail -s "$1" "yujia.miao@ipinyou.com" 
	fi
}
# ------ END : define function -------------------------------------------------


#声明日期参数
#inputDate=${1}

#若输入日期为空，默认日期为当前日期的前一天，格式为：年/月/日
#if [ -z "${inputDate}" ];then
#	inputDate=`date -d "-1 day" +%Y/%m/%d`
#fi

#以inputDate为基数，定义时间变量，格式分别为：年/月/日、年-月-日、年月日。
#today=`date -d "1 day ${inputDate}" +%Y/%m/%d`

#BeginRunning init
#cd 到当前目录 并拿到rootdir
ROOTDIR=`dirname $0`
FILENAME=`basename $0`
RUNLOG=${ROOTDIR}/${FILENAME}.runlog

LOCAL=/data/users/data-mprofile/myflow

echo $ROOTDIR
echo $FILENAME
#BeginRunning over
cd $ROOTDIR
