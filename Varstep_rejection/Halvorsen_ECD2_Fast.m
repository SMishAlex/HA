h=h*0.5;

//cromer 2
x[2]=x[2]+h*(-b[0]*x[2]-4*(x[1]+x[0])-x[0]*x[0]);
x[1]=x[1]+h*(-b[1]*x[1]-4*(x[0]+x[2])-x[2]*x[2]);
x[0]=x[0]+h*(-b[2]*x[0]-4*(x[1]+x[2])-x[1]*x[1]);

//D1
x[0]=(x[0]+h*(-4*(x[1]+x[2])-x[1]*x[1]))/(1+b[0]*h);
x[1]=(x[1]+h*(-4*(x[0]+x[2])-x[2]*x[2]))/(1+b[1]*h);
x[2]=(x[2]+h*(-4*(x[1]+x[0])-x[0]*x[0]))/(1+b[2]*h );