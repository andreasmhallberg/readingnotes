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

library("igraph")
## Make graph object
net <- graph_from_data_frame(d=edges, vertices=nodes, directed=F) 
str(net)
# Media outlets are blue squares, audience nodes are orange circles:

V(net)$type
E(net)

l <- cbind(c(
             # x
             rep(2,length(V(net)[type=='ref'])),
             rep(1,length(V(net)[type!='ref']))
             ),
             # y
           c(
             1:length(V(net)[type=='ref']),
             1:length(V(net)[type!='ref'])
             )
)
names(l) <- c('x','y')
l$y[l$x==2] <- l$y[l$x==2]+mean(l$y[l$x==1])

plot(net, vertex.size=2, layout=l, vertex.label.cex=.4, vertex.label.degree=0)
help(igraph)
?graph_from_data_frame
vertex_attr(net)

