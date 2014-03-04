
import sys
import commands 


def main():

  S0vec = [0.80, .85, 0.90, 0.91, 0.92, 0.93, 0.94, 0.95, .96, .97, .98]
  Nvec = [100,  200,  300,  400,  500,  600,  700,  800,  900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]
  C = 50.0

  for S0 in S0vec:
    for N in Nvec:

      cmd = 'sbatch --account zheng_y --cpus-per-task=1 --time=1-0 --wrap=\"R --no-save --no-restore --args N=%d S0=%f cens.perc=%f< onesim.R\"' % (N, S0, C)
      (status, output) = commands.getstatusoutput(cmd)
      print(cmd)
      
      if status:    ## Error case, print the command's output to stderr and exit
        sys.stderr.write(output)
        sys.exit(1)
        
      print output  ## Otherwise do something with the command's output
  
 
if __name__ == "__main__":
  main()
