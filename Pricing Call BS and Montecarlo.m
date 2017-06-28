
clear all
clc

% set the parameters
S0    = 100;
T     = 1;
r     = .04;
sigma = .25;
K     = 95;

% evaluate the function which we defined
% in the other file
mybsprice(S0, K, r, T, sigma)

% from the Finance toolbox (requires the Finance toolbox)
blsprice(S0, K, r, T, sigma)

% second part 
Kset = (75:125)';
Tset = ((1/12):(1/12):2)';

% initialize some tables to store the values of the options
table1 = nan( size(Kset,1), size(Tset,1));
table2 = nan( size(Kset,1), size(Tset,1)); 

for t = 1:size(Tset,1)
  for k = 1:size(Kset,1)
    T = Tset(t);
    K = Kset(k);

    % populate a table using our function
    table1(k,t) = mybsprice(S0, K, r, T, sigma);

    % populate a table using the built in function
    table2(k,t) = blsprice(S0, K, r, T, sigma);
  end
end

% print the results out
table1

% get the average absolute deviation of the two prices to check
% the discrepancy between the two values
% note the double sum because it only sums across one dimension
sum(sum(abs(table1-table2)))/numel(table1)

% or the vectorized version
K_vals = repmat(Kset',[numel(Tset) 1])';
T_vals = repmat(Tset,[1 numel(Kset)])';

table3 = mybsprice(S0, K_vals, r, T_vals, sigma)

sum(sum(abs(table3-table2)))/numel(table1)

% Read in the values
% skipping a row with the second parameter of csvread
filename = 'optionsdata.csv';
optionsdata = csvread(filename,1);
% S0, sigma, r, T, K
% add the values
optionsdata(:,6) = mybsprice(optionsdata(:,1),optionsdata(:,5), ...
                             optionsdata(:,3),optionsdata(:,4), ...
                             optionsdata(:,2));
                         
csvwrite('lab4out.csv',optionsdata)                         

% Part 2 - Monte Carlo
inT = 1;
inr = .04;
insigma = .25;
inK = 95;
ins0 = 100;

% make sure your parameters are in the right order
price_call_mc(ins0,inK,inr,insigma,inT,100000)
mybsprice(ins0,inK,inr,inT,insigma)
