/*********************************************
 * OPL 12.10.0.0 Model
 * Author: zeba
 * Creation Date: 7 Feb 2020 at 17:49:16
 *********************************************/
 
 //parameters

int m=...; // number of regions
int n = ...;



//range region1=2..m+2;
range total_region=1..m;
//range region2=1..m+1;
//range r =2..m+1;
range inspect=1..n;
tuple Pair {
  int k;
  int l;
}

int cost[total_region][total_region]= ...;
int penalty[total_region][total_region]=...;
//int con[total_region][total_region] = ...;

{Pair} theta  = ...;
Pair theta1 = <8,0>;

// variables
 dvar boolean x[total_region][total_region];
 dvar int u[2..m];
 dvar boolean y[total_region][total_region];
 //dvar int+ y[total_region][total_region];
 float temp;
execute{
var before = new Date();
temp = before.getTime();
}
 
 // model
//maximize sum(i in total_region, j in total_region) cost[i][j]*x[i][j] + sum(i in total_region) cost[1][i]*x[1][i] + sum(i in total_region) cost[i][m+2]*x[i][m+2] + sum(a in theta) penalty[a.k][a.l]*(1-y[a.k][a.l]);
minimize sum(i in total_region,j in total_region) cost[i][j]*x[i][j] + sum(a in theta) penalty[a.k][a.l]*(1-y[a.k][a.l]);
subject to {

        /*forall(i in r )
        region_once:
        sum(i in total_region, j in total_region) x[i][j] == 1;*/
       /* forall()
       
        forall(j in total_region)
        arrive_once:
        sum(i in total_region) x[i][j] == 1;
       
        forall(i in total_region)
        leave_once:
        sum(j in r) x[i][j] == 1;
       
        forall(a in theta)
           force:
           x[a.k][a.l] >= y[a.k][a.l];
       
        forall(i in total_region)
          self:
          x[i][i] == 0;  
         
        forall(i in total_region)
          continuity:
          sum(j in total_region: i != j) x[i][j] == sum(j in total_region: i != j) x[j][i];*/
         
        //Subtour elimination using Miller-Tuker-Zemlin formulation
        forall(i in total_region)
          no_self:
          x[i][i] == 0;
         
        forall(i in total_region)
          arrive_once:
          sum(j in total_region: i !=j ) x[i][j] == 1;
         
        forall(j in total_region)
        leave_once:
        sum(i in total_region) x[i][j] == 1;
       
        forall(i,j in total_region: i > 1 && j > 1)
          sub_tour:
          u[i] + 1 <= u[j] + 1000*(1-x[i][j]);
       
        forall(i in total_region)
          flow:
          sum(j in total_region: i != j) x[i][j] == sum(j in total_region: i != j) x[j][i];
         
        forall(i,j in total_region: cost[i][j]>1)
         direct_path:  
            x[i][j]== 0;
       
        forall(a in theta)
          forces_binary:
          x[a.k][a.l] >= y[a.k][a.l];
         
         //each_region:
         //sum(i,j in total_region) x[i][j] == 1;  
       
         
 
}

execute {
 
    writeln("theta:",theta1.l);
    var after = new Date();
    writeln("solving time ~= ",after.getTime()-temp);
 
}
