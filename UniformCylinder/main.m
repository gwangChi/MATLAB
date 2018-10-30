%{
 Description:   -Main program
 
 Updated:       10/18/2018

 Update Details:-
%}
% Simulation parameters
npoint = 2000;
nstep = 2000;
tstep = 0.05e-3;                                  
lstep = sqrt(6 * 10^(-9) * tstep);

wy = 125*2*pi;
wr = 300*2*pi;

% Cylinder parameters
cpos = {[0; 0]};
%cpos = {lcube*[-1/4; -1/4] lcube*[1/4; 1/4]};
%cpos = {lcube*[-1/4; -1/4] lcube*[1/4; -1/4] 
%        lcube*[1/4; 1/4] lcube*[-1/4; 1/4]};
%cpos = {lcube*[-1/3; -1/3] lcube*[0; -1/3] lcube*[1/3; -1/3] 
%        lcube*[1/3; 0] lcube*[1/3; 1/3] lcube*[0; 1/3] 
%        lcube*[-1/3; 1/3] lcube*[-1/3; 0] lcube*[0; 0]};
gamma = 42.57748e6 * 2 * pi;                        
chi = 0.15e-6;                                      
y = 0.70;                                           
w0 = 7 * gamma;                                     
rcyl = 9e-6;                                        
bfr = 0.04;                                         
lcube = sqrt(3.1415926 * rcyl^2 / bfr);             

% Assign initial random positions
pos = zeros(3, npoint);
pos(:, :) = rand([3 npoint])*lcube - ones([3 npoint])*lcube/2;  

% Record the dipolar field during diffusion
w = zeros(3, npoint, nstep);
for curr_s = 1 : nstep
    for curr_p = 1 : npoint
        w(3, curr_p, curr_s) = getField(pos(:, curr_p), pi/2, chi, y, w0, rcyl, cpos);
        pos(:, curr_p) = randWalk(pos(:, curr_p), lstep, lcube, rcyl, cpos);
    end
end
clear pos;

% Add CWy to the B matrix
w(2, :, :) = wy * ones([npoint nstep]);

% Assign initial magnetizations
m0 = reshape([zeros([1 npoint]); zeros([1 npoint]); ones([1 npoint])], 3*npoint, 1);

% Evolve the mags
tspan = [0:0.01e-4:0.090];
[t,m] = ode45(@(t,m) blochSolver(t, m, tstep, npoint, w, wr), tspan, m0);

ms = reshape(m, size(m,1), 3, npoint);
m_=mean(ms,3);

figure
[X,Y,Z] = sphere;
mesh(X,Y,Z,'EdgeColor',[0.9 0.9 0.9],'FaceColor','none');
hold on
plot3(m_(:,1), m_(:,2), m_(:,3));