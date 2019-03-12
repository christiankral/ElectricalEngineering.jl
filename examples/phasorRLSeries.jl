using PyPlot,EE

close("all")
figure(figsize=(3.3,2.5))
rc("text",usetex=true);
rc("text.latex",preamble="\\usepackage{fourier}\\usepackage[scaled=0.95]{inconsolata}");
rc("font", family="serif")

U = 100+0im
refU = 100
Z = 30+40im
I = U/Z
Ur = real(Z)*I
Ux = 1im*imag(Z)*I
refI=abs(I)*0.8

phasor(U,label=L"$\underline{U}$",tlabel=-0.1,ref=refU,relrot=true)
phasor(Ur,label=L"$\underline{U}_r$",tlabel=-0.1,ref=refU,relrot=true)
phasor(Ux,origin=Ur,label=L"$\underline{U}_x$",tlabel=0.15,ref=refU,relrot=true)
phasor(I,label=L"$\underline{I}$",tlabel=0.15,rlabel=0.7,ref=refI,relrot=true,par=0.05)

axis("square")
xlim(-1,1)
ylim(-1,1)

# Remove axis
ax=gca()
ax[:set_axis_off]()
