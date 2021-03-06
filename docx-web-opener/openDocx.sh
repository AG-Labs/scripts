#!/bin/bash
unzip -p This_is_a_test.docx word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g' > temp.txt

readarray -t mySearches < "temp.txt"

chromeVar="https://www.google.com/search?q="
openedNewWindow=false


for i in "${mySearches[@]}"
do
   : 
    removedSpaces=$(echo $i| sed 's/ /+/g')
    if ([[ !  -z  $removedSpaces  ]])
    then 
        if $openedNewWindow
        then
            start chrome $chromeVar$removedSpaces
        else
            start chrome --new-window $chromeVar$removedSpaces
            openedNewWindow=true
        fi
    fi
done
