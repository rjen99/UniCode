l=16; %metre, 50ft
m=15000; %kilogram, approx guess
I=(1/3)*m*(l^2);
g=9.81;
t=linspace(0,5,100);
theta_vec,vel_vec,accel_vec=tree_pivot(m,l,I,1);
theta=theta_vec(end);vel=vel_vec(end);accel=accel_vec(end);
x_base=-(l/2).*sin(theta);
y_com=(l/2).*cos(theta);
base=[x_base,0];
com=[0,y_com];
top=[-x_base,2*y_com];