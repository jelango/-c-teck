#!/bin/bash
fileName="pgEvent_25000000-49999999"
extn=".psv"
echo "processing ${fileName}${extn}"
echo "performing sed for quote replace done.. "
sed  's/"//g' "${fileName}${extn}" > "${fileName}_1"
echo "replacing False| with False|\" "
awk '{gsub(/False\|/,"False|\"")}; 1' "${fileName}_1" > "${fileName}_2"
echo "replacing True| with True|\" "
awk '{gsub(/True\|/,"True|\"")}; 1' "${fileName}_2" > "${fileName}_3"
echo "string news line within columns and replacing line starting with | to |\""
awk '{if (NR==1) {print$0} else if ($1 ~/^\|/){print p"\""$0;p="";} else {p=p$0}}' "${fileName}_3" > "${fileName}_4
"
echo "replacing \r chars "
sed 's/\r//g'  "${fileName}_4" > "${fileName}_data"
echo "copying to gcs.."
gsutil cp "${fileName}_data" gs://extracted-eisic1oesh5cohbaelieyohraegirazi
echo "total lines.."
wc -l "${fileName}${extn}"
wc -l "${fileName}_data"
echo " checking for True|"
cat "${fileName}${extn}" | grep 'True|' | wc -l 
echo "Completed processing ${fileName}${extn}"