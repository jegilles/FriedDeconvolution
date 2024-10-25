function FK=FriedKernel(D,L,lambda,Cn2,N)

%============================================================
% function FK=FriedKernel(D,L,lambda,Cn2,N)
%
% Fried Kernel generator
% Version:
% -v1.0 - 05/17/2011
% -v2.0 - 06/23/2016
%
% This function build the Fried Kernel in the
% Fourier domain
%
% D = Entrance pupil diameter in meter
% L = path length (distance between sensor and scene in meter
% lambda = wavelength in meter
% Cn2 = Refractive index structure parameter in meter^(-2/3)
% N = size of the image in pixels (we assume a square image)
%
% Author: Jerome Gilles
% Institution: UCLA - Math Department
% email: jegilles@math.ucla.edu
%
% Note: weak turbulence <=> Cn2 ~ 12e-16,
% strong turbulence <=> Cn2 ~ 12e-14
%
%============================================================

k=2*pi/lambda;
P=sqrt(lambda*L);
r0=2.1*1.437*(k^2*L*Cn2)^(-3/5);

X=D/r0;
Q=D/P;
x=log10(X);
q=log2(Q);

if q>-1.50
   qa=1.35*(q+1.5);
   sqa=(exp(qa)-1)/(exp(qa)+1);
   A=0.840+0.116*sqa;
else
   qa=0.51*(q+1.5);
   sqa=(exp(qa)-1)/(exp(qa)+1);
   A=0.840+0.280*sqa;
end

qb=1.45*(q-0.15);
sqb=(exp(qb)-1)/(exp(qb)+1);
B=0.805+0.265*sqb;

Vqx=A+(B/10)*exp(-((x+1)^3)/3.5);

w=sqrt(([-1:2/N:1-2/N]'*ones(1,N)).^2+(ones(1,N)'*[-1:2/N:1-2/N]).^2);

Mo=zeros(size(w));

for i=1:size(w,1)
    for j=1:size(w,2)
        if w(i,j)>1
            Mo(i,j)=0;
        else
            Mo(i,j)=(2/pi)*(acos(w(i,j))-w(i,j)*sqrt(1-w(i,j)^2));
        end
    end
end

FK=Mo.*exp(-((2.1*X)^(5/3)*(w.^(5/3)-Vqx*w.^2)));
