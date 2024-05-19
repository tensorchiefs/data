# Challenger Dataset

# Rendered from challenger.qmd

[Link to original
file](https://github.com/tensorchiefs/data/tree/docs/data/challenger.qmd)

## Description

This dataset contains information about the O-rings of the solid rocket
boosters used in the Space Shuttle program. The data was collected
during the investigation of the Space Shuttle Challenger disaster in
1986 (Rogers commission). Here we provide a binarized version of the
original dataset, where the dependent variable `y` indicates whether at
least O-ring failed (1) or not (0). This data is often used as an
example of logistic regression.

### Further Information

A nice background story about the Challenger disaster and the fatal data
analysis done can be found in:
https://homafiles.info/2016/06/06/the-challenger-disaster-a-tragic-lesson-in-data-analysis/

![](challenger_files/figure-commonmark/plot-1.png)

### Addtional Functionality

``` r
library(ggplot2)
ggplot(data, aes(x = Temp, y = Failure)) +
  geom_point() + 
  xlab("Temperature (F)") +
  ggtitle("Challenger O-Ring Data")
```
