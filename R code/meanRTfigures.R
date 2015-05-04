# Looks at block 2 data from behavioral pilot data
# Checks for expected results of evaluative priming
# faster RT for congruent trials than incongruent

#read in cleaned data set
Block2dat = read.delim("Block2dat.txt", header = T, stringsAsFactors=F)

#to find mean RT in congruent vs incongruent trials
tapply(Block2dat$RT, INDEX=list(Block2dat$Congruent), FUN= mean)

#Figure 1
#find mean RT in congruent/incongruent trials, separated by fixation
means1 = tapply(Block2dat$RT, INDEX=list(Block2dat$Congruent, Block2dat$Fix), FUN= mean)

#write the means as a table to a text file
sink ("Figures/Tables of means.txt")
print ("Figure 1: Mean RTs (congruent x fixation) for all trials")
means1
sink (file = NULL)

#make a bar graph
barplot(means1, main="mean RT (congruency x fixation) for all trials",
        xlab="Fixation", col=c("darkblue","green"),
        ylim = c(630,700), legend = c("incongruent", "congruent"), beside=TRUE, xpd=FALSE)

#Figure 2
#mean RT for congruent/incongruent trials, separated by fixation for correct trials
corTrials = Block2dat[Block2dat$Error == 0,]
means2 = tapply(corTrials$RT, INDEX=list(corTrials$congruent, corTrials$Fix), FUN= mean)

#write the means as a table to a text file
sink ("Figures/Tables of means.txt", append = T)
print ("Figure 2: Mean RTs (congruent x fixation) for correct trials")
means2
sink (file = NULL)

#count number of correct trials included in means in each condition
sink ("Figures/Tables of means.txt", append = T)
print ("Number of correct trials in each condition")
tapply(corTrials$RT, INDEX=list(corTrials$Congruent, corTrials$Fix), FUN= length)
sink (file = NULL)

#make a bar graph
barplot(means2, main="mean RT (congruency x fixation) for correct trials",
        xlab="Fixation", col=c("blue","lightgreen"),
        ylim = c(630,715), legend = c("incongruent", "congruent"), beside=TRUE, xpd=FALSE)

#Figure 3
#mean RT for congruent/incongruent trials, separated by fixation for error trials
errTrials = Block2dat[Block2dat$Error == 1,]
means3 = tapply(errTrials$RT, INDEX=list(errTrials$Congruent, errTrials$Fix), FUN= mean)

#write the means as a table to a text file
sink ("Figures/Tables of means.txt", append = T)
print ("Figure 3: Mean RTs (congruent x fixation) for error trials")
means3
sink (file = NULL)

#count number of error trials included in means in each condition
sink ("Figures/Tables of means.txt", append = T)
print ("Number of error trials in each condition")
tapply(errTrials$RT, INDEX=list(errTrials$Congruent, errTrials$Fix), FUN= length)
sink (file = NULL)

#make a bar graph
barplot(means3, main="mean RT (congruency x fixation) for error trials",
        xlab="Fixation", col=c("cornflowerblue","aquamarine"),
        ylim = c(300,700), legend = c("incongruent", "congruent"), beside=TRUE, xpd=FALSE)


# Figure 4: Looking just at trials with Black prime (separated by word target and fixation)
BTrials = Block2dat[Block2dat$Race == 1,]

means4 = tapply(BTrials$RT, INDEX= list(BTrials$WordValence, BTrials$Fix), FUN= mean)
#write the means as a table to a text file
sink ("Figures/Tables of means.txt", append = T)
print ("Figure 4: Mean RTs (word valence x fixation) following Black primes")
means4
sink (file = NULL)

#count number of error trials included in means in each condition
sink ("Figures/Tables of means.txt", append = T)
print ("Number of trials in each condition")
tapply(BTrials$RT, INDEX= list(BTrials$WordValence, BTrials$Fix), FUN= length)
sink (file = NULL)

#make a bar graph
barplot(means4, main="mean RT (word valence x fixation) following Black primes",
        xlab="Fixation", col=c("blueviolet","red"),
        ylim = c(630,730), legend = c("negative", "positive"), beside=TRUE, xpd=FALSE)

#Figure 4b: same but with congruence instead of word valence
means4b = tapply(BTrials$RT, INDEX= list(BTrials$Congruent, BTrials$Fix), FUN= mean)

barplot(means4b, main="mean RT (congruence x fixation) following Black primes",
        xlab="Fixation", col=c("blueviolet","orange"),
        ylim = c(630,730), legend = c("incongruent", "congruent"), beside=TRUE, xpd=FALSE)


# Figure 5: Looking just at trials with White prime (separated by word target and fixation)
WTrials = Block2dat[Block2dat$Race == 2,]

means5 = tapply(WTrials$RT, INDEX= list(WTrials$WordValence, WTrials$Fix), FUN= mean)
#write the means as a table to a text file
sink ("Figures/Tables of means.txt", append = T)
print ("Figure 5: Mean RTs (word valence x fixation) following White primes")
means5
sink (file = NULL)

#count number of error trials included in means in each condition
sink ("Figures/Tables of means.txt", append = T)
print ("Number of trials in each condition")
tapply(WTrials$RT, INDEX= list(WTrials$WordValence, WTrials$Fix), FUN= length)
sink (file = NULL)

#make a bar graph
barplot(means5, main="mean RT (word valence x fixation) following White primes",
        xlab="Fixation", col=c("blueviolet","red"),
        ylim = c(630,730), legend = c("negative", "positive"), beside=TRUE, xpd=FALSE)

#Figure 5b: same but with congruence instead of word valence
means5b = tapply(WTrials$RT, INDEX= list(WTrials$Congruent, WTrials$Fix), FUN= mean)

barplot(means5b, main="mean RT (congruence x fixation) following White primes",
        xlab="Fixation", col=c("blueviolet","orange"),
        ylim = c(630,730), legend = c("incongruent", "congruent"), beside=TRUE, xpd=FALSE)




##################################
Block2dat$WordValence = as.factor(Block2dat$WordValence)
Block2dat$Race = as.factor(Block2dat$Race)

barW = ggplot(Block2dat, aes(Race, RT, fill = WordValence))
barW + 
  stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width=.9), width = .2) +
  facet_wrap(~Fix) +
  coord_cartesian(ylim=c(500,800)) +
  theme_bw() +
  scale_fill_manual("WordValence", values = c("1" = "brown", "2" = "lightblue"))


