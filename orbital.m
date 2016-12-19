fid=fopen('generate2.txt');
data=textscan(fid,'%s');
fclose(fid);
data=data{1,1};
[m,n]=size(data);

hold on;

r=6371;
sc=10000;

%At all times, have a list of reachable neighbours.
%HYPOTHESIS: find neighbour closest to midpoint of shortest line on land
%connecting points.


for i=3:m-1

    line=textscan(data{i,:},'%s %f %f %f','Delimiter',',');
    x=cos(line{1,2})*cos(line{1,3})*(line{1,4}+r);
    y=cos(line{1,2})*sin(line{1,3})*(line{1,4}+r);
    z=sin(line{1,2})*(line{1,4}+r);
    
    plot3(x,y,z,'marker','.','color','red');
    text(x,y,z,line{1,1});
    
end


 line=textscan(data{m,:},'%s %f %f %f %f','Delimiter',',');
 
 geo1=[line{1,2} line{1,3}];
 x=cos(line{1,2})*cos(line{1,3})*(r);
 y=cos(line{1,2})*sin(line{1,3})*(r);
 z=sin(line{1,2})*(r);
    
    plot3(x,y,z,'marker','.','color','green');
    text(x,y,z,'Start');
V1=[x y z];

geo2=[line{1,4} line{1,5}];


x=cos(line{1,4})*cos(line{1,5})*(r);
 y=cos(line{1,4})*sin(line{1,5})*(r);
 z=sin(line{1,4})*(r);
    
    plot3(x,y,z,'marker','.','color','blue');
    text(x,y,z,'End');
V2=[x y z];
lat1=line{1,2};
lon1=line{1,3};
lat2=line{1,4};
lon2=line{1,5};

f=1;
d=acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon1-lon2));


midV=r*(V1+V2)/norm(V1+V2);
 plot3(midV(1,1),midV(1,2),midV(1,3),'marker','.','color','yellow');
    text(midV(1,1),midV(1,2),midV(1,3),'MidPOINT');

[X,Y,Z]=sphere(50);

sr=r*0.95; %draw a smaller earth
x=0:0.1:2*pi;
y=sqrt(sr^2-x.^2);
plot(sr*cos(x),r*sin(x),'r');
plot3(r*cos(x),r*sin(x)*0,r*sin(x),'b');
plot3(r*cos(x)*0,r*cos(x),r*sin(x),'g');

xlabel('x');
ylabel('y');
zlabel('z');
surf(X*sr,Y*sr,Z*sr);
shading flat;
hold off;