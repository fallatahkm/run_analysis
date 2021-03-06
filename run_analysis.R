# import the data to R program, use read.table from the test file
# both x and y files
txdata <- read.table("./R/assign3/UCI HAR Dataset/test/x_test.txt")
tydata <- read.table("./R/assign3/UCI HAR Dataset/test/y_test.txt")
#rename the y as response 
names(tydata)<- "Respons"
#import features which considered as headers
tsdata <- read.table("./R/assign3/UCI HAR Dataset/features.txt")
#change it as vector
daname <- as.vector(tsdata$V2)
#change the name for x testing file
names(txdata) <- daname
#marge the x and y test file
txydata <- cbind(tydata,txdata)
names(txydata)
###----------------------###
# do same to training file
#read train data and call them as the following
rxdata <- read.table("./R/assign3/UCI HAR Dataset/train/x_train.txt")
rydata <- read.table("./R/assign3/UCI HAR Dataset/train/y_train.txt")
# rename the rydata as response
names(rydata)<- "Respons"
tsdata <- read.table("./R/assign3/UCI HAR Dataset/features.txt")
head(tsdata)
head(daname)
daname1 <- as.vector(tsdata$V2)
names(rxdata) <- daname1
rxydata <- cbind(rydata,rxdata)
##########-----------------#####
# marge the both data frames to get general one big data frame call gedata
gedata <- rbind(txydata,rxydata)
dim(gedata)
###########-------------#######
#download stringer to select column column has mean or std
# by using grep function, we repeat it twice because it can by taken
# big than one length vector
dstd <- gedata[,grep( "std" ,names(gedata))]
dmean <- gedata[,grep( "mean" ,names(gedata))]
TidyData <- cbind(dmean,dstd)
dim(TidyData)
######-----------#####
#creating other data set call sec_tidy_data
# take he mean of the variable using sapply function
var_mean <- sapply(TidyData,mean)
# bind the Var_mean to sec_tidy_data using rbind
sec_Tidy_data <- rbind(TidyData,var_mean)
# creating column contain the mean of each subject
# using apply function
subj_mean<- apply(sec_Tidy_data,1,mean)
#bind it to sec_tidy_data using cbind
sec_Tidy_data <- cbind(sec_Tidy_data,subj_mean)
#the new data set has been written on txt file named run_analysis
write.table(sec_Tidy_data,"run_analysis.txt", row.names = FALSE)

