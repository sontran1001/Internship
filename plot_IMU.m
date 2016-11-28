clc
clear all
close all
%% Import data from text file.
%% Initialize variables.
filename = 'C:\Users\SONTRAN\Desktop\Internship\Data-Log\log23112016\Log 2016-11-23 12_31_34.txt';
delimiter = {'\t',' ',':','-'};
startRow = 400;
endRow = 1500;

%% Format string for each line of text:

% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.

%% Create output variable
Log = table(dataArray{1:end-1}, 'VariableNames', {'nRF','Connect','VarName3','VarName4','VarName16','VarName17','VarName18','VarName19','VarName20','VarName21','VarName22','VarName23','VarName24','VarName25','VarName26','VarName27','VarName28','VarName29','VarName30','VarName31','VarName32','VarName33'});

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;
log_id = Log(1:2:(endRow-startRow),:);

%% Calculate rotation, unit deg/s, range -250, +250
% gyro X
gyroX1 = log_id.VarName16;
gyroX2 = log_id.VarName17;
gyroX = strcat(gyroX2,gyroX1);
gyroX = typecast(uint16(base2dec(gyroX, 16)), 'int16');
gyroX = double(gyroX);
gyroX = (gyroX * 1.0) / (65536 / 500);
% gyro Y
gyroY1 = log_id.VarName18;
gyroY2 = log_id.VarName19;
gyroY = strcat(gyroY2,gyroY1);
gyroY = typecast(uint16(base2dec(gyroY, 16)), 'int16');
gyroY = double(gyroY);
gyroY = (gyroY * 1.0) / (65536 / 500);
% gyro Z
gyroZ1 = log_id.VarName20;
gyroZ2 = log_id.VarName21;
gyroZ = strcat(gyroZ2,gyroZ1);
gyroZ = typecast(uint16(base2dec(gyroZ, 16)), 'int16');
gyroZ = double(gyroZ);
gyroZ = (gyroZ * 1.0) / (65536 / 500);

%% Calculate acceleration, unit G, range -2, +2
% acc X
accX1 = log_id.VarName22;
accX2 = log_id.VarName23;
accX = strcat(accX2,accX1);
accX = typecast(uint16(base2dec(accX, 16)), 'int16');
accX = double(accX);
accX = (accX * 1.0) / (32768/2);
% acc Y
accY1 = log_id.VarName24;
accY2 = log_id.VarName25;
accY = strcat(accY2,accY1);
accY = typecast(uint16(base2dec(accY, 16)), 'int16');
accY = double(accY);
accY = (accY * 1.0) / (32768/2);
% acc Z
accZ1 = log_id.VarName26;
accZ2 = log_id.VarName27;
accZ = strcat(accZ2,accZ1);
accZ = typecast(uint16(base2dec(accZ, 16)), 'int16');
accZ = double(accZ);
accZ = (accZ * 1.0) / (32768/2);

%% Calculate magnetism, unit uT, range +-4900
% mag X
magX1 = log_id.VarName28;
magX2 = log_id.VarName29;
magX = strcat(magX2,magX1);
magX = typecast(uint16(base2dec(magX, 16)), 'int16');
magX = double(magX);
magX = 1.0 * magX;
% mag Y
magY1 = log_id.VarName30;
magY2 = log_id.VarName31;
magY = strcat(magY2,magY1);
magY = typecast(uint16(base2dec(magY, 16)), 'int16');
magY = double(magY);
magY = 1.0 * magY;
% mag Z
magZ1 = log_id.VarName32;
magZ2 = log_id.VarName33;
magZ = strcat(magZ2,magZ1);
magZ = typecast(uint16(base2dec(magZ, 16)), 'int16');
magZ = double(magZ);
magZ = 1.0 * magZ;
% calculate time in second
time = log_id.VarName3*60 + log_id.VarName4;

%% Plot results
% Gyro
figure(1)
plot(time,gyroX,'r');
title('Gyro X');
grid on
figure(2)
plot(time,gyroY,'b');
title('Gyro Y');
grid on
figure(3)
plot(time,gyroZ,'g');
title('Gyro Z');
grid on

% Acc
figure(4)
plot(time,accX,'r');
title('Acc X');
grid on
figure(5)
plot(time,accY,'b');
title('Acc Y');
grid on
figure(6)
plot(time,accZ,'g');
title('Acc Z');
grid on
% Mag
figure(7)
plot(time,magX,'r');
title('Mag X');
grid on
figure(8)
plot(time,magY,'b');
title('Mag y');
grid on
figure(9)
plot(time,magZ,'g');
title('Mag Z');
grid on

