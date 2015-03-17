#Looks at block 3 data from behavioral pilot data
#Within subjects ANOVA shows main effect of race, qualified by Race*Fix interaction

#read in cleaned data set
dat = read.delim("CleanedPilotData.txt", header = T, stringsAsFactors=F)

Block3dat = dat[dat$Block == 3,]

#isolate error trials
Block3err = Block3dat[Block3dat$Error ==1,]

#to find number of error trials in Black vs White trials
count= tapply(Block3dat$Trial, INDEX=list(Block3dat$Error, Block3dat$Race, Block3dat$Fix), FUN= length)

#find number of trials separated race x fix (looking only at error trials)
err= tapply(Block3err$Trial, INDEX=list(Block3err$Race, Block3err$Fix), FUN= length)

err2= tapply(Block3err$Trial, INDEX=list(Block3err$Fix, Block3err$Race), FUN= length)

#fixation separated by race
barplot(err, main="# of error trials, Fix separated by Race",
        xlab="Fixation", col=c("black","white"),
        ylab="Number of errors",
        ylim= c(0,230),
        beside=TRUE, xpd=FALSE)
legend("topright",
       legend= c("Black", "White"),
       fill= c("black","white"))

#race separated by fixation
barplot(err2, main="# of error trials, Race separated by Fix",
        xlab="Race", col=c("red","blue", "green"),
        ylab="Number of errors",
        names.arg= c("Black","White"),
        ylim= c(0,230),
        beside=TRUE, xpd=FALSE)
legend("topright",
  legend= c("Eyes", "Forehead", "Nose"),
  fill= c("red", "blue", "green"))

#change dichotomous variables to factors so that they are identified as two separate levels?
#ie race, error, etc
#example: Block3dat$Error = factor(Block3dat$Error)
#summary() of facotrs will give you levels of factors and how many are in each level (frequencies of levels)



