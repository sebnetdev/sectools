#!/bin/bash

. $(dirname $0)/lib.sh

campaign="$1"
shift
category="$1"
shift
dest="$1"
shift


header=$(head -1 "$1" | tr " " "_" )
report=$(mktemp)
echo "$header" > $report
Info "Debug:header:$header"
Info "Processing files ..."
for report_raw in "$@"
do
    Info "  - Starting $report_raw -> $dest"
    Info "    - Extracting data ..."
    $GREP -vP "^Plugin ID,CVE,CVSS,Risk,Host,Protocol,Port,Name,Synopsis," $report_raw >> $report
    Info "  - Done!"
done

Info "Selecting data ..."
q -d "," -H --output-header "select '$campaign' as Campaign, '$category' as Category,Plugin_ID,CVE,CVSS,Risk,Host,Protocol,Port,Name,REPLACE(Synopsis,CHAR(10),' ') as Description from $report ;" > "$dest"
Info "Done!"

rm $report