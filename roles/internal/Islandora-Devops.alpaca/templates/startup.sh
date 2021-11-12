#!/bin/sh

if [ -f "/usr/libexec/tomcat9/tomcat-locate-java.sh" ]; then
  . /usr/libexec/tomcat9/tomcat-locate-java.sh
fi
if [ -z "$JAVA_HOME" ]; then
  echo "Cannot locate JAVA, please define JAVA_HOME."
  exit 1
fi
# Source the config file.
. ${ALPACA_HOME}/${ALPACA_CONFIG}

${JAVA_HOME}/bin/java -Dislandora.alpaca.log=${ALPACA_LOG_LEVEL} -Xmx${ALPACA_HEAP} -jar ${ALPACA_JAR} -c ${ALPACA_PROPERTIES} > ${ALPACA_LOG_DIR}/alpaca.log &