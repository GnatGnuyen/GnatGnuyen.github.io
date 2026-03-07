function traj = ScrewTrajectory(Xstart, Xend, Tf, N, method)
% SCREWTRAJECTORY Generate N SE(3) waypoints using screw interpolation.
%
% Inputs:
%   Xstart - Initial end-effector configuration (4x4 in SE(3))
%   Xend   - Final end-effector configuration (4x4 in SE(3))
%   Tf     - Total trajectory duration in seconds
%   N      - Number of sampled trajectory points (N > 1)
%   method - 3 for cubic time scaling, 5 for quintic time scaling
%
% Output:
%   traj   - 1xN cell array of SE(3) matrices

timegap = Tf / (N - 1);
traj = cell(1, N);
for i = 1:N
    if method == 3
        s = CubicTimeScaling(Tf, timegap * (i - 1));
    else
        s = QuinticTimeScaling(Tf, timegap * (i - 1));
    end
    traj{i} = Xstart * MatrixExp6(MatrixLog6(TransInv(Xstart) * Xend) * s);
end

end
