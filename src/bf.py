import argparse
from BloomFilter import BloomFilter
from query import query

'''
a place to test the implementation of the BloomFilter
'''
def main():

    # create a parser object 
    parser = argparse.ArgumentParser(description = "A program for testing an implementation of a Bloom Filter") 
    
    # creating map of functions bf.py can run
    FUNCTION_MAP = {'build' : BloomFilter,
                    'query' : BloomFilter}
    parser.add_argument("command", choices=FUNCTION_MAP.keys())

    # add bf.py build arguments
    parser.add_argument("-k", "--keyfile", nargs = 1, metavar = "file name",
                        help = "Path to the file containing all keys to insert to BloomFilter")

    parser.add_argument("-f", "--fdr", nargs = 1, metavar = "false discovery rate",  
                        help = "False positive rate for testing membership of the BloomFilter")

    parser.add_argument("-n", "--num_distinct_keys", nargs = 1, metavar = "num. distinct keys",  
                        help = "The number of distinct keys contained in --keyfile")

    parser.add_argument("-o", "--outfile", nargs = 1, metavar = "file name",  
                        help = "Path to output file for BloomFilter")

    # add bf.py query arguments
    parser.add_argument("-i", "--infile", nargs = 1, metavar = "file name",  
                        help = "Path to saved BloomFilter built with the \"bf.py build\" step") 

    parser.add_argument("-q", "--queryfile", nargs = 1, metavar = "file name",  
                        help = "Path to file containing queries for Bloom Filter")

    # parse the arguments from standard input 
    args = parser.parse_args()

    # build the bloom filter
    if args.command == "build":
        a = BloomFilter(args.keyfile, args.fdr, args.outfile)

        # sainity check:
        print("your BloomFilter has:")
        print("    ", "fdr                      =", a.fdr)
        print("    ", "number of keys           =", a.num_keys)
        print("    ", "number of bits in bitvec =", a.M)
        print("    ", "number of hash functions =", a.k)
        
        # saving output:
        a.saveBF(args.outfile)
    # or query an already built BloomFilter
    elif args.command == "query":
        # OLD WAY:
        #print(a.query("TATTCTAACCATGGTTCCACTTGGGGGGGTCAAGTTTATCCGTGAGCCCGAGCATTGGTGTCCTTTGGGTATGCAAGTAGTCGTTGCAGAGAGGAGAATA"))
        query(args.infile, args.queryfile)

    else:
        print("The command you have entered is not 'build' or 'query' -- please try again")


if __name__ == "__main__":
    main()