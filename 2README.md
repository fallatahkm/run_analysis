# impoer the data to R program, use read.table from the test fiel
# both x and y file
txdata <- read.table("./R/assign3/UCI HAR Dataset/test/x_test.txt")
tydata <- read.table("./R/assign3/UCI HAR Dataset/test/y_test.txt")
#rename the y as response 
names(tydata)<- "Respons"
#import features which considered as headers
tsdata <- read.table("./R/assign3/UCI HAR Dataset/features.txt")
#change it as vector
daname <- as.vector(tsdata$V2)
#chage the name for x testing file
names(txdata) <- daname
#marege the x and y test file
txydata <- cbind(tydata,txdata)
head(txydata)
###----------------------###
# do same to training file
rxdata <- read.table("./R/assign3/UCI HAR Dataset/train/x_train.txt")
rydata <- read.table("./R/assign3/UCI HAR Dataset/train/y_train.txt")
names(rydata)<- "Respons"
tsdata <- read.table("./R/assign3/UCI HAR Dataset/features.txt")
#daname <- as.vector(tsdata$V2)
names(rxdata) <- daname
rxydata <- cbind(rydata,rxdata)
head(rxydata)
##########-----------------#####
# marerge the both data frames to get general one
gedata <- rbind(txydata,rxydata)
###########-------------#######
#download stringer to select column column has mean or std
dstd <- gedata[,grep( "std" ,names(gedata))]
dmean <- gedata[,grep( "mean" ,names(gedata))]
dmstd <- cbind(dmean,dstd)
dim(dmstd)
write.table(dmstd,"run2_analysis.txt", row.names = FALSE)
###------------------------####
###########---------------################
#summary of the data
data_symmary <- sapply(dmstd,summary)
write.table(data_symmary,"run_summary.txt", row.names = FALSE)
