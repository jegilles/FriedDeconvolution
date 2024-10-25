# FriedDeconvolution
 Matlab code to perform the Fried turbulence deconvolution

 Package that does perform the Fried deconvolution as described in J.Gilles, S.Osher, 
 "Fried Deconvolution", SPIE Defense, Security and Sensing conference, Baltimore, USA, 
 April 2012.

 The two main functions are
 - FriedDeconvolution.m -> perform the non-blind deconvolution (i.e all parameters are 
 supposed to be known)
 - BlindFriedDeconvolution.m -> perform the blind deconvolution (i.e. it does estimate
 the Cn2 paramter)

 Note the following toolboxes are necessary to run this code:
 - Bregman Cookbook:  https://github.com/jegilles/BregmanCookbook-Matlab
 - framelet: https://jegilles.sdsu.edu/code/Framelet.zip
