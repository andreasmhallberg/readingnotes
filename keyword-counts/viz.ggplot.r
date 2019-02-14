source('keywordcounts.r')

library(GGally)
library(network)

# remove statistics
edges <- edges[edges$kw!='statistics',]
edges <- edges[edges$kw!='pedagogy',]
edges <- edges[edges$kw!='icraab',]
edges.net <- network(edges)

# make vertex attributes with type (ref,kw)
edges.net %v% 'vertex.type' <- ifelse(grepl('\\(',network.vertex.names(edges.net)),'ref','kw')
# make vertex attributes with color by type
edges.net %v% 'vertex.color' <- ifelse(grepl('\\(',network.vertex.names(edges.net)),'black','tomato')
edges.net %v% 'vertex.labsize' <- ifelse(grepl('\\(',network.vertex.names(edges.net)),2,6)

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


# Make one with only Arabic
edges.ar <- edges.ar[edges.ar$kw!='icraab',]
edges.ar <- edges.ar[edges.ar$kw!='Arabic',]
edges.ar <- edges.ar[edges.ar$kw!='Standard',]
# edges.ar <- edges.ar[edges.ar$kw!='phonotactics',] # remove for aesthetic reasons
edges.ar <- edges.ar[edges.ar$kw!='textbook',] # remove for aesthetic reasons
edges.ar <- edges.ar[edges.ar$kw!='language-ideology:primary-source',]

edges.ar.net <- network(edges.ar)

## make vertex attributes with type (ref,kw)
edges.ar.net %v% 'vertex.type' <- ifelse(grepl('\\(',network.vertex.names(edges.ar.net)),'ref','kw')
## make vertex attributes with color by type
edges.ar.net %v% 'vertex.color' <- ifelse(grepl('\\(',network.vertex.names(edges.ar.net)),'black','tomato')
edges.ar.net %v% 'vertex.labsize' <- ifelse(grepl('\\(',network.vertex.names(edges.ar.net)),2,6)

ggnet2(edges.ar.net
       , size=1
       , label=T
       , label.size='vertex.labsize'
       , color='white'
       , label.color='vertex.color'
       , mode='kamadakawai'
       , edge.alpha=.5
       , edge.size=.1
       )
ggsave('kamadakawai.ar.pdf',width=420,heigh=594, unit='mm', limitsize=F)
