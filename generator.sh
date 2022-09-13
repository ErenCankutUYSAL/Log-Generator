TIMEFORMAT='It took %0R seconds.' 
{
count=0


while [ "$count" -lt 5000 ]
do

date="$(date '+%Y-%m-%d')"
### time sadece saat.
time="$(date +%H:%M:%S)"



random_number="$(shuf -i 1000000000000000000-9999999999999999999 -n 1)"
src_port="$(shuf -i 10-99999 -n 1)"
dst_port="$(shuf -i 10-99999 -n 1)"
sessionid="$(shuf -i 1000000-999999 -n 1)"


srcip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"
#dstip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"
#transip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"




  case $((RANDOM % 2)) in
        (0) devnamekey=Nema-Fortigate100E
                ;;
        (1) devnamekey=PRD-FRW-SP-CANTU
                ;;
  esac
  
  case $((RANDOM % 3)) in
        (0) actionkey=deny
                ;;
        (1) actionkey=allow
                ;;
        (2) actionkey=accept
                ;;
  esac


part='<14>date='$date' time='$time' devname="'$random_number'" devid="CankutUysal" eventtime='$sessionid' tz="+0300" logid="0000000013" type="traffic" subtype="forward" level="notice" vd="root" srcip='$srcip' srcname="Galaxy-A51" srcport='$src_port' srcintf="Nema-Office" srcintfrole="lan" dstip='$srcip' dstport='$src_port' dstintf="wan1" dstintfrole="wan" srcuuid="d742d386-3e95-51e8-7fc6-794e11dbdb0e" dstuuid="d742d386-3e95-51e8-7fc6-794e11dbdb0e" srccountry="Reserved" dstcountry="Turkey" sessionid=1343531 proto=17 action="" policyid=2 policytype="policy" poluuid="046deac8-4f9b-51e9-5e88-9fa4f94432cd" policyname="Trust-to-Internet" service="DNS" trandisp="snat" transip='$srcip' transport=43954 appid=16195 app="DNS" appcat="Network.Service" apprisk="elevated"'


## ciktiyi bir part haline getirip tek metinde yazdiriyoruz.
	echo "$part" >> forti5.log ## Arka planda çalsması için & ekle
	
	#echo "$part" ## ekrana yazdırmasını istemiyorsan disable et
	  count=$((count + 1))
done
}
