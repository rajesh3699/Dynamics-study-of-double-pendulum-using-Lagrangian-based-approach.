clear
%defining constants
m1=2;
m2=1;
g=9.8;
l1=1;
l2=1.5;

%parameters
syms thetha1(t) thetha2(t)  thetha2_dot(t) thetha1_ddot(t) thetha2_ddot(t) 
thetha1_dot(t)= diff(thetha1);
thetha2_dot(t)= diff(thetha2);
thetha1_ddot(t)= diff(thetha1_dot);
thetha2_ddot(t)= diff(thetha2_dot);


  eqn1 = thetha1_ddot==(m2*l1*thetha1_dot*thetha1_dot*sin(thetha1-thetha2)-m2*g*sin(thetha2)-m2*l2*thetha2_ddot)*(1/(m2*l1*cos(thetha1-thetha2)));
  eqn2 = thetha2_ddot==-1*((m1+m2)*l1*thetha1_ddot+m2*l2*thetha2_dot*thetha2_dot*sin(thetha1-thetha2)+(m1+m2)*g*sin(thetha1))*(1/(m2*l2*cos(thetha1-thetha2)));                         

[V,S] = odeToVectorField(eqn1,eqn2);

M = matlabFunction(V, 'vars',{'t','Y'});
initCond = [pi 0 pi/6 0];
sols = ode45(M,[0 1000],initCond);


% plot(sols.x,sols.y)
% legend('\theta_2','d\theta_2/dt','\theta_1','d\theta_1/dt')
% title('Solutions of State Variables')
% xlabel('Time (s)')
% ylabel('Solutions (rad or rad/s)')
 x1 =  l1*sin(sols.y(3,:));
 y1 =  -l2*cos(sols.y(3,:));
 x2 =  l1*sin(sols.y(3,:))+l2*sin(sols.y(1,:));
 y2 =  -l1*cos(sols.y(3,:))-l2*cos(sols.y(1,:));
% 
% 
for i=1:1000
fig=figure(1);
hold on
fig1=line([0 x1(i)],[0 y1(i)],'Color','red');
fig2=plot(x1(i),y1(i),'ro','MarkerSize',m1*10,'MarkerFaceColor','r');
fig3=line([x1(i) x2(i)],[y1(i) y2(i)],'Color','green');
fig4=plot(x2(i),y2(i),'go','MarkerSize',m2*10,'MarkerFaceColor','g');
xlim([-5,5]);
ylim([-5,5]);
zlim([-5,5]);

pause(0.1)
clf('reset')
end

