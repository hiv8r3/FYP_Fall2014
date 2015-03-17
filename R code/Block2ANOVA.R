#Block 2 data
#2 wave of analyses

#read in cleaned data set, just Block 2 trials
Block2dat = read.delim("Block2dat.txt", header = T, stringsAsFactors=F)

#change format to do ANOVA
#different line for each value (so each variable has a column specifying which level of that variable
#the value is for)
require(reshape2)
wide= melt(tapply(Block2dat$RT, INDEX=list(Block2dat$Fix, Block2dat$Race, Block2dat$Congruent, Block2dat$Subnum), 
                  FUN= mean))

require(plyr)
wide = rename(wide, c("Var1" = "Fix", "Var2" = "Race", 
                      "Var3" = "Congruent", "Var4" = "Subnum", "value" = "RT"))

#for within subjects ANOVAs, SUBJECT HAS TO BE A FACTOR
wide$Subnum = factor(wide$Subnum)

#to do ANOVA (look at effect of Fix, Race, Congruency and interaction)
#need to add error term because of within subjects design (wouldn't have that for between subjects)
#if mixed design, put only within Ss variables in Error term
int <- aov(RT ~ (Fix*Race*Congruent)+Error(Subnum/(Fix*Race*Congruent)), data = wide)

summary(int)  #displays Type 1 ANOVA, will be different from Type 3 ANOVA when unbalanced design

#finds main effect of race, no significant interactions

boxplot(RT~Fix*Race*Congruent, data = wide)

hist(wide$RT, breaks= 30) #looks skewed, try log(RT)?


#Same anaylsis, but with log transformed RT

#need to take out RTs < 50ms
elimfast = Block2dat[Block2dat$RT >= 50,]
#add column for logRT
elimfast$logRT = NULL

for (i in 1:length(row.names(elimfast))) {
  elimfast$logRT[i] = log(elimfast$RT[i])
}

hist(elimfast$RT, breaks = 30)
hist(elimfast$logRT, breaks = 30)  


widelog= melt(tapply(elimfast$logRT, INDEX=list(elimfast$Fix, elimfast$Race, elimfast$Congruent, elimfast$Subnum), 
                     FUN= mean))

widelog = rename(widelog, c("Var1" = "Fix", "Var2" = "Race", 
                            "Var3" = "Congruent", "Var4" = "Subnum", "value" = "logRT"))

#for within subjects ANOVAs, SUBJECT HAS TO BE A FACTOR
widelog$Subnum = factor(widelog$Subnum)

#omnibus ANOVA
intlogRT <- aov(logRT ~ (Fix*Race*Congruent)+Error(Subnum/(Fix*Race*Congruent)), data = widelog)

summary(intlogRT)  #displays Type 1 ANOVA, will be different from Type 3 ANOVA when unbalanced design

#create figure with log RT
#Figure 1b
#find mean RT in congruent/incongruent trials, separated by fixation
means1 = tapply(elimfast$logRT, INDEX=list(elimfast$Fix), FUN= mean)


