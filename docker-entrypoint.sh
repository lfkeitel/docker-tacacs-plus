#!/bin/bash

TAC_PLUS_BIN=/tac_plus/sbin/tac_plus
CONF_FILE=/etc/tac_plus/tac_plus.cfg

# Check configuration file exists
if [ ! -f /etc/tac_plus/tac_plus.cfg ]; then
    echo "No configuration file at ${CONF_FILE}"
    exit 1
fi

echo "Checking configuration..."

# Check configuration file for syntax errors
${TAC_PLUS_BIN} -P ${CONF_FILE}
if [ $? -ne 0 ]; then
    echo "Invalid configuration file"
    exit 1
fi

echo "Configuration looks good."

# Make the log directories
mkdir -p /var/log/tac_plus

echo "Starting server..."

# Start the server
${TAC_PLUS_BIN} ${CONF_FILE}