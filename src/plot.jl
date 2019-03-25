export colorBlack1, colorBlack2, colorBlack3, colorBlack4, colorBlack5,
    lineStyle1, lineStyle2, lineStyle3, lineStyle4,
    lineWidth1, lineWidth2, lineWidth3, lineWidth4,
    marker1, marker2, marker3, marker4,
    markerSize1, markerSize2, markerSize3, markerSize4,
    legendFontSize, arrowaxes, removeaxes, lengthdimension

const colorBlack1 = "0"
const colorBlack2 = "0.25"
const colorBlack3 = "0.5"
const colorBlack4 = "0.6"
const colorBlack5 = "0.85"

const lineStyle1 = "-"
const lineStyle2 = linestyle = (0, (4, 1))
const lineStyle3 = linestyle = (0, (2, 0.81))
const lineStyle4 = linestyle = (0, (8, 1))

const lineWidth1 = 1
const lineWidth2 = 1
const lineWidth3 = 1.5
const lineWidth4 = 1

const marker1 = "D"
const marker2 = "o"
const marker3 = "s"
const marker4 = "*"

const markerSize1 = 4
const markerSize2 = 4
const markerSize3 = 4
const markerSize4 = 5

const legendFontSize  =  10

@doc raw"""
# Function call

```
arrowaxes(fig=gcf(), ax=gca(); xmin, xmax, ymin, ymax,
    xa=0, ya=0, xlabel="", ylabel="",
    xneg = false, yneg = false,
    color="black", backgroundcolor="none", axisoverhang = 0.18,
    linewidth = 0.75, headwidth = 0.06, headlength = 0.09, overhang = 0.1,
    labelsep = 0.06, left=0.2, right=0.85, bottom=0.20, top=0.85)
```

# Description

Creates a plot with a horizontal and a vertical axis instead of a frame.

# Variables

`fig` Figure handle; by default the figure handle of a actual figure is used

`xmin` Minimum of horizontal axis; default value = actual scaling

`xmax` Maximum of horizontal axis; default value = actual scaling

`ymin` Minimum of vertical axis; default value = actual scaling

`ymax` Maximum of vertical axis; default value = actual scaling

`ax` Axes handle; by default the axes handle of a actual figure is used

`xa` Horizontal location of the vertical axis; default value = 0

`ya` Vertical location of the horizontal axis; default value = 0

`xlabel` Label of x-axis; default value = ""

`ylabel` Label of y-axis; default value = ""

`xneg` If true, the horizontal arrow is drawn from right to left;
default value = `false`

`yneg` If true, the vertical arrow is drawn from top to bottom;
default value = `false`

`color` Color of the axes; default value = "black"

`backgroundcolor` Background color of the label; if labelrsep is equal to 0, the
background color "white" can be used; default value = "none"

`axisoverhang` Overhang of the axis, relative to plot area;
default value = 0.18 (18% of plot width)

`linewidth` Line width of the axes; default value = 0.75

`headwidth` Width of head, relative to plot area;
default value = 0.045 (4.5% of horizontal plot width)

`headlength` Length of head, relative to plot area;
default value = 0.07 (7% of horizontal plot width)

`overhang` Overhang of arrow head; default value = 0.0

`labelsep` Location of labels from axis, relative to plot area;
default value = 0.05 (5% of plot width)

`left` Left side of the figure; default value = 0.2

`right` Right side of the figure; default value = 0.85

`bottom` Bottom side of the figure; default value = 0.2

`top` Top side of the figure; default value = 0.85

# Examples

Copy and paste the following code:

```julia
using Unitful,Unitful.DefaultSymbols,ElectricalEngineering,PyPlot
figure(figsize=(3.3, 2.5))
rc("text", usetex=true); rc("font", family="serif")
x=collect(0.0:0.1:5.0); y=exp.(sin.(x));
plot(x,y,color=colorBlack1, linewidth=lineWidth1, linestyle=lineStyle1)
xlim(0,5); ylim(0,3); arrowaxes(xlabel=L"$x$",ylabel=L"$y$")
# save3fig("arrowaxes", crop=true)
```
"""
function arrowaxes(fig=gcf(), ax=gca();
    xmin=ax.get_xlim()[1], xmax=ax.get_xlim()[2],
    ymin=ax.get_ylim()[1], ymax=ax.get_ylim()[2],
    xa=0, ya=0, xlabel="", ylabel="",
    xneg = false, yneg = false,
    color="black", backgroundcolor="none", axisoverhang = 0.18,
    linewidth = 0.6, headwidth = 5, headlength = 10, overhang = 0,
    labelsep = 0.05,
    left=0.2, right=0.85, bottom=0.20, top=0.85)
    # The basic idea of this implementation is taken from:
    # http://www.yueshen.me/2015/1011.html
    # https://stackoverflow.com/questions/33737736/matplotlib-axis-arrow-tip/44138298#44138298

    # Create enough space around the plot area of fit in arrows
    fig.subplots_adjust(left=left, right=right, top=top, bottom=bottom)
    # fig[:subplots_adjust](left=left, right=right, top=top, bottom=bottom)
    ax.spines["right"].set_visible(false)
    ax.spines["top"].set_visible(false)
    ax.yaxis.set_ticks_position("left") # Only show vertical ticks on left
    ax.xaxis.set_ticks_position("bottom") # Only show horizontal ticks on bottom
    # Set position of horizontal axis:
    ax.spines["bottom"].set_position(("data",ya))
    # Remove horizontal axis, since it will be overwritten by arrow
    # ax[:spines]["bottom"][:set_color]("none")
    ax.spines["bottom"].set_color("none")
    # Set position of vertical axis
    ax.spines["left"].set_position(("data",xa))
    # Remove vertical axis since it will be overwritten by arrow
    ax.spines["left"].set_color("none")

    # Axis limits
    (xMIN,xMAX) = ax.get_xlim() # Horizontal limits
    dx = xMAX-xMIN # Difference of horizontal limits
    (yMIN,yMAX) = ax.get_ylim() # Vertical limits
    dy = yMAX-yMIN # Difference of vertical limits
    # Get width and height of axes object to compute
    # matching arrowhead length and width
    dps = fig.dpi_scale_trans.inverted()
    bbox = ax.get_window_extent().transformed(dps)
    width = bbox.width # width of bbox
    height = bbox.height # height of bbox
    # Physical arrow dimensions
    hwx = headwidth*dy # Width of x-axis arrow head
    hlx = headlength*dx # Length of x-axis arrow length
    hwy = headwidth*dx * height/width # Width of y-axis arrow head
    hly = headlength*dy * width/height # Length of y-axis arrow length

    xbeg = xneg ? xmax : xmin
    xend = xneg ? xmin-axisoverhang*dx : xmax+axisoverhang*dx
    ybeg = yneg ? ymax : ymin
    yend = yneg ? ymin-axisoverhang*dy : ymax+axisoverhang*dy

    # Set new limits
    xlim(xbeg,xend)
    ylim(ybeg,yend)
    # Horizontal arrow created by annotate instead of axis.arrow
    annotate("", xy=(xend, ya),
        xytext=(xbeg, ya), xycoords="data",
        arrowprops=Dict("edgecolor"=>color,
            "facecolor"=>color,
            "width"=>0.2,
            "linewidth"=>linewidth,
            "linestyle"=>"-",
            "headlength"=>headlength,
            "headwidth"=>headwidth,
            "joinstyle"=>"round"),
        annotation_clip=false)
    # Vertical arrow created by annotate instead of axis.arrow
    annotate("", xy=(xa,yend),
        xytext=(xa,ybeg), xycoords="data",
        arrowprops=Dict("edgecolor"=>color,
            "facecolor"=>color,
            "width"=>0.2,
            "linewidth"=>linewidth,
            "linestyle"=>"-",
            "headlength"=>headlength,
            "headwidth"=>headwidth,
            "joinstyle"=>"round"),
        annotation_clip=false)
    # https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.text.html#matplotlib.axes.Axes.text
    # Horizontal label
    ha = xneg ? "left" : "right"
    ax.text(xend, ya+dy*labelsep, xlabel,
        ha=ha, va="bottom", backgroundcolor=backgroundcolor)
    # Vertical label
    va = yneg ? "bottom" : "top"
    ax.text(xa+dx*labelsep, yend, ylabel,
        ha="left",va=va, backgroundcolor=backgroundcolor)
end

"""
# Function call

`removeaxes(ax=gca())`

# Description

Removes the axis of the actual plot

# Variables

`ax` Axes handle; by default the axes handle of a actual figure is used
"""
function removeaxes(ax=gca())
    #
    setproperty!(ax,"set_axis_off",true)
    xticks([])
    yticks([])
    ax.spines["right"].set_visible(false)
    ax.spines["top"].set_visible(false)
    ax.spines["bottom"].set_visible(false)
    ax.spines["left"].set_visible(false)
end

@doc raw"""
# Function call

```
lengthdimension(x1=0, y1=0, x2=1, y2=1;
    label = "", labeltsep = 0.1, labelrsep=0.5, labelrelrot=false,
    labelrelangle=0, ha = "center", va = "center",
    color="black", backgroundcolor = "none",
    arrowstyle1 = "<|-", arrowstyle2 = "-|>", linewidth=0.6, linestyle = "-",
    width=0.2, headlength=5, headwidth=2.5,
    par=0, paroverhang = 0.02, parcolor = "black",
    parlinewidth=0.6, parlinestyle = "-")

```

# Description

This function draws length dimension with label based on rectangular x- and
y-coordinates. The length dimension arrow can be shifted parallel to the
specified  coordinates by means the single parameter `par`. Additionally,
auxiliary lines  from the specified coordinates to the length dimension are
drawn.

# Variables

`x1` x-component of the begin of the length dimension; default value = 0

`y1` y-component of the begin of the length dimension; default value = 0

`x2` x-component of the end of the length dimension; default value = 1

`y2` y-component of the end of the length dimension; default value = 1

`label` Label of the angle; default value =""

`labelphisep` Angular separation of the label with respect to the arc; if
`labelphisep == 0`, the label is located at angle `phi1` and if `labelphisep ==
1`, the label is located at angle `phi2`; default value = 0.5, right in the
middle between `phi1` and `phi2`

labelrsep` Radial per unit location of label (in direction of the phasor):
`labelrsep = 0` locates the label right on the arc. A positive value locates the
label outside the arc, a negative value locates the label inside the arc;
default value = 0.1

`labelrelrot` Relative rotation of label; if `labelrelrot == false` (default
value) then the label is not rotated relative to the center of the arc;
otherwise the label is rotated relative to the  angle `labelrelangle`

`labelrelangle` Relative angle of label with respect to center of the arc; this
angle is only applied, it `labelrelrot == true`; this angle indicates the
relative orientation of the label with respect to the center of the arc;
default value = 0

`ha` Horizontal alignment of label; actually represents the radial alignment of
the label; default value = "center"

`va` Vertical alignment of label; actually represents the tangential alignment
of the label; default value = "center"

`color` Color of the arc; default value = "black"

`backgroundcolor` Background color of the label; if labelrsep is equal to 0, the
background color "white" can be used; default value = "none"

`arrowstyle1` Arrow style of the begin of the arc; default value = "."; valid
strings are:

- `.` dot marker
- `<|-` arrow

`arrowstyle2` Arrow style of the end of the arc; default value = "-|>"; valid
strings are:

- `.` dot marker
- `-|>` arrow

`headlength` Length of arrow head; default value = 5

`headwidth` Width of arrow head; default value = 2.5

`par` In order to be able to draw the length dimension parallel to the specified
coordiantes `x1`, `y1`, `x2`, `y2`, `par` is used to specify the per unit
tangential shift (offset) of the length dimension; default value = 0 (no shift)

`paroverhang` The auxiliary lines, drawn in case of `par != 0`, show the absolute
overhang `paroverhang`; default value = 0.02

`parcolor` Color of the auxiliary lines; default value = "black"

`parlinewidth` Line width of the auxiliary line; default value = 0.6

`parlinestyle` Line style of the auxiliary line; default value = "-"

# Example

Copy and paste code:

```julia
using Unitful, Unitful.DefaultSymbols, PyPlot, ElectricalEngineering
figure(figsize=(3.3, 2.5))
rc("text", usetex=true); rc("font", family="serif")
t1=0.2;t2=0.3;ymax=1
t=[0,t1,t1+t2,2*t1+t2,2*(t1+t2),3*t1+2*t2]
y=[0,ymax,0,ymax,0,ymax]
step(t,y,linewidth=1,color="black")
grid(true); xlim(0,1), ylim(-0.1,1.3);
xlabel(L"$t$\,(s)"); ylabel(L"$y$")
lengthdimension(0,0.2,t1,0.2,label=L"$t_1$",labeltsep=0,backgroundcolor="white")
lengthdimension(t1,0.2,t1+t2,0.2,label=L"$t_2$",labeltsep=0,backgroundcolor="white")
lengthdimension(t1,ymax,2*t1+t2,ymax,label=L"$T$",par=0.1,labeltsep=0.05,labelrsep=0.7)
# save3fig("lengthdimension",crop=true)
```
"""
function lengthdimension(
    x1 = 0,
    y1 = 0,
    x2 = 1,
    y2 = 1;
    label = "",
    labeltsep = 0.1,
    labelrsep = 0.5,
    labelrelrot = false,
    labelrelangle = 0,
    ha = "center",
    va = "center",
    color="black",
    backgroundcolor = "none",
    arrowstyle1 = "<|-",
    arrowstyle2 = "-|>",
    linewidth = 0.6,
    linestyle = "-",
    width = 0.2,
    headlength = 5,
    headwidth = 2.5,
    par = 0,
    paroverhang = 0.02,
    parcolor = "black",
    parlinewidth = 0.6,
    parlinestyle = "-")

    # Length of line
    dr = sqrt((x2-x1)^2 + (y2-y1)^2)
    # x-difference of line
    drx = (x2 - x1)/dr
    # y-difference of line
    dry = (y2 - y1)/dr
    # Angle of line
    absangle = atan(dry, drx)
    # Orientation tangential to phasor (lagging by 90°)
    # x-component of tangential component with repsect to length
    dtx = +dry
    # y-component of tangential component with repsect to length
    dty = -drx
    # x-component of parallel shift of line
    dpx = -par*dtx
    # y-component of parallel shift of line
    dpy = -par*dty
    # x-component of auxiliary line indicating parallel shift of line
    dox = -paroverhang*dtx*sign(par)
    # y-component of auxiliary line indicating parallel shift of line
    doy = -paroverhang*dty*sign(par)

    # Draw line
    plot([x1+dpx,x2+dpx], [y1+dpy,y2+dpy],
        color=color, linewidth=linewidth,linestyle=linestyle)
    # Draw line indicating parallel shift
    if par!=0
        plot([x1,x1+dpx+dox], [y1,y1+dpy+doy],
            color=parcolor, linewidth=parlinewidth, linestyle=parlinestyle)
        plot([x2,x2+dpx+dox], [y2,y2+dpy+doy],
            color=parcolor, linewidth=parlinewidth, linestyle=parlinestyle)
    end

    # Draw arrows at begin and end of line, depending on the specified arrow
    # styles

    # Begin of line
    if arrowstyle1 == "<|-"
        # Arrow head
        annotate("", xy=(x1+dpx, y1+dpy),
            xytext=(x1+dpx+0.001*drx, y1+dpy+0.001*dry),
            xycoords="data",
            arrowprops=Dict("edgecolor"=>color, "facecolor"=>color,
                "width"=>width, "linestyle"=>"-",
                "headlength"=>headlength,
                "headwidth"=>headwidth),
            annotation_clip=false)
    elseif arrowstyle1 == "."
        # Dot marker
        plot(x1+dpx, y1+dpy, marker=".", color=color, clip_on=false)
    end

    # End of line
    if arrowstyle2 == "-|>"
        # Arrow head
        annotate("", xy=(x2+dpx, y2+dpy),
            xytext=(x2+dpx-0.001*drx, y2+dpy-0.001*dry),
            xycoords="data",
            arrowprops=Dict("edgecolor"=>color, "facecolor"=>color,
                "width"=>width, "linestyle"=>"-",
                "headlength"=>headlength,
                "headwidth"=>headwidth),
            annotation_clip=false)
    elseif arrowstyle2 == "."
        # Marker dot
        plot(x2+dpx, y2+dpy ,marker=".", color=color, clip_on=false)
    end

    # Plot label
    if labelrelrot == false
        # Without relative rotation of label
        text(x1 + dr*drx*labelrsep - dtx*labeltsep + dpx,
            y1 + dr*dry*labelrsep - dty*labeltsep + dpy,
            label, ha=ha, va=va, rotation=labelrelangle*180/pi,
            backgroundcolor=backgroundcolor)
    else
        # Applying relative rotation of label
        text(x1 + dr*drx*labelrsep - dtx*labeltsep + dpx,
            y1 + dr*dry*labelrsep - dty*labeltsep + dpy,
            label, ha=ha, va=va, rotation=(absangle+labelrelangle)*180/pi,
            backgroundcolor=backgroundcolor)
    end
end
