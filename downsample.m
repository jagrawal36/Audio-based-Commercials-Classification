function [ y_out ] = downsample( y_in, downsample_ratio, average_points )
%UNTITLED4 Summary of this function goes here
%   average points = 0.5 of tatal number of points taken for average

p = fix(length(y_in)/10);
y_out = zeros(1,p);
for i = 1:10:length(y_in)
    i;
    if ((i-average_points) < 0)
        y_out(i) = y_in(i);
    else
        temp = sum(y_in(i-average_points:i+average_points));
        temp = temp/(2*average_points+1);
        y_out(fix(i/10)+1) = temp;
    end
end

