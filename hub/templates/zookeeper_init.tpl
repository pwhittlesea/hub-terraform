#!/usr/bin/env bash

apt-get update -y
apt-get install zookeeperd -y

cat <<EOF >> /etc/zookeeper/conf/zoo.cfg
${zk_urls}
EOF

echo '${zk_id}' > /etc/zookeeper/conf/myid

service zookeeper restart
