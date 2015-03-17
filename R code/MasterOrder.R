# Steps of processing and analysis of behavioral pilot data collected in Fall 2014

## 1st wave ##

>>>PilotCleaning.R
#1. Put all individual data files into master file
#2. Added subject number
#3. Corrected fixation labels for Block 2
#4. Corrected condition according to fixation labels for Block 2
#5. Outputs data as 
> CleanedPilotData.txt
#Note: can find cleaner and revised way to do this in PilotCleaning2.R or data_aggregator.R as written by Joe


>>>Block2file.R
#1. Reads in CleanedPilotData.txt
#2. Creates data.frame of just Block 2 data
#3. Adds column for congruence
#4. Outputs data as
> Block2dat.txt


>>>MakeWideFiles.R
#1. Reads in Block2dat.txt
#2. Creates wide version: Subject x Fix x Congruence => mean RT
#3. Outputs data as
> meanRT_allTrials_fixBYcon.txt
#4. Creates wide version, just for Black trials: Subject x Fix x Valence => mean RT
#5. Outputs data as
> meanRT_BlackTrials_fixBYval.txt
#6. Same thing for White trials
#7. Outputs data as
> meanRT_WhiteTrials_fixBYval.txt
#8. Files used for ANOVAs in SAS. SAS output is in
> Output > SAS stats.docx
#Results: nothing significant


>>>meanRTfigures.R
#1. Reads in Block2dat.txt
#2. Creates Figures 1-5 (bargraphs), plus 4b and 5b


>>>Block3file.R
#1. Reads in CleanedPilotData.txt
#2. Creates data frame of just Block 3 data
#3. Counts number of error trials in each condition (Race x Fix)
#4. Creates two bar plots (Fig. 6 & 7)



## 2nd wave ##

>>>Block2ANOVA.R
#1. Reads in Block2dat.txt
#2. Creates wide file for 3 way omnibus ANOVA (Fix x Race x Congruence separated by subject)
#3. Does 3 way ANOVA. Ouput in 
> Output > ANOVA_Block2.docx
#Results: Main effect of Race
#4. Creates column for log transform of RT
#5. Creates wide file for same ANOVA, using logRT as dependent
#6. Does 3 way ANOVA. Ouput in 
> Output > ANOVA_Block2.docx
#Results: Main effect of Fix, main effect of Race


>>>Block3ANOVA.R
#1. Reads in Block3dat.txt
#2. Creates wide file for 2 way omnibus ANOVA (Fix x Race separated by subject)
#3. Does 2 way ANOVA. Ouput in 
> Output > ANOVA_Block3.docx
#Results: Main effect of Fix, interaction of Fix x Race
#4. Does 1 way ANOVA (Fix) within each level of Race. No significant effects found.
#5. Creates Figure 6b
