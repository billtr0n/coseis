%------------------------------------------------------------------------------%
% Time integration

t  = t  + dt;
v  = v  + dt * w1;
u  = u  + dt * v;
sl = sl + dt * sv;

