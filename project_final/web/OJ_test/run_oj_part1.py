# Run OJ part1: 
# Parameter1: the path of model
# Parameter2: the path of testcode
# Parameter3: the path of run2
# 
# In this part, both model and testcode will be write into run2
# Then we can run 'run2' to get test result 

import sys

model_path = sys.argv[1]
testcode_path = sys.argv[2]
run2_path = sys.argv[3]
    
with open(model_path, 'r') as f1:
    f1_lines = f1.readlines()
with open(testcode_path, 'r') as f2:
    f2_lines = f2.readlines()    
with open(run2_path,'w+') as f3:
    for r1 in f1_lines:
        f3.write(r1)
    for r2 in f2_lines:
        f3.write(r2)
