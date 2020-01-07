#include <iostream>
#include <vector>
#include <string>
#include <sdsl/bit_vectors.hpp>
#include "bloomfilter.h"
using namespace std;

// description
int main(int argc, char** argv){
    // INITIALIZATIONS //
    // EXAMPLE CALL: ./tmp ../data/keyfile.txt 0.1 path2/
    std::cout << argv[1] << " <-- [string] path to the key file" << "\n";
    string keyfile = argv[1]; // example: "../data/keyfile.txt"
    
    std::cout << argv[2] << " <-- [float] false positive rate" << "\n";
    float fdr = stof(argv[2]); // example: 0.1

    std::cout << argv[3] << " <-- [int] number of distinct keys" << endl;
    int num_uniq_keys = stoi(argv[3]); // do we even need this? should just be 
                                       // evaluated from keyfile.txt input

    std::cout << argv[4] << " <-- [string] path to output file containing constructed bloom filter" << "\n";
    string bloomfile = argv[4]; // example: "../results/bloomfilter.x"

    // COUNTING NUMBER OF DISTINCT KEYS:

    bloomfilter bf ( num_uniq_keys ,  fdr );
};