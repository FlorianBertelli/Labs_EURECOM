 %Matlab-Programming
clear all;
close all;
list_harmonic_frequency= [] ;
i=1 ;


for name= ["string1.mp3" , "string2.mp3" , "string3.mp3"]

    [x,fs]=audioread(name);

    x = x(:,1);
    y = fft(x);

    n = length(x);          % number of samples
    f = (0:n-1)*(fs/n);     % frequency range
    power = abs(y).^2/n;    % power of the DFT

    figure;
    plot(f(1:floor(n/2)),power(1:floor(n/2)));
  
    xlabel('Frequency');
    ylabel('Power');

    [a , loc]= findpeaks(power, 'Threshold', 0.1,'NPeaks',1);

    harmonic_frequency = loc * fs/n;
    
    list_harmonic_frequency(i) =  harmonic_frequency;
    i = i +1 ;
end

keySet = [329.63 , 246.94  , 196.00 , 146.83 , 110.00 , 82.41];
valueSet = [0.15,0.15,0.15,0.08,0.08,0.04];
note = ["E1" , "B2" , "G3", "D4", "A5" , "E6"];
%c = containers.Map (keySet , valueSet)


for frequency = list_harmonic_frequency
    dist    = abs(keySet - frequency);
    minDist = min(dist);
    idx     = find(dist == minDist);
    cent_accuracy = minDist/valueSet(idx);
    A = ['The note is ' ,note(idx) , 'with an accuracy of', cent_accuracy  ,'cent'];
    disp(A);
end