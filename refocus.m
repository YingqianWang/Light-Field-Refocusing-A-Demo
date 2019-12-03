function refocused_Im = refocus(LF, slope)
[U, V, row, col, ~] = size(LF);
M = U * V;
LF_Image = zeros(M, row, col, 3);

for u = 1 : U
    for v = 1 : V
        k = (u-1)*V + v;
        LF_Image(k, :, :, :) = squeeze(LF(u, v, :, :, :)); 
    end
end

clear LF
shifted_Imr = zeros(M, row, col);
shifted_Img = zeros(M, row, col);
shifted_Imb = zeros(M, row, col);

VVec = linspace(-0.5,0.5, U) *(U-1)*slope;
UVec =  linspace(-0.5,0.5, V) *(V-1)*slope;
UMat = repmat(UVec, U, 1);
VMat = repmat(VVec, 1, V);
D = zeros(M, 2);
for i = 1 : M
    D(i,:) = [VMat(i),UMat(i)];
end

for k = 1 : M
    shifted_Imr(k ,:, :) = ImWarp(squeeze(LF_Image(k,:,:,1)), -D(k,1), -D(k,2));
    shifted_Img(k ,:, :) = ImWarp(squeeze(LF_Image(k,:,:,2)), -D(k,1), -D(k,2));
    shifted_Imb(k ,:, :) = ImWarp(squeeze(LF_Image(k,:,:,3)), -D(k,1), -D(k,2));
end
refocused_Im(:, :, 1) = sum(shifted_Imr, 1)/M;
refocused_Im(:, :, 2) = sum(shifted_Img, 1)/M;
refocused_Im(:, :, 3) = sum(shifted_Imb, 1)/M;
