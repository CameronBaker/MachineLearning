#Cameron Baker
#This script clusters and plots the CSV's in the current directory

library(cluster)

#list of files
files <- list.files()

#iterate through files
for(i in files){
	#read the CSV
	data <- read.csv(i,header=FALSE)
	
	#If there is enough data in the csv
	if(nrow(data) > 15){
		#Extract desired rows
		data <- data[,2:3]
		
		#cluster
		fit <- kmeans(data,3)
		
		#Generate cluster plot
		title <- paste(i,".jpg",sep="")
		jpeg(title)
		plot.new()
		clusplot(data,fit$cluster,color=TRUE,lines=0,main=i,xlab="self mean",ylab="other mean")
		dev.off()
	}
}	