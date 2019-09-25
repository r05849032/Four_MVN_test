# Proportion of Rrejection under Four Multivariate Normality Tests

[![MVN_Package_Badge](https://img.shields.io/badge/MVN-5.0-brightgreen.svg)](https://www.rdocumentation.org/packages/MVN/versions/5.1)  [![energy_Package_Badge](https://img.shields.io/badge/energy-1.7--2-brightgreen)](https://www.rdocumentation.org/packages/energy/versions/1.7-2) [![Code_Size_Badge](https://img.shields.io/github/languages/code-size/r05849032/NTU_submit.paper.svg)](https://github.com/r05849032/NTU_submit.paper)

## Description
prop.reject calculates the proportion of rejection when testing the multivariate normality distributional assumption based on the Energy, Henze-Zirkler (HZ), Royston, and Mardia test. The Energy test is conducted with the function mvnorm.etest in the R package energy (Székely and Rizzo, 2013). The other three tests are conducted with the function mvn in the R package MVN (Korkmaz et al., 2014). 

## Preinstallation
To use the prop.reject function for testing the normality, the MVN and energy package with specific version should be installed beforehand.

Install older package versions by using `devtools`
```r
library(devtools)
```
Install MVN package from CRAN:
```r
install_version("MVN", version = "5.0", 
    repos = "http://cran.us.r-project.org")
```
Install energy package from CRAN:
```r
install_version("energy", version = "1.7-2", 
    repos = "http://cran.us.r-project.org")
```

## Usage
```r
prop.reject(InputData, gene.no = 4, replicate.no = 100, 
    significance.level = 0.05, random.seed = 20190717) 
```

## Arguments
| Name      | Description |
| :-------- | :---------- |
| `InputData` | The original *I*x*J* data matrix, where *I* is the number of samples and *J* is the number of genes. |
| `gene.no` | The number of genes that will be randomly selected to form a set  for multivariate normality test. The default is 4. |
| `replicate.no` | The number of replications. In each replication, a number of  “gene.no” genes will be randomly selected for the normality test. The default is 100. |
| `significance.level` | The significance level. The default is 0.05. |
| `random.seed` | The seed used when randomly select “gene.no” genes. The default  is 20190717. |


## Value
A list containing the following components:

| Name      | Description |
| :-------- | :---------- |
| `P.value` | A matrix containing p-values. The 4 columns are the p-values under the Energy, HZ, Royston, and Mardia test, respectively. The number of rows is equal to replicate.no. |
| `Proportion.table` | A matrix. The rejection rate of “Mardia test”, “HZ test”, “Royston test” and “Energy test” in the setting replication times. |

## Authors
Chi-Hsuan Ho and Yu-Jyun Huang (National Taiwan University), September 20, 2019.

## References
Korkmaz, S., Goksuluk, D., and Zararsiz, G. (2014) MVN: An R package for assessing multivariate normality. The R Journal, 6, 151-162. 

Székely, G. J. and Rizzo, M. L. (2013) Energy statistics: a class of statistics based on distances. Journal of Statistical Planning and Inference, 143, 1249-1272.

## Examples
```r
# Load the required packages.
library(MVN)
library(energy)

# Load the example data.
load("ExampleData.Rdata")
head(Data[,1:6])
dim(Data)

# Test the normality by using the four multivariate tests.
output = Nonnormal(Data, genenumber = 4, times = 10, sig = 0.05)
output
```

The output is

<img align="left" width="520" height="280" src="https://i.imgur.com/9jO8kbi.png">
