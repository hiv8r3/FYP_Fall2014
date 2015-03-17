#Block 3 recognition data

#read in cleaned data set, just Block 3 trials
Block3dat = read.delim("Block3dat.txt", header = T, stringsAsFactors=F)


#change format to do ANOVA
#different line for each value (so each variable has a column specifying which level of that variable
#the value is for)
require(reshape2)
require(plyr)
wide= melt(tapply(Block3dat$Error, INDEX=list(Block3dat$Fix, Block3dat$Race, Block3dat$Subnum), 
                  FUN= sum))

wide = rename(wide, c("Var1" = "Fix", "Var2" = "Race", 
                      "Var3" = "Subnum", "value" = "NumErr"))

#for within subjects ANOVAs, SUBJECT HAS TO BE A FACTOR
wide$Subnum = factor(wide$Subnum)

#to do ANOVA (look at effect of Fix, Race, and interaction)
#need to add error term because of within subjects design (wouldn't have that for between subjects)
#if mixed design, put only within Ss variables in Error term
int <- aov(NumErr ~ (Fix*Race)+Error(Subnum/(Fix*Race)), data = wide)
#same thing as anova(lm(NumErr ~ etc.))
#if between subjects, it would look lik aov(NumErr ~ Fix*Race, data = wide)

summary(int)  #displays Type 1 ANOVA, will be different from Type 3 ANOVA when unbalanced design

boxplot(NumErr~Fix*Race, data = wide)


#for one way ANOVAs within race
Bfaces = Block3dat[Block3dat$Race == 1,]
Wfaces = Block3dat[Block3dat$Race == 2,]
#within Black faces
wideB= melt(tapply(Bfaces$Error, INDEX=list(Bfaces$Fix, Bfaces$Race, Bfaces$Subnum), 
                   FUN= sum))

wideB = rename(wideB, c("Var1" = "Fix", "Var2" = "Race", 
                        "Var3" = "Subnum", "value" = "NumErr"))

onewayB = aov(NumErr ~ Fix+Error(Subnum/Fix), data = wideB)
summary(onewayB)
#within White faces
wideW= melt(tapply(Wfaces$Error, INDEX=list(Wfaces$Fix, Wfaces$Race, Wfaces$Subnum), 
                   FUN= sum))

wideW = rename(wideW, c("Var1" = "Fix", "Var2" = "Race", 
                        "Var3" = "Subnum", "value" = "NumErr"))

onewayW = aov(NumErr ~ Fix+Error(Subnum/Fix), data = wideW)
summary(onewayW)


#one way comparison, corrected for family wise error
#TukeyHSD(oneway)    #Only works for between subjects


#for means/figures
#fix x race (num of errors)
fixrace = tapply(Block3dat$Error, INDEX=list(Block3dat$Fix, Block3dat$Race), FUN= sum)
#USE THIS FIGURE- figure out x axis names
barplot(fixrace, main="Num of recognition errors (race x fixation), Block 3",
        xlab="Race", col=c("darkblue","green", "yellow"),
        ylim = c(125,200), 
        names.arg= c("Black","White"),
        legend = c("eyes", "forehead", "nose"), beside=TRUE, xpd=FALSE)

#just fix (num of errors)
tapply(Block3dat$Error, INDEX=list(Block3dat$Fix), FUN= sum)


