# Proportion of Rrejection under Four Multivariate Normality Tests

[![MVN_Package_Badge](https://img.shields.io/badge/MVN-5.0-brightgreen.svg)](https://www.rdocumentation.org/packages/MVN/versions/5.1)  [![energy_Package_Badge](https://img.shields.io/badge/energy-1.7--2-brightgreen)](https://www.rdocumentation.org/packages/energy/versions/1.7-2) [![R_Version_Badge](https://img.shields.io/badge/R%20-3.4.3-orange)](https://cran.r-project.org/bin/windows/base/old/3.4.3/) [![Code_Size_Badge](https://img.shields.io/github/languages/code-size/r05849032/NTU_submit.paper.svg)](https://github.com/r05849032/NTU_submit.paper)

## Description
`Prop.reject()` calculates the proportion of rejection when testing the multivariate normality distributional assumption based on the Energy, Henze-Zirkler (HZ), Royston, and Mardia test. The Energy test is conducted with the function *mvnorm.etest* in the R package *energy* (Székely and Rizzo, 2013). The other three tests are conducted with the function *mvn* in the R package *MVN* (Korkmaz et al., 2014). 

## Preinstallation
To use `Prop.reject()` for testing the normality, the *MVN* and *energy* package with specific version should be installed beforehand.

Install older package versions by using the *devtools* package.
```r
library(devtools)
```
Install the *MVN* package from CRAN:
```r
install_version("MVN", version = "5.0", 
    repos = "http://cran.us.r-project.org")
```
Install the *energy* package from CRAN:
```r
install_version("energy", version = "1.7-2", 
    repos = "http://cran.us.r-project.org")
```

## Usage
```r
Prop.reject(InputData, gene.no = 4, replicate.no = 100, 
    significance.level = 0.05, random.seed = 20190717) 
```

## Arguments
| Name      | Description |
| :-------- | :---------- |
| `InputData` | The original *I* x *J* data matrix, where *I* is the number of samples and *J* is the number of genes. |
| `gene.no` | The number of genes that will be randomly selected to form a set  for multivariate normality test. The default is 4. |
| `replicate.no` | The number of replications. In each replication, a number of  `gene.no` genes will be randomly selected for the normality test. The default is 100. |
| `significance.level` | The significance level. The default is 0.05. |
| `random.seed` | The seed used when randomly select `gene.no` genes. The default  is 20190717. |


## Value
A list containing the following components:

| Name      | Description |
| :-------- | :---------- |
| `P.value` | A matrix containing p-values. The 4 columns are the p-values under the Energy, HZ, Royston, and Mardia test, respectively. The number of rows is equal to replicate.no. |
| `Proportion.table` | A matrix. The rejection rate of Energy, HZ, Royston and Mardia test in the setting replication times. |

## Authors
Chi-Hsuan Ho and Yu-Jyun Huang (National Taiwan University), September 20, 2019.

## Citation
To cite `Prop.reject()` in publications, use: 

Chi-Hsuan Ho, Yu-Jyun Huang, & Chuhsing Kate Hsiao. (2019) The misuse of normality assumption in gene-set analysis. Submitted.

## References
Korkmaz, S., Goksuluk, D., and Zararsiz, G. (2014) MVN: An R package for assessing multivariate normality. *The R Journal*, 6, 151-162. 

Székely, G. J. and Rizzo, M. L. (2013) Energy statistics: a class of statistics based on distances. *Journal of Statistical Planning and Inference*, 143, 1249-1272.

## Examples
```r
# Load the required packages.
library(MVN)
library(energy)

# Load the example data.
load("ExampleData.RData")
head(Data[,1:6])
##            V1       V2       V3       V4       V5        V6
## [1,] 4.389578 5.325105 7.615827 3.156136 3.084196 10.440905
## [2,] 4.228465 6.024417 8.622200 3.214992 3.022319 10.084841
## [3,] 4.515070 6.088002 6.924315 3.518904 3.284645 11.080127
## [4,] 4.806785 5.827911 7.222731 3.318275 2.988885  8.938788
## [5,] 4.187261 6.037769 7.396842 2.899528 3.144162  9.159416
## [6,] 4.913613 7.503307 7.174726 3.219614 3.095509 10.087335

dim(Data)
## [1]  30 100

# Test the normality by using the four multivariate tests.
output = Prop.reject(Data, gene.no = 4, replicate.no = 10, significance.level = 0.05)
output
## $P.value
##            Energy           HZ      Royston       Mardia
##  [1,] 0.018018018 4.648399e-02 9.586110e-05 3.174030e-03
##  [2,] 0.008008008 1.377571e-01 3.270980e-06 3.698258e-04
##  [3,] 0.316316316 4.730973e-01 5.252593e-03 4.165955e-01
##  [4,] 0.000000000 5.807528e-06 9.588895e-06 1.905740e-03
##  [5,] 0.000000000 1.785811e-03 2.392184e-06 2.066322e-04
##  [6,] 0.000000000 1.760981e-03 1.609500e-05 7.938220e-03
##  [7,] 0.000000000 4.889371e-04 5.591087e-06 1.066556e-03
##  [8,] 0.000000000 5.346123e-07 3.603553e-09 4.198728e-12
##  [9,] 0.000000000 2.382483e-04 6.363017e-09 6.518281e-05
## [10,] 0.045045045 2.583326e-02 6.172577e-06 1.120096e-01
## 
## $Proportion.table
##      Energy  HZ Royston Mardia replicate.no error_times
## [1,]    0.9 0.8       1    0.8           10           0

```
