#!/bin/sh
# install and configure gerrit
# www.vogella.com/tutorials/Gerrit/article.html
# http://review.cyanogenmod.org/Documentation/install-quick.html
# https://git.eclipse.org/r/Documentation/install.html

# download gerrit
[ -f gerrit-2.8.war ] || wget --no-check-certificate -O gerrit-2.8.war \
    https://gerrit-releases.storage.googleapis.com/gerrit-2.8.war

mkdir gerrit

# create gerrit directory structure
java -jar gerrit-2.8.war init --batch -d gerrit

# stop as by default it uses h2
gerrit/bin/gerrit.sh stop

# update configuration to use postgres
sed -i -e 's/h2/postgresql/' gerrit/etc/gerrit.config
sed -i -e 's|db/ReviewDB|reviewdb|' gerrit/etc/gerrit.config
sed -i -e '/auth/i \
      username = ciadmin \
      hostname = localhost' gerrit/etc/gerrit.config

# redo init to create postgres DB
java -jar gerrit-2.8.war init --batch -d gerrit

# really start
gerrit/bin/gerrit.sh start
