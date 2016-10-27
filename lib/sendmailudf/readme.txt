run command:
#不带附件
java -cp /data/production/ToolCommon/sendmailudf:/data/production/ToolCommon/sendmailudf/* com.ipinyou.sendmail.Send "title:测试发送邮件" "这是正文内容,can u see?"  yujia.miao@ipinyou.com

#发多人,带附件
java -cp /data/production/ToolCommon/sendmailudf:/data/production/ToolCommon/sendmailudf/* com.ipinyou.sendmail.Send2 "title" "content" "email1@ipinyou.com;email2@ipinyou.com" "附件的文件" 附件路径
