\name{lambda.agreement}
\alias{lambda.agreement}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Ageement measure lambda
}
\description{
Computes the agreement measure between two experiments across numerous conditions 
}
\usage{
lambda.agreement(means, sigmas, benchmark = "FALSE")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{means}{
a k-times-k matrix that encodes the preservation matrix of correlations (z-transformed) between experiment 1 in rows and experiment 2 in columns across k condition levels. 
}
  \item{sigmas}{
a k-times-k matrix that encodes the standard error for the means.
}
  \item{benchmark}{
a logical (default FALSE) that computes the agreement measure for benchmarking experiment 2 (columns) against experiment 1 (rows).
}
}
\details{
Lambda is an inter-study reliability measure for studies that compute a correlation network of N variables (genes) across different conditions, such as tissues (i = 1..k).  Lambda computes the fraction of diagonal terms of a preservation matrix that are their row and columns maxima. The preservation matrix Z across conditions is given by the pair-wise correlations of the network between experiments and conditions. Lambda is then the expected fraction of conditions that can be reliably matched between experiments.  As lambda assumes that the elements of the preservation matrix are normally distributed, if the elements are derived from correlations between network structures then a Fisher's Z transformation should be applied. 

}
\value{
 \item{estimate }{lambda: expected fraction of conditions (r)  by which the network can be correctly paired by conditions across studies. }
 \item{variance }{variance: variance of the fraction r}

}
\references{
Caceres, A and Gonzalez JR, A measure of agreement across numerous conditions: Assessing when changes in network
connectivities across tissues are functional 
}
\author{
A Caceres
}

\examples{

#simulate correlation network of ten variables (genes) on three conditions (tissues)
k<-10
#number of upper triangular elements in the correlation matrix is (k^2-k)/2 
tn <- (k^2-k)/2

#45 non-redundant gene correlation pairs from a 10 gene-network on 3 conditions and two experiments

E1 <-  matrix(rnorm(tn*3), ncol=3)  #expriment 1
E2 <-  E1 + matrix(rnorm(tn*3), ncol=3)  #expriment 2

E1df <- data.frame(E1)
names(E1df) <- LETTERS[1:3] 
E2df<-data.frame(E2)
names(E2df) <- letters[1:3] 

#correlation matrix between experiments across conditions
cormat<- sapply(E2df, function(i) sapply(E1df, function(j) cor.test(i,j)$estimate))

#Fisher's Z transformation
zmat <- round(log((1 + cormat) / (1 - cormat)) / 2,2)
sigmaz <-  matrix(1/sqrt(nrow(E1) - 3),ncol=3,nrow=3)

#the diagonal terms are the maxima across rows and columns
zmat

#lambda is close to 1
lambda <- lambda.agreement(zmat, sigmaz)
lambda

#A is reliably paired to a, B to b an C to C
}
