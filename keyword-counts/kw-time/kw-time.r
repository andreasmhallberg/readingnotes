# load filenames
notefiles <- dir("../../")
# exclude non-notes
notefiles <- notefiles[grepl('.md$', notefiles)]
# exclude Keywords.md and README.md
notefiles <- notefiles[!grepl('Keywords\\.md|README\\.md', notefiles)]

# escape spaces and brackets
notefiles.e <- gsub(' ','\\\\ ',notefiles)
notefiles.e <- gsub('\\(','\\\\(',notefiles.e)
notefiles.e <- gsub('\\)','\\\\)',notefiles.e)


dates <- c()
fn <- c()
for (note in notefiles.e) {
  d <- system(paste0('git log --follow --format=%ai -- ../../',note,' | tail -1'), intern=T)
  fn <- c(fn,note)
  dates <- c(dates, d)
}

notefiles[1:50]
notefiles[51:100]
notefiles[100:151]
notefiles[150:200]
notefiles[200:250]
notefiles[250:303]
length(notefiles.e)
length(notefiles)
length(dates)
length(fn)


# dates <- gsub(' .*$','', dates)

# convert to data frame
kwtime <- as.data.frame(dates)

# Convert 'Time' to time data type 
kwtime$time <- strptime(kwtime$dates,"%Y-%m-%d")

kwtime$filename <- notefiles


library(ggplot2)
library(scales)

ggplot(kwtime, aes(x=dates, y=0)) +
  geom_point()

+

  geom_line(aes(y=Temperature_C), color='red') +
  geom_line(aes(y=Relative_Humidity/5), color='blue') +
  xlab('Time') +
  ylab('red = °C      blue = Hum./5') +
  scale_y_continuous(breaks=seq(0,25,5), limits=c(0,25)) +
  scale_x_datetime(date_breaks = "6 hour", labels = date_format("%H:%M\n%b %d")) +



