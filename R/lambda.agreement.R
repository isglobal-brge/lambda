lambda.agreement<-function(means, sigmas, benchmark = "FALSE")
{
 
  erf <- function(x) 2 * pnorm(x * sqrt(2)) - 1

  probsdiagrow <- sapply(1:nrow(means), function(dd)
  {

    muddDiag <- means[dd,dd]
    sigmaddDiag <- sigmas[dd,dd]

    mudd <- means[dd,-dd]
    sigmadd <- sigmas[dd,-dd]
    prod((1-erf((-muddDiag + mudd + 1e-16)/sqrt(sigmaddDiag^2 + sigmadd^2 + 1e-16)/sqrt(2)))/2)

  })


  probsdiagcol <- sapply(1:nrow(means), function(dd)
  {

    muddDiag <- means[dd,dd]
    sigmaddDiag <- sigmas[dd,dd]

    mudd <- means[-dd,dd]
    sigmadd <- sigmas[-dd,dd]
    prod((1-erf((-muddDiag + mudd + 1e-16)/sqrt(sigmaddDiag^2 + sigmadd^2 + 1e-16)/sqrt(2)))/2)

  })

  probsdiag <- probsdiagrow*probsdiagcol
  
  if(benchmark == TRUE)
    probsdiag <- probsdiagrow

  #Remove bias at low agreement for the few state case
  #probsdiag<-probsdiag[-which(probsdiag==max(probsdiag))[1]]  

  estimate <- sum(probsdiag) / length(probsdiag)
  variance <- sum(probsdiag * (1-probsdiag)) / (length(probsdiag)^2)
  res <- list(estimate=estimate, variance=variance)
  res  
}  
