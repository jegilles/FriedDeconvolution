function tv=TVnorm(u)

% This function compute the TV norm of an image (the image is normalized)

m=min(min(u));
M=max(max(u));
D=M-m;

u=(u-m)/D;

[ux,uy]=gradient(u);
mu=sqrt(ux.^2+uy.^2);
tv=sum(sum(mu));
