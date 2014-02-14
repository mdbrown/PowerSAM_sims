
import sys
import commands 


def main():

  S0vec = [0.05, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 0.95]
  Nvec = [100,  200,  300,  400,  500,  600,  700,  800,  900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]

  for S0 in S0vec:
    for N in Nvec:

      cmd = 'sbatch --account zheng_y --cpus-per-task=1 --time=1-0 --wrap=\"R --no-save --no-restore --args N=%d S0=%f < onesim.R\"' % (N, S0)
      (status, output) = commands.getstatusoutput(cmd)
      print(cmd)
      
      if status:    ## Error case, print the command's output to stderr and exit
        sys.stderr.write(output)
        sys.exit(1)
        
      print output  ## Otherwise do something with the command's output
  
 
if __name__ == "__main__":
  main()
