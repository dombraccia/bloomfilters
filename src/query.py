import pickle
import mmh3

'''
Code for the `bf.py query` command
'''

# load in saved BloomFilter from -i input

# load in queryfile, which contains the list of queries to execute

# definition for the query function
def query(infile, queryfile):

    # open infile:
    with open(infile[0], "rb") as picklefile:
        blmfltr = pickle.load(picklefile)
    
    # load queryfile line by line
    queryfile = open(queryfile[0])
    for kmer in queryfile:
        kmer = kmer.rstrip()
        for hsh in range(blmfltr.k): 
            current_hashval = mmh3.hash(kmer, hsh) % blmfltr.M
            current_count = 0
            # print(current_count)
            if blmfltr.bitvector[current_hashval] == False:
                out = kmer + ":N"
                current_count = current_count + 1
                print(out)
                break
        # print(current_count)
        if current_count == 0:
            out = kmer + ":Y"
            print(out)
            continue
    queryfile.close()
