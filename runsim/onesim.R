# expects N and S0
for(arg in commandArgs(TRUE)) eval(parse(text=arg)) 


library(survival)
source("../../PowerSAM/main.R")
source("../../PowerSAM/subroutines.R")
source("../../PowerSAM/Estimation.R")

M = 1000 

tmp <- SimulateN(N, parameter = "AUC", 
                      S.0 = S0, 
                      t.0 = 5,
                      cutoff= 0, 
                      predict.time = 5,
                      parval.H0 = .60, 
                      parval.Ha = .65, 
                      ESTmethod = "SP", 
                      f_x = dnorm, 
                      F_xInv = qnorm, 
                      mm = M,  
                      alpha = 0.05, 
                      cens.perc = .4, 
                      time.end = NULL,
                      time.max = NULL, censorType = "cens.perc")


save(tmp, file = paste("../data/simout_S0_", S0, "_N_", N, ".Rdata", sep = ""))

#library(grid)
#library(ggplot2)
#load("../data/simout_S0_0.5_N_100.Rdata")

#printResultPlot(tmp, pars = c("beta", "AUC","TPR", "FPR", "PPV", "NPV"), useLogit=FALSE)
