

source('keywordcounts.r')

nodes$id <- 1:nrow(nodes)

 # make file with tikz commands for ref nodes
refs.tikz <- nodes[nodes$type=='ref',]
refs.tikz$nr <- paste0('\\ref{',1:nrow(refs.tikz))
refs.tikz$node <- gsub('$','}',refs.tikz$node)
refs.tikz <- refs.tikz[,c('nr','id','node')]

write.table(refs.tikz, row.names=F, col.names=F, quote=F, sep='}{', file='nodes.ref.tikz')

 # make file with tikz commands for kw nodes
kws.tikz <- nodes[nodes$type=='kw',]
kws.tikz$nr <- paste0('\\kw{',1:nrow(kws.tikz))
kws.tikz$node <- gsub('$','}',kws.tikz$node)
kws.tikz <- kws.tikz[,c('nr','node')]

write.table(kws.tikz, row.names=F, col.names=F, quote=F, sep='}{', file='nodes.kw.tikz')

 # files with number of refs and kws
 write(paste0(
              '\\def\\nrrefs{',nrow(refs.tikz),'}',
              '\\def\\nrkws{',nrow(kws.tikz),'}'
              ), file='refkwcounts.tikz')

 # make file with tikz commands for edges
 # add ids from aboce

test <- merge(nodes, edges, by.x='node', by.y='ref')
test$id.from <- test$id
test$id <- NULL
test <- merge(test, edges, by.x='kw', by.y='kw')

edges.tikz <- edges
merge(edges.tikz, refs.tikz)

edges.tikz$ref <- gsub('^','\\\\putedge{',edges.tikz$ref)
edges.tikz$kw <- gsub('$','}',edges.tikz$kw)
write.table(edges.tikz, row.names=F, col.names=F, quote=F, sep='}{', file='edges.tikz')

