function  OpIm = ImWarp(IpIm, x, y)
% x--horizontal shift;       y--vertical shift
sm = max(abs(floor(x))+1, abs(floor(y))+1);
Mask = zeros(2*sm+1, 2*sm+1);
X = floor(x); fx = x-X;
Y = floor(y); fy = y-Y;
Center = sm + 1;
Mask(Center+Y, Center+X) = (1-fx)*(1-fy);
Mask(Center+Y, Center+X+1) = fx*(1-fy);
Mask(Center+Y+1, Center+X) = fy*(1-fx);
Mask(Center+Y+1, Center+X+1) = fx*fy;
OpIm = imfilter(IpIm, Mask,  'symmetric' );