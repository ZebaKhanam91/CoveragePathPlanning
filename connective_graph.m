function [vert, edge] = connective_graph()

%%%%%%%%%%%%%%%Generate Experiment Setup%%%%%%%%%%%%%%%%%%%%%%5
[m,centreX,centreY,width,length,order] = experiment_setup();
edge = zeros(m,m);
for i = 1:m
    for j = 1:m
        if i ~= j
            edge(i,j) = sqrt((centreX(i)-centreX(j))^2+(centreY(i)-centreY(j))^2);
        end
    end
end
G = graph(edge);
