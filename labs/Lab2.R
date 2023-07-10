getwd() #get working directory
ep <- read.csv("data/NASAExoplanets.csv")
ep <- na.omit(ep)

ed <- ep$distance
mean(ed)
median(ed)
max(ed)-min(ed)
var(ed)
sd(ed)
IQR(ed)

#outliers
lower <- mean(ed)-3*sd(ed)
upper <- mean(ed)+3*sd(ed)
nout_ed <- ed[ed > lower & ed < upper]
mean(nout_ed)
median(nout_ed)
