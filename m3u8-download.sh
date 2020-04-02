#!/bin/bash
#bash curl.sh [URL] 
#bash curl_preprocessing.sh 
cp ./curlresult.txt ./curlresult.sh
cat curlresult.sh
n=$(wc -l curlresult.sh)
echo
echo 'Total number of m3u8 sources available: ' $n
echo
echo 'Please input start and end of options of the server you want to download from:'
read -p "Input Selection:" input1 input2
start=$input1
end=$input2
s=$start
ee=$end
x=$((end-start))
sed -i -e 's#^#\"\./m3u8-download #' curlresult.sh > download-command
sed -i -e ''$s','$ee'!d' curlresult.sh > download-command
read -p "Give the video name: " vname
sed -i -e 's/$/ '/videos/$vname'/' curlresult.sh > downlaod-command
cat curlresult.sh
echo
read -p "Waiting..., please check if the curlresult with video name is correct: " waitingi1
for (( i=1; i<=x+1; i++ )); do 
	echo i
	sed -i -e ''$i' s/$/'$i'\"/' curlresult.sh > download-command
	exec cat curlresult.sh | grep \.\/m3u8
done

echo "You are going to download from source #"$((start+1))
command=$(cat curlresult.sh | grep \.\/m3u8)
echo
echo "These are going to be executed, you can copy and run them on different sessions: "
echo
echo "bash ./parallel.sh" $command > download-command.sh
cat download-command.sh
echo
echo "............................................."
read -p "This is the last step before executing parallel download, checking... If everything is OK press ENTER:" waiting2

#exec $(echo "bash ./parallel.sh" $command)
exec bash download-command.sh