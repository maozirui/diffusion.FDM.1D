# diffusion.FDM.1D

!!!!! IMPORTANT
This freeware is licensed under a Creative Commons Attribution 4.0 International License. 
By using this freeware, you are agree to the following:
   1. you are free to copy and redistribute the material in any medium or format.
   2. you are free to remix, transform, and build upon the material for any purpose, even commercially.
   3. You must provide the name of the creator and attribution parties, a copyright notice, a license notice, a  
      disclaimer notice, and a link to the material.
   4. Users are entirely at their own risk using this freeware and techniques. 
 Before use, please carefully read the License: 
 <a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
 
%%%%%%%%% Introduction:
% This script is developed to simulate the diffusion phenomenon governed %
% by the diffusion equation in 1D case.                                  % 
%                                                                        %
% %%%%%%%%% Numerical model:                                             %
%  /|\                             |                                     %
%   |                              |                                     %
%   |                              |                                     %
%   |                                                                    %
%   |                   ___________C2___________                         %
%   |                  |           |            |                        %
%   |                  |           |            |                        %
%   |                  |                        |                        %
%   |_______C1_________|<-------- w=f*L ------->|__________C1________    %
%   |                                                                    %
%   |<---------------------------- L ------------------------------->|   %
%   |__________________________________________________________________\ %
%   0                              |                                   / %
%                                  |                                     %
% %%%%%%%%% Governing equation:                                          %
%                                                                        %
%    dc         d^2(c)                                                   %
%   ---- = D * --------   (1)                                            %
%    dt         dx^2                                                     %
%                                                                        %
% where c = density of the diffusing material                            %
%       D = collective diffusion coefficient                             %
%       L = length of 1D domain                                          %
%       w = width of the central segment controlled by the factor f      %
%       f = ratio of the central segment to L.  Note: f in (0, 1)        %
%      C1 = one constant defining the initial c in both sides            %
%      C2 = another constant defining the initial c in central segment   %
%       T = total physical time in simulation                            %
% refer to: https://en.wikipedia.org/wiki/Diffusion_equation.            %
%                                                                        %
% %%%%%%%%% Boundary Conditions:                                         %
% Periodical boundary is applied to the both ending nodes, i.e.,         %
%      x(N) | x(1) x(2) .................. x(N-1) x(N) | x(1)            %
%                                                                        %
% %%%%%%%%% Finite Difference Approximation:                             %
% The second-order derivative of c in the govering equation (1) is       %
% approximated with the 2nd order accurate central Finite Difference     %
% scheme, i.e.,                                                          %
%                                                                        %
%  d^2(c)   c(i+1) - 2c(i) + c(i-1)                                      %
%  ------ = -----------------------                                      %
%   dx^2           (dx)^2                                                %
%                                                                        %
% %%%%%%%%% inputs:                                                      %
% L, T, D, C1, C2, f (all assigned value should be positive, f in(0,1))  %
%                                                                        %
% %%%%%%%%% other information:                                           %
% Author: Zirui Mao | Dep. of Material Science and Engineering |TAMU     %
% Date last modified: Jan., 20th, 2020                                   %
