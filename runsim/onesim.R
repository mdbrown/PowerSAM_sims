# expects N
library(survival)
source("../PowerSAM/main.R")
source("../PowerSAM/subroutines.R")
source("../PowerSAM/Estimation.R")

M = 10 
N = 500
tmp <- SimulateN(N, parameter = "AUC", 
                      S.0 = .905, 
                      t.0 = 1,
                      cutoff= 0, 
                      predict.time = 2,
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
