# isdefined(Base, :__precompile__) && __precompile__()
module EE

    # Implementation of EE is based on PyPlot
    using PyPlot

    export phasor

    function phasor(c;origin=0.0+0.0im,ref=1,par=0,
        rlabel=0.5,tlabel=0.25,label="",ha="center",va="center",
        relrot=false,relangle=0,
        color="black",width=0.2,headlength=10,headwidth=5)

        # Starting point (origin) of phase
        xorigin=real(origin)/ref
        yorigin=imag(origin)/ref
        # End point of phasor
        xend=real(origin+c)/ref
        yend=imag(origin+c)/ref
        # Real part of phasor
        drx=real(c)
        # Imag part of phasor
        dry=imag(c)
        # Length of phasor
        dr=sqrt(drx^2+dry^2)
        # Angle of phasor in degrees
        absangle=atan2(dry,drx)*180/pi
        # Orientation tangential to phasor (lagging by 90°)
        # Real part of tangential component with repsect to length
        dtx=+dry/dr
        # Imag part of tangential component with repsect to length
        dty=-drx/dr
        # Real part of parallel shift of phasor
        dpx=par*dtx
        # Imag part of parallel shift of phasor
        dpy=par*dty

        # Draw arrow
        annotate("",xy=(xend+dpx,yend+dpy),xytext=(xorigin+dpx,yorigin+dpy),
            xycoords="data",
            arrowprops=Dict("edgecolor"=>color,"facecolor"=>color,"width"=>width,
                            "headlength"=>headlength,"headwidth"=>headwidth),
                            annotation_clip=false)
        # Plot label
        if relrot==false
            # Without relative roation of label
            text(xorigin+drx*rlabel+dtx*tlabel+dpx,yorigin+dry*rlabel+dty*tlabel+dpy,
              label,ha=ha,va=va)
        else
            # Applying relative rotation of label
            text(xorigin+drx*rlabel+dtx*tlabel+dpx,yorigin+dry*rlabel+dty*tlabel+dpy,
              label,ha=ha,va=va,rotation=absangle+relangle)
        end
    end

end
