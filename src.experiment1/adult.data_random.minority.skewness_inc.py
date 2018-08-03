import pandas as pd
import math

df = pd.read_csv('data/adult.data_conc.csv')

majority = df[df['target'].str.contains(" <=50K")]
minority = df[df['target'].str.contains(" >50K")]

count = math.floor(((1/100)*(len(majority)/len(minority)))*len(minority))
minority_downsampled = minority.sample(n=count)
df = pd.concat([majority, minority_downsampled])

df.to_csv("data/adult.data_1to100.csv", index=False)

count = math.floor(((1/50)*(len(majority)/len(minority)))*len(minority))
minority_downsampled = minority.sample(n=count)
df = pd.concat([majority, minority_downsampled])

df.to_csv("data/adult.data_1to50.csv", index=False)

count = math.floor(((1/25)*(len(majority)/len(minority)))*len(minority))
minority_downsampled = minority.sample(n=count)
df = pd.concat([majority, minority_downsampled])

df.to_csv("data/adult.data_1to25.csv", index=False)