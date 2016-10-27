#! /bin/sh


ROOTDIR="/data/production/ToolCommon"

ifmail=false
ifsms=false
while getopts "mst:c:u:n:" arg
do
        case $arg in
          m)
                ifmail=true
                ;;
          s)
                ifsms=true
                ;;
          t)
                title=$OPTARG
                ;;
          c)
                content=$OPTARG
                ;;
          u)
                user=$OPTARG
                ;;
	  n)
		usermobilenum=$OPTARG
		;;
          ?)
                echo "`basename $0` -[m if_mail(no value)] -[s if_sms(no value)] -[t title] -[c content] -[u useremail] -[n userMobileNum]"
                exit 1
                ;;
                esac
done

cur_shell=`ps auxw | awk -v ppid="$PPID" '{if($2==ppid){for(i=1;i<=NF;i++){if(index($i,".sh")>0)print $i;}}}'`
content=${content}" ,  Current_Shell:"${cur_shell}

#echo ${content},${title},${user}
if [ $ifmail = true ];then
	echo "email used"
	if [ ! -z "${title}" ] && [ ! -z "${user}" ] && [ ! -z "${content}" ];then
		echo -e "${content}" | mail -s "${title}" "zhao.lin@ipinyou.com,${user}"
	fi
fi

if [ $ifsms = true ];then
	echo "sms used"
	if  [ ! -z "${usermobilenum}" ] && [ ! -z "${content}" ];then

		oldIFS=$IFS
		IFS=,
		for phoneNo in ${usermobilenum};
		do
			echo "send sms to: $phoneNo"
			 /data/jdk1.7.0_45/bin/java -cp /data/production/ToolCommon/sendsms-0.0.1-SNAPSHOT.jar com.ipinyou.sendsms.NewSend ${phoneNo} "${content}"
                        sleep 1
		done
		IFS=$oldIFS

	fi
fi
