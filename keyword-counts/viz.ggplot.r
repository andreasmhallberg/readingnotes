
source('keywordcounts.r')

library(GGally)
library(network)

# remove statistics
edges <- edges[edges$kw!='statistics',]
edges <- edges[edges$kw!='pedagogy',]
edges.net <- network(edges)

# make vertex attributes with type (ref,kw)
edges.net %v% 'vertex.type' <- ifelse(grepl('\\(',network.vertex.names(edges.net)),'ref','kw')
# make vertex attributes with color by type
edges.net %v% 'vertex.color' <- ifelse(grepl('\\(',network.vertex.names(edges.net)),'black','tomato')
edges.net %v% 'vertex.labsize' <- ifelse(grepl('\\(',network.vertex.names(edges.net)),1,3)
ggnet2(edges.net
       , size=1
       , label=T
       , label.size='vertex.labsize'
       , color='white'
       , label.color='vertex.color'
       , mode='kamadakawai'
       , edge.alpha=.5
       , edge.size=.1
       )
ggsave('kamadakawai.pdf',width=420,heigh=594, unit='mm', limitsize=F)


