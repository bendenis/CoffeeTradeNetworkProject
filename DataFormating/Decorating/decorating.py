import numpy as np
import networkx as nx

ngdata = pd.read_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/clean_gas_trade.csv")
cfdata = pd.read_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/clean_coffee_trade.csv")
ssdata = pd.read_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/clean_sugar_trade.csv")

ngdata = ngdata.drop(ngdata.columns[0],1)
cfdata = cfdata.drop(cfdata.columns[0],1)
ssdata = ssdata.drop(ssdata.columns[0],1)

### Natural Gas Graphs

ngdata = ngdata.groupby(["Year","Reporter","Partner","Reporter_ISO","Partner_ISO"])[["Trade_Value__US__","Netweight__kg_"]].sum()
ngdata.columns = ["Trade_Value_USD","Netweight_KG"]
ngdata["Commodity"] = "Natural Gas"

ngdata05 = ngdata.loc[2005]
ngdata05["Year"] = 2005
ngdata05 = ngdata05.reset_index()
ngdata05 = ngdata05.assign(terms = ngdata05.Trade_Value_USD / ngdata05.Netweight_KG)

ngdata10 = ngdata.loc[2010]
ngdata10["Year"] = 2010
ngdata10 = ngdata10.reset_index()
ngdata10 = ngdata10.assign(terms = ngdata10.Trade_Value_USD / ngdata10.Netweight_KG)

ngdata15 = ngdata.loc[2015]
ngdata15["Year"] = 2015
ngdata15 = ngdata15.reset_index()
ngdata15 = ngdata15.assign(terms = ngdata15.Trade_Value_USD / ngdata15.Netweight_KG)

gasG05 = nx.from_pandas_dataframe(ngdata05, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
gasG10 = nx.from_pandas_dataframe(ngdata10, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
gasG15 = nx.from_pandas_dataframe(ngdata15, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
                                  
### Sugar Graphs

ssdata = ssdata.groupby(["Year","Reporter","Partner","Reporter_ISO","Partner_ISO"])[["Trade_Value__US__","Netweight__kg_"]].sum()
ssdata.columns = ["Trade_Value_USD","Netweight_KG"]
ssdata["Commodity"] = "Sugar"

ssdata05 = ssdata.loc[2005]
ssdata05["Year"] = 2005
ssdata05 = ssdata05.reset_index()
ssdata05 = ssdata05.assign(terms = ssdata05.Trade_Value_USD / ssdata05.Netweight_KG)

ssdata10 = ssdata.loc[2010]
ssdata10["Year"] = 2010
ssdata10 = ssdata10.reset_index()
ssdata10 = ssdata10.assign(terms = ssdata10.Trade_Value_USD / ssdata10.Netweight_KG)

ssdata15 = ssdata.loc[2015]
ssdata15["Year"] = 2015
ssdata15 = ssdata15.reset_index()
ssdata15 = ssdata15.assign(terms = ssdata15.Trade_Value_USD / ssdata15.Netweight_KG)

sugarG05 = nx.from_pandas_dataframe(ssdata05, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
sugarG10 = nx.from_pandas_dataframe(ssdata10, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
sugarG15 = nx.from_pandas_dataframe(ssdata15, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())

### Coffee Graphs

cfdata = cfdata.groupby(["Year","Reporter","Partner","Reporter_ISO","Partner_ISO"])[["Trade_Value__US__","Netweight__kg_"]].sum()
cfdata.columns = ["Trade_Value_USD","Netweight_KG"]
cfdata["Commodity"] = "Raw Coffee"

cfdata05 = cfdata.loc[2005]
cfdata05["Year"] = 2005
cfdata05 = cfdata05.reset_index()
cfdata05 = cfdata05.assign(terms = cfdata05.Trade_Value_USD / cfdata05.Netweight_KG)

cfdata10 = cfdata.loc[2010]
cfdata10["Year"] = 2010
cfdata10 = cfdata10.reset_index()
cfdata10 = cfdata10.assign(terms = cfdata10.Trade_Value_USD / cfdata10.Netweight_KG)

cfdata15 = cfdata.loc[2015]
cfdata15["Year"] = 2015
cfdata15 = cfdata15.reset_index()
cfdata15 = cfdata15.assign(terms = cfdata15.Trade_Value_USD / cfdata15.Netweight_KG)

coffeeG05 = nx.from_pandas_dataframe(cfdata05, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
coffeeG10 = nx.from_pandas_dataframe(cfdata10, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())
coffeeG15 = nx.from_pandas_dataframe(cfdata15, source = 'Reporter', target = 'Partner', 
                                  edge_attr = True, create_using = nx.DiGraph())


####

all_graphs = [gasG05,gasG10,gasG15,coffeeG05,coffeeG10,coffeeG15,sugarG05,sugarG10,sugarG15]

def set_attr(G):
    nx.set_node_attributes(G, "indegree_centrality", nx.in_degree_centrality(G))
    nx.set_node_attributes(G, "outdegree_centrality", nx.out_degree_centrality(G))
    nx.set_node_attributes(G, "betweenness_centrality", nx.betweenness_centrality(G))
    nx.set_node_attributes(G, "closeness_centrality", nx.closeness_centrality(G))
    
[set_attr(g) for g in all_graphs]


####

nx.set_node_attributes(gasG05, "total_exported", dict(ngdata05.groupby(['Reporter'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(gasG10, "total_exported", dict(ngdata10.groupby(['Reporter'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(gasG15, "total_exported", dict(ngdata15.groupby(['Reporter'])["Trade_Value_USD"].sum()))

nx.set_node_attributes(coffeeG05, "total_exported", dict(cfdata05.groupby(['Reporter'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(coffeeG10, "total_exported", dict(cfdata10.groupby(['Reporter'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(coffeeG15, "total_exported", dict(cfdata15.groupby(['Reporter'])["Trade_Value_USD"].sum()))

nx.set_node_attributes(sugarG05, "total_exported", dict(ssdata05.groupby(['Reporter'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(sugarG10, "total_exported", dict(ssdata10.groupby(['Reporter'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(sugarG15, "total_exported", dict(ssdata15.groupby(['Reporter'])["Trade_Value_USD"].sum()))

nx.set_node_attributes(gasG05, "total_imported", dict(ngdata05.groupby(['Partner'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(gasG10, "total_imported", dict(ngdata10.groupby(['Partner'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(gasG15, "total_imported", dict(ngdata15.groupby(['Partner'])["Trade_Value_USD"].sum()))

nx.set_node_attributes(coffeeG05, "total_imported", dict(cfdata05.groupby(['Partner'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(coffeeG10, "total_imported", dict(cfdata10.groupby(['Partner'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(coffeeG15, "total_imported", dict(cfdata15.groupby(['Partner'])["Trade_Value_USD"].sum()))

nx.set_node_attributes(sugarG05, "total_imported", dict(ssdata05.groupby(['Partner'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(sugarG10, "total_imported", dict(ssdata10.groupby(['Partner'])["Trade_Value_USD"].sum()))
nx.set_node_attributes(sugarG15, "total_imported", dict(ssdata15.groupby(['Partner'])["Trade_Value_USD"].sum()))

nx.set_node_attributes(gasG05, "mean_terms", dict(ngdata05.groupby(['Reporter'])['terms'].mean()))
nx.set_node_attributes(gasG10, "mean_terms", dict(ngdata10.groupby(['Reporter'])['terms'].mean()))
nx.set_node_attributes(gasG15, "mean_terms", dict(ngdata15.groupby(['Reporter'])['terms'].mean()))

nx.set_node_attributes(coffeeG05, "mean_terms", dict(cfdata05.groupby(['Reporter'])['terms'].mean()))
nx.set_node_attributes(coffeeG10, "mean_terms", dict(cfdata10.groupby(['Reporter'])['terms'].mean()))
nx.set_node_attributes(coffeeG15, "mean_terms", dict(cfdata15.groupby(['Reporter'])['terms'].mean()))

nx.set_node_attributes(sugarG05, "mean_terms", dict(ssdata05.groupby(['Reporter'])['terms'].mean()))
nx.set_node_attributes(sugarG10, "mean_terms", dict(ssdata10.groupby(['Reporter'])['terms'].mean()))
nx.set_node_attributes(sugarG15, "mean_terms", dict(ssdata15.groupby(['Reporter'])['terms'].mean()))


all_graphs = [gasG05,gasG10,gasG15,coffeeG05,coffeeG10,coffeeG15,sugarG05,sugarG10,sugarG15]


