#include <iostream>
#include <vector>
#include <string>
#include "bloomfilter.h"
using namespace std;

// description
int main(int argc, char** argv){
    // INITIALIZATIONS //
    std::cout << argv[1] << " <-- [string] path to the key file" << endl;
    string keyfile = argv[1]; // example: "../data/keyfile.txt"
    
    std::cout << argv[2] << " <-- [float] false positive rate" << endl;
    float fdr = stof(argv[2]); // example: 0.1

    std::cout << argv[3] << " <-- [int] number of distinct keys" << endl;
    int num_uniq_keys = stoi(argv[3]); // do we even need this? should be able to get from keyfile

    std::cout << argv[4] << " <-- [string] path to output file containing constructed bloom filter" << endl;
    string bloomfile = argv[4]; // example: "../results/bloomfilter.x"

    // K-MER GENERATION (step done by python script) //


};