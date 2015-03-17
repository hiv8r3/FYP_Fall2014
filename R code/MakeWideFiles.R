#Puts files into wide format for ANOVA analysis in SAS
require(plyr)

#read in cleaned data set, just block 2 trials
Block2 = read.delim("Block2dat.txt", header = T, stringsAsFactors=F)


#makes wide file with meanRTs from all trials, separated by fixation x congruent
wide = tapply(Block2$RT, INDEX = list(Block2$Subnum, Block2$Congruent, Block2$Fix), FUN= mean)

wide_format = as.data.frame(wide, row.names=NULL, stringsAsFactors=F)
wide_format$Subnum = rownames(wide_format)
#renames columns (1 = congruent, 0 = incongruent)
wide_format = rename(wide_format, c("0.eyes" = "eyes_inc", "1.eyes" = "eyes_con", 
                                    "0.forehead" = "fore_inc", "1.forehead" = "fore_con",
                                    "0.nose" = "nose_inc", "1.nose" = "nose_con"))
#reorganizes the columns
wide_format = wide_format[c("Subnum", "eyes_con", "eyes_inc", "fore_con", "fore_inc", "nose_con", "nose_inc")]

#writes mean RT data for all trials to external file
write.table(wide_format, file="meanRT_allTrials_fixBYcon.txt", sep = "\t", na = "NA", row.names= FALSE)



#makes wide file with meanRTs from Black trials, separated by fixation x word valence

Blackdat =  Block2[Block2$Race == 1,]

wide = tapply(Blackdat$RT, INDEX = list(Blackdat$Subnum, Blackdat$WordValence, Blackdat$Fix), FUN= mean)

wide_format = as.data.frame(wide, row.names=NULL, stringsAsFactors=F)
wide_format$Subnum = rownames(wide_format)
#renames columns (2 = positive, 1 = negative)
wide_format = rename(wide_format, c("1.eyes" = "eyes_neg", "2.eyes" = "eyes_pos", 
                                    "1.forehead" = "fore_neg", "2.forehead" = "fore_pos",
                                    "1.nose" = "nose_neg", "2.nose" = "nose_pos"))
#reorganizes the columns
wide_format = wide_format[c("Subnum", "eyes_pos", "eyes_neg", "fore_pos", "fore_neg", "nose_pos", "nose_neg")]

#writes mean RT data for all trials to external file
write.table(wide_format, file="meanRT_BlackTrials_fixBYval.txt", sep = "\t", na = "NA", row.names= FALSE)


#makes wide file with meanRTs from Black trials, separated by fixation x word valence

Whitedat =  Block2[Block2$Race == 2,]

wide = tapply(Whitedat$RT, INDEX = list(Whitedat$Subnum, Whitedat$WordValence, Whitedat$Fix), FUN= mean)

wide_format = as.data.frame(wide, row.names=NULL, stringsAsFactors=F)
wide_format$Subnum = rownames(wide_format)
#renames columns (2 = positive, 1 = negative)
wide_format = rename(wide_format, c("1.eyes" = "eyes_neg", "2.eyes" = "eyes_pos", 
                                    "1.forehead" = "fore_neg", "2.forehead" = "fore_pos",
                                    "1.nose" = "nose_neg", "2.nose" = "nose_pos"))
#reorganizes the columns
wide_format = wide_format[c("Subnum", "eyes_pos", "eyes_neg", "fore_pos", "fore_neg", "nose_pos", "nose_neg")]

#writes mean RT data for all trials to external file
write.table(wide_format, file="meanRT_WhiteTrials_fixBYval.txt", sep = "\t", na = "NA", row.names= FALSE)


