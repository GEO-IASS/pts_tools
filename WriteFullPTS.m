function WriteFullPTS(PTS, pts_filename)
% WriteFullPTS - Write a full PTS file with point cloud data from memory
%
% WriteFullPTS(data)
%
% Input:
%   data = the path of the input PTS file
%   pts_filename = name of the PTS file to be written

f = fopen(pts_filename, 'w');

fprintf(f, '%d\r\n', PTS.N);

if isfield(PTS, {'X', 'Y', 'Z', 'I'})
  data = [PTS.X'; PTS.Y'; PTS.Z'; double(PTS.I')];
  fprintf(f, '%.4f %.4f %.4f %d\r\n', data);
end

fclose(f);
