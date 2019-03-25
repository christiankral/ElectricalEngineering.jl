"""
# ElectricalEngineering.Tab20bc

Defines colors based on
https://matplotlib.org/users/plotting/colormaps/grayscale_01_04.pdf. As an
alternative `ElectricalEngineering.Gray` can be used instead of `ElectricalEngineering.Tab20bc` in order to create a
gray scale plot instead of a color plot.

# Colors

The following colors are defined:

- `colorBrown1`, `colorBrown2`, `colorBrown3`, `colorBrown4`
- `colorBlue1`, `colorBlue2`, `colorBlue3`, `colorBlue4`
- `colorRed1`, `colorRed2`, `colorRed3`, `colorRed4`
- `colorOrange1`, `colorOrange2`, `colorOrange3`, `colorOrange4`
- `colorGreen1`, `colorGreen2`, `colorGreen3`, `colorGreen4`
- `colorPurple1`, `colorPurple2`, `colorPurple3`, `colorPurple4`
- `colorDarkPurple1`, `colorDarkPurple2`, `colorDarkPurple3`, `colorDarkPurple4`
- `colorMagenta1`, `colorMagenta2`, `colorMagenta3`, `colorMagenta4`
- `colorGray1`, `colorGray2`, `colorGray3`, `colorGray4`

# Example

Copy and paste code:

```julia
using PyPlot,ElectricalEngineering,ElectricalEngineering.Tab20bc
x=collect(0:0.01:1);
figure(figsize=(3.3,2.5))
plot(x,x,color=colorRed1,linestyle=lineStyle1,linewidth=lineWidth1,
label="(1)")
plot(x,x.^2,color=colorRed2,linestyle=lineStyle2,linewidth=lineWidth2,
label="(2)")
plot(x,x.^3,color=colorRed3,linestyle=lineStyle3,linewidth=lineWidth3,
label="(3)")
plot(x,x.^4,color=colorRed4,linestyle=lineStyle4,linewidth=lineWidth4,
label="(4)")
subplots_adjust(left=0.20, right=0.95, top=0.95, bottom=0.20)
legend(loc="upper left",fontsize=legendFontSize)
```

# See also

`ElectricalEngineering.Gray`

"""
module Tab20bc
  using ElectricalEngineering

    export colorBrown1,colorBrown2,colorBrown3,colorBrown4,
        colorBlue1,colorBlue2,colorBlue3,colorBlue4,
        colorRed1,colorRed2,colorRed3,colorRed4,
        colorOrange1,colorOrange2,colorOrange3,colorOrange4,
        colorGreen1,colorGreen2,colorGreen3,colorGreen4,
        colorPurple1,colorPurple2,colorPurple3,colorPurple4,
        colorDarkPurple1,colorDarkPurple2,colorDarkPurple3,colorDarkPurple4,
        colorMagenta1,colorMagenta2,colorMagenta3,colorMagenta4,
        colorGray1,colorGray2,colorGray3,colorGray4

    # Color schemes tab20c and tab20b are taken from
    # https://matplotlib.org/users/plotting/colormaps/grayscale_01_04.pdf
    const colorBrown1="#8C6D31"
    const colorBrown2="#BD9E39"
    const colorBrown3="#E7BA52"
    const colorBrown4="#E7CB94"

    const colorBlue1="#3182BD"
    const colorBlue2="#6BAED6"
    const colorBlue3="#9ECAE1"
    const colorBlue4="#C6DBEF"

    const colorRed1="#843C39"
    const colorRed2="#AD494A"
    const colorRed3="#D6616B"
    const colorRed4="#E7969C"

    const colorOrange1="#E6550D"
    const colorOrange2="#FD8D3C"
    const colorOrange3="#FDAE6B"
    const colorOrange4="#FDD0A2"

    const colorGreen1="#31A354"
    const colorGreen2="#8CA252"
    const colorGreen3="#B5CF6B"
    const colorGreen4="#C7E9C0"

    const colorPurple1="#756BB1"
    const colorPurple2="#9E9AC8"
    const colorPurple3="#BCBDDC"
    const colorPurple4="#DADAEB"

    const colorDarkPurple1="#393B79"
    const colorDarkPurple2="#5254A3"
    const colorDarkPurple3="#6B6ECF"
    const colorDarkPurple4="#9C9EDE"

    const colorMagenta1="#7B4173"
    const colorMagenta2="#A55194"
    const colorMagenta3="#CE6DBD"
    const colorMagenta4="#DE9ED6"

    const colorGray1="#636363"
    const colorGray2="#969696"
    const colorGray3="#BDBDBD"
    const colorGray4="#D9D9D9"
end
