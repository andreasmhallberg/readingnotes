# Generate data
## run in shell
system("grep -E '^@\\S+' ../*.md > kw.txt")
system("sed 's/:@/\t/' kw.txt > kw2.txt")

 # separately only for @Arabic notes

  system("grep -l '@Arabic' ../*.md | ack -x --no-group '^@\\S+' > kw.ar.txt")
  system("sed -E 's/:[0-9]+:@/\t/' kw.ar.txt > kw2.ar.txt") # also remove linenu outputted by ack

## Load data
kw <- as.data.frame(read.table('kw2.txt', sep='\t', heade=F))
kw.ar <- as.data.frame(read.table('kw2.ar.txt', sep='\t', heade=F))


## Variable names
names(kw) <- c('file','kw')
names(kw.ar) <- c('file','kw')

kw$file <- gsub('../','', kw$file)
kw.ar$file <- gsub('../','', kw.ar$file)

## Exclude hits from Keyword.md
kw <- kw[kw$file!='Keywords.md',]
kw.ar <- kw.ar[kw.ar$file!='Keywords.md',]


## variable for sub-keywords
kw$kw.sub <- kw$kw # copy keyword
kw$kw.sub[!grepl(':\\S+',kw$kw.sub)] <- NA # remove items w/o subs
kw$kw.sub <- gsub('^.+:','',kw$kw.sub) # remove main from kw.sub
kw$kw <- gsub(':.*$','',kw$kw) # remove sub from kw
kw$kw <- as.factor(kw$kw)
kw$kw.sub <- as.factor(kw$kw.sub)


kw.ar$kw.sub <- kw.ar$kw # copy keyword
kw.ar$kw.sub[!grepl(':\\S+',kw.ar$kw.sub)] <- NA # remove items w/o subs
kw.ar$kw.sub <- gsub('^.+:','',kw.ar$kw.sub) # remove main from kw.sub
kw.ar$kw <- gsub(':.*$','',kw.ar$kw) # remove sub from kw
kw.ar$kw <- as.factor(kw.ar$kw)
kw.ar$kw.sub <- as.factor(kw.ar$kw.sub)


## make a variable with ref Author (year)
kw$ref <- gsub('^(.*), (\\d\\d\\d+).*$', '\\1 (\\2)', kw$file)

kw.ar$ref <- gsub('^(.*), (\\d\\d\\d+).*$', '\\1 (\\2)', kw.ar$file)


# Write file with counts
counts <- sort(table(kw$kw), decreasing=T)
write.table(counts, 'kw.counts1.txt', row.names=F,col.names=F)


system("sed 's/\"//g' kw.counts1.txt > kw.counts.txt")
system("rm kw.counts1.txt")
system("rm kw.txt kw2.txt kw.ar.txt kw2.ar.txt")

# Networkviz
## dataframe with nodes (kws and refs)
nodes.ref <- as.data.frame(unique(kw$ref))
names(nodes.ref) <- 'node'
nodes.ref$type <- 'ref'

 # rdata
  nodes.ar.ref <- as.data.frame(unique(kw.ar$ref))
  names(nodes.ar.ref) <- 'node'
  nodes.ar.ref$type <- 'ref'

nodes.kw <- as.data.frame(unique(kw$kw))
names(nodes.kw) <- 'node'
nodes.kw$type <- 'kw'

 # rdata
  nodes.ar.kw <- as.data.frame(unique(kw.ar$kw))
  names(nodes.ar.kw) <- 'node'
  nodes.ar.kw$type <- 'kw'

nodes <- rbind(nodes.ref,nodes.kw)
nodes$type <- as.factor(nodes$type)
## data framw with edges
edges <- cbind(kw[,c('ref','kw')])


 # rdata
  nodes.ar <- rbind(nodes.ar.ref,nodes.ar.kw)
  nodes.ar$type <- as.factor(nodes.ar$type)
  ## data framw with edges
  edges.ar <- cbind(kw.ar[,c('ref','kw')])
