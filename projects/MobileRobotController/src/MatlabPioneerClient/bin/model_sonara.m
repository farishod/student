function model = model_sonara(sonars2, ranges2, theta, SCALE, max_udaljenost)
B = 7;
R = ceil(max_udaljenost/SCALE-3);
TOLERANCE = 1;
MAXOCCUPIED = 0.98;
model_size = 59;
model = zeros(model_size, model_size);
model(:,:)= NaN;
a = -theta/180*pi; 
T = [cos(a) -sin(a) ; sin(a) cos(a)];
%sonars = sonarSensorPositions;
% Remove out of range sensors
tmp = []; 
tmp2 = [];
for si = 1:length(sonars2)
if ranges2(si) < max_udaljenost
tmp = [tmp; sonars2(si,:)];
tmp2 = [tmp2; ranges2(si)];
end
end
if size(tmp, 1) == 0
return
end
sonars = tmp;
ranges = tmp2 ./ SCALE;
sonars(:,1:2) = sonars(:,1:2)*T ./ SCALE;
sonars(:,3) = sonars(:,3) + theta;
for yi = 1:model_size
for xi = 1:model_size
for si = 1:size(sonars, 1)
x = xi - model_size / 2;
y = yi - model_size / 2;
% optimized version of norm()
r = ((x - sonars(si,1))^2 + (y - sonars(si,2))^2)^0.5;
b = abs(atan2(y - sonars(si,2), x - sonars(si,1)) / pi * 180 - sonars(si,3));
while b > 180
b = abs(b - 360);
end
if b > B || r > ranges(si) + TOLERANCE/2
continue
end
if abs(r - ranges(si)) <= TOLERANCE
psn = ((((R - r) / R) + ((B-b) / B)) / 2) * MAXOCCUPIED;
psn = 0.5 * psn + 0.5;
else
psn = (((R - r) / R) + ((B-b) / B)) / 2;
psn = 1 - (0.5 * psn + 0.5);
end
model(xi, yi) = psn;
end
end
end