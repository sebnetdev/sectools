#!/bin/bash

. $(dirname $0)/lib.sh

risks=$(echo "$1"| tr "," " ")
shift
#diff_campaing="$1"
#shift
#categories="$1"
#shift
table="$1"
shift
dest="$1"
shift

for risk in $risks
do
  risk_tmp="$risk_tmp or risk = '$risk'"
done

risk="where"${risk_tmp:3}

#q -d "," -H --output-header "select '$campaign' as Campaign, '$category' as Category,Plugin_ID,CVE,CVSS,Risk,Host,Protocol,Port,Name,REPLACE(Synopsis,CHAR(10),' ') as Description from $report ;" > "$dest"


tmp=$(mktemp)

q -d "," -H --output-header "select campaign,category,risk,plugin_id,host from $table $risk group by campaign,category,risk,plugin_id,host order by campaign,category,risk,plugin_id,host ;"  > $tmp

q -d "," -H --output-header "select campaign,category,risk,count(host) as nb_vuln from $tmp group by campaign,category,risk order by campaign,category,risk ;" 

rm $tmp

