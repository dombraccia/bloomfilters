import sys
import random
import numpy as np

'''
A script to generate a user defined number of kmers of length 100
'''

bases = ['A', 'C', 'G', 'T']
num_kmers = int(sys.argv[1])

# define random generator
def uniform_bernoulli_sequence(symbols, length):
    return ''.join(random.choice(symbols) for i in range(length))

# generate user defined number of sequences
kmers = [None] * num_kmers 
for n in np.arange(num_kmers):
    kmers[n] = uniform_bernoulli_sequence(bases, 100)

# saving list of kmers to text file
with open('../data/keyfile.txt', 'w') as filehandle:
    for kmer in kmers:
        filehandle.write('%s\n' % kmer)
