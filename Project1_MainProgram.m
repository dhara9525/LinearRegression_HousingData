readFile=dlmread('housing_price_data.dat');
F=sortrows([readFile(:,5) readFile(:,2)]);
% Initial plotting of values on graph from file 'housing_price_data.dat'
figure
scatter(F(:,1) , F(:,2))
xlabel('Size in square Feet');
ylabel('Price');
title('Housing price projection')
F=F(25:600,:);
x=F(:,1);
y=F(:,2);
% Normalization of x
normalization=true;
if(normalization)
maxX=max(x);
minX=min(x);
norX=x/(maxX-minX);
norFactor=(maxX-minX);
end
x=[ ones(length(x),1) norX ];
w=rand(2,1);        %d w=weight
newW1=[];
newW2=[];
newE=[];
lr=0.45;             %d lr= learning rate
for i=1:400 
m=length(y);
h=(x*w-y)';
  w(1,1) = w(1,1) - (lr * (1/m) * h * x(:, 1));
  w(2,1) = w(2,1) - (lr * (1/m) * h * x(:, 2)); 
  newW1(end+1)=w(1,1);
  newW2(end+1)=w(2,1);
  e1 = (x * w - y)' * (x * w - y) / (length(y)); % e1=Mean Square Error
  newE(end+1)=e1;
end
% Finding where differnce between consecutive value of MSE becomes
% insignificant 
for i=1:399
    diff=(newE(i)-newE(i+1));
    if(diff<=1000000)
        iteration=i;
        break;
    end
end
fprintf('Learning rate :');disp(lr); % This will display provided learning rate 
fprintf('Number of iteration are required :'); disp(iteration); % This will display required learning rate 
figure;
plot(1:400,newE);
xlabel('Iteration');
ylabel('Error');
finalW1=newW1(iteration);
finalW2=newW2(iteration);
finalWeightForPlot=[finalW1;finalW2];
figure;
hold off;
scatter(x(:,2)*(maxX-minX),y,5,'blue','.');
hold;
yhat = x*finalWeightForPlot;
plot(x(:,2)*(maxX-minX),yhat,'r');
xlabel('Size in square Feet');
ylabel('Price');
