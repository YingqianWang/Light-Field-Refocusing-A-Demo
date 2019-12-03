%% Code of Light Field Refocusing
%% Programmed by Yingqian Wang, NUDT, China
%% Email: wangyingqian16@nudt.edu.cn

%% Please cite our paper if you use this code.

% Y. Wang, J. Yang, Y. Guo, C. Xiao, and W. An, Selective Light Field
% Refocusing for Camera Arrays Using Bokeh Rendering and Superresolution,
% IEEE Signal Processing Letters, vol. 26, no. 1, 2019.
 
clear all
clc

path = './LegoKnights/';


files = dir(fullfile( path,'*.png'));
M= length(files);
angRes = sqrt(M);  % angular resolution

slope_begin = -5;  slope_end = 5;
depth_res = 10;

SLOPE = linspace(slope_begin, slope_end, depth_res);

for u = 1 : angRes
    for v = 1 : angRes
        k = (u-1)*angRes+v;
        I = imread([path, files(k).name]);
        LF_Image(u,v,:,:,:) = double(I);
    end
end

%% Refocusing

for ns = 1 :depth_res
    ns
    slope = SLOPE(ns);
    refocused_Im = refocus(LF_Image, slope);
    imwrite(uint8(refocused_Im), ['./Results/refocus_', num2str(ns,'%02d'), '.png']); 
end



