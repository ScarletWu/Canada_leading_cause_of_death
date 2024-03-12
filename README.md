## Overview
This repo is a in depth analysis of  leading cause of death in Canada from 2000 to 2022. We employ Poisson and negative binomial models to explore the distribution and dynamics of mortality causes. The analysis could be used to inform better health policy decisions and interventions.


## LLM Usage
LLM's like ChatGPT have been used for code explanation, error explanations and fixes. The chat can be found in LLM/llm.txt.

## File Structure
The repo is structured as:

-   `input/data` contains the data sources used in analysis including the raw data.
-   `outputs/data` contains the cleaned dataset that was constructed.
-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.