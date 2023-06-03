#!/bin/bash
LOOP=0

while true
do
    LOOP=$(($LOOP + 1))
    EPOCH=$(cat epoch.txt)

    if [ $EPOCH -ge $(date +%s) ]
    then
	git push origin main
        echo "Do not automate push in the future!"
        exit
    fi

    EPOCH=$(($EPOCH + $RANDOM))
    echo $EPOCH > epoch.txt
    DATE=$(date -r $EPOCH)
    echo $DATE > date.txt
    git add .
    git commit -m "$DATE" --date "$DATE"

    if [ $LOOP -ge 100 ]
    then
        git push origin main
        LOOP=0
    fi
done
