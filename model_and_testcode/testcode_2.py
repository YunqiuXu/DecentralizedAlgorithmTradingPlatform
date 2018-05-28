model = Model()
result = model.show_result()
print(result)

import sys
resultPath = sys.argv[1]
with open(resultPath,'w+') as f:
    f.write(str(result))
