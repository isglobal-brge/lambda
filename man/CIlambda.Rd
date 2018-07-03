\name{CIlambda}
\alias{CIlambda}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Confidence intervals for lambda
}
\description{
Computes the confidence intervals of lambda from bootstrapping 
}
\usage{
CIlambda(E1, E2, alpha, nsam=1000, mc.cores=1, benchmark = FALSE, verbose=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{E1}{
Matrix of k conditions (tissues) and N observations (gene-pair correlations) for rater 1 (experiment 1) 
}
  \item{E2}{
Matrix of k conditions (tissues) and N observations (gene-pair correlations) for rater 2 (experiment 2) 
}

  \item{alpha}{
confidence level of CI  
}

  \item{nsam}{
number of resamplings with replacements  
}

  \item{mc.cores}{
number cores for parallelization  
}

  \item{benchmark}{
a logical (default FALSE) that computes the agreement measure for benchmarking experiment 2 (columns) against experiment 1 (rows).
}

  \item{verbose}{
logical. If TRUE it prints the sampling number during computation.  
}

}
\details{
The function computes the CI of lambda at alpha level from resampling with replacement the rows of E1 and E2. E1 and E2 correspond to the observations made by each rater across multiple conditions (columns). Each observation is assumed to be the corralation between two variables.

For gene networks the variables may be the correation of expression levels between two genes across subjects. In this case, the first column in E1 contais, for intance, all non-redundant pair-wise correlations among the genes in the network for condition (tissue) 1 in experiment 1.   

}
\value{
 \item{CI}{confidence intervals}
}
\references{
Caceres, A and Gonzalez JR, A measure of agreement across numerous conditions: Assessing when changes in network
connectivities across tissues are functional  
}
\author{
A Caceres
}

\examples{

#simulate E1 and E2 from a multivariate distribution
library(MASS)
library(parallel)

nlevels<-5 #total conditions
ntrue<-3 #number of reliable conditions
cortrue<-0.5 #correlations of reliable conditions
basecor<-0.1 #background correlation

ngenes<-10 #number of genes in network
nonredundantcor<-ngenes*(ngenes-1)/2 #number of non-redundant correlations

#specify covariance matrix for simulation
covmat<-matrix(basecor, ncol=nlevels*2, nrow=nlevels*2)
  
for(ind in 1:nlevels)
  {  
    covmat[(2*ind-1):(2*ind), (2*ind-1):(2*ind)] <- matrix(c(1,cortrue,cortrue,1), ncol = 2)
    if(ind > ntrue)
      covmat[(2*ind-1):(2*ind), (2*ind-1):(2*ind)] <- matrix(c(1,basecor,basecor,1), ncol = 2)
  }
  
simul <- mvrnorm(nonredundantcor, mu = rep(0,nlevels*2), Sigma = covmat, empirical = TRUE)
### 
  
#45 gene correlations on 5 subjects

E1 <- simul[,seq(1,ncol(simul),2)] #experiment 1
E2 <- simul[,seq(1,ncol(simul),2)+1] #experiment 1
  
CIlambda(E1=E1, E2=E2, alpha=0.05, nsam=100, mc.cores=2)
    
}

