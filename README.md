# Bloom filter implementation in Python 3.7

The data used to build a bloom filter and query is is generated through the python script in `scripts/kmergen.py`. Version 3.7.5 of python was used. See "environment.yml" for a list of packages used. 

First, I generated random k-mers of length 100 like so:

```
cd scripts
python kmergen.py <num_of_kmers>
```

For the benchmarks shown in the writeup, I generated 5 sets of kmers (1 000, 10 000, 100 000, 1 000 000, 10 000 000). The output shows up in the `data/` folder under `keyfile_<num_of_kmers>.txt`

The next step is to build Bloom filters of the previously generated keyfiles. Here is an example call of `bf.py build`
```
python bf.py build -k <path/to/keyfile> -f <target_fpr> -n <num_distinct_keys> -o <path/to/outfile>
```

For the benchmarks shown in the writeup, I generated Bloom filters over all 5 values of N above as well as over 5 different false positive rates (FPRs): {0.01, 0.05, 0.10, 0.20, 0.25}. This way I could truly test that I made a functional Bloom filter.

Next, a query can be called on the recently constructed Bloom filter from a file with a set of queries in it. Here is an example call to `bf.py query`:

```
python bf.py query -i <path/to/bloomfilter/outfile> -q <path/to/queryfile>
```

The results of the query will be outputted to the standard out in your terminal.

All the plots made for the writeup were made in the script: `benchmarks/make_plots.R`. Assuming you have all necessary libraries installed, you should be able to recreate all of these plots by sourcing the R script. I suggest running the script in R studio for better user experience; otherwise the plots would have to be saved and viewed in separate steps.
