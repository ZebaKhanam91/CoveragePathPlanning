hold on;
time1 = tic;
%%%%%%%%%%%%%%%%Initialization%%%%%%%%%%%%%%%%%
[m,centreX,centreY,width,length,order] = experiment_setup();
[edge,theta] = connective_graph(m,centreX,centreY,order);
n = size(theta);
Z = [];
ZQ =[];
%%%%%%%%%%%%%%%%%%%Order Generation%%%%%%%%%%%%%%%%%
for i = 1:n(1)
   Z = [];
   x = size(Z);
   arc = theta(i,:);
   while(x(2) ~= m)
       [Z arc] = next_regn(Z,m,edge,arc,theta);
       x = size(Z);
   end
   ZQ = [ZQ;Z];
end
 %%%%%%%%%%%%%%%%%%%%%%%%Feasible Solution%%%%%%%%%%%%%%%%
 for i =1:n(1)
     count = 0;
     X = size(unique(ZQ(i,:)));
     if(X(2)~=m)
         ZQ(i,:) = []
     end
 end
 
 %%%%%%%%%%%%%%%%%%%%%%%%%Cost Calculation%%%%%%%%%%%%%%%
 cost_z = zeros(n(1),1);
 for i = 1:n(1)
     for j = 1:m-1
         cost_z(i,1) = cost_z(i,1) + edge(ZQ(i,j),ZQ(i,j+1));
     end
     cost_z(i,1) = cost_z(i,1) + edge(ZQ(i,m),ZQ(i,1));
 end
 [cost i] = min(cost_z);
 start = find(ZQ(i,:)==1); 
 chi = [ZQ(b,start:m),ZQ(b,1:start-1)];
