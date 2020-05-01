#!/bin/bash

if [[ "${DEBUG}" = "true" ]]; then
  sed -i \
    -e "s|%DEBUG_ENABLED%|${DEBUG}|g" \
    "${CATALINA_HOME}"/webapps/jolokia/WEB-INF/web.xml
fi

# https://github.com/bodsch/docker-jolokia/blob/8f3ef375b230bebf302c7f95511118460f09fef3/rootfs/init/run.sh#L57-L86
# set pid file
CATALINA_PID="${CATALINA_HOME}/temp/catalina.pid"
# set memory settings
# export JAVA_OPTS="-Xmx256M ${JAVA_OPTS}"
# https://github.com/rhuss/jolokia/issues/222#issuecomment-170830887
# 30s timeout
CATALINA_OPTS=(
-Xms256M
-Xmx1024m
-XX:NewSize=256m
-XX:MaxNewSize=256m
#-XX:PermSize=256m
#-XX:MaxPermSize=256m
-XX:+DisableExplicitGC
-XX:HeapDumpPath=/var/logs/
-XX:+HeapDumpOnOutOfMemoryError
-XX:+UseConcMarkSweepGC
-XX:+UseParNewGC
-XX:SurvivorRatio=8
-XX:+UseCompressedOops
-Dserver.name=${HOSTNAME}
-Dcom.sun.management.jmxremote.port=22222
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
-Dsun.rmi.transport.tcp.responseTimeout=30000
${CATALINA_OPTS} )

CATALINA_OPTS="${CATALINA_OPTS[@]}"
