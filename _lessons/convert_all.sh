for f in *.ipynb; do
  sed -i \
    's/import babypandas as bpd/import pandas as pd/g' $f
  sed -i 's/bpd/pd/g' $f
done
