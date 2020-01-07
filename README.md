# bloomfilters

The data used to build a bloom filter and query is is generated through the python script in `scripts/kmergen.py`. Version 3.7.5 of python was used. See "environment.yml" for a list of packages used. 

Before moving on with the k-mergeneration step and bloomfilter building step, we must load the `sdsl-lite` library into the project folder. This library encodes the bitvector we will use for the bloom filter:

```
git clone https://github.com/simongog/sdsl-lite.git
cd sdsl-lite
./install.sh /path/to/this/dir/HW2
```

I generated 1,000,000 random k-mers of length 100 like so:

```
cd scripts
python kmergen.py 1000000
```
