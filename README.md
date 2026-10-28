# Open-Source R Workflows for Modern Geospatial and Accessibility Analysis

Repository accompanying my presentation at FOSS4G North America 2026.

## Overview

This repository demonstrates a reproducible workflow for GIS using various R packages. This workflow applies the R packages to accessibility analysis using:

- U.S. Census data

- OpenStreetMap data

- sf

- r5r

The workflow includes:

1.  Data acquisition and collection

2.  Data preparation and spatial processing

3.  Transportation network construction

4.  Travel time matrix generation

5.  Accessibility calculations

6.  Accessibility visualization and mapping

## Repository Structure

```         
Packages/ ├── Data Acquisition/ │   ├── Census Data/ │ ├── tidycensus.r | ├── ... │ ├──  Geoprocessing/ │   ├── sf.R │   ├── ... │ ├── Routing/ │   ├── r5r.R │ ├── Spatial Statistics/ │   ├── spdep.R │├── Visualization/ │   ├── mapview.R │   ├── ... │ run_all.qmd README.md 
```

Scripts are organized by package and workflow component. The project is designed to be executed through `run_all.qmd`, which sources the required scripts in the correct order.

## Quick Start

1.  Clone or download this repository.

2.  Open the project in RStudio.

3.  Review the setup requirements below.

4.  Run:

```         
run_all.qmd 
```

The Quarto document serves as the primary entry point for the workflow.

## Setup Requirements

### Required Packages

Package installation instructions are included in `run_all.qmd`.

Commonly used packages include:

```         
r5r sf tidycensus dplyr mapview
```
### Java Required

The routing portion of this workflow uses `r5r`, which requires Java.

Verify that Java is installed by running:

```r
system("java -version")
```

Java 11 or higher is required.

If Java is not installed, one option is:

```r
install.packages("rJavaEnv")
rJavaEnv::java_quick_install(version = 21)
```

After installation, restart R before running the workflow.

### Census API Key Required

Portions of this workflow use Census data accessed through the `tidycensus` package.

Before running the workflow, obtain a Census API key:

<https://api.census.gov/data/key_signup.html>

Install your key using:

```         
tidycensus::census_api_key("YOUR_KEY_HERE", install = TRUE) 
```

Restart R after installation.

Without a valid Census API key, portions of the workflow will not execute successfully.

## Data Sources

The workflow utilizes:

- TIGER/Line shapefiles

- OpenStreetMap street network data

- U.S. Census Bureau data

- CMS hospital data

Detailed acquisition instructions, download links, and source information are provided in:

```         
docs/data_sources.md
```

## Example Outputs

The repository includes example accessibility outputs, maps, and visualizations generated through the workflow.

Included output files may include:

``` text
data/
├── ttm.rds
├── itins_subset.rds
├── iso.rds
├── access.rds
└── ...
```

These files allow users to explore accessibility outputs directly without rerunning the full analysis workflow.

Large routing caches and other intermediate files are intentionally excluded to keep the repository lightweight and reproducible.

## Reproducibility

Users can reproduce the analysis by:

1.  Obtaining the required datasets described in `docs/data_sources.md`

2.  Configuring a Census API key

3.  Running `run_all.qmd`

Some computationally intensive steps have been commented out and replaced with previously generated outputs included in the repository.

Users wishing to fully reproduce the workflow from raw data can uncomment these sections and rerun the analysis.

Examples include network construction and other time-intensive processing steps.

## Author

Ari Tilles

M.S. Student in Geographic Information Science

Graduate Student Researcher

Department of Geography & Environmental Studies\
California State University, Northridge
