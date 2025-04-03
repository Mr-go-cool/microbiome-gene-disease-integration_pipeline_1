#Part 1: Process Kraken2 Report

# Load required libraries
library(dplyr)
library(readr)
library(stringr)

# Input file
kraken_file <- "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/kraken2_report.txt"

# Step 1: Load Kraken2 Report
kraken_data <- read.table(kraken_file, sep="\t", header=FALSE, fill=TRUE, quote="", stringsAsFactors=FALSE)
colnames(kraken_data) <- c("Percentage", "Reads_covered", "Reads_assigned", "Rank", "NCBI_TaxID", "Taxon_name")

# Step 2: Keep Only Species-Level Data
species_data <- kraken_data %>%
  filter(Rank == "S") %>%
  select(Taxon_name, Percentage)

# Step 3: Save Processed Species-Level Microbiome Data
write.csv(species_data, "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/processed_microbiome_data.csv", row.names = FALSE)

# Preview result
head(species_data)
