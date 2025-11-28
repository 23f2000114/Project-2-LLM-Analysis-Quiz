
import pandas as pd
df = pd.read_csv("demo-audio-data.csv", header=None)
cutoff = 49354
filtered_df = df[df.iloc[:, 0] > cutoff]
answer = filtered_df.iloc[:, 0].sum()
print(answer)
