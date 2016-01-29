#!/usr/bin/env bash

# provoke an exception to automate the installer
echo -e 'openthinclient installation'
echo -e '\n' | java -jar /tmp/data/openthinclient-2.1-Pales.jar -console || /bin/true # &> /dev/null
# move it to /opt
pwd
mv /usr/local/openthinclient /opt
chmod -R g+w /opt/openthinclient

# check, whether it starts automatically, disable rpcbind
ln -s /opt/openthinclient/bin/start.sh /etc/init.d/openthinclient
update-rc.d openthinclient defaults
update-rc.d -f rpcbind remove

# httpd
SOURCES_LIST="/opt/openthinclient/server/default/data/nfs/root/etc/sources.list"

mkdir -p /var/www/openthinclient/manager-rolling
chown -R www-data:www-data /var/www/openthinclient/
chmod -R g+w /var/www/openthinclient/

echo "deb http://localhost/openthinclient/manager-rolling ./" > ${SOURCES_LIST}
echo "deb http://packages.openthinclient.org/openthinclient/v2.1/manager-testing ./" >> ${SOURCES_LIST}
echo "deb http://packages.openthinclient.org/openthinclient/v2.1/manager-rolling ./" >> ${SOURCES_LIST}

#mv /tmp/data/start.sh /opt/openthinclient/bin/start.sh
# add user vagrant to www-data, so we upload the packages
# usermod -a -G www-data,staff vagrant

exit 0
