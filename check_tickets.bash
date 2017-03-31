#!/bin/bash

##http://paste.tclers.tk/3842

cd /root/booking

of=output/29.04_`date +%Y-%m-%d_%H_%M_%S`.json
res=output/29.04_`date +%Y-%m-%d_%H_%M_%S`.txt
hist=output/history.txt

#echo $of

wget -O $of https://uticket.ua/search/train/22200001/22218255/2017-04-29?format=json

cat $of | jq '.' | egrep "tosId|freeCount|id\"|locId" > $res

egrep "1020|1025" $res && if [ $? -eq 0 ] ; then cat $res | mailx -s "YAREMCHE" oleksiy.delendyk@gmail.com ; fi

echo "_______________________________________" >> $hist
echo `date +%Y-%m-%d_%H:%M:%S` >> $hist
echo "_______________________________________" >> $hist
egrep "tosId|freeCount|id\"" $res >> $hist

echo "<html>" > /var/www/html/index.html
echo "   <body>" >> /var/www/html/index.html
cat $hist | perl -i -p -e 's/\n/<br>\n/' >> /var/www/html/index.html
echo "   </body>" >> /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html


