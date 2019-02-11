#!/bin/bash

report="$1"
shift

. $(dirname $0)/lib.sh

header=$(head -1 "$1" | tr " " "_" )
echo "$header" > $report
Info "Debug:header:$header"
Info "Processing files ..."
for report_raw in "$@"
do
    Info "  - Starting $report_raw -> $dest"
    Info "    - Extracting data ..."
    $GREP -vP "^Campaign,Category,Plugin_ID,CVE,CVSS,Risk,Host,Protocol,Port,Name" $report_raw >> $report
    Info "  - Done!"
done
