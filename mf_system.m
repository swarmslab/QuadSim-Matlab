% time
dt=0.1;
t=0:dt:10;

% parameters
params.m=1;
params.g=9.8;
params.rmin = 0;
params.ref = [2, 0]';
params.kp = [0.5, 0.1];

% initial conditions
x0 = [0, 0]';
dx0 = [0, 0]';

x = x0;
dx = dx0;

[T, X] = ode45(@(t, x) dynamics(t, x, params), [0, 10], x0, params);
plot(T, X(:,1))

% functions
function dx = dynamics(t, x, params)
    if x(1)>=params.rmin
        dx = [0, 0]';
        dx(1)=x(2);
        dx(2)=control(t, x, params)/params.m-params.g;
    else
        dx = [-x(2), 0]';
    end
end

function u = control(t, x, params)
    e = params.ref - x;
    u = params.kp*e + params.m * params.g;
end