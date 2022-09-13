# Log Generator

- ### Islem Suresi
islem suresi ayarlamasi Dongunun kac saniye surdugunun bilgisini verir. Alttaki formatta yazilmasi yeterli olacaktir.
```
start=$(date +%s)

## Kodun gelecegi aralik
end=$(date +%s) runtime=$(($end - $start))

echo "$runtime"
```

- ###  While Dongusu
While dongusunde Count = 0 ile baslar ve verilen degere kadar artirma islemi yapar bu islemide her islem sonucunda Count + 1 olarak ayarlanir. KOD Satirinin Sonunda Count Artirilmalidir.

```
count=0


while [ "$count" -lt 5000 ]
do

	  count=$((count + 1))
done
```

- ### Date Formati
Date ismine Yil,Ay ve Gun sirasiyla tanimlanarak bunu kisa sekilde kod parcacigina aktarmak icin syntax olarak tanimliyoruz.
Time ismine Saat,Dakika ve Saniye sirasiyla tanimlanarak bunu kisa sekilde kod parcacigina aktarmak icin syntax olarak tanimliyoruz.

```
date="$(date '+%Y-%m-%d')"
### time sadece saat.
time="$(date +%H:%M:%S)"
```

- ### Rastgele Numara Uretme
Random_number a 19 haneli 1 ile 9 araliginda bulunan tum hanelerden rastgele bir numara yaratmasini sagliyoruz.
src_port ve dst_port 10 ile 99999 arasinda rastgele bir numara yaratmasini sagliyoruz.
sessionid alaninda 7 haneli 1 ve 9 araliginda bulunan tum hanelerden rastgele bir numara yaratmasini sagliyoruz.

```
random_number="$(shuf -i 1000000000000000000-9999999999999999999 -n 1)"
src_port="$(shuf -i 10-99999 -n 1)"
dst_port="$(shuf -i 10-99999 -n 1)"
sessionid="$(shuf -i 1000000-999999 -n 1)"
```

- ### Random IP Uretme

Burada maximum 3 haneli ve formati xxx.xxx.xxx.xxx olacak sekilde random ip uretme islemi yapilmaktadir.

```
srcip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"
dstip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"
transip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"
```


- ### Random Deger Secme
Random olarak Devnamekey 2 adet ve actionkey 3 adet deger atanmis bu degerlerden rastgelebirisi secilebilsin diye bir dongu yaratilmistir.


```
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
```

- ### Random Key Uretme

Burada ise part syntaxina yukarida olusturulan degerlerin hepsini $ ile cekiyoruz ve olusturulmus tum random keyleri bu degerlere atayarak logun icerisine entegre ediyoruz.
```
part='<14>date='$date' time='$time' devname="'$random_number'" devid="CankutUysal" eventtime='$sessionid' tz="+0300" logid="0000000013" type="traffic" subtype="forward" level="notice" vd="root" srcip='$srcip' srcname="Galaxy-A51" srcport='$src_port' srcintf="Nema-Office" srcintfrole="lan" dstip='$dstip' dstport='$dst_port' dstintf="wan1" dstintfrole="wan" srcuuid="d742d386-3e95-51e8-7fc6-794e11dbdb0e" dstuuid="d742d386-3e95-51e8-7fc6-794e11dbdb0e" srccountry="Reserved" dstcountry="Turkey" sessionid=1343531 proto=17 action="" policyid=2 policytype="policy" poluuid="046deac8-4f9b-51e9-5e88-9fa4f94432cd" policyname="Trust-to-Internet" service="DNS" trandisp="snat" transip='$transip' transport=43954 appid=16195 app="DNS" appcat="Network.Service" apprisk="elevated"'
```
- ### Dosyaya logu yazdirma
Olusturulan logu bir dosya icerisine satir satir olarak yazmasini saglar burada ki >> isareti ile yeni bir satir eklenmesi saglanir.
```
echo "$part" >> forti.log
```


- ### Port uzerinden log yollama
Olusturulan logu 514 portu uzerinden belirtilen ip ye mesaj olarak iletilmesini saglar. Ubuntu ve Centos surumlerinde /dev/udp default olarak gelmektedir.
```
echo "$part" | /dev/udp/10.10.10.10/514
```

- ### Log yollama hizi
Dongu icerisinde direkt olarak 514 portuna mesaj iletilmesi toplam 5000 logun tamamlanma suresi 15-20 sn surecektir.
Bunun yerine forti.log dosyasi olusturulup bir dongu veya rsyslog ile yonlendirme yapilirsa daha hizli sekilde yollanabilir.

- ### Alternatif Log Yollama
Forti.log ta ki tum satirlari tek tek yollayabilmek icin while dongusu kullaniliyor.
Bu dongu yapilmadan direkt olarak log `cat forti.log >>` gibi kullanilirsa tum satirlari birlesik yollayacaktir.

```
filename=forti.log

 while read x; do

	#echo "$x" > /dev/udp/10.10.2.132/514
	
done < $filename
```



---------
- ## Log Dosyasi

Alttaki dosya kopyalanip bir a.sh olarak olusuturulup calistirilirsa Forti.log adinda bulundugu dizine log olusutaracaktir. ( 5000 Satir )

```
start=$(date +%s)

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
dstip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"
transip="$(dd if=/dev/urandom bs=4 count=1 2>/dev/null |od -An -tu1 |sed -e 's/^ *//' -e 's/  */./g')"




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


part='<14>date='$date' time='$time' devname="'$random_number'" devid="CankutUysal" eventtime='$sessionid' tz="+0300" logid="0000000013" type="traffic" subtype="forward" level="notice" vd="root" srcip='$srcip' srcname="Galaxy-A51" srcport='$src_port' srcintf="Nema-Office" srcintfrole="lan" dstip='$dstip' dstport='$dst_port' dstintf="wan1" dstintfrole="wan" srcuuid="d742d386-3e95-51e8-7fc6-794e11dbdb0e" dstuuid="d742d386-3e95-51e8-7fc6-794e11dbdb0e" srccountry="Reserved" dstcountry="Turkey" sessionid=1343531 proto=17 action="" policyid=2 policytype="policy" poluuid="046deac8-4f9b-51e9-5e88-9fa4f94432cd" policyname="Trust-to-Internet" service="DNS" trandisp="snat" transip='$transip' transport=43954 appid=16195 app="DNS" appcat="Network.Service" apprisk="elevated"'


## ciktiyi bir part haline getirip tek metinde yazdiriyoruz.
	echo "$part" >> forti.log ## Arka planda çalsması için & ekle
	#echo "$part" | /dev/udp/10.10.10.10/514 ## Udp iletme
	#echo "$part" ## ekrana yazdırmasını istemiyorsan disable et
	  count=$((count + 1))
done
end=$(date +%s) runtime=$(($end - $start))

echo "$runtime"
```