/* bloomfilter.h */
#include <iostream>
#include <vector>
using namespace std;

void calcParams(int num_keys, float FDR);

// a file that defines and constructs a bloom filter
class bloomfilter
{
public:
    // data members: size of filter in bits and number of hash functions to use
    int size, hashes;

    // constructor for the bloomfilter (m = size of bf in bits, k = # of hash functions to use)
    bloomfilter(int m, int k)
    {
        // write somthing
    }
};

// a function for calculating the size of filter and number of hash functions needed
void calcParams(int num_keys, float FDR){
    // int m = -1 * num_keys * ln(FDR) / (ln(2))^2
    // k = (m / num_keys) * ln(2)
}
