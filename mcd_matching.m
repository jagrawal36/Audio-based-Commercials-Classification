[y1,fs] = audioread('mcd1.mp3');
yy1 = downsample(y1, 10, 2); clear y1;
[y2,fs] = audioread('mcd3.mp3');
yy2 = downsample(y2, 10, 2); clear y2;
[y3,fs] = audioread('mcd4.mp3');
yy3 = downsample(y3, 10, 2); clear y3;
[y4,fs] = audioread('mcd5.mp3');
yy4 = downsample(y4, 10, 2); clear y4;
[y5,fs] = audioread('kfc1.mp3');
yy5 = downsample(y5, 10, 2); clear y5;
[y6,fs] = audioread('bk1.mp3');
yy6 = downsample(y6, 10, 2); clear y6;
[y7,fs] = audioread('bud1.mp3');
yy7 = downsample(y7, 10, 2); clear y7;
[y8,fs] = audioread('ph1.mp3');
yy8 = downsample(y8, 10, 2); clear y8;
[y9,fs] = audioread('wdy1.mp3');
yy9 = downsample(y9, 10, 2); clear y9;
[y10,fs] = audioread('tb1.mp3');
yy10= downsample(y10,10, 2); clear y10;


leng = max([length(yy1),length(yy2),length(yy3),length(yy4),length(yy5),
    length(yy6),length(yy7),length(yy8),length(yy8),length(yy10)])

data = zeros(10,leng);
lengths = [length(yy1),length(yy2),length(yy3),length(yy4),length(yy5),
    length(yy6),length(yy7),length(yy8),length(yy9),length(yy10)];

data(1,1:length(yy1)) = yy1;
data(2,1:length(yy2)) = yy2;
data(3,1:length(yy3)) = yy3;
data(4,1:length(yy4)) = yy4;
data(5,1:length(yy5)) = yy5;
data(6,1:length(yy6)) = yy6;
data(7,1:length(yy7)) = yy7;
data(8,1:length(yy8)) = yy8;
data(9,1:length(yy9)) = yy9;
data(10,1:length(yy10)) = yy10;

clear yy1,yy2,yy3,yy4,yy5,yy6,yy7,yy8,yy9,yy10;
acc = [];
snr_test = [1, 0.5, 0.3, 0.1, 0.01, 0.005, 0.001]
for snr_count = length(snr_test):-1:1
    snr = snr_test(snr_count)

    accuracy = zeros(1,5);
    
    signal = data;
    for lp = 1:5
        sp = rms(data(lp,1:lengths(lp)));
        n = (sp/snr)*randn(1,lengths(lp));
        
        signal(lp,1:lengths(lp)) = signal(lp,1:lengths(lp)) + n;

        result1 = match(signal(lp,1:lengths(lp)), data(1,1:lengths(1)), fs, 2);
        result2 = match(signal(lp,1:lengths(lp)), data(2,1:lengths(2)), fs, 2);
        result3 = match(signal(lp,1:lengths(lp)), data(3,1:lengths(3)), fs, 2);
        result4 = match(signal(lp,1:lengths(lp)), data(4,1:lengths(4)), fs, 2);
        result5 = match(signal(lp,1:lengths(lp)), data(5,1:lengths(5)), fs, 2);

        %{
        result1 = match(yy1,yy1,fs,5);
        result2 = match(yy1,yy2,fs,5);
        result3 = match(yy1,yy3,fs,5);
        result4 = match(yy1,yy4,fs,5);
        result5 = match(yy1,yy5,fs,5);
        %}

        m1 = mean(result1);
        m2 = mean(result2);
        m3 = mean(result3);
        m4 = mean(result4);
        m5 = mean(result5);

        [m,i] =  max([m1,m2,m3,m4,m5]);
        if i == lp
            accuracy(lp) = 1;
        end
        accuracy;
        
    end
    acc = [acc, mean(accuracy)]
end