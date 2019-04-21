# load filenames
notefiles <- dir("../../")
# exclude non-notes
notefiles <- notefiles[grepl('\\.md$', notefiles)]
# exclude Keywords.md and README.md
notefiles <- notefiles[!grepl('Keywords\\.md|README\\.md', notefiles)]


  # escape spaces and brackets
notefiles.e <- notefiles
notefiles.e <- gsub(' ','\\\\ ',notefiles.e)
notefiles.e <- gsub('\\(','\\\\(',notefiles.e)
notefiles.e <- gsub('\\)','\\\\)',notefiles.e)

dates <- c()
fn <- c()
for (n in notefiles.e) {
  d <- system(paste0('git log --follow --format=%ai -- ../../',n,' | tail -1'), intern=T)
  fn <- c(fn,n)
  dates <- c(dates, d)
}

print("File names loaded")

# convert to data frame
kwtime <- as.data.frame(dates)

# Convert 'Time' to time data type 
kwtime$time.lt <- as.POSIXlt(kwtime$dates)
kwtime$time.ct <- as.POSIXct(kwtime$dates)

kwtime$filename <- fn


# remove notes added on first commit
kwtime <- kwtime[kwtime$time.ct!=min(kwtime$time.ct),]

# Make vector with keywords
for (n in notefiles.e){
 kwraw <- system(paste0("grep -E '^@[a-zA-Z:]+' ../../*.md"), intern=T)
}
print("done")

kwraw <- !grepl('Keywords.md', kwraw)

kwfn <- gsub('^\\.\\./\\.\\./(.+\\.md).+','\\1',kwraw)
kwkw <- gsub('^.+\\.md:@(.+)$','\\1',kwraw)
kwkw <- gsub('\\r','',kwkw)

kw <- as.data.frame(kwkw)
kw$filename <- kwfn
# remove Keywords.md
kw <- kw[kw$filename!='Keywords.md',]

kw$filename.e <- gsub('(\\)|\\(|\\.| )','\\\\\\1',kw$filename)

# Import time variable from kwtime to kw
kw <- merge(kwtime, kw, by='filename')


# Separate dataset with means times and length of timespan for keywords an number
# one line per keyword
kw.meantime <- as.data.frame(unique(kw$kwkw))
names(kw.meantime) <- c('kw')

## mean time
for(k in kw.meantime$kw) {
  kw.meantime$kw.meantime.ct[kw.meantime$kw==k] <- mean(kw$time.ct[kw$kwkw==k])
}

kw.meantime$kw.meantime.ct <- as.POSIXct(kw.meantime$kw.meantime.ct, origin='1970-01-01')

## timespan
for(k in kw.meantime$kw) {
  kw.meantime$kw.last.time[kw.meantime$kw==k] <- max(kw$time.ct[kw$kwkw==k])
  kw.meantime$kw.first.time[kw.meantime$kw==k] <- min(kw$time.ct[kw$kwkw==k])
}

kw.meantime$timespan <- kw.meantime$kw.last.time-kw.meantime$kw.first.time

## number
kw.meantime$nr <- NA
for(k in kw.meantime$kw) {
  kw.meantime$nr[kw.meantime$kw==k] <- length(kw$kwkw[kw$kwkw==k])  
}

# Data frame with all occurances as

groups <- kw[,c('kwkw','filename')]
names(groups) <- c("kw","filename")
groups <- merge(groups, kw.meantime, by='kw')
groups <- merge(groups, kwtime, by='filename')

names(groups)

library(ggplot2)
library(scales)

ggplot(data=kwtime, aes(x=time.ct, y=0, label=filename)) +
  geom_segment(data=groups, aes(x=time.ct, xend= kw.meantime.ct, y=0, yend=timespan+10000000), color='gray', size=.2) +
  geom_text(data=kw.meantime, aes(label=kw, x=kw.meantime.ct, y=timespan+10000000, size=log(nr)), color='red') +
  geom_text(angle=-90, hjust=0) +
  theme(axis.text.x = element_text(angle = -90, hjust = 1)) 
ggsave(width=50, height=10, file='test.pdf', limitsize=F)
