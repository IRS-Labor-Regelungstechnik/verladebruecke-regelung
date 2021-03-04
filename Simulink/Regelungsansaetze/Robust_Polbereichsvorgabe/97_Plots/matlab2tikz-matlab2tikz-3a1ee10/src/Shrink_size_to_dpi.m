function Shrink_size_to_dpi



% Path to call cleanfigure.m, if same folder use pwd

path_to_cleanfigure = pwd;



current_path = pwd;



% get you maximum limits to adjust to printing dpi

dif = get(gca,'ylim');



max_dpi = 300;



% calculates minimum y_distance. Looses Information which will not be

% printed due to resolution issues

min_point_distance = (dif(2)-dif(1))/max_dpi;



cd(path_to_cleanfigure)



cleanfigure('minimumPointsdistance', min_point_distance);

matlab2tikz('width', '8in', 'height', '2in', 'standalone', true);



cd(current_path);