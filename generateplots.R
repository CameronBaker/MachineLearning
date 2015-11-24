#Cameron Baker
#This script clusters and plots the CSV's in the current directory

#plyr library is used for the counting function for counting specific elements in a dataframe
library(plyr)

#list of files
files <- list.files()

#iterate through files
for(i in files){
	#read the CSV
	data <- read.csv(i,header=FALSE)
	
	#If there is enough data in the csv
	if(nrow(data) > 15){
		#Extract desired rows
		
		#bipartite clustering of the dataset
		fit <- kmeans(data[,2:3],2)

		#Elimates sets that did not cluster well (alloted to each cluster)
		#from being plotted
		if(!(count(fit$cluster)[1,2] < 4) || !(count(fit$cluster) < 4)){	

			#Generate cluster plot
			title <- paste(i,".jpg",sep="")
			jpeg(title)
			plot.new()
		
			#differentiates colors between plots
			data$color[fit$cluster<1] = "blue"
			data$color[fit$cluster>1] = "red"

			#plots the data
			plot(data[,2],data[,3],xlab="self mean",ylab="other mean",main=i)
			text(data[,2],data[,3],labels=data[,4],col=data[,5])
			dev.off()
		}else{
			print("not enough clustering")
		}
	}else{
		print("not enough samples")
	}
}	