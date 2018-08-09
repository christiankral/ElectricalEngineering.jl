export colorBlack1,colorBlack2,colorBlack3,colorBlack4,colorBlack5,
    lineStyle1,lineStyle2,lineStyle3,lineStyle4,
    lineWidth1,lineWidth2,lineWidth3,lineWidth4,
    marker1,marker2,marker3,marker4,
    markerSize1,markerSize2,markerSize3,markerSize4,
    legendFontSize,arrowAxes

const colorBlack1="0"
const colorBlack2="0.25"
const colorBlack3="0.5"
const colorBlack4="0.6"
const colorBlack5="0.85"

const lineStyle1="-"
const lineStyle2=linestyle=(0,(4,1))
const lineStyle3=linestyle=(0,(2,0.81))
const lineStyle4=linestyle=(0,(8,1))

const lineWidth1=1
const lineWidth2=1
const lineWidth3=1.5
const lineWidth4=1

const marker1="D"
const marker2="o"
const marker3="s"
const marker4="*"

const markerSize1=4
const markerSize2=4
const markerSize3=4
const markerSize4=5

const legendFontSize=10

doc"""
# Function call

`arrowaxes(fig=gcf(), ax=gca(); xa=0, ya=0, xlabel="", ylabel="",
color="black", axisoverhang = 0.18, linewidth = 0.75,
headwidth = 0.06, headlength = 0.09, overhang = 0.1,
labelsep = 0.06,
left=0.2, right=0.85, bottom=0.20, top=0.85, fancy=false)`

# Description

Creates a plot with a horizontal and a vertical axis instead of a frame.

# Variables

`fig` Figure handle; by default the figure handle of a actual figure is used

`ax` Axes handle; by default the axes handle of a actual figure is used

`xa` Horizontal location of the vertical axis; default value = 0

`ya` Vertical location of the horizontal axis; default value = 0

`color` Color of the axes; default value = "black"

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

`fancy` If `true`, the annotate arrow is used instead of the axis arrow; in this
case the arrow scales with the figure size automatically; default value = `false`

# Examples

Copy and paste the following code:

```julia
using Unitful,Unitful.DefaultSymbols,EE,PyPlot
x=collect(0.0:0.1:5.0); y=exp.(sin.(x));
plot(x,y,color=colorBlack1, linewidth=lineWidth1, linestyle=lineStyle1)
xlim(0,5); ylim(0,3); arrowaxes(xlabel=L"$x$",ylabel=L"$y$")
```
"""
function arrowaxes(fig=gcf(), ax=gca(); xa=0, ya=0, xlabel="", ylabel="",
    color="black", axisoverhang = 0.18, linewidth = 0.75,
    headwidth = 0.045, headlength = 0.07, overhang = 0,
    labelsep = 0.05,
    left=0.2, right=0.85, bottom=0.20, top=0.85, fancy=false)
    # The basic idea of this implementation is taken from:
    # http://www.yueshen.me/2015/1011.html
    # https://stackoverflow.com/questions/33737736/matplotlib-axis-arrow-tip/44138298#44138298

    # Create enough space around the plot area of fit in arrows
    fig[:subplots_adjust](left=left, right=right, top=top, bottom=bottom)
    # Format axis
    ax[:spines]["right"][:set_visible](false) # Disable right axis
    ax[:spines]["top"][:set_visible](false) # Disable top axis
    ax[:yaxis][:set_ticks_position]("left") # Only show vertical ticks on left
    ax[:xaxis][:set_ticks_position]("bottom") # Only show horizontal ticks on bottom
    # Set position of horizontal axis
    ax[:spines]["bottom"][:set_position](("data",ya))
    # Remove horizontal axis, since it will be overwritten by arrow
    ax[:spines]["bottom"][:set_color]("none")
    # Set position of vertical axis
    ax[:spines]["left"][:set_position](("data",xa))
    # Remove vertical axis since it will be overwritten by arrow
    ax[:spines]["left"][:set_color]("none")

    # Axis limits
    (xmin,xmax) = ax[:get_xlim]() # Horizontal limits
    dx = xmax-xmin # Difference of horizontal limits
    (ymin,ymax) = ax[:get_ylim]() # Vertical limits
    dy = ymax-ymin # Difference of vertical limits
    # Get width and height of axes object to compute
    # matching arrowhead length and width
    dps = fig[:dpi_scale_trans][:inverted]()
    bbox = ax[:get_window_extent]()[:transformed](dps)
    width = bbox[:width] # width of bbox
    height = bbox[:height] # height of bbox
    # Physical arrow dimensions
    hwx = headwidth*dy # Width of x-axis arrow head
    hlx = headlength*dx # Length of x-axis arrow length
    hwy = headwidth*dx * height/width # Width of y-axis arrow head
    hly = headlength*dy * width/height # Length of y-axis arrow length

    if fancy
        # Horizontal arrow created by annotate instead of axis.arrow
        annotate("", xy=(xmax+axisoverhang*dx, ya),
            xytext=(xmin, ya), xycoords="data",
            arrowprops=Dict("edgecolor"=>color,
                "facecolor"=>color,
                "width"=>0.2,
                "linewidth"=>linewidth*0.6/0.7,
                "linestyle"=>"-",
                "headlength"=>headlength*10/0.07,
                "headwidth"=>headwidth*5/0.045,
                "joinstyle"=>"round"),
            annotation_clip=false)
        # Vertical arrow created by annotate instead of axis.arrow
        annotate("", xy=(xa,ymax+axisoverhang*dy),
            xytext=(xa,ymin), xycoords="data",
            arrowprops=Dict("edgecolor"=>color,
                "facecolor"=>color,
                "width"=>0.2,
                "linewidth"=>linewidth*0.6/0.7,
                "linestyle"=>"-",
                "headlength"=>headlength*10/0.07,
                "headwidth"=>headwidth*5/0.045,
                "joinstyle"=>"round"),
            annotation_clip=false)
    else
        # https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.arrow.html#matplotlib.axes.Axes.arrow
        # Horizontal arrow
        ax[:arrow](xmin, ya, dx*(1+axisoverhang) ,0,
            fc=color, ec=color, lw=linewidth,
            head_width=hwx, head_length=hlx, overhang=overhang,
            joinstyle="round", length_includes_head=true, clip_on=false)
        # Vertical arrow
        ax[:arrow](xa, ymin, 0, dy*(1+axisoverhang),
            fc=color, ec=color,lw=linewidth,
            head_width=hwy, head_length=hly, overhang=overhang,
            joinstyle="round", length_includes_head=true, clip_on=false)
    end
    # https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.text.html#matplotlib.axes.Axes.text
    # Horizontal label
    ax[:text](xmax+dx*axisoverhang, ya+dy*labelsep, xlabel,
        ha="right", va="bottom")
    # Vertical label
    ax[:text](xa+dx*labelsep, ymax+dy*axisoverhang, ylabel,
        ha="left",va="top")
end

doc"""
# Function call

`removeaxes(ax=gca())`

# Description

Removes the axis of the actual plot

# Variables

`ax` Axes handle; by default the axes handle of a actual figure is used
"""
function removeaxes(ax=gca())
    ax[:set_axis_off]();
end
