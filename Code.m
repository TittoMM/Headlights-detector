clc;
clear all;
close all;
l=[];
F=[];
% a=arduino('COM10');
% configureDigitalPin(a,13,'output');
v=vision.VideoFileReader('D:\MATLAB\Projects\Al\20160403_230939_xvid.avi');
videoplayer=vision.VideoPlayer();
inform=info(v);
inform.VideoFrameRate=20;
% inform.VideoSize=[256 256];
roi=[875,500,200,110];
area=22000;
diag=228.2542;
for i=1:400
    frame{i,1}=step(v);
    i1=im2bw(frame{i,1},0.85);
%     F(i)=im2frame(frame{i,1});
    blob=vision.BlobAnalysis('BoundingBoxOutputPort',true, ...
    'AreaOutputPort', false, 'CentroidOutputPort',false, ...
    'MinimumBlobArea',1500);
bbox=step(blob,i1);
% for t=875:985
%     for j=500:700
%         l=[l;[t j]];
%     end
% end
result = insertShape(frame{i,1}, 'Rectangle', [bbox;roi] );
if isempty(bbox)==0
   % a.writeDigitalPin(13,1);% high if headlights deteced
else
   % a.writeDigitalPin(13,0)% low if headlight not detected
end
% figure,imshow(result);
step(videoplayer,result);
% if isempty(bbox)==0 
% %     if 
%     a.writeDigitalPin(13,1);% high if headlights deteced
% else
%     a.writeDigitalPin(13,0)% low if headlight not detected
% end
end
release(v);