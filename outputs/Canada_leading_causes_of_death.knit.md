---
title: "Canada_leading_causes_of_death"
author: "Scarlet Ruoxian Wu"
format: pdf
date: "March 12, 2024"
date-format: long
toc: true
number-sections: true
bibliography: references.bib
thanks: "Code and data are available at: https://github.com/ScarletWu/Canada_leading_cause_of_death.git"
abstract: "This study analyzed the main causes of death in Canada between 2000 and 2022 using advanced statistical models to uncover patterns in mortality data. The research used Poisson and negative binomial regressions to identify significant trends and variances in death causes, with a focus on the over-dispersion of such data. The findings reveal a  landscape of mortality and highlight the predominance of certain diseases over time and their fluctuating incidence rates. By enhancing our understanding of mortality dynamics, this analysis offers valuable insights for public health policy and prevention strategies that aim to mitigate the most common causes of death and improve overall life expectancy in Canada."
---




# Introduction

Mortality involves the complex interplay between lifestyle, environment, healthcare access, and genetic predisposition. Every year, mortality statistics shed light on a nation's health and the effectiveness of its healthcare system. The Canadian government has kept records of causes of death from 2000 to 2022. This study aims to examine the leading causes of death during this period, identify patterns, highlight healthcare challenges, and suggest potential improvements in public health policy. The primary estimate of this study is the annual number of deaths attributed to various causes.

This analysis aims to understand the complexity of mortality data and the variability in death counts. The study employs the simulation of datasets using the negative binomial distribution. This particular distribution is well-suited to model count data, especially in cases where the data exhibit over-dispersion. By simulating datasets, this study aims to gain insights into the potential distributions of deaths by cause and year, allowing for a deeper understanding of the trends and variability in the actual data.

This study employs both Poisson and negative binomial regression models to analyze the Candian death data. The reason to use both models is to accommodate the variable nature of mortality counts. While Poisson regression is a conventional choice for count data, it assumes equality between the mean and variance of the data, which is often not the case in mortality statistics due to over-dispersion. In contrast, the negative binomial model provides greater flexibility by accommodating over-dispersion, making it a more realistic tool for analyzing the complex nature of mortality data.

The critical comparison between Poisson and negative binomial models in this analysis is not merely a statistical preference but a methodological necessity. It underscores the importance of selecting a model that accurately reflects the data's underlying distribution, ensuring the reliability and validity of the findings. This comparison is instrumental in identifying the model that best captures the nuances of mortality data, thereby providing a solid foundation for concluding the leading causes of death in Canada and the potential implications for public health policies and initiatives.

In summary, this paper comprehensively analyzes mortality data from Canada by using Poisson and negative binomial models to capture the nuances of death-related statistics. The primary estimand —the annual number of deaths by various causes—sets the stage for a detailed exploration of mortality patterns within Canada. Besides quantifying the burden of mortality, this study reveals underlying trends that can inform future health policies and interventions to reduce preventable deaths and improve Canadians' health and well-being.

# Data

This analysis examines mortality data in Canada from 2000 to 2022 obtained from the comprehensive database maintained by Statistics Canada. The data includes the annual number of deaths categorized by different causes, offering a detailed view of mortality trends in the country. The primary variables of interest are the year of death, the cause of death according to the ICD-10 classification, and the total number of deaths attributed to each cause. These variables provide an overview of how mortality patterns have changed over the past two decades, reflecting the impact of healthcare advancements, public health initiatives, and emerging challenges.

To prepare the dataset for analysis, we made significant efforts to ensure that the data was clean and appropriately structured. This included truncating the cause of death descriptions for readability and consistency, which helped ensure that our analyses were accurate and easy to interpret. We chose the Canadian dataset specifically due to its comprehensive coverage and the high quality of data reporting standards maintained by Statistics Canada. This allowed us to gain a nuanced understanding of mortality within the Canadian context, which may differ from individual provincial trends due to various socio-economic, environmental, and healthcare factors.

To explore and visualize the data, we used a suite of R (@r) packages, each chosen for its specific capabilities. The dplyr (@rDplyr) package facilitated efficient data manipulation, while ggplot2 (@rGgplot2) helped us visualize trends and patterns in mortality. We used Poisson and negative binomial regression techniques to model the data, and rstanarm (@rRstanarm) was chosen for its advanced Bayesian modeling capabilities. The modelsummary (@rModelsummary) package efficiently summarized the results, providing clear and concise insights into the findings. We also utilized the broom (@rBroom) and broom.mixed (@rBroomMixed) packages to tidy the outputs of our statistical models, making the results more accessible and interpretable.

By systematically examining the variables within the dataset and using rigorous statistical modeling, this analysis provides a deeper understanding of mortality trends in Canada, underscoring the critical role of data-driven approaches in public health planning and evaluation.

# Result
The analysis comprises various elements that are meticulously designed to provide a comprehensive insight into the mortality trends prevailing in Canada. It involves statistical models to analyze these trends and evaluate the model performance. 

The analysis begins with the creation of a simulated death dataset that replicates the structure of real-world data, where causes of death over the years 2000 to 2022 are distributed according to a negative binomial distribution. @fig-0 shows the simulated distributions of death for each cause. 

::: {#fig-0 .cell layout-ncol="3"}
::: {.cell-output-display}
![Malignant Neoplasms](Canada_leading_causes_of_death_files/figure-pdf/fig-0-1.pdf){#fig-0-1}
:::

::: {.cell-output-display}
![Cardiovascular Diseases](Canada_leading_causes_of_death_files/figure-pdf/fig-0-2.pdf){#fig-0-2}
:::

::: {.cell-output-display}
![Ischaemic Heart Diseases](Canada_leading_causes_of_death_files/figure-pdf/fig-0-3.pdf){#fig-0-3}
:::

Negative binomial death simulation for each cause of death
:::




@tbl-1 ranks the ten leading causes of death in Canada for the year 2022. It lists the specific causes, the number of deaths attributed to each cause, and the rank based on the number of deaths. This snapshot is crucial for understanding the most pressing health threats faced by Canadians in the latest year of the study.




::: {#tbl-1 .cell tbl-cap='Top-ten causes of death in Canada in 2022'}
::: {.cell-output-display}


|Year |                          Cause| Deaths| Rank| Years|
|:----|------------------------------:|------:|----:|-----:|
|2022 |  Malignant neoplasms [C00-C97]|  82412|    1|    23|
|2022 | Major cardiovascular diseas...|  76639|    2|    23|
|2022 | Diseases of heart [I00-I09,...|  57357|    3|    23|
|2022 | Ischaemic heart diseases [I...|  34830|    4|    23|
|2022 |      Dementia [F010-F019, F03]|  25994|    5|     6|
|2022 |     Unspecified dementia [F03]|  23896|    6|     6|
|2022 | Other forms of chronic isch...|  20126|    7|    23|
|2022 | COVID-19 [U07.1, U07.2, U10.9]|  19716|    8|     3|
|2022 | Malignant neoplasms of trac...|  19151|    9|    23|
|2022 | Other heart diseases [I26-I51]|  18913|   10|    23|


:::
:::


@fig-1 shows a series of line graphs, each representing a different cause of death in Canada, such as heart disease, cancer, and dementia. Each line displays the change in the number of deaths from 2000 to 2022, enabling viewers to track how each cause of death has fluctuated over time. One noticeable line represents COVID-19, indicating its emergence and impact in recent years.



::: {.cell}
::: {.cell-output-display}
![](Canada_leading_causes_of_death_files/figure-pdf/fig-1-1.pdf){#fig-1}
:::
:::

@tbl-2 provides a broad overview of the number of deaths from the top causes over the years. It includes the minimum, maximum, and average number of deaths, standard deviation, variance, and the total count of data points (N). These statistics offer a foundational understanding of the distribution and variability of mortality data.


::: {#tbl-2 .cell tbl-cap='Summary statistics of the number of yearly deaths, by cause, in Canada'}
::: {.cell-output-display}
\begin{table}
\centering
\begin{tabular}[t]{lrrrrrr}
\toprule
  & Min & Mean & Max & SD & Var & N\\
\midrule
value & \num{14466} & \num{42831} & \num{82822} & \num{22480} & \num{505344387} & 153\\
\bottomrule
\end{tabular}
\end{table}


:::
:::



The analysis uses two statistical methods to study the causes of death. The Poisson model was first applied. However, this model can sometimes be limited due to its assumption of equal mean and variance. To address this limitation and consider over-dispersion in the data, the negative binomial model was also used. This model allows for greater variance than the mean, providing a more detailed understanding of the mortality data. These models were useful in clarifying the relationship between various causes of death and their frequencies over time.







The model summary compares the coefficient estimates from both Poisson and negative binomial models for the leading causes of death. The estimates measure the impact each cause has on mortality rates. A higher value suggests a greater influence on increasing death rates. This table is crucial in discerning the relative importance of each cause in the context of mortality (@tbl-3).


::: {#tbl-3 .cell tbl-cap='Modeling the most prevalent cause of deaths in Canada, 2001-2020'}
::: {.cell-output-display}
\begin{table}
\centering
\begin{tabular}[t]{lcc}
\toprule
  & Poisson & Negative Binomial\\
\midrule
Malignant Neoplasms & \num{1.479} & \num{1.472}\\
 &  & \vphantom{1} (\num{0.082})\\
Diseases of Heart & \num{1.137} & \num{1.129}\\
 &  & \vphantom{1} (\num{0.083})\\
Respiratory Malignant Neoplasms & \num{0.123} & \num{0.116}\\
 &  & (\num{0.082})\\
Major Cardiovascular Diseases & \num{1.450} & \num{1.443}\\
 &  & (\num{0.085})\\
Ischaemic Heart Diseases & \num{0.770} & \num{0.761}\\
 &  & (\num{0.083})\\
Unspecified Dementia & \num{0.259} & \num{0.253}\\
 &  & (\num{0.096})\\
\midrule
Num.Obs. & \num{153} & \num{153}\\
Log.Lik. & \num{-14947.833} & \num{-1463.624}\\
ELPD & \num{-15593.5} & \num{-1468.3}\\
ELPD s.e. & \num{1752.0} & \num{7.1}\\
LOOIC & \num{31186.9} & \num{2936.6}\\
LOOIC s.e. & \num{3504.0} & \num{14.3}\\
WAIC & \num{31838.1} & \num{2936.3}\\
RMSE & \num{3153.30} & \num{3153.84}\\
\bottomrule
\end{tabular}
\end{table}


:::
:::


@fig-2 demonstrates how well the Poisson and negative binomial models fit the actual data. The dark line represents the observed data, while the lighter lines or bands show the range of outcomes predicted by the models. A close match between the two indicates a good fit, meaning the model's predictions closely align with the real-world data.


::: {#fig-2 .cell layout-ncol="2"}
::: {.cell-output-display}
![Poisson model](Canada_leading_causes_of_death_files/figure-pdf/fig-2-1.pdf){#fig-2-1}
:::

::: {.cell-output-display}
![Negative binomial model](Canada_leading_causes_of_death_files/figure-pdf/fig-2-2.pdf){#fig-2-2}
:::

Comparing posterior prediction checks for Poisson and negative binomial models
:::



