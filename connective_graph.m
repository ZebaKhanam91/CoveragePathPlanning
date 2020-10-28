function [edge,theta] = connective_graph(m,centreX,centreY,order)

%%%%%%%%%%%%%%%%%%%%%%%%Initialization%%%%%%%%%%%%%%%%
theta = order;
%%%%%%%%%%%%%%%%%%%Self-Loop Elimination%%%%%%%%%%%%%%%%%%%
edge = zeros(m,m);
for i = 1:m
    %Eliminate Self loop%
    edge(i,i) = 10000;
end
a = find(order(:,1) == order(:,2));
x = size(a);
for k = 1:x(1)
   theta(a(k,1),:) = [];
end
    %%%%%%%%%%%Cost Matrix Calculation%%%%%%%%%%%%%%%5
for i = 1:m
    for j = 1:m
        if i ~= j
            edge(i,j) = sqrt((centreX(i)-centreX(j))^2+(centreY(i)-centreY(j))^2);
        end
    end
end
G = graph(edge);
            
