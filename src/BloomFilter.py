import random
import math 
import mmh3 
from bitarray import bitarray
import pickle

'''
script to make a the bloomFilter class
'''

class BloomFilter:
    # define data members:

    # constructor function:
    def __init__(self, keyfile, fdr, outfile):
        
        # initializing data members:
        self.fdr = float(fdr[0])                # accessing arg as string ->float instead of list
        keys = self.read_keyfile(keyfile[0])    # accessing arg as string instead of list
        self.num_keys = self.count_keys(keys)

        # calculate m (number of bits in vector) & k (number of hash functions)
        # based on input:
        self.M = math.ceil( -1 * self.num_keys * math.log(self.fdr) / pow(math.log(2), 2) )
        if self.M == 0:
            self.M = 1
        self.k = math.ceil( (self.M / self.num_keys) * math.log(2) )

        # making a bitvector of size M:
        self.bitvector = bitarray(self.M)
        self.bitvector.setall(0)
        self.insert(keys)
    
    # method to read in the keyfile
    def read_keyfile(self, path_to_keyfile):
        with open(path_to_keyfile, 'r') as filehandle:
            keys = filehandle.read().split('\n')
        return keys
    
    # method to count the number of keys in the keyfile
    def count_keys(self, keys):
        num_keys = len(keys)
        return num_keys
    
    # method to insert initial set to the BloomFilter
    def insert(self, keys):
        for kmer in keys:
            for hsh in range(self.k):
                current_hashval = mmh3.hash(kmer, hsh) % self.M
                self.bitvector[current_hashval] = True
    
    # method to test if a set of kmers are present in the keyfile set
    # OLD WAY - ONLY TESTS SINGLE KMER QUERY:
    # def query(self, kmer_query):
    #     for hsh in range(self.k): 
    #         current_hashval = mmh3.hash(kmer_query, hsh) % self.M
    #         if self.bitvector[current_hashval] == False: 
    #             return False
    #     return True

    # method to save BloomFilter object to disk
    def saveBF(self, outfile):
        new_out = outfile[0] + ".pickle"
        print(new_out)
        with open(new_out, "wb") as filehandle:
            pickle.dump(self, filehandle)
            
class Blocked(BloomFilter):
    def __init__(self, keyfile, fdr, outfile, block_size):
        
        # initializing data members:
        self.fdr = float(fdr[0])                # accessing arg as string ->float instead of list
        keys = self.read_keyfile(keyfile[0])    # accessing arg as string instead of list
        self.num_keys = self.count_keys(keys)
        self.blockSize = float(block_size[0])

        # calculate m (number of bits in vector) & k (number of hash functions)
        # based on input:
        self.M = math.ceil( -1 * self.num_keys * math.log(self.fdr) / pow(math.log(2), 2) )
        if self.M == 0:
            self.M = 1
        self.k = math.ceil( (self.M / self.num_keys) * math.log(2) )

        # determining number of blocks in blocked Bloom filter:
        self.B = math.ceil(self.M / float(block_size[0]))
        
        # expanding Bloom filter so that the last block reaches the intended block_size
        self.M = int(self.B*float(block_size[0]))

        # making a bitvector of size M:
        self.bitvector = bitarray(self.M)
        self.bitvector.setall(0)
        self.insert_blocked(keys, self.blockSize)

    def insert_blocked(self, keys, blockSize):
        for kmer in keys:
            for hsh in range(self.k):
                if hsh == 0: # use first hash val to set the block number
                    block_number = int(math.floor(abs(mmh3.hash(kmer, hsh) % self.M / blockSize)))
                    continue
                else:
                    block_hashval = int(mmh3.hash(kmer, hsh) % blockSize)
                    current_hashval = int(block_number*blockSize + block_hashval)
                    self.bitvector[current_hashval] = True