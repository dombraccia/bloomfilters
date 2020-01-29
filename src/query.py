import pickle
import mmh3
import time
import math

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
    query_times = [None] * 100 # initializing array to hold query times
    queryfile = open(queryfile[0])
    for k, kmer in enumerate(queryfile):
        t = time.time()
        kmer = kmer.rstrip()
        for hsh in range(blmfltr.k): 
            current_hashval = mmh3.hash(kmer, hsh) % blmfltr.M
            current_count = 0
            # print(current_count)
            if blmfltr.bitvector[current_hashval] == False:
                out = kmer + ":N"
                current_count = current_count + 1
                elapsed = time.time() - t
                query_times[k] = elapsed
                print(out)
                break
        # print(current_count)
        if current_count == 0:
            out = kmer + ":Y"
            elapsed = time.time() - t
            query_times[k] = elapsed
            print(out)
            continue
        #query_times[k] = elapsed
    queryfile.close()
    return query_times

def queryBlocked(infile, queryfile):

    # open infile:
    with open(infile[0], "rb") as picklefile:
        blmfltr = pickle.load(picklefile)
    
    # load queryfile line by line
    query_times = [None] * 100 # initializing array to hold query times
    queryfile = open(queryfile[0])
    for k, kmer in enumerate(queryfile):
        t = time.time()
        kmer = kmer.rstrip()
        for hsh in range(blmfltr.k): 
            if hsh == 0:
                #print(blmfltr.blockSize)
                #print(type(blmfltr.blockSize))
                block_number = int(math.floor(abs(mmh3.hash(kmer, hsh) % blmfltr.M / float(blmfltr.blockSize))))
                continue
            else:
                block_hashval = int(mmh3.hash(kmer, hsh) % float(blmfltr.blockSize))
            current_count = 0
            current_hashval = int(block_number*blmfltr.blockSize + block_hashval)
            #print(type(current_hashval))
            # print(current_count)
            if blmfltr.bitvector[current_hashval] == False:
                out = kmer + ":N"
                current_count = current_count + 1
                elapsed = time.time() - t
                query_times[k] = elapsed
                print(out)
                break
        # print(current_count)
        if current_count == 0:
            out = kmer + ":Y"
            elapsed = time.time() - t
            query_times[k] = elapsed
            print(out)
            continue
        #query_times[k] = elapsed
    queryfile.close()
    return query_times