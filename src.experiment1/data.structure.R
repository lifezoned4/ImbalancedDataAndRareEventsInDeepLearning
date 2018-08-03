calcStatsAdult <- function(experimentName, file, targetColumn, minortiyCases, majorityCases) {
data <- read.csv(file, stringsAsFactors = FALSE)

minortiy <- nrow(data[data[, targetColumn] %in% minortiyCases,])
majority <- nrow(data[data[, targetColumn] %in% majorityCases,])

return(data.frame("name"= experimentName, "features"= length(data) - 1,"rows"= nrow(data),"sum"= majority + minortiy, "minortiy"= minortiy, "minority_cases" = paste(minortiyCases, collapse=" "), "majority"= majority, "majority_cases"= paste(majorityCases, collapse=" "), "skewness"= minortiy/majority, "boost"= majority/minortiy))
}

df <- rbind(
  calcStatsAdult("winequality-white", "/home/dfour/projects/MasterThesis/src.experiment1/data/winequality-white.csv", "quality", seq(0, 4),seq(5,10)),
  calcStatsAdult("parkinsons", "/home/dfour/projects/MasterThesis/src.experiment1/data/parkinsons.data.csv", "status", c(0), c(1)),
  calcStatsAdult("adult.orginal", "/home/dfour/projects/MasterThesis/src.experiment1/data/adult.data_orginal.csv", "target", c(" >50K"," >50K."), c(" <=50K"," <=50K.")),
  calcStatsAdult("adult.1to25", "/home/dfour/projects/MasterThesis/src.experiment1/data/adult.data_1to25.csv", "target", c(" >50K"," >50K."), c(" <=50K"," <=50K.")),
  calcStatsAdult("adult.1to50", "/home/dfour/projects/MasterThesis/src.experiment1/data/adult.data_1to50.csv", "target", c(" >50K"," >50K."), c(" <=50K"," <=50K.")),
  calcStatsAdult("adult.1to100", "/home/dfour/projects/MasterThesis/src.experiment1/data/adult.data_1to100.csv", "target", c(" >50K"," >50K."), c(" <=50K"," <=50K."))
)

colnames(df) <- c("Name", "Feature Columns count", "Rows", "Sum", "Minority", "Minority Cases", "Majority", "Majority Cases", "Skewness.", "Cost-Sensitiv boost")

df
