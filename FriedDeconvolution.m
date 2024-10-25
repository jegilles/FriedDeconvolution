function u=FriedDeconvolution(f,D,L,cn2,wavelength,mu,lambda,Niter)

%=========================================================================
%
%  u=FriedDeconvolution(f,D,L,cn2,wavelength,mu,lambda,Niter)
%
%  This function performs the non-blind Fried deconvolution: All parameters 
%  are assumed to be known.
%
%  INPUT PARAMETERS:
%  f : input image which needs to be deconvolved
%  D : entrance pupille diameter of the imaging system
%  L : distance between the scene and the sensor
%  cn2: Cn2 parameter corresponding to the turbulence degree
%  wavelength : wavelength in which the imaging system is working on
%  mu, lambda : framelet regularization parameters (mu=10^7 and lambda=100
%               are typical values)
%  Niter: number of iteration for the framelet deconvolution (typically
%         Niter=3-10 depending on the image)
%
%  OUTPUT PARAMETERS:
%  u = deconvolved image
%
%  Author: J.Gilles
%  Institution: UCLA - Dept of Mathematics
%  email: jegilles@math.ucla.edu
%  Date: July 12, 2011 - update on June 23, 2016
%
%=========================================================================

% We build the Fried Kernel
FK=fftshift(FriedKernel(D,L,wavelength,cn2,size(f,1)));
% We perform the framelet deconvolution
u=Framelet_NB_Deconvolution(f,FK,mu,lambda,Niter,0,3,1);
