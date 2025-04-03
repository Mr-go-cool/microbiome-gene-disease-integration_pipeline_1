#Part 4: Network Visualization (Static + Interactive)

# Load required libraries
library(igraph)
library(visNetwork)
library(dplyr)

# Load final merged data
network_data <- read.csv("C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/microbe_gene_disease_mapping_cleaned_symbols.csv", stringsAsFactors = FALSE)

### --- Static igraph Plot ---
# Build edge list
edges1 <- network_data[, c("Taxon_name", "Gene_Symbol_Cleaned")]
edges2 <- network_data[, c("Gene_Symbol_Cleaned", "Disease_Name")]
colnames(edges1) <- colnames(edges2) <- c("Source", "Target")

# Combine all edges
edge_list <- rbind(edges1, edges2)

# Create igraph object
graph <- graph_from_data_frame(edge_list, directed = FALSE)

# Plot basic network
plot(graph, vertex.size = 10, vertex.label.cex = 0.7, edge.arrow.size = 0.5,
     main = "Microbiome-Gene-Disease Network")

### --- Interactive visNetwork Plot (with edge labels/colors) ---
# Create edges with labels and scores
edges_microbe_gene <- network_data %>%
  distinct(from = Taxon_name, to = Gene_Symbol_Cleaned, label = "microbe-gene", Score = NA)
edges_gene_disease <- network_data %>%
  distinct(from = Gene_Symbol_Cleaned, to = Disease_Name, label = "gene-disease", Score)

edges <- bind_rows(edges_microbe_gene, edges_gene_disease)

# Edge color and width
edges$color <- ifelse(is.na(edges$Score), "black",
                      ifelse(edges$Score > 0.8, "green",
                             ifelse(edges$Score >= 0.5, "gray", "red")))
edges$width <- ifelse(is.na(edges$Score), 1,
                      ifelse(edges$Score > 0.8, 3,
                             ifelse(edges$Score >= 0.5, 2, 1)))

# Create nodes
nodes <- data.frame(id = unique(c(edges$from, edges$to)), stringsAsFactors = FALSE)
nodes$label <- nodes$id
nodes$group <- ifelse(nodes$id %in% network_data$Taxon_name, "Microbe",
                      ifelse(nodes$id %in% network_data$Gene_Symbol_Cleaned, "Gene", "Disease"))
node_colors <- c("Microbe" = "blue", "Gene" = "green", "Disease" = "red")

# Plot interactive network
visNetwork(nodes, edges) %>%
  visNodes(color = list(background = node_colors[nodes$group])) %>%
  visEdges(arrows = "to") %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visLayout(randomSeed = 42) %>%
  visInteraction(navigationButtons = TRUE, dragNodes = TRUE, dragView = TRUE, zoomView = TRUE)
