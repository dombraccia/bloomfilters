import argparse
from BloomFilter import BloomFilter, Blocked
from query import query, queryBlocked
import time
from statistics import mean

'''
a place to test the implementation of the BloomFilter
'''
def main():

    # create a parser object 
    parser = argparse.ArgumentParser(description = "A program for testing an implementation of a Bloom Filter") 
    
    # creating map of functions bf.py can run
    FUNCTION_MAP = {'build'         : BloomFilter,
                    'build_blocked' : BloomFilter,
                    'query'         : BloomFilter,
                    'query_blocked' : BloomFilter}

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
    
    # add bf.py build_blocked argument
    parser.add_argument("-b", "--block_size", nargs = 1, metavar = "block size for blocked bf in bits",
                        help = "The desired size of a block in bits (recommended value is 512)")

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

    elif args.command == "build_blocked":
        a = Blocked(args.keyfile, args.fdr, args.outfile, args.block_size)

        # sainity check:
        print("your BlockedBloomFilter has:")
        print("    ", "fdr                      =", a.fdr)
        print("    ", "number of keys           =", a.num_keys)
        print("    ", "number of bits in bitvec =", a.M)
        print("    ", "number of hash functions =", a.k)
        print("    ", "number of blocks         =", a.B)

        # saving output:
        a.saveBF(args.outfile)

    # or query an already built BloomFilter
    elif args.command == "query":
        query_times = query(args.infile, args.queryfile)
        print("average query time:", mean(query_times))

    elif args.command == "query_blocked":
        query_times = queryBlocked(args.infile, args.queryfile)
        print("average query time:", mean(query_times))

    else:
        print("The command you have entered is not 'build' or 'query' -- please try again")


if __name__ == "__main__":
    main()