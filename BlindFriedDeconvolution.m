function [u,cn2,tvi]=BlindFriedDeconvolution(f,D,L,wavelength,mu,lambda,Niter)

%=========================================================================
%
%  [u,cn2,tvi]=BlindFriedDeconvolution(f,D,L,wavelength,mu,lambda,Niter)
%
%  This function performs the semi-blind Fried deconvolution: we estimate
%  the best value of the Cn2 (reflective structure index). All the other
%  parameters are assumed to be known.
%
%  INPUT PARAMETERS:
%  f : input image which needs to be deconvolved
%  D : entrance pupille diameter of the imaging system
%  L : distance between the scene and the sensor
%  wavelength : wavelength in which the imaging system is working on
%  mu, lambda : framelet regularization parameters (mu=1000 and lambda=10
%               are typical values)
%  Niter: number of iteration for the framelet deconvolution (typically
%         Niter=3-10 depending on the image)
%
%  OUTPUT PARAMETERS:
%  u = deconvolved image
%  cn2 = estimated Cn2 value
%  tvi = the polynomial approximated TV curve
%
%  Author: J.Gilles
%  Institution: UCLA - Dept of Mathematics
%  email: jegilles@math.ucla.edu
%  Date: July 12, 2011 - update on June 23, 2016
%
%=========================================================================


N=size(f,1); %we assume a square image
Ncn2 = 10; % number of point to evaluate

% Set the range of CN2
cn2min=0.5e-14;
cn2max=2.5e-13;

% Variable initialization
Vcn2=cn2min:(cn2max-cn2min)/(Ncn2-1):cn2max;
tv=zeros(1,Ncn2);

%we compute the equispaced points of the TV curve
for k=1:Ncn2
    FK=fftshift(FriedKernel(D,L,wavelength,Vcn2(k),N));
    res=Framelet_NB_Deconvolution(f,FK,mu,lambda,Niter,0,3,1);
    tv(k)=TVnorm(res);
end

% We fit a polynomial approximation of the TV curve
%[p,s] = polyfit(Vcn2,tv,5);
p = polyfit(Vcn2,tv,5);

% We generate 1000 points of the approximated TV curve
clear Vcn2;
Vcn2=cn2min:(cn2max-cn2min)/1000:cn2max;
tvi = polyval(p,Vcn2);
% We find the evaluated CN2 from the maximum of the TV curve
[~,index]=max(tvi);
cn2=Vcn2(index);

% We do the final restoration
FK=fftshift(FriedKernel(D,L,wavelength,cn2,N));
u=Framelet_NB_Deconvolution(f,FK,mu,lambda,Niter,0,3,1);
