###################### 14.10.2020
###################### determining aquatic taxa in the database

rm(list = ls())
library(dplyr)

# a key with information which taxa is aquatic or semi-aquatic is under construction

# I assume the structure will be similar to the key data frame below, 
# column Name contains names of taxa which are confirmed as aquatic
# column Rank represents taxonomic rank of the Name
# for now I picked some to test, but I'm working on a full list, which will contain
# only the lowest ranks which can be determined as fully aquatic

Name <- c("Dermaptera", "Embioptera","Odonata", # I made up some to check if it works 
          "Vespidae", "Carabidae") 

Rank <- c(rep("order",3), rep("family",2))
key<- data.frame(Name, Rank)

#### target dataset

tax<- read.csv("C:/Users/agsen/Dropbox/BGB_INV_SESYNC_DATA/taxonomy_table.csv",
               header = TRUE, sep = ",") ### taxonomic file from SESYNC currently on my dropbox 
set.seed(6)
small <- sample_n(tax, 1000)

#### matching approach

small$try <- ifelse(
  grepl(paste(key$Name, collapse="|"), ## matching all expressions in Name column/key table 
        paste(small$order, small$family)), "aquatic", "not aquatic")# matching multiple (currently 2) columns in the target table

test_1<- filter(small, try == "aquatic")
unique(test_1$order)
unique(test_1$family)

test_2<- filter(small, try != "aquatic")
