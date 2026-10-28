# Data Sources

This document describes the data sources used in the accessibility workflow and provides instructions for obtaining the required datasets.

## OpenStreetMap Street Network

Street network data were obtained from OpenStreetMap.

The network used in this analysis can be downloaded using the following bounding box for Sacramento County and the surrounding areas:

<https://shorturl.at/QsQh2>

Place the downloaded network file in:

``` text
Data/
```

## Census Data

Census data are accessed through the `tidycensus` package.

A Census API key is required.

A Census API key can be obtained here:

<https://api.census.gov/data/key_signup.html>

Install your key using:

```         
tidycensus::census_api_key("YOUR_KEY_HERE", install = TRUE) 
```

Restart R after installation.

Without a valid Census API key, portions of the workflow will not execute successfully.

## CMS Hospital Data

Hospital locations were obtained from U.S Centers for Medicare & Medicaid Services (CMS) Provider Data.

The hospital dataset included in this repository is located in:

``` text
Data/
```

## Notes on Runtime

Several workflows involve computationally intensive processing steps, including transportation network construction and travel time calculations.

Pre-generated outputs are included where appropriate to allow users to explore the workflow without waiting for full recomputation. Commented sections in the code can be uncommented to regenerate results from source data.

## Included Data

Several RDS files are included to help users explore the workflow without regenerating all outputs. If users wish to generate the outputs themselves, uncomment and run the respective lines of code.

| File             | Description                                            |
|------------------|--------------------------------------------------------|
| ttm.rds          | Example travel time matrix output                      |
| itins_subset.rds | Example detailed itineraries output, includes geometry |
| iso.rds          | Example isochrone function output, includes geometry   |
| access.rds       | Accessibility table output                             |

RDS files can be loaded using:

``` r
object <- readRDS("data/example_accessibility_results.rds")
```

These files are provided for convenience and reproducibility.

## Data Licensing

Data sources used in this project may be subject to their own licenses, terms of service, and attribution requirements.

Users should consult the original data providers for details.
