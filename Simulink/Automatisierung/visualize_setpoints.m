% param must be loaded from modell_parameter.m!

% 'true' if midpoints should be given between end points 
add_midpoints = true;

% Gripper length for midpoints. Set to -1 for max length that still prevents collision with other boxes
midpoint_height = -1;

[x, y, mag] = automation_setpoints(param, add_midpoints, midpoint_height, 50);

last_index = find(x==0,1)-1;
x = x(1:last_index);
y = y(1:last_index);
mag = mag(1:last_index);

y = param.gripper_max_length - y;

numpoints = 10000;
draw_x = zeros(1, (last_index-1)*numpoints);
draw_y = zeros(1, (last_index-1)*numpoints);
for i = 2:last_index
    draw_x(((i-2)*numpoints+1):((i-1)*numpoints)) = linspace(x(i-1),x(i),numpoints);
    draw_y(((i-2)*numpoints+1):((i-1)*numpoints)) = linspace(y(i-1),y(i),numpoints);
end
figure()
% pause(20);
comet(draw_x, draw_y)
