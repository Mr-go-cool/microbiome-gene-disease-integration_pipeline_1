#Part 3: Clean & Merge Gene–Disease Data from DisGeNET

# Load required libraries
library(dplyr)
library(stringr)
library(readr)

# Input files
microbe_gene_file <- "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/microbe_gene_mapping_cleaned.csv"
disgenet_file <- "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/DisGeNET_Gene_Disease_Large_Dummy.csv"

# Step 1: Load data
microbe_gene_data <- read.csv(microbe_gene_file, stringsAsFactors = FALSE)
disgenet_data <- read.csv(disgenet_file, stringsAsFactors = FALSE)

# Step 2: Clean and match gene symbols
microbe_gene_data$Gene_Symbol_Cleaned <- toupper(str_replace_all(microbe_gene_data$Gene..ID., "\\s*\\(.*?\\)", ""))
disgenet_data$Gene_Symbol <- toupper(disgenet_data$Gene_Symbol)

# Step 3: Merge on gene symbol
microbe_gene_disease_data <- microbe_gene_data %>%
  inner_join(disgenet_data, by = c("Gene_Symbol_Cleaned" = "Gene_Symbol")) %>%
  select(Taxon_name, Percentage, Gene_Symbol_Cleaned, Disease_ID, Disease_Name, Score)

# Step 4: Save final merged table
write.csv(microbe_gene_disease_data,
          "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/microbe_gene_disease_mapping_cleaned_symbols.csv",
          row.names = FALSE)

# Preview result
head(microbe_gene_disease_data)

