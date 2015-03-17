#Looks at block 2 data from behavioral pilot data

#read in cleaned data set
dat = read.delim("CleanedPilotData.txt", header = T, stringsAsFactors=F)

Block2dat = dat[dat$Block == 2,]

#add column for congruence
# 1 = race and word are congruent
# 2 = race and word are incongruent
Block2dat$Congruent = NULL

for (i in 1:length(rownames(Block2dat)))
  if (Block2dat$Race[i] == Block2dat$WordValence[i])  {
    Block2dat$Congruent[i] = 1
  } else if (Block2dat$Race[i] != Block2dat$WordValence[i])  {
    Block2dat$Congruent[i] = 2
  }

#descriptive statistics for each group separated by factors
require(pastecs)
by(Block2dat$RT, list(Block2dat$Race, Block2dat$Fix, Block2dat$Congruent), stat.desc, basic = FALSE)

write.table(Block2dat, file="Block2dat.txt", sep="\t",row.names= FALSE)

