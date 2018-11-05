#!/bin/bash
# Usage:
# macgen.sh MACs_count MACs_prefix
# Example:
# macgen.sh 10 52:54:00:

SCRIPT_DIR=`dirname $0`
cd ${SCRIPT_DIR}
MAC_COUNT="$1"
MAC_PREFIX="$2"
MIN_COUNT="1"
MAX_COUNT="100"
MAC_PREFIX_DEFAULT="52:54:00:"

# Check MAC prefix
if [[ $MAC_PREFIX =~ ^([[:xdigit:]]{2}:){3}$ ]]; then
    echo -e "Use custom MAC prefix $MAC_PREFIX"
else
#    echo -e "MAC prefix must be FF:FF:FF: \nUse default MAC prefix ($MAC_PREFIX_DEFAULT)"
    MAC_PREFIX=$MAC_PREFIX_DEFAULT
fi

# Check MAC count is an integer
if ! [[ "$MAC_COUNT" =~ ^[0-9]+$ ]]; then
#    echo "MAC count must be integer"
    MAC_COUNT=1
fi

# Check MAC count range
if [ "$MAC_COUNT" -lt "$MIN_COUNT" -o "$MAC_COUNT" -gt "$MAX_COUNT" ]; then
    MAC_COUNT=1
    echo "Range from $MIN_COUNT to $MAX_COUNT only"
fi

echo -e "\e[97m"
for ((n=0;n<$MAC_COUNT;n++)); do
    MAC_GEN=$MAC_PREFIX`(date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{6}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;'`
    echo -e "\e[32m$MAC_GEN"
done
echo -e "\e[97m"
