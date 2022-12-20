# Purpose

Assist business to classify good and bad applicants for a loan.

# Dependencies

-   R kernel
-   R packages:
    -   install.packages("tidyverse")

    -   install.packages("dplyr")

    -   install.packages("h2o")

# Directory structure

-   1-data

-   2-report

-   3-R

-   4-model

-   5-predictions

-   app

# How to execute code

1.  Download data from: <https://github.com/Giemoc/KTU-DVDA-PROJECT>

2.  Run data preparation script: data_Transformation.R

3.  Run modelling script: modelling.R

# Results

Current model has the ability to classify good/bad applicants with AUC for new data of approx. 0.83.
