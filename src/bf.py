from BloomFilter import BloomFilter

'''
a place to test the implementation of the BloomFilter
'''

a = BloomFilter("../data/keyfile.txt", 0.1)

# sainity check:
print("your BloomFilter has:")
print("    ", "fdr                      =", a.fdr)
print("    ", "number of keys           =", a.num_keys)
print("    ", "number of bits in bitvec =", a.M)
print("    ", "number of hash functions =", a.k)

# testing query:
print(a.query("TCGCGAGATTCGTCAGGCGATTTAGATAGCTGATAGTGACAGATCGCGCACTGGAAACGCAGCAATCCGGGAAAGACCTGGACTGACCGTGGAGGTATTT"))
