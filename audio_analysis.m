% read the audio file
[y,fs] = audioread('12-21-15.wav');

% divide into segments of 20 seconds each
patch_size = fs*20;
extra = mod(length(y),patch_size);
patches = reshape(y(1:length(y)-extra),patch_size,(length(y)-extra)/patch_size);

%find corelation of each patch with other possible patches throughout
patch = patches(:,1);

correlation = zeros(1,length(y));
for i =1:5:length(y)-length(patch)
    disp('looping in');
    i
    r = corrcoef(patch, y(i:i+length(patch)-1));
    correlation(i) = r(1,2);
    %i=i+5;
end

