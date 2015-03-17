# Cleans behavioral pilot data, concatenates all files into one compiled file


#read in all the individual output files
#how to do this in a loop?
Sub1 = read.delim("./Individual data files/Sub1.txt", header = T, stringsAsFactors=F)
Sub2 = read.delim("./Individual data files/Sub2.txt", header = T, stringsAsFactors=F)
Sub3 = read.delim("./Individual data files/Sub3.txt", header = T, stringsAsFactors=F)
Sub4 = read.delim("./Individual data files/Sub4.txt", header = T, stringsAsFactors=F)
Sub5 = read.delim("./Individual data files/Sub5.txt", header = T, stringsAsFactors=F)
Sub6 = read.delim("./Individual data files/Sub6.txt", header = T, stringsAsFactors=F)
Sub7 = read.delim("./Individual data files/Sub7.txt", header = T, stringsAsFactors=F)
Sub8 = read.delim("./Individual data files/Sub8.txt", header = T, stringsAsFactors=F)
Sub9 = read.delim("./Individual data files/Sub9.txt", header = T, stringsAsFactors=F)
Sub10 = read.delim("./Individual data files/Sub10.txt", header = T, stringsAsFactors=F)
Sub11 = read.delim("./Individual data files/Sub11.txt", header = T, stringsAsFactors=F)
Sub12 = read.delim("./Individual data files/Sub12.txt", header = T, stringsAsFactors=F)
Sub13 = read.delim("./Individual data files/Sub13.txt", header = T, stringsAsFactors=F)
Sub14 = read.delim("./Individual data files/Sub14.txt", header = T, stringsAsFactors=F)
Sub15 = read.delim("./Individual data files/Sub15.txt", header = T, stringsAsFactors=F)
Sub16 = read.delim("./Individual data files/Sub16.txt", header = T, stringsAsFactors=F)
Sub17 = read.delim("./Individual data files/Sub17.txt", header = T, stringsAsFactors=F)
Sub18 = read.delim("./Individual data files/Sub18.txt", header = T, stringsAsFactors=F)
Sub19 = read.delim("./Individual data files/Sub19.txt", header = T, stringsAsFactors=F)
Sub20 = read.delim("./Individual data files/Sub20.txt", header = T, stringsAsFactors=F)
Sub21 = read.delim("./Individual data files/Sub21.txt", header = T, stringsAsFactors=F)
Sub22 = read.delim("./Individual data files/Sub22.txt", header = T, stringsAsFactors=F)
Sub23 = read.delim("./Individual data files/Sub23.txt", header = T, stringsAsFactors=F)
Sub24 = read.delim("./Individual data files/Sub24.txt", header = T, stringsAsFactors=F)
Sub25 = read.delim("./Individual data files/Sub25.txt", header = T, stringsAsFactors=F)
Sub26 = read.delim("./Individual data files/Sub26.txt", header = T, stringsAsFactors=F)
Sub27 = read.delim("./Individual data files/Sub27.txt", header = T, stringsAsFactors=F)

#concatenate all individual data files
merged = rbind(Sub1, Sub2, Sub3, Sub4, Sub5, Sub6, Sub7, Sub8, Sub9, Sub10, Sub11, Sub12, 
               Sub13, Sub14, Sub15, Sub16, Sub17, Sub18, Sub19, Sub20, Sub21, Sub22, Sub23, 
               Sub24, Sub25, Sub26, Sub27)

#add subject numbers since they weren't in the original files
merged$Subnum = NA
for (k in 1:27)
  for (i in 1:320)
    merged$Subnum[(k-1)*320+i] = k

#to do the same thing as a loop (combines 3 steps into one). Also adds the subject numbers as you do it
dat = data.frame(NULL) # make empty container
for (i in 1:27) {
  fileName = paste("./Individual data files/Sub", i, ".txt", sep="") # make filename
  temp = read.delim(file=fileName, stringsAsFactors=F) # read data with filename
  temp$ID = i # mark data with subject number
  dat = rbind(dat, temp) # staple it to previous
}



#Change fixations points for Block 2 so they correctly match face picture
forehead_range = c(1:8)
eyes_range = c(9:16)
nose_range = c(17:24)

require(stringr)

#splits FaceFilename column at underscore, only returns first part
#essentially takes away "_neu.jpg" extension
split1 = str_split_fixed(merged$FaceFilename, "_", 2)[,1]

#isolates number in filename for Black and White faces separately
Blacknum = str_split_fixed(split1, "k", 2)[,2]
Whitenum = str_split_fixed(split1, "e", 2)[,2]
#combines two vectors into two column matrix
combine = cbind(Blacknum, Whitenum)
#coerces matrix into data frame
combine = as.data.frame(combine)
#tells you what class each column is- shows that both columns are factors
sapply(combine, class)
#coerces factors into numbers
combine$Blacknum = as.numeric(as.character(combine$Blacknum))
combine$Whitenum = as.numeric(as.character(combine$Whitenum))


#determine which fixation point it is based on number in filename
combine$fixation = NA

#runs loop determining fixation point for black faces
for (i in 1:length(rownames(combine)))
  if (combine$Blacknum[i] <= 8 & !is.na(combine$Blacknum[i]))  {
      combine$fixation[i] = "forehead"
  } else if (combine$Blacknum[i] > 8 & combine$Blacknum[i] <= 16 & !is.na(combine$Blacknum[i]))  {
      combine$fixation[i] = "eyes" 
  } else if (combine$Blacknum[i] > 16 & combine$Blacknum[i] <= 24 & !is.na(combine$Blacknum[i])) {
      combine$fixation[i] = "nose"
  }
#runs loop again, this time for white faces
for (i in 1:length(rownames(combine)))
  if (combine$Whitenum[i] <= 8 & !is.na(combine$Whitenum[i]))  {
    combine$fixation[i] = "forehead"
  } else if (combine$Whitenum[i] > 8 & combine$Whitenum[i] <= 16 & !is.na(combine$Whitenum[i]))  {
    combine$fixation[i] = "eyes" 
  } else if (combine$Whitenum[i] > 16 & combine$Whitenum[i] <= 24 & !is.na(combine$Whitenum[i])) {
    combine$fixation[i] = "nose"
  }

#replaces the fixation column in merged file with the correct values from combine, just for block 2
Block2rows = as.numeric(rownames(merged[merged$Block == 2,])) #saves row names as numbers (coerced from characters)
merged$Fix[merged$Block == 2] = combine$fixation[Block2rows]

merged$newCond = NA

#Change condition according to fixation in Block 2

#long ugly loop taking info from Race, Fix and WordValence to determine condition, puts in new column
#First digit: 1 = black, 0 = white
#Second digit: 1 = forehead, 2 = eyes, 3 = nose
#Third digit: 1 = negative, 2 = positive
for (i in 1:length(rownames(merged)))
  if (merged$Race[Block2rows][i] == 1 & merged$Fix[Block2rows][i] == "forehead" & merged$WordValence[Block2rows][i] == 1) {
    merged$newCond[Block2rows][i] = 111
  } else if (merged$Race[Block2rows][i] == 1 & merged$Fix[Block2rows][i] == "forehead" & merged$WordValence[Block2rows][i] == 2) {
    merged$newCond[Block2rows][i] = 112
  } else if (merged$Race[Block2rows][i] == 1 & merged$Fix[Block2rows][i] == "eyes" & merged$WordValence[Block2rows][i] == 1) {
    merged$newCond[Block2rows][i] = 121
  } else if (merged$Race[Block2rows][i] == 1 & merged$Fix[Block2rows][i] == "eyes" & merged$WordValence[Block2rows][i] == 2) {
    merged$newCond[Block2rows][i] = 122
  } else if (merged$Race[Block2rows][i] == 1 & merged$Fix[Block2rows][i] == "nose" & merged$WordValence[Block2rows][i] == 1) {
    merged$newCond[Block2rows][i] = 131
  } else if (merged$Race[Block2rows][i] == 1 & merged$Fix[Block2rows][i] == "nose" & merged$WordValence[Block2rows][i] == 2) {
    merged$newCond[Block2rows][i] = 132
    
  } else if (merged$Race[Block2rows][i] == 2 & merged$Fix[Block2rows][i] == "forehead" & merged$WordValence[Block2rows][i] == 1) {
    merged$newCond[Block2rows][i] = 211
  } else if (merged$Race[Block2rows][i] == 2 & merged$Fix[Block2rows][i] == "forehead" & merged$WordValence[Block2rows][i] == 2) {
    merged$newCond[Block2rows][i] = 212
  } else if (merged$Race[Block2rows][i] == 2 & merged$Fix[Block2rows][i] == "eyes" & merged$WordValence[Block2rows][i] == 1) {
    merged$newCond[Block2rows][i] = 221
  } else if (merged$Race[Block2rows][i] == 2 & merged$Fix[Block2rows][i] == "eyes" & merged$WordValence[Block2rows][i] == 2) {
    merged$newCond[Block2rows][i] = 222
  } else if (merged$Race[Block2rows][i] == 2 & merged$Fix[Block2rows][i] == "nose" & merged$WordValence[Block2rows][i] == 1) {
    merged$newCond[Block2rows][i] = 231
  } else if (merged$Race[Block2rows][i] == 2 & merged$Fix[Block2rows][i] == "nose" & merged$WordValence[Block2rows][i] == 2) {
    merged$newCond[Block2rows][i] = 232
  }

#takes condition from new column and puts into existing condition column
merged$Condition[Block2rows] = merged$newCond[Block2rows]      

#write data set only with previous columns (not new condition column)
write.table(subset(merged, select = -c(newCond)), file="CleanedPilotData.txt", sep="\t",row.names= FALSE)


