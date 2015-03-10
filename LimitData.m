function PTS = LimitData(PTS, Field, Min, Max)
% LimitData - Removes data outside the given limits of a specified field
%
% Example:
%
%   PTS = LimitData(PTS, 'D', 0, 5)
%
%   This will remove data from the PTS structure array for distances
%   larger than or equal to 0m and smaller than or equal to 5 meters.

fields = fieldnames(PTS);

if isfield(PTS, Field)
  Index = PTS.(Field) >= Min & PTS.(Field) <= Max;
  Size = size(PTS.(Field));
  for i = 1:numel(fields)
    if fields{i} == 'N'
      PTS.N = nnz(Index);
    elseif size(PTS.(fields{i})) == Size
      PTS.(fields{i}) = PTS.(fields{i})(Index);
    end
  end
else
  disp([Field, ' is not a valid field'])
end
