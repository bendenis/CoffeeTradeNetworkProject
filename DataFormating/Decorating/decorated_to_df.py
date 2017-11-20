def graph_to_df(G):

        a5 = np.array(G.nodes())
        a1 = np.array(list(nx.get_node_attributes(G,"closeness_centrality").values()))
        a2 = np.array(list(nx.get_node_attributes(G,"indegree_centrality").values()))
        a3 = np.array(list(nx.get_node_attributes(G,"outdegree_centrality").values()))
        a4 = np.array(list(nx.get_node_attributes(G,"betweenness_centrality").values()))
        
        df = pd.DataFrame(np.stack((a5,a1,a2,a3,a4), axis = -1), columns = ["country","closeness_centrality",
                                                                                     "indegree_centrality",
                                                                                     "outdegree_centrality",
                                                                                     "betweenness_centrality"])
        
        df = df.set_index('country')
        
        mtdf =  pd.DataFrame(nx.get_node_attributes(G,"mean_terms"), index = ["mean_terms"]).T
        tedf =  pd.DataFrame(nx.get_node_attributes(G,"total_exported"), index = ["total_exported"]).T
        tidf =  pd.DataFrame(nx.get_node_attributes(G,"total_imported"), index = ["total_imported"]).T
        
        mtdf = mtdf.reindex(df.index)
        tedf = tedf.reindex(df.index)
        tidf = tidf.reindex(df.index)
        
        df = df.join(mtdf).join(tedf).join(tidf)
        return(df)


all_graphs = [gasG05,gasG10,gasG15,coffeeG05,coffeeG10,coffeeG15,sugarG05,sugarG10,sugarG15]
graph_measures_dfs = [graph_to_df(gg) for gg in all_graphs]

      
graph_measures_dfs[0].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/gasG05measures.csv")
graph_measures_dfs[1].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/gasG10measures.csv")
graph_measures_dfs[2].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/gasG15measures.csv")
graph_measures_dfs[3].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/coffeeG05measures.csv")
graph_measures_dfs[4].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/coffeeG10measures.csv")
graph_measures_dfs[5].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/coffeeG15measures.csv")
graph_measures_dfs[6].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/sugarG05measures.csv")
graph_measures_dfs[7].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/sugarG10measures.csv")
graph_measures_dfs[8].to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Decorated/sugarG15measures.csv")
