$input > input
$in = cat .\input
$in | py "C:\Users\Jamiro Ferrara\GitHub\Personal\pyaudioclassification\pyac.py" | grep "%" | awk '$1 == /1./ {print $2, $3}' > classes
$classes = cat ./classes 

echo $in
echo $classes
