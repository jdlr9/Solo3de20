# Solo 3 de 20: Evaluating Fare Evasion Intervention in Bogotá's TransMilenio

The project creates a pre- and post-treatment design to evaluate the impact of the **"Solo 3 de 20"** informational campaign. The campaign aims to reduce fare evasion in Bogotá's TransMilenio public transportation system by educating passengers about the prevalence of evasion rates.

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Project Structure](#project-structure)
5. [Dependencies](#dependencies)
6. [Contact](#contact)

## Overview

- **Goal**: Evaluate the impact of an educational campaign on reducing fare evasion at selected TransMilenio stations.
- **Baseline Fare Evasion Rates**:
    - Treatment Stations (Troncal 26): **14.58%**
    - Control Stations (Troncal 80): **13.04%**
- **Expected Treatment Effect**: A 2% reduction in fare evasion at treatment stations.
- **Methodology**: Pre-test and post-test design comparing treatment and control stations.

## Installation

Follow these steps to run the project on your machine:

### Clone the Repository

```bash
git clone https://github.com/yourusername/Solo3de20.git
cd Solo3de20
```

### Install Required R Packages

Ensure the required R libraries are installed:

```R
install.packages(c("DeclareDesign", "estimatr", "fabricatr"))
```

## Usage

Run the following steps to execute the analysis:

1. Open R or RStudio.
2. Load the main analysis script:
   ```R
   source("fare_evasion_experiment.R")
   ```
3. Inspect results in the console, including simulated data and diagnostic outcomes.

### Output Example

The script outputs simulated fare evasion data before and after the intervention and calculates:

- **Change Score**: Difference in fare evasion rates (Post-test - Pre-test).
- **Post-Test Only**: Treatment effect measured using post-treatment rates.

## Project Structure

The project directory is organized as follows:

```
Solo3de20/
├── data/                    # Placeholder for input datasets (if needed)
├── results/                 # Placeholder for generated results
├── fare_evasion_experiment.R # Main R script for running the analysis
├── README.md                # Project documentation (this file)
└── LICENSE                  # License information
```

## Dependencies

The project requires the following R packages:
- **DeclareDesign**: For defining the experimental design.
- **estimatr**: For robust linear regression.
- **fabricatr**: For creating and manipulating data.

## Contact

For questions or feedback, please contact:
- **Author**: Your Name
- **Email**: youremail@example.com
- **GitHub**: [Your GitHub Profile](https://github.com/yourusername)

Thank you for exploring the impact of "Solo 3 de 20"!
