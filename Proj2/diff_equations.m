a1 = @(x,y) (3/4)*m*(l^2) + M*(l^2) + 2*I;
b1 = @(x,y) 0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I;
c1 = @(x,y) 0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y);
d1 = @(x,y) - (5/2)*m*g*l*sin(x) - k*(y-x);

a2 = @(x,y) 0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I;
b2 = @(x,y) 0.25*m*(l^2) + M*(l^2) + I;
c2 = @(x,y) -0.5*(l^2)*sin(x-y)*(m + M);
d2 = @(x,y) k*(y-x) - (3/2)*m*g*l*sin(y);

%%
z = [0,0,0,0];
tau = 750;
sol = ode45(@(t,x) rhs_ode(t,z,tau),[0,5],z);

%%
function dzdt = rhs_ode(t,z,tau)
% Correct values need put in
m=100;
M=200;
l=1.8;
g=9.81;
I=100;
k=100;

a1 = @(x,y) (3/4)*m*(l^2) + M*(l^2) + 2*I;
b1 = @(x,y) 0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I;
c1 = @(x,y) 0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y);
d1 = @(x,y) - (5/2)*m*g*l*sin(x) - k*(y-x);

a2 = @(x,y) 0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I;
b2 = @(x,y) 0.25*m*(l^2) + M*(l^2) + I;
c2 = @(x,y) -0.5*(l^2)*sin(x-y)*(m + M);
d2 = @(x,y) k*(y-x) - (3/2)*m*g*l*sin(y);

x = z(1);
y = z(2);
x_d = z(3);
y_d = z(4);
x_dd = (tau - c1(x,y)*(x_d^2) - d2(x,y) - (b1(x,y)./b2(x,y))*(tau - c2(x,y)*(x_d^2) - d2(x,y)))./(a1(x,y)-(a1(x,y)*b1(x,y)/b2(x,y)));
y_dd = (tau - c2(x,y)*(x_d^2) - d2(x,y) - (a2(x,y)./a1(x,y))*(tau - c1(x,y)*(y_d^2) - d1(x,y)))./(b2(x,y)-(a1(x,y)*b1(x,y)/a1(x,y)));
dzdt = [x_d; y_d; x_dd; y_dd];
end

