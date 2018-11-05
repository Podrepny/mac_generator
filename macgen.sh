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

if [[ $MAC_PREFIX =~ ^([[:xdigit:]]{2}:){3}$ ]]; then echo "Use custom mac prefix $MAC_PREFIX"; else echo "Use default mac prefix ($MAC_PREFIX_DEFAULT)"; MAC_PREFIX=$MAC_PREFIX_DEFAULT; fi
if ! [[ "$MAC_COUNT" =~ ^[0-9]+$ ]]; then echo "Sorry integers only"; exit 1; fi
if [ "$MAC_COUNT" -le "$MIN_COUNT" -o "$MAC_COUNT" -ge "$MAX_COUNT" ]; then MAC_COUNT=1; echo "Range from $MIN_COUNT to $MAX_COUNT only"; fi

for ((n=0;n<$MAC_COUNT;n++)); do   MAC_GEN=$MAC_PREFIX`(date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{6}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;'`; echo $MAC_GEN; done
