function s = CubicTimeScaling(Tf, t)
% CUBICTIMESCALING Third-order polynomial time scaling.
%
% s(0) = 0, s(Tf) = 1, s_dot(0) = s_dot(Tf) = 0

tau = t / Tf;
s = 3 * tau^2 - 2 * tau^3;

end
