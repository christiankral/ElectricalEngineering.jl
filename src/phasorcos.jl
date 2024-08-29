    mag = 1;
    phi = pi/4;
    add = false;
    figsize = (6.6,2.5);
    xlabel = L"$\omega\!\cdot\!\!t$\,($^\circ $)";
    ylabel = "";
    maglabel = L"\hat I"
    phasorlabel = maglabel
    color = "black"
    backgroundcolor = "none"
    linewidth = 1
    linestyle = "-"
    labeltsep = 0.1
    labelrsep = 0.5
    labelrelrot = true
    labelrelangle = 0
    colorDash="gray"
    left=0.20
    right=0.80
    bottom=0.20
    top=0.80
    showcosine = true
    showdashline = true



    @doc raw"""
    # Function call

    ```
    phasorsine(mag = 1, phi = 0; add = false, figsize = (6.6,2.5),
        xlabel = L"$\omega t$\,($^\circ $)", ylabel = "", maglabel = "",
        phasorlabel = maglabel, labeltsep = 0.1, labelrsep = 0.5,
        labelrelrot = true, labelrelangle = 0,
        color = "black", linewidth = 1, linestyle = "-",
        colorDash="gray", left=0.20, right=0.80, bottom=0.20, top=0.80,
        showsine=true, showdashline=true)
    ```

    # Description

    This function draws a phasor with magnitude between 0 and 1 on the left subplot
    of a figure and a sine diagram on the right subplot of the figure. Such graph
    is used in electrical engineering to explain the relationship between phasors
    and time domain wave forms.

    # Variables

    `mag` Magnitude of displayed phasor; shall be between 0 and 1;
    default value = 1

    `phi` Phase angle of the phasor; default value = 0

    `add` When calling this function the first time, `add` shall be equal to
    `false`, which is the default value. In this case a new figure with the
    dimensions specified in `figsize` is created. In order to add a second phasor
    and sine diagram to an existing figure, `add` has to be set `true`

    `figsize` Size of the new figure, if `add` is equal to `false`; default value
    = (6.6,2.5)

    `xlabel` Label of x-axis of right subplot; default value ="ωt(°)" in LaTeX
    notation

    `ylabel` label of y-axis of right subplot; default value = "";  if more than one
    phasors and sine diagram shall be drawn (`add = true`), this label is displayed
    only once; therefore, one has to create the label of all phasors when function
    `phasorsine` is called the first time for creating a figure

    `maglabel` Label of positive and negative magnitude `mag` on the right subplot;
    dafault value = "";

    `phasorlabel` Label of phasor of left subplot; default value = `maglabel`

    `labelrsep` Radial per unit location of label (in direction of the phasor):
    `labelrsep = 0` represents the shaft of the phasor and `labelrsep = 1`
    represents the arrow hear of the phasor; default value = 0.5, i.e., the radial
    center of the phasor

    `labeltsep` Tangential per unit location of label: `labeltsep = 0` means that
    the label is plotted onto the phasor; `labeltsep = 0.1` plots the label on top
    of the phasor applying a displacement of 10% with respect to `ref`; `labeltsep =
    -0.2` Plots the label below the phasor applying a displacement of 20% with
    respect to `ref`; default value = 0.1

    `labelrelrot` Relative rotation of label; if `labelrelrot == false` (default value)
    then the label is not rotated relative to the orientation of the phasor;
    otherwise the label is rotated relative to the phasor by the angle
    `labelrelangle`

    `labelrelangle` Relative angle of label with respect to phasor
    orientation; this angle is only applied, it `labelrelrot == true`; this angle the
    indicates the relative orientation of the label with respect to the
    orientation of the phasor; default value = 0

    `color` Color of the phasor; i.e., shaft and arrow head color; default
    value = "black"

    `backgroundcolor` Background color of all labels; if labelrsep is equal to 0, the
    background color "white" can be used; default value = "none"

    `linewidth` Line width of the phasor; default value = 1

    `linestyle` Line style of the phasor; default value = "-"

    `colorDash` Color of the dashed circle (left subplot) and the horizontal dashed
    lines between the left and right subplot; default value = colorBlack4

    `left` Left side of the figure; default value = 0.2

    `right` Right side of the figure; default value = 0.85

    `bottom` Bottom side of the figure; default value = 0.2

    `top` Top side of the figure; default value = 0.85

    `showsine` If `true`, the sinewave is shown; default value = `true`

    `showdashline` If `true`, the dashed lines are shown; default value = `true`

    # Example

    Copy and paste code:

    ```julia
    using Unitful, Unitful.DefaultSymbols, PyPlot, ElectricalEngineering
    rc("text", usetex=true); rc("font", family="serif")
    phasorsine(1, 45°, ylabel=L"$u,i$", maglabel=L"$\hat{U}$", labelrsep=0.3,
        color="gray", linestyle="--")
    phasorsine(0.55, 0, add=true, maglabel=L"$\hat{I}$")
    # save3fig("phasorsine",crop=true);
    ```
    """
    function phasorsine(mag = 1,
        phi = 0;
        add = false,
        figsize = (6.6,2.5),
        xlabel = L"$\omega\!\cdot\!t$\,($^\circ $)",
        ylabel = "",
        maglabel = "",
        phasorlabel = maglabel,
        color = "black",
        backgroundcolor = "none",
        linewidth = 1,
        linestyle = "-",
        labeltsep = 0.1,
        labelrsep = 0.5,
        labelrelrot = true,
        labelrelangle = 0,
        colorDash="gray",
        left=0.20,
        right=0.80,
        bottom=0.20,
        top=0.80,
        showcosine = true,
        showdashline = true)
        # https://matplotlib.org/tutorials/text/annotations.html#plotting-guide-annotation
        # https://matplotlib.org/users/annotations.html
        # https://stackoverflow.com/questions/17543359/drawing-lines-between-two-plots-in-matplotlib

        #######################################
        close("all")
        # Create figure
        if !add
            # Create new figure
            fig = figure(figsize=figsize)
            subplots_adjust(left=left, right=right, bottom=bottom, top=top)
        end
        # Create left subplot
        subplot(121)
        # Angle vector to draw circle
        psi = collect(0:pi/500:2*pi)
        # Coordinates of circle
        x = mag*cos.(psi)
        y = mag*sin.(psi)
        # Plot circle
        plot(x, y, color=colorDash, linewidth=1, linestyle=":",
            dash_capstyle="round")
        # Plot phasor
        phasor(pol(mag,phi.+pi/2), ref=1,
            label=phasorlabel, labelrsep=labelrsep, labeltsep=labeltsep,
            labelrelrot=labelrelrot, labelrelangle=labelrelangle,
            color=color, backgroundcolor=backgroundcolor,
            linestyle=linestyle, linewidth=linewidth)
        axis("square")
        ax1 = gca()
        if !add
            xlim(-1.1,1.1)
            ylim(-1.1,1.1)
            ax1.spines["left"].set_visible(false)
            ax1.spines["right"].set_visible(false)
            ax1.spines["bottom"].set_visible(false)
            ax1.spines["top"].set_visible(false)
            # Remove ticks
            xticks([])
            yticks([])
        end

        # Create right subplot
        subplot(122)
        # Plot sine if selected by showcosine = true
        if showcosine
            yphi = mag*cos.(psi.+phi)
            plot(psi*180/pi, yphi,
                color=color, linewidth=linewidth, linestyle=linestyle)
        end
        ax2 = gca()
        # First phasor and sine wave diagram must be drawn with add = false
        if !add
            # Scale and tick x-axis
            xlim(0, 360)
            ylim(-1.1, 1.1)
            xticks(collect(90:90:360),
                backgroundcolor=backgroundcolor)
            if maglabel != ""
                yticks([-mag, 0, mag],[L"$-$"*maglabel, L"$0$", maglabel],
                    backgroundcolor=backgroundcolor)
            else
                yticks([-mag, 0, mag],["","",""])
            end
            # Create arrows and labels of axes
            arrowaxes(xlabel=xlabel, ylabel=ylabel)
        else
            # If additional phasor and sine wave diagram are added, further
            # y-axis ticks have to beee added; for this purpose, the existing (old)
            # ticks are stored
            yticks_old = ax2.get_yticks()
            # Store existing (old) labels
            ytickslabel_old = ax2.get_yticklabels()
            # Extend old ticks and labels by addition ticks and labels
            if maglabel != ""
                yticks(cat(yticks_old, [-mag,mag],dims=1),
                    cat(ytickslabel_old, [L"$-$"*maglabel,maglabel],dims=1),
                        backgroundcolor=backgroundcolor)
            end
        end
        # Change vertical scaling of left subplot to match
        ax1.set_ylim(ax2.get_ylim())

        # Plot dashed lines, if showdashline = true
        if showdashline
            # Dotted line from phasor arrow to begin of cosine wave, split in two
            # parts, to avoid overlay effects if multiple dashed lines are drawn
            con = matplotlib.patches."ConnectionPatch"(
                xyB=(360, mag*cos(phi)), xyA=(0, mag*cos(phi)),
                coordsA="data", coordsB="data",
                axesA=ax2, axesB=ax2, color=colorDash,
                linewidth=lineWidth4, linestyle=":", clip_on=false)
            ax2.add_artist(con)
            con = matplotlib.patches."ConnectionPatch"(
                xyA=(0, mag*cos(phi)), xyB=(-mag*sin(phi), mag*cos(phi)),
                coordsA="data", coordsB="data",
                axesA=ax2, axesB=ax1, color=colorDash,
                linewidth=lineWidth4, linestyle=":", clip_on=false)
            ax2.add_artist(con)
            # Dotted line of y-axis of right diagram to maximum of sine wave
            con = matplotlib.patches."ConnectionPatch"(
                xyB=(mod(0-phi*180/pi,360), mag), xyA=(0, mag),
                coordsA="data", coordsB="data",
                axesA=ax2, axesB=ax2, color=colorDash,
                linewidth=lineWidth4, linestyle=":", clip_on=false)
            ax2.add_artist(con)
            # Dotted line of y-axis of right diagram to minimum of sine wave
            con = matplotlib.patches."ConnectionPatch"(
                xyB=(mod(180-phi*180/pi, 360),-mag), xyA=(0, -mag),
                coordsA="data", coordsB="data",
                axesA=ax2, axesB=ax2, color=colorDash,
                linewidth=lineWidth4, linestyle=":", clip_on=false)
                ax2.add_artist(con)
        end
    end
