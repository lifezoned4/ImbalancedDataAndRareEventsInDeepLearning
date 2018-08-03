# Loading
library(ggplot2)

theme_set(theme_grey(base_size = 24))

data_folder <- paste0(getwd(), "/")

dnn_type <- ""
if(endsWith(data_folder, "0/")) {
  dnn_type <- "DNN"
} else if(endsWith(data_folder, "1/")) {
  dnn_type <- "Non-deep"
}

get_data_experiment_summary <- function(experimentName, folder) {
  data_summary <- data.frame()
  for (method in c("Imbalanced", "AdaGrad", "RUS", "ENN", "ROS", "SMOTE", "SMOTEENN", "CostSensitive")){
      data_tmp = read.table(sep=",", col.names=c("step", "AUC", "tpr", "tnr"), paste0(folder, "experiment_", experimentName, ".", method, ".log"))
      data_tmp$method_type <- method

      data_summary <- rbind(data_summary, data.frame(name=experimentName, method_type=method, mean=round(mean(data_tmp$AUC),3), sd=round(sd(data_tmp$AUC),3)))
    }

    return(data_summary)
}

get_data_experiment <- function(experimentName, folder) {
  data <- data.frame()

  for (method in c("Imbalanced","SMOTE", "ROS", "RUS", "ENN", "SMOTEENN", "CostSensitive", "AdaGrad")){
    data_tmp = read.table(sep=",", col.names=c("step", "AUC", "tpr", "tnr"), paste0(folder, "experiment_", experimentName, ".", method, ".log"))
    data_tmp$method_type <- method

    data <- rbind(data, data_tmp)
  }

  return(data)
}


data <- get_data_experiment("winequality", data_folder)

p <- ggplot(data, aes(x=method_type, y=AUC)) + geom_violin(scale = "width", draw_quantiles = c(0.25, 0.5, 0.75))
p <- p + labs(title=paste("winequality", dnn_type), x="", y="AUC score") + coord_cartesian(ylim=c(0.40, 1))
p

ggsave(paste0(data_folder, "winequality_auc.pdf"), width = 20, height = 5)

data <- get_data_experiment("parkinsons", data_folder)

p <- ggplot(data, aes(x=method_type, y=AUC)) + geom_violin(scale = "width", draw_quantiles = c(0.25, 0.5, 0.75))
p <- p + labs(title=paste("parkinsons", dnn_type), x="", y="AUC score") + coord_cartesian(ylim=c(0.2,1))
p

ggsave(paste0(data_folder, "parkinsons_auc.pdf"), width = 20, height = 5)

data <- get_data_experiment("adult.orginal", data_folder)

p <- ggplot(data, aes(x=method_type, y=AUC))  + geom_violin(scale = "width", draw_quantiles = c(0.25, 0.5, 0.75))
p <- p + labs(title=paste("adult.original", dnn_type), x="", y="AUC score") + coord_cartesian(ylim=c(0.45,0.7))
p

ggsave(paste0(data_folder, "adult_original_auc.pdf"), width = 20, height = 5)

data <- get_data_experiment("adult.1to25", data_folder)

p <- ggplot(data, aes(x=method_type, y=AUC))  + geom_violin(scale = "width", draw_quantiles = c(0.25, 0.5, 0.75))
p <- p + labs(title=paste("adult.1to25", dnn_type), x="", y="AUC score") + coord_cartesian(ylim=c(0.45,0.7))
p

ggsave(paste0(data_folder, "adult_1to25_auc.pdf"), width = 20, height = 5)

data <- get_data_experiment("adult.1to50", data_folder)

p <- ggplot(data, aes(x=method_type, y=AUC))  + geom_violin(scale = "width", draw_quantiles = c(0.25, 0.5, 0.75))
p <- p + labs(title=paste("adult.1to50", dnn_type), x="", y="AUC score") + coord_cartesian(ylim=c(0.45,0.7))
p

ggsave(paste0(data_folder, "adult_1to50_auc.pdf"), width = 20, height = 5)

data <- get_data_experiment("adult.1to100", data_folder)

p <- ggplot(data, aes(x=method_type, y=AUC))  + geom_violin(scale = "width", draw_quantiles = c(0.25, 0.5, 0.75))
p <- p + labs(title=paste("adult.1to100", dnn_type), x="", y="AUC score") + coord_cartesian(ylim=c(0.45,0.7))
p

ggsave(paste0(data_folder, "adult_1to100_auc.pdf"), width = 20, height = 5)

summary_table1 <- rbind(
  get_data_experiment_summary("winequality", data_folder),
  get_data_experiment_summary("parkinsons", data_folder))

summary_table2 <- rbind(
  get_data_experiment_summary("adult.orginal", data_folder),
  get_data_experiment_summary("adult.1to25", data_folder),
  get_data_experiment_summary("adult.1to50", data_folder),
  get_data_experiment_summary("adult.1to100", data_folder))


summary_table1
summary_table2

data_tmp = read.csv(sep=",", paste0(data_folder, "loss.log/experiment_adult.orginal.Imbalanced/1.csv"))

p <- ggplot(data_tmp, aes(x=step, y=loss))+ geom_line() + labs(title= paste(dnn_type, "adult.original", "'Imbalanced'", "loss"))
p

ggsave(paste0(data_folder, "bad_loss.pdf"),width=8, height=6)

data_tmp = read.csv(sep=",", paste0(data_folder, "loss.log/experiment_winequality.CostSensitive/1.csv"))

p <- ggplot(data_tmp, aes(x=step, y=loss))+ geom_line() + labs(title= paste(dnn_type, "winequality", "'CostSensitive'", "loss"))
p

ggsave(paste0(data_folder, "good_loss.pdf"), width=8, height=6)
