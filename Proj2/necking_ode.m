% x = theta 1
% y = theta 2
%% Equations of motion
tau = x_dd.*(0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I) ...
    + y_dd.*(0.25*m*(l^2) + M*(l^2) + I) ...
    - (x_d.^2).*(0.5*(l^2)*sin(x-y)*(m + M)) ...
    + k*(y-x) - (3/2)*m*g*l*sin(y);

tau = x_dd.*((3/4)*m*(l^2) + M*(l^2) + 2*I) ...
    + y_dd.*(0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I) ...
    + (y_d.^2)*(0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y)) ...
    - (5/2)*m*g*l*sin(x) - k*(y-x);
%%
x_dd = -(y_dd.*(0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I) ...
     + (y_d.^2)*(0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y)) ...
     - (5/2)*m*g*l*sin(x) - k*(y-x) - tau)./((3/4)*m*(l^2) + M*(l^2) + 2*I);

%%
x_dd = (tau - c1(x,y)*(x_d^2) - d2(x,y) - (b1(x,y)./b2(x,y))*(tau - c2(x,y)*(x_d^2) - d2(x,y)))./(a1(x,y)-(a1(x,y)*b1(x,y)/b2(x,y)));
y_dd = (tau - c2(x,y)*(x_d^2) - d2(x,y) - (a2(x,y)./a1(x,y))*(tau - c1(x,y)*(y_d^2) - d1(x,y)))./(b2(x,y)-(a1(x,y)*b1(x,y)/a1(x,y)));
%% Functions
% tau = a1(x,y)*x_dd + b1(x,y)*y_dd + c1(x,y)*y_d + d1(x,y);
% tau = a2(x,y)*x_dd + b2(x,y)*y_dd + c2(x,y)*x_d + d2(x,y);
a1 = @(x,y) (3/4)*m*(l^2) + M*(l^2) + 2*I;
b1 = @(x,y) 0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I;
c1 = @(x,y) 0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y);
d1 = @(x,y) - (5/2)*m*g*l*sin(x) - k*(y-x);

a2 = @(x,y) 0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I;
b2 = @(x,y) 0.25*m*(l^2) + M*(l^2) + I;
c2 = @(x,y) -0.5*(l^2)*sin(x-y)*(m + M);
d2 = @(x,y) k*(y-x) - (3/2)*m*g*l*sin(y);

