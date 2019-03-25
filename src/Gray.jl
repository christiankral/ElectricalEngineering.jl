"""
# ElectricalEngineering.Gray

Defines colors based on the four base types of gray `colorBlack1`,
`colorBlack2`, `colorBlack3` and `colorBlack4`. So independent of the picked
color everything will always appear in gray scale. This way a gray scale and a
color plot can alternatively be created. So either `ElectricalEngineering.Gray` or `ElectricalEngineering.Tab20bc` can
be loaded (at a time) and be used.

# Colors

The following colors are substitued by `colorBlack1`,
`colorBlack2`, `colorBlack3` and `colorBlack4`:

- `colorBrown1`, `colorBrown2`, `colorBrown3`, `colorBrown4`
- `colorBlue1`, `colorBlue2`, `colorBlue3`, `colorBlue4`
- `colorRed1`, `colorRed2`, `colorRed3`, `colorRed4`
- `colorOrange1`, `colorOrange2`, `colorOrange3`, `colorOrange4`
- `colorGreen1`, `colorGreen2`, `colorGreen3`, `colorGreen4`
- `colorPurple1`, `colorPurple2`, `colorPurple3`, `colorPurple4`
- `colorDarkPurple1`, `colorDarkPurple2`, `colorDarkPurple3`, `colorDarkPurple4`
- `colorGray1`, `colorGray2`, `colorGray3`, `colorGray4`
- `colorMagenta1`, `colorMagenta2`, `colorMagenta3`, `colorMagenta4`

# Example

Copy and paste code:

```julia
using PyPlot,ElectricalEngineering,ElectricalEngineering.Gray
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

`ElectricalEngineering.Tab20bc`

"""
module Gray
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

    # Color scheme is only based on colorBlack1..4
    const colorBrown1=colorBlack1
    const colorBrown2=colorBlack2
    const colorBrown3=colorBlack3
    const colorBrown4=colorBlack4

    const colorBlue1=colorBlack1
    const colorBlue2=colorBlack2
    const colorBlue3=colorBlack3
    const colorBlue4=colorBlack4

    const colorRed1=colorBlack1
    const colorRed2=colorBlack2
    const colorRed3=colorBlack3
    const colorRed4=colorBlack4

    const colorOrange1=colorBlack1
    const colorOrange2=colorBlack2
    const colorOrange3=colorBlack3
    const colorOrange4=colorBlack4

    const colorGreen1=colorBlack1
    const colorGreen2=colorBlack2
    const colorGreen3=colorBlack3
    const colorGreen4=colorBlack4

    const colorPurple1=colorBlack1
    const colorPurple2=colorBlack2
    const colorPurple3=colorBlack3
    const colorPurple4=colorBlack4

    const colorDarkPurple1=colorBlack1
    const colorDarkPurple2=colorBlack2
    const colorDarkPurple3=colorBlack3
    const colorDarkPurple4=colorBlack4

    const colorMagenta1=colorBlack1
    const colorMagenta2=colorBlack2
    const colorMagenta3=colorBlack3
    const colorMagenta4=colorBlack4

    const colorGray1=colorBlack1
    const colorGray2=colorBlack2
    const colorGray3=colorBlack3
    const colorGray4=colorBlack4
end
