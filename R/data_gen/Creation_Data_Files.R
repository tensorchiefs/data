#### This script creates the data files for the examples in this repository ####
dat = data.frame(matrix(ncol=2, nrow=33, c(22,131,41,139,52,128,23,128,41,171,54,105,24,116,46,137,56,145,27,106,47,111,57,141,28,114,48,115,58,153,9,123,49,133,59,157,30,117,49,128,63,155,32,122,50,183,67,176,33,99,51,130,71,172,35,121,51,133,77,178,40,147,51,144,81,217), byrow = TRUE))
colnames(dat) = c('x', 'y')
#dat
write.csv(dat, "../../data/sbp.csv", row.names = FALSE)
