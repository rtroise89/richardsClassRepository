library(data.table)
library(dplyr)
library(ggplot2)
all_data <- fread("data_csv/stroop_stand.csv")

RTs <- c(as.numeric(unlist(all_data[,1])),
         as.numeric(unlist(all_data[,2])),
         as.numeric(unlist(all_data[,3])),
         as.numeric(unlist(all_data[,4]))
)

Congruency <- rep(rep(c("Congruent","Incongruent"),each=50),2)
Posture <- rep(c("Stand","Sit"),each=100)
Subject <- rep(1:50,4)

stroop_df <- data.frame(Subject,Congruency,Posture,RTs)

num_subjects <- stroop_df %>%
        group_by(Subject) %>%
        summarise(counts = length(Subject))

hist(stroop_df$RTs)

overall_means <- stroop_df %>%
  group_by(Posture,Congruency) %>%
  summarise(meanRT = mean(RTs),
            SEMRT = (sd(RTs)/sqrt(length(RTs))))

# make a table of overall means
knitr::kable(overall_means)

ggplot(overall_means, aes(x=Posture,
                          y=meanRT, 
                          group=Congruency,
                          fill=Congruency))+
  geom_bar(stat="identity",position="dodge")+
  theme_classic(base_size=12)+
  ylab("Mean Reaction Time (ms)")+
  geom_errorbar(aes(ymin=meanRT-SEMRT,
                    ymax=meanRT+SEMRT),
                position=position_dodge(width=0.9),
                width=.2,
                color="black")+
  coord_cartesian(ylim=c(750,1000))

# Make sure Subjecdt is  a factor
stroop_df$Subject <-  as.factor(stroop_df$Subject)

aov_out <- aov(RTs~Posture*Congruency + Error(Subject/(Posture*Congruency)), stroop_df)
#print summary of ANOVA table
summary(aov_out)

# prints a nicer ANOVA table
summary_out <- summary(aov_out)
library(xtable)
knitr::kable(xtable(summary_out))
