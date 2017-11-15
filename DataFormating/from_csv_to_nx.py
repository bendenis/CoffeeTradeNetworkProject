import pandas as pd
import networkx as nx

cfdata = pd.read_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/clean_coffee_trade.csv")

G = nx.from_pandas_dataframe(cfdata, source = 'Reporter', target = 'Partner', edge_attr = True)