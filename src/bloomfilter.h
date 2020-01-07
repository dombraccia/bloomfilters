/* bloomfilter.h */
#include <iostream>
#include <vector>
#include <bitset>
#include <include/sdsl/bit_vectors.hpp>
#include <math.h>
using namespace std;

// a file that defines and constructs a bloom filter
class bloomfilter
{
public:
    // data members: size of filter in bits and number of hash functions to use
    int num_keys;
    double M, k; // because ceil outputs a double
    float fdr;
    sdsl::bit_vector bv;
    vector<int> seeds;

    // constructor for the bloomfilter (m = size of bf in bits, k = # of hash functions to use)
    bloomfilter(int num_keys, float fdr)
    {
        // calculate M and k based on input number of keys and FDR?
        M = ceil (-1 * num_keys * log(fdr) / pow(log(2), 2));
        k = ceil (M / num_keys) * log(2);

        // create bit_vector
        bv = sdsl::bit_vector(M, 0);

        // set hash functions
        
    };

    void insert_key()
    {
        //
    };

    bool query()
    {
        //
    };

//private:
    // Size of the bloom filter state in bits (2^16).
	// static constexpr size_t bloomfilter_store_size = (-1) * num_keys * log(fdr) / (log(2))^2;
    // bitset<bloomfilter_store_size> bv;
};
