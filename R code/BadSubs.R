#Look for bad subs or trials

dat2 = read.delim("Block2Reorganized.txt", stringsAsFactors=F)


# Look for people with insanely fast RTs -- they're just jamming a button
meanRT = tapply(dat2$RT, INDEX=dat2$Subno, FUN=mean)
meanRT
barplot(meanRT)
hist(meanRT, breaks=20)
# Sub 5 and Sub 24 have mean < 400 ms (that's pretty fast). Consider throwing out?

# who's doing shitty?

NumError = tapply(dat2$Error, INDEX=dat2$Subno, FUN=sum, na.rm=T)
NumError
barplot(NumError)
hist(NumError, breaks=10)

# How many errors is acceptable?
# Probability of getting trial correct by chance is 50%
# so what's the critical number of correct trials to be 
# not an asshole, p<.01?
alpha = .01
qbinom(p = 1-alpha, 
       size = 192,    #number of trials
       prob=.5)
# grab subjects who got <112 correct
NumCorrect = 192 - tapply(dat2$Error, dat2$Subno, FUN=sum)
badTab = NumCorrect[NumCorrect < 112]

# make a log of it
badSubs = data.frame("Subno" = names(badTab),
                      "correctCount" = badTab,
                      "reason" = "Bad accuracy, fast RT")


write.table(badSubs, file="badSubs.txt", sep="\t", row.names=F)

