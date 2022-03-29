
import pandas as pd
import numpy

data = pd.read_csv("priority_table.csv")

print(data)

for i in range(148):
    priority = data.iloc[i][0]
    name = data.iloc[i][1]

    #print(priority, name)

    print('[' + str(priority) + ', "' + name + '"],')