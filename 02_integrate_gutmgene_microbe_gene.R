#Part 2: Clean and Integrate GutMGene Microbe–Gene Associations

# Load required libraries
library(dplyr)
library(stringr)

# Input files
microbiome_file <- "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/processed_microbiome_data.csv"
gutmgene_file <- "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/GutMGene_Microbe_Disease.csv"

# Step 1: Load data
microbiome_data <- read.csv(microbiome_file, stringsAsFactors = FALSE)
gutmgene_data <- read.csv(gutmgene_file, stringsAsFactors = FALSE)

# Step 2: Clean microbe names
microbiome_data$Taxon_name_Cleaned <- str_trim(str_replace_all(
  microbiome_data$Taxon_name, "\\[|\\]|\\(.*?\\)|\\s+\\w+$", "")
)

gutmgene_data$Gut.Microbe.Cleaned <- str_trim(str_replace_all(
  gutmgene_data$Gut.Microbe..ID., "\\(.*?\\)", "")
)

# Step 3: Join cleaned microbes to genes
microbe_gene_data <- microbiome_data %>%
  inner_join(gutmgene_data, by = c("Taxon_name_Cleaned" = "Gut.Microbe.Cleaned")) %>%
  select(Taxon_name, Percentage, Gene..ID.)

# Step 4: Save mapped data
write.csv(microbe_gene_data, "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/microbe_gene_mapping_cleaned.csv", row.names = FALSE)

# Preview result
head(microbe_gene_data)
