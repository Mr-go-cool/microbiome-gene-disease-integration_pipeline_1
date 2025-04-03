#Part 5: Save Interactive Network as HTML (with & without edge labels)

# Load required libraries
library(htmlwidgets)

# Reuse `nodes` and `edges` from previous part

# === Save with edge labels ===
network_with_labels <- visNetwork(nodes, edges) %>%
  visNodes(color = list(background = node_colors[nodes$group])) %>%
  visEdges(smooth = TRUE) %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visInteraction(navigationButtons = TRUE) %>%
  visLayout(randomSeed = 123)

saveWidget(network_with_labels,
           file = "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/microbe_gene_disease_network.html")

# === Save without edge labels ===
edges_no_label <- edges
edges_no_label$label <- NULL

network_no_labels <- visNetwork(nodes, edges_no_label) %>%
  visNodes(color = list(background = node_colors[nodes$group])) %>%
  visEdges(smooth = TRUE) %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
  visInteraction(navigationButtons = TRUE) %>%
  visLayout(randomSeed = 123)

saveWidget(network_no_labels,
           file = "C:/Users/Nama Gokul/Downloads/microbiome_pro/try3/microbe_gene_disease_network_no_labels.html")
