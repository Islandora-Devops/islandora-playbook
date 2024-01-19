#!/bin/bash

if [ -z "$JAVA_HOME" ]; then
    if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
        if [ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
        # Make a guess for Debian based systems.
            export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
        fi
    elif [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
        if [ -d "/usr/lib/jvm/jre" ] || [ -f "/usr/lib/jvm/jre" ] || [ -L "/usr/lib/jvm/jre" ]; then
        # Make a guess for RHEL based systems.
            export JAVA_HOME=/usr/lib/jvm/jre
        fi
    else
        echo "Cannot locate JAVA, please define JAVA_HOME."
    fi
fi

# Source the config file.
source ${ALPACA_HOME}/${ALPACA_CONFIG}

${JAVA_HOME}/bin/java -Dislandora.alpaca.log=${ALPACA_LOG_LEVEL} -Xmx${ALPACA_HEAP} -jar ${ALPACA_JAR} -c ${ALPACA_PROPERTIES} > ${ALPACA_LOG_DIR}/alpaca.log &
