# microbiome-gene-disease-integration_pipeline_1
Integration of microbiome species with gene and disease associations using Kraken2, GutMGene, and DisGeNET data to construct interactive biological networks in R

Perfect — here’s a **long GitHub repo description** that explains your project **step by step**, including the tools, data sources, and workflow.

---

### 📘 **Long Description for GitHub Repository**

> This repository contains an R-based pipeline for integrating microbiome data with gene and disease associations to build a comprehensive **microbe–gene–disease network**. The workflow involves preprocessing microbiome taxonomic profiles from **Kraken2**, mapping microbes to genes using the **GutMGene** database, and linking genes to diseases using **DisGeNET**. The final result is an interactive, visualizable network that reveals potential biological relationships across multiple omics layers.

---

### 🔄 **Workflow Overview**

#### **1. Microbiome Data Preprocessing**
- Load the Kraken2 report file containing taxonomic classification results.
- Filter and extract **species-level taxa** with their relative abundances.
- Save the cleaned microbiome data for further mapping.

#### **2. Microbe–Gene Integration (GutMGene)**
- Download microbe–gene association data from [GutMGene](http://bio-computing.hrbmu.edu.cn/gutmgene/#/home).
- Clean taxon names from Kraken2 (remove brackets, numbers, etc.).
- Match and map microbes from Kraken2 to associated genes in GutMGene.
- Save the **microbe → gene** mapping.

#### **3. Gene–Disease Integration (DisGeNET)**
- Download gene–disease association files from [DisGeNET](https://disgenet.com/).
- Clean and extract gene symbols.
- Match gene symbols from GutMGene to those in DisGeNET.
- Integrate disease associations and save the **gene → disease** mapping.

#### **4. Full Data Integration**
- Merge all three levels: **microbe → gene → disease**.
- Create a combined table showing relationships between microbiome species, gene IDs, and associated diseases with evidence scores.

#### **5. Network Visualization**
- Build the integrated network using `igraph` (static) and `visNetwork` (interactive).
- Nodes are colored by type (microbe, gene, disease).
- Edges are colored and weighted by association strength (DisGeNET score).
- Export the network to interactive **HTML files** for easy exploration and sharing.

---

### 📦 **Tools & Technologies**
- **Language:** R
- **Visualization:** `igraph`, `visNetwork`, `htmlwidgets`
- **Data Sources:**
  - [GutMGene](http://bio-computing.hrbmu.edu.cn/gutmgene/#/home) – microbe ↔ gene
  - [DisGeNET](https://disgenet.com/) – gene ↔ disease
  - **Kraken2** – taxonomic classification of microbiome data
