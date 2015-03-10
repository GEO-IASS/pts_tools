function PTS = ReadFullPTS(ptsfile, calc_dist)
% ReadFullPTS - Read a full PTS file with point cloud data into memory
%
% PTS = ReadFullPTS(ptsfile, calc_dist)
%
% Input:
%   ptsfile = the path of the input PTS file
%   calc_dist = boolean to indicate whether to calculate the distance or
%               not (a non zero value means yes, default = yes)
%
% Output:
%   PTS: structure array with data from the PTS file
%
%   with fields:
%     X, Y, Z = coordinates
%     I = Intensity (optional)
%     N = number of data records
%     R, G, B = red, green and blue values (optional)
%     DXY = 2D euclidian distance vector (optional)
%     DXYZ = 3D euclidian distance vector (optional)

if nargin < 2
  calc_dist = 1;
end

fin = fopen(ptsfile);

% The first line in a PTS file should be the number of data lines
N = str2double(fgetl(fin));

% Read the rest of the file into nlines-by-7 cell array called PTS
% 7 columns: X, Y, Z, I, R, G, B
data = textscan(fin, '%f %f %f %d16 %d16 %d16 %d16');

fclose(fin);

% Simple validity check on the input PTS file
assert(length(data{1}) == N, 'Number of lines not conform the header')

% When only intensity in one column is given in the input PTS file, remove
% the empty columns 5,6 and 7.
if unique(data{5}) == 0 & unique(data{6}) == 0 & unique(data{7}) == 0
  data(7) = [];
  data(6) = [];
  data(5) = [];
end

if calc_dist
  DXY = sqrt(data{1}.^2 + data{2}.^2);
  DXYZ = sqrt(data{1}.^2 + data{2}.^2 + data{3}.^2);
end

% Create the structure array with output data
if size(data, 2) == 4
  PTS = cell2struct(data, {'X', 'Y', 'Z', 'I'}, 2);
elseif size(data, 2) == 7
  PTS = cell2struct(data, {'X', 'Y', 'Z', 'I', 'R', 'G', 'B'}, 2);
end

PTS.N = N;
if exist('DXY', 'var'); PTS.DXY = DXY; end
if exist('DXYZ', 'var'); PTS.DXYZ = DXYZ; end
