#!/bin/bash


# rsync script to backup gerrit important dirs as well as tomcats
# gerritdb is also dumped



SOURCE_DIR="/data01/gerrit/reviewsite/etc /data01/gerrit/reviewsite/git /data01/gerrit/apache-tomcat-7.0.62/conf /data01/gerrit/apache-tomcat-7.0.62/keystore"
DEST_DIR=/home/gerrit2/backup/
DBTODUMP=gerritdb
PASS=pass
OUTDUMPFILE=/home/gerrit2/backup/gerritdb."$(date +%Y%m%d_%H%M%S)"
timestamp=$(date +%Y%m%d_%H%M%S)
now="$(date +'%d.%m.%Y')"

#start the backup
/usr/bin/rsync -avz --delete   --log-file=/home/gerrit2/backup/LOG/"$timestamp-rsync.log" $SOURCE_DIR $DEST_DIR 2>>/dev/null
sleep 1

#start dumping the db
echo "Dumping DB..."
mysqldump -u root -p$PASS $DBTODUMP > $OUTDUMPFILE 2>>/dev/null

#check if dbdump exited OK...
if [ $? -eq 0 ]
then
   echo "Db successfully dumped"
else
   echo "Error dumping db!"

fi
