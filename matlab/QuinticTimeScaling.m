function s = QuinticTimeScaling(Tf, t)
% QUINTICTIMESCALING Fifth-order polynomial time scaling.
%
% s(0) = 0, s(Tf) = 1
% s_dot(0) = s_dot(Tf) = 0
% s_ddot(0) = s_ddot(Tf) = 0

tau = t / Tf;
s = 10 * tau^3 - 15 * tau^4 + 6 * tau^5;

end
