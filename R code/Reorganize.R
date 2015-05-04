require(plyr)
require(dplyr)

# read in full data

dat = read.delim("Block2dat.txt", stringsAsFactors=F)
dat = rename(dat, c("Race" = "FaceRace", "Subnum" = "Subno"))

# Change FaceRace to words instead of numbers
for (i in 1:length(row.names(dat))) {
  if (dat$FaceRace[i] == 1) {
    dat$FaceRace[i] = "Black"
  } else if (dat$FaceRace[i] == 2) {
    dat$FaceRace[i] = "White"
  }
}

# Change WordValence to words instead of numbers
for (i in 1:length(row.names(dat))) {
  if (dat$WordValence[i] == 1) {
    dat$WordValence[i] = "Neg"
  } else if (dat$WordValence[i] == 2) {
    dat$WordValence[i] = "Pos"
  }
}

# Change Congruent to words instead of numbers
for (i in 1:length(row.names(dat))) {
  if (dat$Congruent[i] == 1) {
    dat$Congruent[i] = "Con"
  } else if (dat$Congruent[i] == 2) {
    dat$Congruent[i] = "Incon"
  }
}


dat = select(dat, -Familiar)

# Still need to add ParRace and ParGender

write.table(dat, file = "Block2Reorganized.txt", sep = "\t", row.names=F)


