close all;clc;clear;
% load('points.mat')
% load('pointshsv.mat')
% load('pointsrgb.mat')

% % % % 4000,0000 3D point
points=zeros(4000000,3);
pointshsv=zeros(4000000,3);
i1=-1000;
j3=1;
for x=1:2000
    i2=1000;
    for y=1:2000
        z=100*sin(i1/150);
        points(j3,:)=[i1,i2,z];
        pointshsv(j3,:)=[0.5*((i1/1000)+1),1,0.5*((-i2/1000)+1)];
        i2=i2-1;
        j3=j3+1;
        if i2==-1001
           i2=1000;
        end
    end
    i1=i1+1;
end
% % show the origignal image
pointsrgb=hsv2rgb(pointshsv);
figure;pcshow(points(:,:),pointsrgb);xlabel('X');ylabel('Y');zlabel('Z');title('3D RGB original image')
figure;pcshow(points(:,:),pointsrgb);view(2);xlabel('X');ylabel('Y');title('2D RGB original image')
figure;pcshow(points(:,:),pointshsv);xlabel('X');ylabel('Y');zlabel('Z');title('3D HSV original image')
figure;pcshow(points(:,:),pointshsv);view(2);xlabel('X');ylabel('Y');title('2D HSV original image')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pointsnewQ1=zeros(4,4000000);
pointsnewQ2=zeros(4,4000000);
pointsnewQ3=zeros(4,4000000);
Q1part1new5=zeros(3,4000000);
Q2part1new5=zeros(3,4000000);
Q3part1new5=zeros(3,4000000);
part1new3=zeros(3,4000000);
part1new7=zeros(3,4000000);
PQ1pointsnew5=zeros(4,4000000);
PQ2pointsnew5=zeros(4,4000000);
PQ3pointsnew5=zeros(4,4000000);
PQ1pointsnew3=zeros(4,4000000);
PQ1pointsnew7=zeros(4,4000000);

p5=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 1/5 1]; % f=5
p3=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 1/3 1]; % f=3
p7=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 1/7 1]; % f=7
Q1=[1 0 0 0;0 1 0 0;0 0 1 1000;0 0 0 1];% Qrcam
Q2=[0.866 0 -0.5 400; 0 1 0 0; 0.5 0 0.866 -600; 0 0 0 1];% QRcam2
Q3=[0.7071 0 0.7071 -1200; 0 1 0 0; -0.7071 0 0.7071 0; 0 0 0 1];% QRcam3
for j2=1:4000000
    pxyz1=[points(j2,:),1];
    pxyz1=pxyz1';
    pxyz2=[points(j2,:),5];
    pxyz2=pxyz2';
    PQ1pointsnew5(:,j2)=p5*(Q1*(pxyz1));
    PQ2pointsnew5(:,j2)=p5*((inv(Q2)*Q1)*(pxyz1));
    PQ3pointsnew5(:,j2)=p5*((inv(Q3)*Q1)*(pxyz1));
    PQ1pointsnew3(:,j2)=p3*(Q1*(pxyz1));
    PQ1pointsnew7(:,j2)=p7*(Q1*(pxyz1));
    Q1part1new5(1:2,j2)=PQ1pointsnew5(1:2,j2)/PQ1pointsnew5(4,j2);
    Q2part1new5(1:2,j2)=PQ2pointsnew5(1:2,j2)/PQ2pointsnew5(4,j2);
    Q3part1new5(1:2,j2)=PQ3pointsnew5(1:2,j2)/PQ3pointsnew5(4,j2);
    part1new3(1:2,j2)=PQ1pointsnew3(1:2,j2)/PQ1pointsnew3(4,j2);
    part1new7(1:2,j2)=PQ1pointsnew7(1:2,j2)/PQ1pointsnew7(4,j2);
end


normQ1=zeros(2,4000000);
normQ2=zeros(2,4000000);
normQ3=zeros(2,4000000);
normf3=zeros(2,4000000);
normf7=zeros(2,4000000);

for jj=1:4000000
    normQ1(1,jj)=((Q1part1new5(1,jj)+12.7/2)/12.7)*640;
    normQ1(2,jj)=((Q1part1new5(2,jj)+12.7/2)/12.7)*480;
    normQ2(1,jj)=((Q2part1new5(1,jj)+12.7/2)/12.7)*640;
    normQ2(2,jj)=((Q2part1new5(2,jj)+12.7/2)/12.7)*480;
    normQ3(1,jj)=((Q3part1new5(1,jj)+12.7/2)/12.7)*640;
    normQ3(2,jj)=((Q3part1new5(2,jj)+12.7/2)/12.7)*480;
    normf3(1,jj)=((part1new3(1,jj)+12.7/2)/12.7)*640;
    normf3(2,jj)=((part1new3(2,jj)+12.7/2)/12.7)*480;
    normf7(1,jj)=((part1new7(1,jj)+12.7/2)/12.7)*640;
    normf7(2,jj)=((part1new7(2,jj)+12.7/2)/12.7)*480;
end

norm2Q1=round(vertcat(normQ1(1,:),normQ1(2,:)));
norm2Q1=norm2Q1';
norm2Q2=round(vertcat(normQ2(1,:),normQ2(2,:)));
norm2Q2=norm2Q2';
norm2Q3=round(vertcat(normQ3(1,:),normQ3(2,:)));
norm2Q3=norm2Q3';
norm2f3=round(vertcat(normf3(1,:),normf3(2,:)));
norm2f3=norm2f3';
norm2f7=round(vertcat(normf7(1,:),normf7(2,:)));
norm2f7=norm2f7';



% background
pr=ones(480,640)*0.5;
pg=ones(480,640)*0.5;
pb=ones(480,640)*0.5;
background1=cat(3,pr,pg,pb);
background2=cat(3,pr,pg,pb);
background3=cat(3,pr,pg,pb);
background4=cat(3,pr,pg,pb);
background5=cat(3,pr,pg,pb);
background6=cat(3,pr,pg,pb);

for u=1:4000000
    background1(norm2Q1(u,2),norm2Q1(u,1),1)=pointsrgb(u,1);
    background1(norm2Q1(u,2),norm2Q1(u,1),2)=pointsrgb(u,2);
    background1(norm2Q1(u,2),norm2Q1(u,1),3)=pointsrgb(u,3);

    background4(norm2f3(u,2),norm2f3(u,1),1)=pointsrgb(u,1);
    background4(norm2f3(u,2),norm2f3(u,1),2)=pointsrgb(u,2);
    background4(norm2f3(u,2),norm2f3(u,1),3)=pointsrgb(u,3);
end
for u=1:4000000
    background6(norm2Q1(u,2),norm2Q1(u,1),1)=pointshsv(u,1);
    background6(norm2Q1(u,2),norm2Q1(u,1),2)=pointshsv(u,2);
    background6(norm2Q1(u,2),norm2Q1(u,1),3)=pointshsv(u,3);
end
figure;imshow(background6);xlabel('X');ylabel('Y');title('IM-Rcam1-HSV-f5-Q1')
figure;imshow(background1);xlabel('X');ylabel('Y');title('IM-Rcam1-RGB-f5-Q1')
figure;imshow(background4);xlabel('X');ylabel('Y');title('IM-Rcam1-RGB-f3-Q1')

for u=1:4000000
    if norm2Q2(norm2Q2(u,2)>0 && norm2Q2(u,2)<=480 && norm2Q2(u,1)>0 && norm2Q2(u,1)<=640)
        background2(norm2Q2(u,2),norm2Q2(u,1),1)=pointsrgb(u,1);
        background2(norm2Q2(u,2),norm2Q2(u,1),2)=pointsrgb(u,2);
        background2(norm2Q2(u,2),norm2Q2(u,1),3)=pointsrgb(u,3);
    end
end
figure;imshow(background2);xlabel('X');ylabel('Y');title('IM-Rcam2-RGB-f5-Q2')

for u=1:4000000
    if norm2Q3(norm2Q3(u,2)>0 && norm2Q3(u,2)<=480 && norm2Q3(u,1)>0 && norm2Q3(u,1)<=640)
        background3(norm2Q3(u,2),norm2Q3(u,1),1)=pointsrgb(u,1);
        background3(norm2Q3(u,2),norm2Q3(u,1),2)=pointsrgb(u,2);
        background3(norm2Q3(u,2),norm2Q3(u,1),3)=pointsrgb(u,3);
    end
end
figure;imshow(background3);xlabel('X');ylabel('Y');title('IM-Rcam3-RGB-f5-Q3')

 
for u=1:4000000
    if norm2f7(norm2f7(u,2)>0 && norm2f7(u,2)<=480 && norm2f7(u,1)>0 && norm2f7(u,1)<=640)
        background5(norm2f7(u,2),norm2f7(u,1),1)=pointsrgb(u,1);
        background5(norm2f7(u,2),norm2f7(u,1),2)=pointsrgb(u,2);
        background5(norm2f7(u,2),norm2f7(u,1),3)=pointsrgb(u,3);
    end
end
figure;imshow(background5);xlabel('X');ylabel('Y');title('IM-Rcam1-RGB-f7-Q1')

