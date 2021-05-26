# Overlapped-grouping-measurement

This is a matlab version for overlapped grouping measurement algorithm.

The main file is main.m

The procedure generates the measurements and the associated probabilities.

***Perform main.m

- Enter a number in {1,2} with keyboard, 1 represents OGM-Version 1, and 2 represents OGM-Version 2.
- Enter a string to represent the Hamiltonian you wish to perform. (H2_4jw means you wish to perform H2 molecule which has 4 qubits and encoded by jw.)

File needed before performing main.m

(1) Folder 1: Hamiltonian, we need all of the Hamiltonian in this folder (Name of the Hamiltonian e.g.: H2_4jw.txt). 

The Hamiltonian can be obtained from https://github.com/charleshadfield/variances.

***Note here we have different representation for the Hamiltonians.

We list the Hamiltonian for H2_4 has an example.

```
0.17218393261915566 3 0 0 0 
-0.2257534922240248 0 3 0 0 
0.1721839326191557 0 0 3 0 
-0.2257534922240248 0 0 0 3 
0.1209126326177663 3 3 0 0 
0.04523279994605781 2 2 1 1 
0.04523279994605781 2 2 2 2 
0.04523279994605781 1 1 1 1 
0.04523279994605781 1 1 2 2 
0.16892753870087912 3 0 3 0 
0.16614543256382408 3 0 0 3 
0.16614543256382408 0 3 3 0 
0.17464343068300447 0 3 0 3 
0.1209126326177663 0 0 3 3 
```

The first column represents the associated coefficients, and the last 4 colums represent the observable. 0/1/2/3 represents I/X/Y/Z. We did not contain the $I$ term, since it does not influence the optimization process.

(2) Folder 2: CutSet, to save the generated measurements and the associated probabilities. The first $n$-rows in a column represents a measurement, and the last row represents the associated probability.

***Note: We do not need the associated ground state for the Hamiltonian in the optimization phase.

