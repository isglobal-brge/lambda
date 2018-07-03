CIlambda<-function(E1, E2, alpha, nsam=1000, mc.cores=5, benchmark = FALSE, verbose=FALSE)
{   
  
  boost<-mclapply(1:nsam, function (smsm)
  { 
    if(verbose)
      print(smsm)
    
    subs <- sample(1:nrow(E1), length(E1), replace=TRUE)
    
    betas <- lapply(1:ncol(E1), function(ii)
    {
      
      cors<-lapply(1:ncol(E2), function(jj)
      { 
        
        rho <- cor.test(E1[subs,ii], E2[subs,jj])
        rho <- rho$estimate
        z <- log((1 + rho) / (1 - rho)) / 2
        sigmaz <-  1/sqrt(length(E2[subs,ii]) -3)
        c(z, sigmaz)
      })
      
      cors
    })
    
    #get means for lambda
    meansMat <- lapply(1:nlevels,function(e1)
    { 
      out <- sapply(1:nlevels, function(e2) betas[[e1]][[e2]][1])
      out
    })
    
    meansMat <- do.call(rbind,meansMat)
    
    #get sigmas for lambda
    sigmasMat <-  lapply(1:nlevels,function(e1)
    { 
      out <- sapply(1:nlevels, function(e2) betas[[e1]][[e2]][2])
      out
    })
    
    sigmasMat <- do.call(rbind,sigmasMat)
    
    out<-lambda.agreement(t(meansMat),t(sigmasMat), benchmark = benchmark)
    
    res<-data.frame(lambda = round(out$estimate,2))
    
    res
    
  }, mc.cores=mc.cores)
  
  
  boost <- unlist(boost)
  
  out <- quantile(unlist(boost), c(alpha/2,1-alpha/2))  
  out
}

