#!/bin/bash
dirPath="/home/elango/teck-files/scanData/extracted/SCAN00800/"
echo "processing ${dirPath}"
for d in $dirPath{.,}*
do
        echo "processing $d"
                mv $d/*.csv /home/elango/teck-files/scanData/extracted/SCAN0800ALL
done
echo "Completed processing ${dirPath}"