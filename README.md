# bloomfilters

The data used to build a bloom filter and query is is generated through the python script in `scripts/kmergen.py`. Version 3.7.5 of python was used. See "environment.yml" for a list of packages used. 

First, I generated 1,000,000 random k-mers of length 100 like so:

```
cd scripts
python kmergen.py 1000000
head -n -1 ../data/keyfile.txt > temp.txt ; mv temp.txt ../data/keyfile.txt
```

Then, running the analysis is as simple as:

```
python bf.py
```