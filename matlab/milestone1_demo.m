% MILESTONE1_DEMO Example script for MAE 204 Milestone 1.
%
% This script generates an 8-segment reference end-effector trajectory
% and writes it to a CSV file in the required 13-column format:
% r11,r12,r13,r21,r22,r23,r31,r32,r33,px,py,pz,gripper

clear; clc;

% Given/default capstone-style frames
Tse_initial = [0, 0, 1, 0.0;
               0, 1, 0, 0.0;
              -1, 0, 0, 0.5;
               0, 0, 0, 1.0];

Tsc_initial = [1, 0, 0, 1.0;
               0, 1, 0, 0.0;
               0, 0, 1, 0.025;
               0, 0, 0, 1.0];

Tsc_final = [0, 1, 0, 0.0;
            -1, 0, 0, -1.0;
             0, 0, 1, 0.025;
             0, 0, 0, 1.0];

Tce_grasp = [-1 / sqrt(2), 0,  1 / sqrt(2), 0.0;
              0,            1,  0,           0.0;
             -1 / sqrt(2), 0, -1 / sqrt(2), 0.0;
              0,            0,  0,           1.0];

Tce_standoff = Tce_grasp;
Tce_standoff(3, 4) = 0.2;

k = 1;

traj = TrajectoryGenerator(Tse_initial, Tsc_initial, Tsc_final, ...
                           Tce_grasp, Tce_standoff, k);

outputFile = "milestone1_trajectory.csv";
writematrix(traj, outputFile);

fprintf("Wrote %d rows to %s\n", size(traj, 1), outputFile);
