% Sphere A
m1 = 0.15; % cm^-1
R1 = 25; % mm

% Sphere B
m2 = 0.05; % cm^-1
R2 = 12; % mm

% Parallelogram
m = 0.1; % cm^-1
w = 256; % mm ---> x
h = 256; % mm ---> y
d = 128; % mm ---> z

% Create grids using ndgrid
[X, Y, Z] = ndgrid(1:w, 1:h, 1:d);

% Calculate distances for each sphere (from their center)
distanceA = sqrt((X - 96).^2 + (Y - 128).^2 + (Z - 64).^2);
distanceB = sqrt((X - 180).^2 + (Y - 128).^2 + (Z - 64).^2);

% Create matrix M to store attenuation coefficient.
M = m * ones(w, h, d); % initialize M to the atteniation coefficient of the parallelogram
M(distanceA <= R1) = m1; % if distanceA <= R1 == true : m1 is stored.
M(distanceB <= R2) = m2; % if distanceB <= R2 == true : m2 is stored.
% Else, the values of m don't change

% Case A (1000 photons per mm^2)
IoA= 1000; 
IdA = IoA * exp(-sum(M, 3) * 0.1); %instead of using 2 "for" loops, using sum(M,3) sums all the m's of the third dimention (d), returning a 2d array (w,h)
noiseA = poissrnd(IdA);
figure;
imshow([IdA, noiseA],[]);

% Case B (100 photons per mm^2)
IoB = 100; 
IdB = IoB * exp(-sum(M, 3) * 0.1);
noiseB = poissrnd(IdB);
figure;
imshow([IdB, noiseB],[]);




