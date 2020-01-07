import argparse
from BloomFilter import BloomFilter

'''
a place to test the implementation of the BloomFilter
'''
def main():

    # create a parser object 
    parser = argparse.ArgumentParser(description = "An program for testing an implementation of a Bloom Filter") 
  
    # add arguments
    parser.add_argument("-k", "--keyfile", nargs = 1, metavar = "file name",
                        help = "Path to the file containing all keys to insert to BloomFilter")

    parser.add_argument("-f", "--fdr", nargs = 1, metavar = "false discovery rate",  
                        help = "False positive rate for testing membership of the BloomFilter")

    parser.add_argument("-n", "--num_distinct_keys", nargs = 1, metavar = "num. distinct keys",  
                        help = "The number of distinct keys contained in --keyfile")

    parser.add_argument("-o", "--outfile", nargs = 1, metavar = "file name",  
                        help = "Path to output file for BloomFilter")
  
    # parse the arguments from standard input 
    args = parser.parse_args()
    print(args)
    print(type(args))

    a = BloomFilter(args.keyfile, args.fdr, args.outfile)

    # sainity check:
    print("your BloomFilter has:")
    print("    ", "fdr                      =", a.fdr)
    print("    ", "number of keys           =", a.num_keys)
    print("    ", "number of bits in bitvec =", a.M)
    print("    ", "number of hash functions =", a.k)

    # testing query:
    print(a.query("TATTCTAACCATGGTTCCACTTGGGGGGGTCAAGTTTATCCGTGAGCCCGAGCATTGGTGTCCTTTGGGTATGCAAGTAGTCGTTGCAGAGAGGAGAATA"))

    # saving output:
    a.saveBF(args.outfile)


if __name__ == "__main__":
    main()