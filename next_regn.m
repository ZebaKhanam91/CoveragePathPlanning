function  [Z,arc] = next_regn(Z,m,edge,arc,theta)

x = size(Z);
%%%%%%%%%%%%%VSRF: Visit Specific Route First%%%%%%%%%%%%%%
if(x(1) == 0)
    Z = VISIT_ARC(arc,Z);
end
next_region = arc(1,2);
rho_cost=[];
element = [];
flag = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%NNV:Next Neighbour Visit%%%%%%%%%%%%%%%%%%%
for i = 1:m
    if(isempty(find(ismember(Z,i))))
    flag = 0;    
    %%%%%%%%%%%%%%%All unvisited neighbour of next_region%%%%%%%%%%%%%%%
             a = ismember(theta,[next_region,i]);
             b = a(:,1) & a(:,2);
             criteriaI = find(b);
             if(not(isempty(criteriaI)))
                 next_region = i;
                 break;
             end
             a = ismember(theta,[i,i]);
             b = a(:,1);
             criteriaII = find(b);
              if(not(isempty(criteriaII)))
              %%%%%%%%%%%%%%%%%%%Look-Ahead Plan%%%%%%%%%%%%%%%
                 next_region = i;
                 break;
              end
             %%%%%%%%%%%%%%%%%%Cost-Constructive Plan%%%%%%%%%%
              rho_cost = [rho_cost,edge(next_region,i)];
              element = [element,i]; 
             %%%%%%%%%%%%%%Away from Sink%%%%%%%%%%%%%%%%
    end
    
end

    if(next_region == arc(1,2))
     [r,i] = min(rho_cost);
      next_region = element(i);
    end
Z = [Z,next_region];
arc = [arc(1,2),next_region];

      
end
