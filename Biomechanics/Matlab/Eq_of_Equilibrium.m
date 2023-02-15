%%BIOMECHANICS

% to solve x(1) and x(2) when x(1)+x(2)=15 and minimize the sum of x(1) and
% x(2) squared.
% check the tutorial here:  https://www.mathworks.com/help/optim/ug/fmincon.html

fun = @(x)x(1)^2+x(2)^2; % this defines the optimization function, i.e. minimize the sum of x(1) and  x(2) squared.
x0 = [0,2]; % this is the point where optimization starts; change of this value would not affect the results being calculated.

A = []; % we are not using this in this example, so leave this as blank
b = []; % we are not using this in this example, so leave this as blank

Aeq = [1,1]; % Aeq and beq define: x(1)+x(2)=15 

beq = 2845;

    x = fmincon(fun,x0,A,b,Aeq,beq); % this is the function we need to solve this optimization problem
