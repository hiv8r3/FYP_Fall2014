require(ggplot2)

# Import reorganized data (doesn't include 2 bad subjects)
# Has columns for logRT and RT.winz

dat= read.delim("Block2Reorganized_log_winz.txt", stringsAsFactors=F)

corTrials = dat[dat$Error == 0,]
errTrials = dat[dat$Error == 1,]
# Make same bar plots as spring data 

# FaceRace x WordValence x Fix: all subjects (minus bad) together, correct trials
ggplot(corTrials, aes(FaceRace, RT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(550,750)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("Minus bad subjects, correct trials- Fall")
# logRT (correct)
ggplot(corTrials, aes(FaceRace, logRT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(6.3,6.6)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("Minus bad subjects, correct trials (log transformed)- Fall")
ggsave("./Figures/For SPAM presentation/Fig. 1- FaceRace x WordVal x Fix (logRT).tiff")

# logRT (error)
ggplot(errTrials, aes(FaceRace, logRT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(5,7)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("Minus bad subjects, error trials (log transformed)- Fall")


# FaceRace x WordValence x Fix: faceted differently
ggplot(corTrials, aes(Fix, RT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~FaceRace) +
  coord_cartesian(ylim=c(500,750)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("Minus bad subjects, correct trials (Winsorized)- Fall")

# FaceRace x WordValence: all subjects (minus bad), correct trials
ggplot(corTrials, aes(FaceRace, RT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
#  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(550,750)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("All subjects (minus bad), correct trials (Winsorized)- Fall")

# Fix x Congruence x FaceRace: all subjects (minus bad), correct trials
# logRT (correct)
ggplot(corTrials, aes(FaceRace, logRT, fill = Congruent)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(6.3,6.6)) +
  theme_bw() +
  scale_fill_manual("Congruent", values = c("Con" = "purple", "Incon" = "lightgreen")) +
  ggtitle("Minus bad subjects, correct trials (log transformed)- Fall")
ggsave("./Figures/For SPAM presentation/Fig. 2- FaceRace x Con x Fix (logRT).tiff")


# Fix x Congruence: all subjects (minus bad), correct trials
# logRT (correct)- WordVal
ggplot(corTrials, aes(Fix, logRT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  coord_cartesian(ylim=c(6.4,6.55)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("Minus bad subjects, correct trials (log transformed)- Fall")
ggsave("./Figures/For SPAM presentation/Fig. 3- FaceRace x WordValence (logRT).tiff")

# logRT (correct)- Con
ggplot(corTrials, aes(Fix, logRT, fill = Congruent)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  coord_cartesian(ylim=c(6.4,6.55)) +
  theme_bw() +
  scale_fill_manual("Congruent", values = c("Con" = "purple", "Incon" = "lightgreen")) +
  ggtitle("Minus bad subjects, correct trials (log transformed)- Fall")
ggsave("./Figures/For SPAM presentation/Fig. 4- FaceRace x Con (logRT).tiff")

# RT (correct)- Con
ggplot(corTrials, aes(Fix, RT, fill = Congruent)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  coord_cartesian(ylim=c(650,750)) +
  theme_bw() +
  scale_fill_manual("Congruent", values = c("Con" = "purple", "Incon" = "lightgreen")) +
  ggtitle("Minus bad subjects, correct trials (raw)- Fall")
ggsave("./Figures/For SPAM presentation/Fig. 5- FaceRace x Con (rawRT).tiff")


# same with fast subjects
dat2= read.delim("Block2Reorganized.txt", stringsAsFactors=F)

corTrials2 = dat2[dat2$Error == 0,]
# Make same bar plots as spring data 

# FaceRace x WordValence x Fix: all subjects together, correct trials
ggplot(corTrials2, aes(FaceRace, RT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(550,750)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("All subjects, correct trials (Winsorized)- Fall")

# FaceRace x WordValence x Fix: faceted differently
ggplot(corTrials2, aes(Fix, RT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~FaceRace) +
  coord_cartesian(ylim=c(550,750)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("All subjects, correct trials (Winsorized)- Fall")

# FaceRace x WordValence: all subjects (minus bad), correct trials
ggplot(corTrials2, aes(FaceRace, RT, fill = WordValence)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  #  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(550,750)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("Neg" = "brown", "Pos" = "lightblue")) +
  ggtitle("All subjects (minus bad), correct trials (Winsorized)- Fall")

# Fix x Congruence: all subjects (minus bad), correct trials
ggplot(corTrials2, aes(Fix, RT, fill = Congruent)) +
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  coord_cartesian(ylim=c(600,750)) +
  theme_bw() +
  scale_fill_manual("Congruent", values = c("Con" = "purple", "Incon" = "red")) +
  ggtitle("All subjects (minus bad), correct trials (Winsorized)- Fall")
