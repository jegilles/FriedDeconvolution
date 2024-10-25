%% Script to test Fried Deconvolution

%% First, we load the image and simulate some blur on it
f=double(imread('lighthouse.png')); %load the image
f=(f-min(f(:)))/(max(f(:))-min(f(:))); %normalize the image in [0,1]

%set the Fried parameters and create the kernel
D=0.07;
L=500;
lambda=0.7e-6;
Cnsim=4e-14;
FK=FriedKernel(D,L,lambda,Cnsim,size(f,1));

%apply the blur on the image
ff=fftshift(fft2(f)); %Fourier transform of f
ff=ff.*FK; %pointwise multiplication with the Fried kernel
blurry=real(ifft2(ifftshift(ff))); %inverse Fourier transform
fprintf('Blurry image done ...\n');

%% Next we try the non-blind deconvolution
NBu=FriedDeconvolution(blurry,D,L,Cnsim,lambda,10^7,100,5);
figure(1);
subplot(1,3,1);imshow(f,[]);
subplot(1,3,2);imshow(blurry,[]);
subplot(1,3,3);imshow(NBu,[]);
fprintf('Non blind deconvolution done ...\n');

%% Next we try the blind deconvolution
[Bu,Cnest,cncurve]=BlindFriedDeconvolution(blurry,D,L,lambda,10^7,100,5);
figure(2);
subplot(1,3,1);imshow(f,[]);
subplot(1,3,2);imshow(blurry,[]);
subplot(1,3,3);imshow(Bu,[]);
fprintf('Blind deconvolution done (estimated Cn2: %d) ...\n',Cnest);