# expects N and S0
for(arg in commandArgs(TRUE)) eval(parse(text=arg)) 


library(survival)
source("../../PowerSAM/main.R")
source("../../PowerSAM/subroutines.R")
source("../../PowerSAM/Estimation.R")
source("../../PowerSAM/dipw.R")

par = "AUC"

t.0 = 3
a = -log(S0)/t.0
predict.time = 3
time.max = 100
cutoff = 0
H0 = .6
Ha = .65
M = 1000 


mybetas <- get.Betas(par, a, predict.time = 5, cutoff = cutoff, H0, Ha)
beta = mybetas[2]
 

#compute lam for censoring distribution
  mymax = 100-floor(Pr.cTtmax(lam = 100, time.max, a, beta)*100)

  if(cens.perc >mymax){
    
    
    out <- uniroot(function(lam, cens.perc, tmax, a, beta){Pr.cTtmax(lam, tmax, a, beta) - cens.perc}, 
                   c(0, 100),
                   cens.perc =  (cens.perc - mymax)/100, 
                   tmax = time.max, 
                   a = a, 
                   beta = beta)$root
  }else{
    
    out = 0
  }
  
  myLam <- out
  





system.time(
tmp <- SimulateN(N, parameter = par, 
                      S.0 = S0, 
                      t.0 = t.0,
                      cutoff= cutoff, 
                      predict.time = predict.time,
                      parval.H0 = H0, 
                      parval.Ha = Ha, 
                      ESTmethod = "NP", 
                      f_x = dnorm, 
                      F_xInv = qnorm, 
                      mm = M,  
                      alpha = 0.05, 
                      cens.lam = myLam, 
                      time.max = time.max))


save(tmp, file = paste("../data/simout_cens_", cens.perc, "_S0_", S0, "_N_", N,"_", par,  "_NP.Rdata", sep = ""))

#library(grid)
#library(ggplot2)
#load("../data/simout_S0_0.5_N_100.Rdata")

#printResultPlot(tmp, pars = c("beta", "AUC","TPR", "FPR", "PPV", "NPV"), useLogit=FALSE)
