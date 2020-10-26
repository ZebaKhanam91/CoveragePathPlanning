function [m,centerX,centreY,width,length,order] = experiment_setup()

%%%%%%%%%%%%%Number of regions%%%%%%%%%%%%%%%%%%%
prompt = 'Enter the number of regions (less than 50)? ';
m = input(prompt);

%%%%%%%%%%%%%Centroid Generation%%%%%%%%%%%%%%%%%
for i = 1:m
    dist = 0 + (200)*rand;
    ang = 0 + (360)*rand;
    angleInRadians = degtorad(ang);
    centreX(i)= dist * sin(angleInRadians);
    centreY(i) = dist * cos(angleInRadians);
end

%%%%%%%%%%%%%%%%%%%Region Creation%%%%%%%%%%%%%%%%%%%%%%%%%%
mu = 7.5;
sigma = 2.5;
figure;
for i = 1:m
    length(i) = normrnd(mu,sigma);
    width(i) = normrnd(mu,sigma);
    x = centreX(i) - length(i)/2;
    y = centreY(i) - width(i)/2;
    hold on;
    rectangle('Position',[x y length(i) width(i)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%Specific Order%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu = round(m/4);
sigma = round(m/8);
p = round(normrnd(mu,sigma));
order = [];
for i = 1:p
     edge1=round(1+ 9*rand); 
     edge2=round(1+ 9*rand); 
     order = [order;[edge1,edge2]];
end    
end    
    
 
