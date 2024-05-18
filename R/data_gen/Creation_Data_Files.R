#### This script creates the data files for the examples in this repository ####


dat = data.frame(matrix(ncol=2, nrow=33, c(22,131,41,139,52,128,23,128,41,171,54,105,24,116,46,137,56,145,27,106,47,111,57,141,28,114,48,115,58,153,9,123,49,133,59,157,30,117,49,128,63,155,32,122,50,183,67,176,33,99,51,130,71,172,35,121,51,133,77,178,40,147,51,144,81,217), byrow = TRUE))
colnames(dat) = c('x', 'y')
#dat
write.csv(dat, "../../data/sbp.csv", row.names = FALSE)


### Probabilistic Deep Learning Random Data ####
N = 4
x = c(-2.,-0.66666, 0.666, 2.)
y = c(-6.25027354, -2.50213382, -6.07525495,  7.92081243)
dat = data.frame(x=x, y=y)
write.csv(dat, "../../data/lr4.csv", row.names = FALSE)


#### Unkown Data ####
load('/Users/oli/Library/CloudStorage/Dropbox/__HTWG/Statistic/Andere_Vorlesungen/Wast3/Andere/WaSt3_fret/Unterlagen_Beate/Datensaetze/abodauer.rda')
write.csv(abodauer, "../../data/abodauer.csv", row.names = FALSE)

