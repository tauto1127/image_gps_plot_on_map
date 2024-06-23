for file in `ls *.HEIC`; do
  filename=$file:t:r
  sips --setProperty format jpeg $file --out out/${filename}.jpg
done
