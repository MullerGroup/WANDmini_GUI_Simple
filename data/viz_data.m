close all
clear
clc

file = uigetfile('./*.mat');
raw = load(file);

clean = raw.raw;
firstClean = find(raw.crc == 0,1);
for i = 1:(firstClean-1)
    clean(i,:) = clean(firstClean,:);
end
crcIdx = find(raw.crc);
crcIdx(crcIdx < firstClean) = [];
for i = 1:length(crcIdx)
    clean(crcIdx,:) = clean(crcIdx-1,:);
end

emg = clean(:,1:64);
temp = uint16(clean(:,65:67));
acc = zeros(size(temp));
for ch = 1:3
    acc(:,ch) = double(typecast(temp(:,ch),'int16'));
end

figure
subplot(2,1,1)
plot(emg)
subplot(2,1,2)
plot(acc)