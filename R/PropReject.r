## Function: prop.reject()
## Prop. reject() calculates the proportion of rejection when testing the multivariate normality distributional assumption based on the Energy, Henze-Zirkler (HZ), Royston, and Mardia test. 
## To use prop.reject() for testing the normality, the MVN and energy package with specific version should be installed beforehand.

#############################
## library(devtools)
## install_version("MVN", version = "5.0", 
##                 repos = "http://cran.us.r-project.org")
## install_version("energy", version = "1.7-2", 
##                 repos = "http://cran.us.r-project.org")
library(MVN)
library(energy)
#############################
## Example data
## The example data is random sampling from GEO "GSE19188" dataset with RMA normalization
## The data cantains 30 rows and 100 columns
## The row variables represents samples
## The column variables represents genes/probes
load("../data/ExampleData.RData")
head(Data[,1:6])
dim(Data)
#############################


  ## Prop.reject function
  Prop.reject = function(InputData, gene.no = 4, replicate.no = 100, significance.level = 0.05, random.seed = 20190717){


  ## return the p(gene.no) > n(sample size) error

  if(gene.no > dim(InputData)[1]){
    stop("\nThe number of genes is greater than the sample size! \nThis will lead to singular matrix problem!\n")
  }


  ## column names of the output "Proportion.table"
  counts = c("countN", "countH", "countR", "countM")


    ## initialize the count number 
    for (i in 1:length(counts)) assign(counts[i], 0)
    

    ## initialize the error time
    error_ct = 0

    P.value <- matrix(0,replicate.no,4)

    ## normality tests
    ## do "replication.no" times
    for(j in 1:replicate.no){

      print(j)
      set.seed(j+random.seed)

      ## randomly seleted "gene.no" genes/probes for normality test

      probe = sample(1:ncol(InputData), gene.no)
      
      possible_error <<- tryCatch({
        resultM <<- mvn(InputData[, probe], mvnTest = "mardia")$multivariateNormality
        resultH <<- mvn(InputData[, probe], mvnTest = "hz")$multivariateNormality
        resultR <<- mvn(InputData[, probe], mvnTest = "royston")$multivariateNormality
        resultN <<- mvnorm.etest(InputData[, probe], R = 999)
      }, warning = function(war){
        return(war)
      }, error = function(err){
        return(err)
      })

      ## singular matrix problem  
      ## return error and count error time  
      if(inherits(possible_error, "error")){
        error_ct = error_ct + 1
        replicate.no = replicate.no - 1
        print("in error")
        next
        print("error check")
      }

      
      if(as.numeric(as.character(resultM$`p value`[which.min(as.numeric(as.character(resultM$`p value`[-3])))])) < significance.level){
        countM = countM + 1
      }
      
      if(resultH$`p value` < significance.level){
        countH = countH + 1
      }

      if(resultR$`p value` < significance.level){
        countR = countR + 1
      }
      
      if(resultN$p.value < significance.level){
        countN = countN + 1
      }

	## save the p-value of four tests
      P.value[j,] <- c(resultN$p.value, resultH$`p value`, resultR$`p value`, 
      as.numeric(as.character(resultM$`p value`[which.min(as.numeric(as.character(resultM$`p value`[-3])))])))

    }

    ## combine the testing results of four tests
    count = matrix(c(countN, countH, countR, countM), 1, 4)
    
    ## the rejection rate of four tests in the setting replication times.
    count = count/replicate.no

    ## combine rejection rate and error times
    count = cbind(count, replicate.no, error_ct)


    colnames(P.value) = c("Energy", "HZ", "Royston", "Mardia")
    colnames(count) = c("Energy", "HZ", "Royston", "Mardia", "replicate.no", "error_times")
    results <- list(P.value,count)
    names(results) <- c("P.value","Proportion.table")

    return(results)
  }


output <- Prop.reject(Data, gene.no = 4, replicate.no = 10, significance.level = 0.05)

## check 
apply(ifelse(output[[1]] < 0.05,1,0),2,mean)
output[[2]]






