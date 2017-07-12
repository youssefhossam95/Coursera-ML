%% Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear regression exercise. 
%
%  You will need to complete the following functions in this 
%  exericse:
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  For this part of the exercise, you will need to change some
%  parts of the code below for various experiments (e.g., changing
%  learning rates).
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);
save('testNorm.txt','X','-ascii');
% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha1 = 0.003;
alpha2=0.01;
alpha3=0.03;
alpha4=0.1;
num_iters = 200;

% Init Theta and Run Gradient Descent 
theta1 = zeros(3, 1);
theta2 = zeros(3, 1);
theta3 = zeros(3, 1);
theta4 = zeros(3, 1);
[theta1, J_history1] = gradientDescentMulti(X, y, theta1, alpha1, num_iters);
[theta2, J_history2] = gradientDescentMulti(X, y, theta2, alpha2, num_iters);
[theta3, J_history3] = gradientDescentMulti(X, y, theta3, alpha3, num_iters);
[theta4, J_history4] = gradientDescentMulti(X, y, theta4, alpha4, num_iters);
% Plot the convergence graph
figure;
xlabel('Number of iterations');
ylabel('Cost J');
hold on;
plot(1:numel(J_history1), J_history1, '-b', 'LineWidth', 2);
plot(1:numel(J_history2), J_history2, '-r', 'LineWidth', 2);
plot(1:numel(J_history3), J_history3, '-g', 'LineWidth', 2);
plot(1:numel(J_history4), J_history4, '-y', 'LineWidth', 2);
% Display gradient descent's result
fprintf('Theta computed from gradient descent1: \n');
fprintf(' %f \n', theta1);
fprintf('\n');
fprintf('Theta computed from gradient descent2: \n');
fprintf(' %f \n', theta2);
fprintf('\n');
fprintf('Theta computed from gradient descent3: \n');
fprintf(' %f \n', theta3);
fprintf('\n');
fprintf('Theta computed from gradient descent4: \n');
fprintf(' %f \n', theta4);
fprintf('\n');
% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.


price1 = [1 (1650-mu(1))/sigma(1) (3-mu(2))/sigma(2) ]*theta1; % You should change this
price2 = [1 (1650-mu(1))/sigma(1) (3-mu(2))/sigma(2) ]*theta2;
price3 = [1 (1650-mu(1))/sigma(1) (3-mu(2))/sigma(2) ]*theta3;
price4 = [1 (1650-mu(1))/sigma(1) (3-mu(2))/sigma(2) ]*theta4;

% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent1):\n $%f\n'], price1);

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent2):\n $%f\n'], price2);
fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent3):\n $%f\n'], price3);
fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent4):\n $%f\n'], price4);
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

% ====================== YOUR CODE HERE ======================
% Instructions: The following code computes the closed form 
%               solution for linear regression using the normal
%               equations. You should complete the code in 
%               normalEqn.m
%
%               After doing so, you should complete this code 
%               to predict the price of a 1650 sq-ft, 3 br house.
%

%% Load Data
data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
price = [1 1650 3]*theta; % You should change this


% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using normal equations):\n $%f\n'], price);

