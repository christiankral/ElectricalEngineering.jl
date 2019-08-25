export arrow_out, arrow_in, arrow_in_out, winding_plot,
    count_coils, winding_mmf, mmf_sum, mmf_plot, winding_mmf_plot,
    slot_label, mmf_label

function arrow_out(x, y; r = 0.2, color = "black", linewidth = 1, ri = 0.05)
    phi = collect(0:pi/36:2*pi)
    fill(x .+ r .* cos.(phi), y .+ r .* sin.(phi),
        color = "white", linewidth = linewidth)
    plot(x .+ r .* cos.(phi), y .+ r .* sin.(phi),
        color = color, linewidth = linewidth)
    fill(x .+ ri .* cos.(phi), y .+ ri .* sin.(phi),
        color = color, linewidth = linewidth)
end

function arrow_in(x, y; r = 0.2, color = "black", linewidth = 1)
    phi = collect(0:pi/36:2*pi)
    fill(x .+ r .* cos.(phi), y .+ r .* sin.(phi),
        color = "white", linewidth = linewidth)
    plot(x .+ r .* cos.(phi), y .+ r .* sin.(phi),
        color = color, linewidth = linewidth)
    plot([x - r / sqrt(2), x + r/sqrt(2)], [y - r / sqrt(2), y + r/sqrt(2)],
        color = color, linewidth = linewidth)
    plot([x - r / sqrt(2), x + r/sqrt(2)], [y + r / sqrt(2), y - r/sqrt(2)],
        color = color, linewidth = linewidth)
end

function arrow_in_out(x, y; mag = 1, r = 0.2, color = "black", linewidth = 1,
    ri = 0.05)
    # mag > 0 plot arrow_out; regular size only with mag = 1
    # mag < 0 plot arrow_in; regular size only with mag = -1
    # mag = 0  does not plot an arrow
    # Size of arrow is scaled with mag
    if mag > 0
        arrow_out(x, y, r = r * mag, color = color, linewidth = linewidth,
            ri = ri)
    elseif mag < 0
        arrow_in(x, y,r = -r * mag, color = color, linewidth = linewidth)
    end
end

function winding_plot(w; r = 0.2,
    color = ["#E6550D", "#8CA252", "#6B6ECF"],
    slot = 1, yoke = 1, fillcolor = "#D9D9D9")
    # Determine the number of layers per slot
    Nl = size(w,1)
    Ns = size(w,2)
    for y in 1:Nl
        for x in 1:Ns
            # plot arrows
            arrow_in_out(x, Nl - y + 1, mag = sign(w[y,x]), color = color[abs(w[y,x])])
        end
    end
    # Create slot structure
    if abs(slot) == 1
        xcontour = cat([0.5, 0.5],
            repeat(collect(0.75:0.5:Ns + 0.4), inner=[2]),
            [Ns + 0.5, Ns + 0.5], dims = 1)
        if slot == 1
            ycontour = cat([0.5 - yoke],
                repeat([Nl+0.5, Nl+0.5, 0.5, 0.5], outer=[Ns]),
                [Nl+0.5, Nl+0.5, 0.5 - yoke], dims = 1)
        else
            ycontour = cat([Nl + yoke + 0.5],
                repeat([0.5, 0.5, Nl+0.5, Nl+0.5], outer=[Ns]),
                [0.5, 0.5, Nl + yoke + 0.5], dims = 1)
        end
    end
    # Plot slots
    fill(xcontour, ycontour, color = fillcolor)
    # Limit horiziontal range
    xlim(0,Ns+1)
    # Make a circle to appear as circle
    axis("equal")
    # Add tickst at the slot locations
    xticks(collect(1:Ns),fill("",Ns))
    # Do not use vertical ticks
    yticks([])
    # gca().spines["left"].set_visible(false)
    # gca().spines["top"].set_visible(false)
    # gca().spines["right"].set_visible(false)
    # gca().spines["bottom"].set_visible(false)
end

function count_coils(w; positive = true)
    # Number of phase
    m = max(maximum(w),minimum(-w))
    # Count positive and negative coil sides
    coils_pos = zeros(Int,m)
    coils_neg = zeros(Int,m)
    # Zero matrix for comparison
    coils_zer = zeros(Int,m)
    # Loop counting
    for k in 1:size(w,1)
        for j in 1:m
            coils_pos[j] += count(w[k,:] .== +j)
            coils_neg[j] += count(w[k,:] .== -j)
        end
    end

    # In case there are more positive than negative coil sides, a warning is
    # caused
    if coils_pos - coils_neg != coils_zer
        @warn "count_coils: Coils sides are not balanced"
        for j in 1:m
            if  coils_pos[j] != coils_neg[j]
                println("Phase ", j, " has ", coils_pos[j], " positive coil sides")
                println("Phase ", j, " has ", coils_neg[j], " negative coil sides")
            end
        end
    end
    # Return number of coils
    if positive
        return coils_pos
    else
        return coils_neg
    end
end

@doc raw"""
# Function call

`mmfwinding(w, i)`

# Description

Calculates the magnetomotive force distribution based on the winding layout
and the actual currents of polyphase winding

# Input variable

`w[:,:]` Winding array with equal number of windings per slot, where

- `size(w,1)` = number of layers, e.g. 1 or 2
- `size(w,2)` = number of slots

`i[:]` Actual phase currents for, e.g.,  the three phases, scaled to 1

# Output variables

`mmf[:,:]` Magnetomotive force, where

- `size(mmf,1)` = number phases
- `size(mmm,1)` = number of slots
"""
function winding_mmf(w, i)
    # Number of slots
    Ns = size(w, 2);
    # Number of layers
    Nl = size(w, 1)
    # Determine number of coils
    coils = count_coils(w)
    # Determine number of phases
    m = size(coils,1)

    # Create relative MMF curves
    wp = zeros(m, Ns);
    for l = 1:Nl
        for k = 1:Ns
            phase = abs(w[l, k])
            orientation = sign(w[l, k])
            # Do not consider invalid phase indices
            if phase > 0
                wp[phase, k] += orientation
            end
        end
    end
    # Initialize mmf
    mmf = zeros(size(wp))
    # Make mean value equal to zero
    for k = 1:m
        # Create cumulative sum
        mmf[k,:] = Base.cumsum(wp[k,:])
        mmf[k,:] = mmf[k,:] .- Statistics.mean(mmf[k,:]);
    end
    # Scale with I and N
    for k = 1:m
        mmf[k,:] = mmf[k,:] * i[k];
    end
    return mmf
end

function mmf_sum(mmf)
    return sum(mmf, dims = 1)
end

function slot_label(Ns; start = 1, inc = 1)
    ticks_label = fill("", Ns)
    for k in start:Ns
        if mod(k + start - 2, inc) == 0
            ticks_label[k] = string(k)
        end
    end
    xticks(collect(1:Ns), ticks_label)
end

function mmf_label(mmf1_max = 0; mmf_max = 0, inc = 0.5, showmmf = true,
    mmf1_label_neg = L"$-\hat V_{m,1}$", mmf1_label_pos = L"$+\hat V_{m,1}$",
    mmf_label_neg = L"$-\hat V_{m}$", mmf_label_pos = L"$+\hat V_{m}$")

    # Pick the greater of the two maxima
    mmf_limit = max(mmf1_max, mmf_max)

    # Create vector of positive ticks
    ticks_pos = collect(+inc:+inc:+mmf_limit)
    # Create vector of negative ticks
    ticks_neg = collect(-mmf_limit:+inc:-inc)
    # Create zero tick
    ticks_zer = [0]
    # Concatenate ticks
    ticks = vcat(ticks_neg,ticks_zer,ticks_pos)
    # Add only zero as label
    ticks_label = vcat(fill("",length(ticks_neg)),
        L"$0$", fill("",length(ticks_pos)))
    # Add MMF labels only if showmmf = true
    if showmmf
        # Add ±mmf1_max if not zero
        if mmf1_max != 0 && mmf1_max != mmf_max
            ticks = vcat(ticks,[-mmf1_max],[+mmf1_max])
            ticks_label = vcat(ticks_label,
                [mmf1_label_neg],[mmf1_label_pos])
        end
        # Add ±mmf_max if not zero
        if mmf_max != 0
            ticks = vcat(ticks,[-mmf_max],[+mmf_max])
            ticks_label = vcat(ticks_label,
                [mmf_label_neg],[mmf_label_pos])
        end
    end
    # Plot ticks
    yticks(ticks, ticks_label)
end

function mmf_plot(mmf; index = collect(1:size(mmf,1)),
    color = ["#E6550D", "#8CA252", "#6B6ECF", "black"],
    showsum = true, label = ["1", "2", "3", L"$\Sigma$"],
    showlegend = true, loc = "best",
    linestyle=[lineStyle1,lineStyle2,lineStyle3,lineStyle4],
    linewidth=[lineWidth1,lineWidth3,lineWidth2,lineWidth4])

    # Number of phases
    m = size(mmf,1)
    # Number of slots
    Ns = size(mmf,2)
    # Array of slot indices
    slots = collect(1:Ns)
    # Plot step curve
    for k in index
        step([0.5; slots; Ns + 0.5], [ mmf[k,end]; mmf[k,end]; mmf[k,:]],
            color = color[k], linestyle = linestyle[k],
            linewidth = linewidth[k], label = label[k]);
    end
    # Local maximum and minimum of the largest phase MMF
    mmf1_max = maximum(maximum(mmf,dims=2))
    mmf1_min = minimum(minimum(mmf,dims=2))

    if showsum
        # Determine sum of all MMF curves
        mmfsum = mmf_sum(mmf)
        # Determine the maximum of the total MMF
        mmf_max = max(maximum(maximum(mmf,dims=2)),maximum(mmfsum))
        mmf_min = min(minimum(minimum(mmf,dims=2)),minimum(mmfsum))
        step([0.5; slots; Ns + 0.5], [mmfsum[end]; mmfsum[end]; mmfsum'],
            linewidth = linewidth[m+1], color = color[m+1] ,
            label = label[m+1])
    else
        mmf_max = mmf1_max
        mmf_min = mmf1_min
    end
    # Limit horizontal range
    xlim(0,Ns+1)
    # Add tickst at the slot locations
    xticks(collect(1:Ns),fill("",Ns))
    # Do not use vertical ticks

    yt = collect(mmf_min:0.5:mmf_max)
    ylim(mmf_min-0.2,mmf_max+0.2)
    Nyt = size(yt,1)
    yticks(yt,fill("",Nyt))
    grid(true)
    legend(loc =loc, fontsize = legendFontSize);
    return (mmf1_max,mmf_max)
end

function winding_mmf_plot(w, i; r = 0.2,
    color = ["#E6550D", "#8CA252", "#6B6ECF", "black"],
    slot = 1, yoke = 1, fillcolor = "#D9D9D9",
    showsum = true, label = ["1", "2", "3", L"$\Sigma$"],
    linestyle=[lineStyle1,lineStyle3,lineStyle2,lineStyle4],
    linewidth=[lineWidth1,lineWidth3,lineWidth2,lineWidth4],
    showlegend = true, loc = "best",
    index = collect(1:size(winding_mmf(w,i),1)),
    showslot = true, start = 1, inc = 1, showmmf = true,
    mmf1_label_neg = L"$-\hat V_{m,1}$", mmf1_label_pos = L"$+\hat V_{m,1}$",
    mmf_label_neg = L"$-\hat V_{m}$", mmf_label_pos = L"$+\hat V_{m}$")

    # Plot winding layout
    # https://matplotlib.org/3.1.1/tutorials/intermediate/tight_layout_guide.html#sphx-glr-tutorials-intermediate-tight-layout-guide-py
    subplot2grid((3, 1), (0, 0))
    winding_plot(w, r = 0.2,
        color = color,
        slot = slot, yoke = yoke, fillcolor = fillcolor)
    # Determine exact extension of plot area
    ax = gca()

    # Plot MMF
    subplot2grid((3, 1), (1, 0), rowspan = 2)
    mmf = winding_mmf(w,i)
    # Plot MMF distribution
    (mmf1_max, mmf_max) = mmf_plot(mmf, index = collect(1:size(mmf,1)),
        color = color,
        showsum = showsum, label = label,
        linestyle = linestyle,
        linewidth = linewidth,
        showlegend = showlegend, loc = loc)
    if showslot
        slot_label(size(mmf,2), start = start, inc = inc)
    end
    # Re-adjust by doing everything twice
    mmf_label(mmf1_max, mmf_max = mmf_max, showmmf = showmmf,
        mmf1_label_neg = mmf1_label_neg, mmf1_label_pos = mmf1_label_pos,
        mmf_label_neg = mmf_label_neg, mmf_label_pos = mmf_label_pos)
    tight_layout()
    xlim(ax.axis()[1],ax.axis()[2])
    tight_layout()
    xlim(ax.axis()[1],ax.axis()[2])
end
