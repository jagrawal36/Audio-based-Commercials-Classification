function [ match_result ] = match( querry, data, fs, matching_points )
%   match number of patches and give average of the max correlation found
%   for each patch
disp('matching...........');

match_result = zeros(1,matching_points);

% taking a 5s audio sample
patch_size = fs*0.5;

points = randi(length(querry)-patch_size,matching_points,1);

for pp = 1:length(points)
    point = points(pp);
    %disp('point = ');
    %point
    patch = querry(point:point+patch_size-1);

    %find corelation of patch with other possible patches throughout
    correlation = zeros(1,length(data));
    for i =1:5:length(data)-length(patch)
        r = corrcoef(patch, data(i:i+length(patch)-1));
        correlation(i) = r(1,2);
        %i=i+5;
    end
    [m,i] = max(correlation);
    %disp('result = ');
    %found = i
    match_result(pp) = m;
    
end


end

