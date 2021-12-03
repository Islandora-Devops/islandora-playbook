#!/bin/sh

if [ -z "$JAVA_HOME" ]; then
  if [ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
    # Make a guess because this is only for Ubuntu
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
  else
    echo "Cannot locate JAVA, please define JAVA_HOME."
    exit 1
  fi
fi
# Source the config file.
. ${ALPACA_HOME}/${ALPACA_CONFIG}

${JAVA_HOME}/bin/java -Dislandora.alpaca.log=${ALPACA_LOG_LEVEL} -Xmx${ALPACA_HEAP} -jar ${ALPACA_JAR} -c ${ALPACA_PROPERTIES} > ${ALPACA_LOG_DIR}/alpaca.log &