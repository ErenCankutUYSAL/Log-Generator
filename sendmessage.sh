start=$(date +%s)


filename=nginx10.log

 while read x; do

	#echo "$x" > /dev/udp/10.10.2.132/514
	echo "$x" > /dev/udp/10.10.2.130/514
	#echo "$x" > /dev/udp/10.10.9.26/514
done < $filename

end=$(date +%s) runtime=$(($end - $start))



echo "$runtime"
