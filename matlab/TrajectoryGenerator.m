function traj = TrajectoryGenerator(Tse_initial, Tsc_initial, Tsc_final, Tce_grasp, Tce_standoff, k)
% TRAJECTORYGENERATOR Build the 8-segment Milestone 1 reference trajectory.
%
% Inputs:
%   Tse_initial   - Initial end-effector configuration in {s}
%   Tsc_initial   - Initial cube configuration in {s}
%   Tsc_final     - Final cube configuration in {s}
%   Tce_grasp     - End-effector configuration relative to cube when grasping
%   Tce_standoff  - End-effector standoff configuration relative to cube
%   k             - Number of trajectory reference points per 0.01 s
%
% Output:
%   traj          - Nx13 matrix, each row:
%                   r11 r12 r13 r21 r22 r23 r31 r32 r33 px py pz gripper
%
% Example:
%   k = 1;
%   traj = TrajectoryGenerator(Tse_initial, Tsc_initial, Tsc_final, ...
%                              Tce_grasp, Tce_standoff, k);
%   writematrix(traj, "milestone1_trajectory.csv");

if ~(isscalar(k) && k >= 1 && floor(k) == k)
    error("k must be an integer >= 1.");
end

method = 5;  % Quintic time scaling for smoother segment transitions.

% Segment durations (seconds).
t1 = 4.0;    % Move to initial standoff
t2 = 1.0;    % Move down to grasp
t3 = 0.65;   % Close gripper (>= 0.63 s recommended)
t4 = 1.0;    % Move back up to standoff
t5 = 4.0;    % Move to final standoff
t6 = 1.0;    % Move down to place
t7 = 0.65;   % Open gripper (>= 0.63 s recommended)
t8 = 1.0;    % Move back up to final standoff

pointsFromDuration = @(Tf) max(2, ceil((Tf / 0.01) * k));

Tse_standoff_initial = Tsc_initial * Tce_standoff;
Tse_grasp_initial = Tsc_initial * Tce_grasp;
Tse_standoff_final = Tsc_final * Tce_standoff;
Tse_grasp_final = Tsc_final * Tce_grasp;

traj = zeros(0, 13);

% 1) Initial -> standoff above initial cube (open)
seg = ScrewTrajectory(Tse_initial, Tse_standoff_initial, t1, pointsFromDuration(t1), method);
traj = appendSE3Segment(traj, seg, 0);

% 2) Standoff -> grasp pose (open)
seg = ScrewTrajectory(Tse_standoff_initial, Tse_grasp_initial, t2, pointsFromDuration(t2), method);
traj = appendSE3Segment(traj, seg, 0);

% 3) Hold grasp pose while closing gripper (closed)
traj = appendHoldSegment(traj, Tse_grasp_initial, t3, k, 1);

% 4) Grasp pose -> standoff above initial cube (closed)
seg = ScrewTrajectory(Tse_grasp_initial, Tse_standoff_initial, t4, pointsFromDuration(t4), method);
traj = appendSE3Segment(traj, seg, 1);

% 5) Initial standoff -> final standoff (closed)
seg = ScrewTrajectory(Tse_standoff_initial, Tse_standoff_final, t5, pointsFromDuration(t5), method);
traj = appendSE3Segment(traj, seg, 1);

% 6) Final standoff -> final place pose (closed)
seg = ScrewTrajectory(Tse_standoff_final, Tse_grasp_final, t6, pointsFromDuration(t6), method);
traj = appendSE3Segment(traj, seg, 1);

% 7) Hold place pose while opening gripper (open)
traj = appendHoldSegment(traj, Tse_grasp_final, t7, k, 0);

% 8) Final place pose -> final standoff (open)
seg = ScrewTrajectory(Tse_grasp_final, Tse_standoff_final, t8, pointsFromDuration(t8), method);
traj = appendSE3Segment(traj, seg, 0);

end

function traj = appendSE3Segment(traj, segCells, gripperState)
% Append ScrewTrajectory cells as rows. If this is not the first segment,
% drop the first SE(3) waypoint to avoid duplicated boundaries.
startIdx = 1;
if ~isempty(traj)
    startIdx = 2;
end
for i = startIdx:numel(segCells)
    traj(end + 1, :) = se3ToRow(segCells{i}, gripperState); %#ok<AGROW>
end
end

function traj = appendHoldSegment(traj, T, holdTime, k, gripperState)
% Append constant-pose rows for gripper open/close dwell.
nHold = max(2, ceil((holdTime / 0.01) * k));
row = se3ToRow(T, gripperState);
holdRows = repmat(row, nHold, 1);
traj = [traj; holdRows]; %#ok<AGROW>
end

function row = se3ToRow(T, gripperState)
R = T(1:3, 1:3);
p = T(1:3, 4);
row = [R(1, :), R(2, :), R(3, :), p.', gripperState];
end
