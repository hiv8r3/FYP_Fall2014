# Welcome! To data aggregator!

# Read in the data file
dat <- read.delim("Sub1.txt") 
head(dat)
View(dat)

# Basic data import, label, and concatenate loop
dat1 <- read.delim("Sub1.txt")
dat1$ID = 1 
dat2 <- read.delim("Sub2.txt") 
dat2$ID = 2
dat <- rbind(dat1, dat2)

# Let's not repeat ourselves. 
# Let's make a loop so we don't have to type read.delim("SubX.txt" a billion times)

# With paste() we can make a string that varies with the loop
coolStuff = c("Shades", "Story", "Beans")
paste("Cool", coolStuff)  #adds "Cool" to everything in the array coolStuff
paste("Cool", coolStuff, sep="... ") # can change sep argument to whatever

paste("Sub", 1:27, sep="") # aha! Numerics are coerced to strings so that everything gets pasted
paste("Sub", 1:27, ".txt", sep="")

for (i in 1:27) {
  fileName = paste("Sub", i, ".txt", sep="")
  print(fileName)
}


dat = data.frame(NULL) # make empty container
for (i in 1:27) {
  fileName = paste("Sub", i, ".txt", sep="") # make filename. Paste() combines strings together.
  temp = read.delim(file=fileName, stringsAsFactors=F) # read data with filename
  temp$ID = i # mark data with subject number
  dat = rbind(dat, temp) # staple it to previous
}

# make a column for race of face
# We want to match all columns where FaceFilename contains "Black"
# grep() function lets us search and match strings
row.names(mtcars)
grep("Merc", row.names(mtcars))
grep("Merc", row.names(mtcars), value=T)

# So let's set up a fresh column for race
dat$race = NA
# Where FaceFilename contains "Black", we set dat$race to "black"
dat$race[grep("Black", dat$FaceFilename)] = "Black"
View(dat)
dat$race[grep("White", dat$FaceFilename)] = "White"
View(dat)

# We can do a similar thing to fix the point of fixation
forehead_range = c(1:8)
eyes_range = c(9:16)
nose_range = c(17:24)

dat$fixation = NA # empty container
for (i in forehead_range) {
  dat$fixation[grep(i, dat$FaceFilename)] = "forehead"
} # note that this will still match 1 with 11, 21, but we're gonna fix those later
for (i in eyes_range) {
  dat$fixation[grep(i, dat$FaceFilename)] = "eyes"
}
for (i in nose_range) {
  dat$fixation[grep(i, dat$FaceFilename)] = "nose"
} # not a problem now because it won't match 21 to 1
View(dat)
sub2dat = dat[dat$ID == 2,]
table(sub2dat$fixation, sub2dat$Block)


