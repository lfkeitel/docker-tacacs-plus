#!/bin/sh

TAC_PLUS_BIN=/tacacs/sbin/tac_plus
CONF_FILE=/etc/tac_plus/tac_plus.cfg

# Check configuration file exists
if [ ! -f /etc/tac_plus/tac_plus.cfg ]; then
    echo "No configuration file at ${CONF_FILE}"
    exit 1
fi

# Check configuration file for syntax errors
${TAC_PLUS_BIN} -P ${CONF_FILE}
if [ $? -ne 0 ]; then
    echo "Invalid configuration file"
    exit 1
fi

# Make the log directories
mkdir -p /var/log/tac_plus

echo "Starting server..."

# Start the server
exec ${TAC_PLUS_BIN} -f ${CONF_FILE}