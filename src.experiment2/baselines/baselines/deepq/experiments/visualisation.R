library(tidyverse)
require(scales)
require(data.table)

datadir <- paste0(getwd(), "/")

theme_set(theme_grey(base_size = 16))

progress_L0 <- read.csv(paste0(datadir, "data.L0/progress.csv"))
progress_L0$Latency <- "L0"
progress_L1 <- read.csv(paste0(datadir, "data.L1/progress.csv"))
progress_L1$Latency <- "L1"
progress_L2 <- read.csv(paste0(datadir, "data.L2/progress.csv"))
progress_L2$Latency <- "L2"
progress_L3 <- read.csv(paste0(datadir, "data.L3/progress.csv"))
progress_L3$Latency <- "L3"
progress_L4 <- read.csv(paste0(datadir, "data.L4/progress.csv"))
progress_L4$Latency <- "L4"

cruve_progress_L0toL4 <- rbind(progress_L0, progress_L1, progress_L2, progress_L3, progress_L4)

comma <- c(0, 1, 2 ,3, 4)

ggplot(data = cruve_progress_L0toL4, aes(x = steps, y = mean.100.episode.reward, color=Latency)) +
  geom_line() +  labs(title = "Training progress for models L0-L4" , x = "Seen frames [million]", y = "Return last 100 episodes") + scale_x_continuous(labels = comma)

ggsave(paste0(datadir, "progress_L0toL4.pdf"))


progress_LM1 <- read.csv(paste0(datadir, "data.LM1/progress.csv"))
progress_LM1$Method <- "seasonal"
progress_LM2 <- read.csv(paste0(datadir, "LM2.run1/data.LM2/progress.csv"))
progress_LM2$Method <- "alternate"
progress_LM3 <- read.csv(paste0(datadir, "LM3.run1/data.LM3/progress.csv"))
progress_LM3$Method <- "alternateRNG"

cruve_progress_LM1toLM3 <- rbind(progress_LM1, progress_LM2, progress_LM3)

ggplot(data = cruve_progress_LM1toLM3, aes(x = steps, y = mean.100.episode.reward, color=Method)) +
  geom_line() +  labs(title = "Training progress for special methods" , x = "Seen frames [million]", y = "Return last 100 episodes") + scale_x_continuous(labels = comma)

ggsave(paste0(datadir, "progress_special_methods.pdf"))


ggplot(data = progress_L0, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress L0" , x = "Seen frames [million]", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_L0.pdf"))

ggplot(data = progress_L1, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress L1" , x = "Seen frames", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_L1.pdf"))

ggplot(data = progress_L2, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress L2" , x = "Seen frames", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_L2.pdf"))

ggplot(data = progress_L3, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress L3" , x = "Seen frames", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_L3.pdf"))

ggplot(data = progress_L4, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress L4" , x = "Seen frames", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_L4.pdf"))

ggplot(data = progress_LM1, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress 'seasonal'" , x = "Seen frames [million]", y = "Return over last 100 epsiodes") +
  scale_x_continuous(labels = comma)

ggsave(paste0(datadir, "progress_seasonal.pdf"))

ggplot(data = progress_LM2, aes(x = steps, y = mean.100.episode.reward)) +
   geom_line() +  labs(title = "Training progress LM2" , x = "Seen frames", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_LM2.pdf"))

ggplot(data = progress_LM3, aes(x = steps, y = mean.100.episode.reward)) +
  geom_line() +  labs(title = "Training progress LM3" , x = "Seen frames", y = "Mean reward over last 100 epochs")

ggsave(paste0(datadir, "progress_LM3.pdf"))

# Latency 0
result_L0_U0 <- read.csv(paste0(datadir, "data.L0/PongNoFrameskip-v4.L0.pkl.on-L0.csv"))
result_L0_U0$UnderLatency <-  rep("L0" ,nrow(result_L0_U0))

result_L0_U1 <- read.csv(paste0(datadir, "data.L0/PongNoFrameskip-v4.L0.pkl.on-L1.csv"))
result_L0_U1$UnderLatency <-  rep("L1" ,nrow(result_L0_U1))

result_L0_U2 <- read.csv(paste0(datadir, "data.L0/PongNoFrameskip-v4.L0.pkl.on-L2.csv"))
result_L0_U2$UnderLatency <-  rep("L2" ,nrow(result_L0_U2))

results_L0  <- rbind(result_L0_U0, result_L0_U1, result_L0_U2)

ggplot(results_L0, aes(x=UnderLatency, y=Reward)) +
  geom_boxplot() + labs(title="Performance L0", x="Latency game runs on", y="Return in game") + coord_cartesian(ylim=c(-21,21))

ggsave(paste0(datadir, "result_L0.pdf"))

# Latency 1
result_L1_U0 <- read.csv(paste0(datadir, "data.L1/PongNoFrameskip-v4.L1.pkl.on-L0.csv"))
result_L1_U0$UnderLatency <-  rep("L0" ,nrow(result_L1_U0))

result_L1_U1 <- read.csv(paste0(datadir, "data.L1/PongNoFrameskip-v4.L1.pkl.on-L1.csv"))
result_L1_U1$UnderLatency <-  rep("L1" ,nrow(result_L1_U1))

result_L1_U2 <- read.csv(paste0(datadir, "data.L1/PongNoFrameskip-v4.L1.pkl.on-L2.csv"))
result_L1_U2$UnderLatency <-  rep("L2" ,nrow(result_L1_U2))

results_L1  <- rbind(result_L1_U0, result_L1_U1, result_L1_U2)

ggplot(results_L1, aes(x=UnderLatency, y=Reward)) +
  geom_boxplot() + labs(title="Performance L1", x="Latency game runs on", y="Return in game") + coord_cartesian(ylim=c(-21,21))

ggsave(paste0(datadir, "result_L1.pdf"))

# Latency 2
result_L2_U0 <- read.csv(paste0(datadir, "data.L2/PongNoFrameskip-v4.L2.pkl.on-L0.csv"))
result_L2_U0$UnderLatency <-  rep("L0" ,nrow(result_L2_U0))

result_L2_U1 <- read.csv(paste0(datadir, "data.L2/PongNoFrameskip-v4.L2.pkl.on-L1.csv"))
result_L2_U1$UnderLatency <-  rep("L1" ,nrow(result_L2_U1))

result_L2_U2 <- read.csv(paste0(datadir, "data.L2/PongNoFrameskip-v4.L2.pkl.on-L2.csv"))
result_L2_U2$UnderLatency <-  rep("L2" ,nrow(result_L2_U2))

results_L2  <- rbind(result_L2_U0, result_L2_U1, result_L2_U2)

ggplot(results_L2, aes(x=UnderLatency, y=Reward)) +
  geom_boxplot() + labs(title="Performance L2", x="Latency game runs on", y="Return in game") + coord_cartesian(ylim=c(-21,21))


ggsave(paste0(datadir, "result_L2.pdf"))

# Latency All Mode 1
result_LM1_U0 <- read.csv(paste0(datadir, "data.LM1/PongNoFrameskip-v4.LM1.pkl.on-L0.csv"))
result_LM1_U0$UnderLatency <-  rep("l0" ,nrow(result_LM1_U0))

result_LM1_U1 <- read.csv(paste0(datadir, "data.LM1/PongNoFrameskip-v4.LM1.pkl.on-L1.csv"))
result_LM1_U1$UnderLatency <-  rep("L1" ,nrow(result_LM1_U1))

result_LM1_U2 <- read.csv(paste0(datadir, "data.LM1/PongNoFrameskip-v4.LM1.pkl.on-L2.csv"))
result_LM1_U2$UnderLatency <-  rep("L2" ,nrow(result_LM1_U2))

results_LM1  <- rbind(result_LM1_U0, result_LM1_U1, result_LM1_U2)

ggplot(results_LM1, aes(x=UnderLatency, y=Reward)) +
  geom_boxplot() + labs(title="Performance 'seasonal'", x="Latency game runs on", y="Return in game") + coord_cartesian(ylim=c(-21,21))

ggsave(paste0(datadir, "result_seasonal.pdf"))

# Latency All Mode 2
result_LM2_U0 <- read.csv(paste0(datadir, "LM2.run1/data.LM2/PongNoFrameskip-v4.LM2.pkl.on-L0.csv"))
result_LM2_U0$UnderLatency <-  rep("L0" ,nrow(result_LM2_U0))

result_LM2_U1 <- read.csv(paste0(datadir, "LM2.run1/data.LM2/PongNoFrameskip-v4.LM2.pkl.on-L1.csv"))
result_LM2_U1$UnderLatency <-  rep("L1" ,nrow(result_LM2_U1))

result_LM2_U2 <- read.csv(paste0(datadir, "LM2.run1/data.LM2/PongNoFrameskip-v4.LM2.pkl.on-L2.csv"))
result_LM2_U2$UnderLatency <-  rep("L2" ,nrow(result_LM2_U2))

results_LM2  <- rbind(result_LM2_U0, result_LM2_U1, result_LM2_U2)

ggplot(results_LM2, aes(x=UnderLatency, y=Reward)) +
  geom_boxplot() + labs(title="Performance 'alternate'", x="Latency game runs on", y="Return in game") + coord_cartesian(ylim=c(-21,21))

ggsave(paste0(datadir, "result_alternate.pdf"))

# Latency All Mode 3
result_LM3_U0 <- read.csv(paste0(datadir, "LM3.run6/data.LM3/PongNoFrameskip-v4.LM3.pkl.on-L0.csv"))
result_LM3_U0$UnderLatency <-  rep("L0" ,nrow(result_LM3_U0))

result_LM3_U1 <- read.csv(paste0(datadir, "LM3.run6/data.LM3/PongNoFrameskip-v4.LM3.pkl.on-L1.csv"))
result_LM3_U1$UnderLatency <-  rep("L1" ,nrow(result_LM3_U1))

result_LM3_U2 <- read.csv(paste0(datadir, "LM3.run6/data.LM3/PongNoFrameskip-v4.LM3.pkl.on-L2.csv"))
result_LM3_U2$UnderLatency <-  rep("L2" ,nrow(result_LM3_U2))

results_LM3  <- rbind(result_LM3_U0, result_LM3_U1, result_LM3_U2)

ggplot(results_LM3, aes(x=UnderLatency, y=Reward)) +
  geom_boxplot() + labs(title="Performance 'alternateRNG'", x="Latency game runs on", y="Return in game") + coord_cartesian(ylim=c(-21,21))

ggsave(paste0(datadir, "result_run6_alternateRNG.pdf"))

# alternate Multi
#################
run_numbers <- c("1", "2", "3", "4", "5", "6")

data_summary <- data.frame()
conf.interval <- 0.95
for(latencyName in c("L0", "L1", "L2")){
  i = 0
  for(run_number in run_numbers){
    result_alternate <- read.csv(paste0(datadir, "LM3.run", run_number, "/data.LM3/PongNoFrameskip-v4.LM3.pkl.on-" ,latencyName ,".csv"))

    ciMult <- qt(conf.interval/2 + .5, length(result_alternate$Reward)-1)
    data_summary <- rbind(data_summary, data.frame(latency=latencyName,qtmax=quantile(result_alternate$Reward)["75%"], qtmin=quantile(result_alternate$Reward)["25%"],ci = ciMult * sd(result_alternate$Reward) / sqrt(length(sd(result_alternate$Reward))),sd=round(sd(result_alternate$Reward),8),median=round(median(result_alternate$Reward),8), mean=round(mean(result_alternate$Reward),8)))
  }
}

theme_set(theme_grey(base_size = 8))

colours <- c("#57575F","#AEC8C9", "#849FA0", "#276478", "#CA3542")

data_summary <- data_summary[order(data_summary$mean, decreasing = FALSE),]

data_summary <- tibble::rowid_to_column(data_summary, "ID")

data_summary$ID <- factor(data_summary$ID)

p <-ggplot(data_summary, aes(x=ID, y=mean, color=sd)) +
  scale_color_gradientn(colours = colours, na.value="yellow", guide = guide_legend()) +
  facet_wrap(~latency, scale="free_x") +
  geom_crossbar(aes(ymin=qtmin,ymax=qtmax), colour="gray", width=0.75) +
  geom_errorbar(aes(ymin=mean-ci,ymax=mean+ci), colour="red", width=0.05) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) + geom_point()

p <- p +  labs(title=paste0("'alternate' in ", length(run_numbers), " experiments"), x="runs", y="Mean of returns") + coord_cartesian(ylim=c(-40,40))

p

ggsave(paste0(datadir, "multi_result_alternate.pdf"), units = "cm")

c(
paste("alternate L0 mean of means:", round(mean(data_summary[data_summary$latency == "L0",]$mean),3))
,paste("alternate L0 mean of sds:", round(mean(data_summary[data_summary$latency == "L0",]$sd),3))
,paste("alternate L1 mean of means:", round(mean(data_summary[data_summary$latency == "L1",]$mean),3))
,paste("alternate L1 mean of sds:", round(mean(data_summary[data_summary$latency == "L1",]$sd),3))
,paste("alternate L2 mean of means:", round(mean(data_summary[data_summary$latency == "L2",]$mean),3))
,paste("alternate L2 mean of sds:", round(mean(data_summary[data_summary$latency == "L2",]$sd),3))
)

# alternateRNG multi
####################
run_numbers <- c("1", "2", "3", "4", "5", "6")

data_summary <- data.frame()
conf.interval <- 0.95
for(latencyName in c("L0", "L1", "L2")){
  i = 0
  for(run_number in run_numbers){
    result_alternateRNG <- read.csv(paste0(datadir, "LM2.run", run_number, "/data.LM2/PongNoFrameskip-v4.LM2.pkl.on-" ,latencyName ,".csv"))

    ciMult <- qt(conf.interval/2 + .5, length(result_alternateRNG$Reward)-1)
    data_summary <- rbind(data_summary, data.frame(latency=latencyName,qtmax=quantile(result_alternateRNG$Reward)["75%"], qtmin=quantile(result_alternateRNG$Reward)["25%"], ci = ciMult * sd(result_alternateRNG$Reward) / sqrt(length(sd(result_alternateRNG$Reward))),sd=round(sd(result_alternateRNG$Reward),8),median=round(median(result_alternateRNG$Reward),8), mean=round(mean(result_alternateRNG$Reward),8)))
  }
}

theme_set(theme_grey(base_size = 8))

colours <- c("#57575F","#AEC8C9", "#849FA0", "#276478", "#CA3542")

data_summary <- data_summary[order(data_summary$mean, decreasing = FALSE),]

data_summary <- tibble::rowid_to_column(data_summary, "ID")

data_summary$ID <- factor(data_summary$ID)

p <-ggplot(data_summary, aes(x=ID, y=mean, color=sd)) +
    scale_color_gradientn(colours = colours, na.value="yellow", guide = guide_legend()) +
    facet_wrap(~latency, scale="free_x") +
          geom_crossbar(aes(ymin=qtmin,ymax=qtmax), colour="gray", width=0.75) +
          geom_errorbar(aes(ymin=mean-ci,ymax=mean+ci), colour="red", width=0.05) +
          theme(axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank()) + geom_point()

p <- p +  labs(title=paste0("'alternateRNG' in ", length(run_numbers), " experiments"), x="runs", y="Mean of returns") + coord_cartesian(ylim=c(-40,40))

p

ggsave(paste0(datadir, "multi_result_alternateRNG.pdf"), units = "cm")

c(
paste("alternateRNG L0 mean of means:", round(mean(data_summary[data_summary$latency == "L0",]$mean),3))
,paste("alternateRNG L0 mean of sds:", round(mean(data_summary[data_summary$latency == "L0",]$sd),3))
,paste("alternateRNG L1 mean of means:", round(mean(data_summary[data_summary$latency == "L1",]$mean),3))
,paste("alternateRNG L1 mean of sds:", round(mean(data_summary[data_summary$latency == "L1",]$sd),3))
,paste("alternateRNG L2 mean of means:", round(mean(data_summary[data_summary$latency == "L2",]$mean),3))
,paste("alternateRNG L2 mean of sds:", round(mean(data_summary[data_summary$latency == "L2",]$sd),3))
)
