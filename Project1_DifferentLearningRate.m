readFile=dlmread('temp.dat');
figure;
plot(readFile(:,1) , readFile(:,2));
xlabel('Number of iteration');
ylabel('Learning rate');
title(' Number of iteration V/S Learning rate ');