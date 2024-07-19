function [C1, C2] = lineEllipse(a, b, x0, y0, phi, p, q)
% Brief: Intersections of generalized ellipse and lines in Cartesian plane.
% This is an improved lineEllipse function, based on the work of Paurakh.
% See: Intersection of Line to Generalized Ellipse,
% (https://www.mathworks.com/matlabcentral/fileexchange/46954-intersection-
% of-line-to-generalized-ellipse)
% The improved lineEllipse function deals with the abnormal parameter input
% and improves the validity judgment of the intersection.
% INPUT :  a      - major axis of Ellipse.
%          b      - minor axis of Ellipse.
%          x0     - Abscissa of the center point of the ellipse.
%          y0     - Ordinate of the center point of the ellipse.
%          phi    - Angle (in radian) between x-axis and the major axis,
%                   counter-clockwise axis of rotation.
%          p, q   - line is defined by (x/p + y/q = 1), with p and q as
%                   x axis and y axis intercepts, p or q ∊ [-inf, inf].
% OUTPUT : C1, C2 - respectively the two points of intersection of line and
%                   ellipse are (C1, C2).
% POST CONDITION:
%        If (line does not intersect) NaN is returned.
%        If a single point of intersection, (C1) = (C2) or one of the point
%			is NaN.
%        If two points of intersetion, two distinct (C1) and (C2) returned.
% Copyright (c)2024, Aeron. Shanghai China.

%% Parameter of line
if(p == 0)
	m = -q/eps;
else
	m = -q/p;
end
c = q;

%% Parameter for ellipse
phi = -phi; % counter-clockwise from the x-axis
A = ( cos(phi)^2 / a^2  + sin(phi)^2 / b^2 );
B = - 2 * cos (phi) * sin(phi) * (1/a^2 - 1/b^2);
C = ( sin(phi)^2 / a^2  + cos(phi)^2 / b^2 );

%% Handle case with infinite slope
if (abs(q) == inf)
	% vertical line
	x1 = p;
	x2 = p;
	M = C;
	N = B*p-(2*C*y0+B*x0);
	O = A*p^2 - p*(2*A*x0 + y0*B) + (A*x0^2+B*x0*y0+C*y0^2-1);
	determinant = (N^2 - 4* M * O);
	y1  = (-N + sqrt(determinant))/ (2*M);
	y2  = (-N - sqrt(determinant))/ (2*M);
else
	M = A + B*m + C* m^2;
	N = B*c + 2*C*m*c - 2*A*x0 - y0*B - m* (2*C*y0+ B* x0);
	O = C*c^2 - c* (2*C*y0 + B*x0) + A*x0^2 + B*x0*y0 + C*y0^2 -1 ;

	determinant = (N^2 - 4* M * O);

	x1  = (- N + sqrt(determinant))/ (2*M);
	x2  = (- N - sqrt(determinant))/ (2*M);

	y1 = m*x1 + c;
	y2 = m*x2 + c;
end

C1 = [x1, y1];
C2 = [x2, y2];

%% Check if intersection points exists
if (~isreal(C1))
	C1 = [NaN, NaN]; % C1 is imaginary number.
end

if (~isreal(C2))
	C2 = [NaN, NaN]; % C2 is imaginary number.
end
end


