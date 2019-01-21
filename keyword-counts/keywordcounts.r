# Generate data
## run in shell
system("grep -E '^@\\S+' ~/jobb/readingnotes/* > kw.txt")
system("sed 's/:@/\t/' kw.txt > kw2.txt")

## Load data
kw <- as.data.frame(read.table('kw2.txt', sep='\t', heade=F))


## Variable names
names(kw) <- c('file','kw')

kw$file <- gsub('/Users/xhalaa/jobb/readingnotes/','', kw$file)

## Exclude hits from Keyword.md
kw <- kw[kw$file!='Keywords.md',]

## variable for sub-keywords
kw$kw.sub <- kw$kw # copy keyword
kw$kw.sub[!grepl(':\\S+',kw$kw.sub)] <- NA # remove items w/o subs
kw$kw.sub <- gsub('^.+:','',kw$kw.sub) # remove main from kw.sub
kw$kw <- gsub(':.*$','',kw$kw) # remove sub from kw

kw$kw <- as.factor(kw$kw)
kw$kw.sub <- as.factor(kw$kw.sub)

## make a variable with ref Author (year)
kw$ref <- gsub('^(.*), (\\d\\d\\d+).*$', '\\1 (\\2)', kw$file)

counts <- sort(table(kw$kw), decreasing=T)
write.table(counts, 'kw.counts1.txt', row.names=F,col.names=F)
system("sed 's/\"//g' kw.counts1.txt > kw.counts.txt")
system("rm kw.counts1.txt")
system("rm kw.txt")
system("rm kw2.txt")

# Networkviz
## dataframe with nodes (kws and refs)
nodes.ref <- as.data.frame(unique(kw$ref))
names(nodes.ref) <- 'node'
nodes.ref$type <- 'ref'

nodes.kw <- as.data.frame(unique(kw$kw))
names(nodes.kw) <- 'node'
nodes.kw$type <- 'kw'

nodes <- rbind(nodes.ref,nodes.kw)
nodes$type <- as.factor(nodes$type)
## data framw with edges
edges <- cbind(kw[,c('ref','kw')])

## with tikz

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

names(edges)

help(write.table)

## with igraph
library("igraph")
 ## Make graph object
net <- graph_from_data_frame(d=edges, vertices=nodes, directed=F) 

summary(net)

str(V(net)$type)
E(net)


 # column layout Layout
refcoords <- cbind(rep(2,nrow(nodes.ref)), 1:nrow(nodes.ref))
kwcoords  <- cbind(rep(1,nrow(nodes.kw)),  1:nrow(nodes.kw))

 # spread out kw on y axis
 spreadfactor <- nrow(refcoords)/nrow(kwcoords)
 kwcoords[,2] <- kwcoords[,2]*spreadfactor

l <- rbind(refcoords,kwcoords)



png("plot.png", width=10, height=30, units="in", res=300)
plot(net
     , vertex.size=5
     , vertex.label.cex=.5
     , vertex.label.degree=0.0
     , vertex.label.dist=1
     , layout=l
     , edge.curved=F
     , vertex.shape='none'
     , edge.width=.4
)
dev.off()

help(igraph.plotting)
