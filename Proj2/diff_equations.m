a1 = @(x,y) (3/4)*m*(l^2) + M*(l^2) + 2*I;
b1 = @(x,y) 0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I;
c1 = @(x,y) 0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y);
d1 = @(x,y) - (5/2)*m*g*l*sin(x) - k*(y-x);

a2 = @(x,y) 0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I;
b2 = @(x,y) 0.25*m*(l^2) + M*(l^2) + I;
c2 = @(x,y) -0.5*(l^2)*sin(x-y)*(m + M);
d2 = @(x,y) k*(y-x) - (3/2)*m*g*l*sin(y);

x_dd = (tau - c1(x,y)*(x_d^2) - d2(x,y) - (b1(x,y)./b2(x,y))*(tau - c2(x,y)*(x_d^2) - d2(x,y)))./(a1(x,y)-(a1(x,y)*b1(x,y)/b2(x,y)));
y_dd = (tau - c2(x,y)*(x_d^2) - d2(x,y) - (a2(x,y)./a1(x,y))*(tau - c1(x,y)*(y_d^2) - d1(x,y)))./(b2(x,y)-(a1(x,y)*b1(x,y)/a1(x,y)));
