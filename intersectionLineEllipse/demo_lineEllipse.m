%%
% 这是个改进的lineEllipse函数，基于Paurakh的工作成果。具体参见：Intersection of Line to Generalized Ellipse，
% (https://www.mathworks.com/matlabcentral/fileexchange/46954-intersection-of-line-to-generalized-ellipse)，
% MATLAB Central File Exchange.
% 本demo生成一个随机的椭圆和直线，并计算交点。改进的lineEllipse函数处理了异常参数输入，并且改进了交点有效性判断。
%%
% This is an improved lineEllipse function, based on the work of Paurakh.
% See: Intersection of Line to Generalized Ellipse,
% (https://www.mathworks.com/matlabcentral/fileexchange/46954-intersection-of-line-to-generalized-ellipse),
% MATLAB Central File Exchange.
% This demo generates a random ellipse and line and calculates the intersection points.
% The improved lineEllipse function deals with the abnormal parameter input and improves the validity
% judgment of the intersection.
% Copyright (c)2024, Aeron. Shanghai China.

%%
% if a = b, we get circle
ab = randperm(10,2);
a = max(ab); % some random major axis
b = min(ab); % some random minor axis

% random center of ellipse
O = rand(2,1);

% rotation angle
phi = rand(1)*2*pi - pi;

% Two random intercept for stright line
p = randperm(20,1) - 10;
q = randperm(20,1) - 10;

% Get intersection poins
[C1,C2] = lineEllipse(a,b,O(1),O(2),phi,p,q);

fprintf("a=%.1f; b=%.1f; O=[%.1f, %.1f]; phi=%.1f; p=%.1f; q=%.1f; C1=[%.1f, %.1f], C2=[%.1f, %.1f]\r\n", ...
	a,b,O(1),O(2),phi,p,q,C1(1),C1(2),C2(1),C2(2));

% figure
clf
h=gca;
h.YAxisLocation = 'origin';
h.XAxisLocation = 'origin';
axis([-20 20 -15 15], 'equal')
hold on

% plot line
fimplicit(@(x,y) x/p + y/q - 1, 'Color', "#4DBEEE")
plot([C1(1), C2(1)], [C1(2), C2(2)], 'Color', "#D95319")

% plot ellipse without rotatation
th = linspace(0,2*pi);
x = O(1)+a*cos(th) ;
y = O(2)+b*sin(th) ;
plot(x,y, 'Color', "#DDDDDD")

% plot rotate ellipse
try
	ellipse(a,b,phi,O(1),O(2), "#FF00FF");
catch
	warning("Can't find function ellipse!")
	disp("ellipse draw function refer to : ")
	disp("David Long (2024).  ellipse.m")
	disp("https://www.mathworks.com/matlabcentral/fileexchange/289-ellipse-m")
	disp("MATLAB Central File Exchange. ")
end

% plot intersection points
scatter([C1(1), C2(1), O(1)], [C1(2), C2(2), O(2)], 'MarkerEdgeColor', "#A2142F");

drawnow

