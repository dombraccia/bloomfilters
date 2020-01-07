import random
import math 
import mmh3 
from bitarray import bitarray 

'''
script to make a the bloomFilter class
'''

class BloomFilter:
    # define data members:

    # constructor function:
    def __init__(self, keyfile, fdr):
        
        # initializing data members:
        self.fdr = fdr
        keys = self.read_keyfile(keyfile)
        self.num_keys = self.count_keys(keys)

        # calculate m (number of bits in vector) & k (number of hash functions)
        # based on input:
        self.M = math.ceil( -1 * self.num_keys * math.log(fdr) / pow(math.log(2), 2) )
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
    
    def query(self, kmer_query):
        for hsh in range(self.k): 
            current_hashval = mmh3.hash(kmer_query, hsh) % self.M
            if self.bitvector[current_hashval] == False: 
                return False
        return True