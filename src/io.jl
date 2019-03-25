export printuln,usprint,save3fig

@doc raw"""
# Function call

`printuln(r...; label="")`

# Description

This function prints a real or complex variable in an optionally specified unit

# Variables

`r[1]` Text string to printed, indicating the variable name or description; a
maximum of 16 characters is allowed, in case the optional variable `label` is
NOT specified; in  case of specifying the variable `label`, the maximum length
of `r[1]` may not exceed 12 characters

`r[2]` Variable to be printed; the variable may be real or complex, units
assigned from the module Unitful are allowed; vectors of variables are also
allowed

`r[3]` Optional target unit of `r[2]` to be displayed

`label` Optional four character label structuring the output of variables, e.g.,
`label = "(a)"`

# Examples

```julia
julia> using Unitful, Unitful.DefaultSymbols, ElectricalEngineering
julia> U1 = 300V+j*400V
julia> printuln("U1", U1, kV)
              U1 = 0.3 kV + j 0.4 kV
                 = 0.5 kV ∠ 53.1301°
julia> printuln("real(U1)", real(U1), kV)
        real(U1) = 0.3 kV
julia> printuln("U1", U1, V, label="(a)")
(a)           U1 = 300 V + j 400 V
                 = 500 V ∠ 53.1301°
```
"""
function printuln(r...; label="")
    # r[1] = 1st argument = string to be printed
    # r[2] = 2nd argument = quantity to shown
    # r[3] = 3rd argument = optional output unit
    # If unit is specified as preferred 3rd argument, then convert number
    # to this argument
    for k in collect(1:size(r[2], 1))
        if length(r) >= 3
            # Convert numerical value to specified units
            # Change printed unit
            num = uconvert(r[3], r[2][k])
        else
            num = r[2][k]
        end
        numunit = unit(num)

        # Real and imaginary part
        numre = ustrip(real(num))
        numim = ustrip(imag(num))
        # Magnitude and angle
        numabs = abs(ustrip(num))
        numargdeg = angle(ustrip(num))*180/pi
        # Determine unit associated to numeric value and consider
        # special spelling of units

        # Print text string (1st argument)
        if size(r[2], 1) == 1
          # Second argument (string) is a scalar value
          if label == ""
              @printf("%16s = ", r[1])
          else
              @printf("%-4s%12s = ",label, r[1])
          end
        else
          # Second argument (string) is a vector
          if label == ""
              @printf("%16s = ", r[1]*"["*@sprintf("%i", k)*"]")
          else
              if k == 1
                  # Print label only in first entry
                  @printf("%-4s%12s = ", label, r[1]*"["*@sprintf("%i", k)*"]")
              else
                  # Omit label on sencond and following entries
                  @printf("%16s = ", r[1]*"["*@sprintf("%i", k)*"]")
              end
          end
        end
        @printf("%g %s", numre, numunit)
        if numim > 0
            @printf(" + j*%g %s\n", abs(numim), numunit)
            @printf("%16s = %g %s ∠ %g°\n","",numabs, numunit, numargdeg)
        elseif ustrip(imag(num)) < 0
            @printf(" - j*%g %s\n",abs(numim), numunit)
            @printf("%16s = %g %s ∠ %g°\n","",numabs, numunit, numargdeg)
        else
            @printf("\n")
        end
    end
end


"""
# Function call

`usprint(u,U)`

# Description

Returns a string containing the number with six digits plus unit without space
in between, such that the string output can be copied and pasted.

# Variables

`u` Variable to be processed

`U` Optional target unit; if not provided, the actual unit is used

# Examples
```julia
julia> I1 = 1mA
julia> usprint(I1)
1mA
julia> usprint(I1, A)
0.001A
"""
function usprint(u, U=unit(u))
    q = uconvert(U, u)
    return @sprintf("%g%s", Float64(ustrip(q)), U)
end

"""
# Function call

`save3fig(fileName, subDir="."; dpi=300, tight=true, crop=false)`

# Description

Save the actual figure in the following three file formats
- `png` Portable network graphics in subdirectory png/
- `eps` Encapsulated postscript in subdirectory eps/
- `pdf` Encapsulated postscript in subdirectory pdf/
These three graphics format are relevant when processing figures in LaTeX,
LyX, LibreOffice or other word processors

# Variables

`fileName` String of the filename, extended by `.png`, `.eps` and `.pdf`; the
file names are stored in sub directories `png/`, `eps/` and `pdf/`

`subDir` String of sub directory in which the adjacent sub directories  `png/`,
`eps/` and `pdf/` are located; default = `.` (local work directory)

`dpi` Resolution of the stored PNG file; default = 300 (dpi)

`tight` Additional margin around the figure is removed, except for a 2% margin;
default = `true`

`crop` Crop all 'white' space around the figure; this feature requires the
installation of the following software
- imagemagick to be applied to `png` files,
  see https://www.imagemagick.org/script/index.php on Windows
  or apply `sudo apt install imagemagick` on Linux (Mint or Ubuntu)
- epstool to be applied to `eps` files, see
  http://pages.cs.wisc.edu/~ghost/gsview/epstool.htm on Windows
  or apply `sudo apt install epstool` on Linux (Mint or Ubuntu)
- pdfcrop to be applied to `pdf` files, see
  https://www.ctan.org/pkg/pdfcrop on Windows
  or apply `sudo apt install texlive-extra-utils` on Linux (Mint or Ubuntu)

# Examples

```julia
julia> save3fig("phasordiagram")
julia> save3fig("phasordiagram_crop", crop=true)
```
"""
function save3fig(fileName, subDir="."; dpi=300, tight=true, crop=false)
    # Store PNG file
    mkpath(subDir*"/png")
    if tight == false
        savefig(subDir*"/png/"*fileName*".png", dpi=dpi)
    else
        savefig(subDir*"/png/"*fileName*".png", dpi=dpi,
            bbox_inches = "tight", pad_inches=0.02)
    end
    if crop==true
        try
            arg = `$subDir/png/$fileName.png`
            status = readstring(`convert $arg -trim $arg`);
        catch err
            error("module ElectricalEngineering: function save3fig: Binary file not found: convert
    The software convert (imagemagick) may not be installed or the path may not
    be specified or the software may have caused a runtime error
    To install imagemagick, see https://www.imagemagick.org/script/index.php on
    Windows or apply `sudo apt install imagemagick` on Linux (Mint or Ubuntu)")
        end
    end

    # Store EPS file
    mkpath(subDir*"/eps")
    if tight == false
        savefig(subDir*"/eps/"*fileName*".eps")
    else
        savefig(subDir*"/eps/"*fileName*".eps",
            bbox_inches = "tight", pad_inches=0.02)
    end
    if crop==true
        try
            arg = `$subDir/eps/$fileName.eps`
            argtemp = `$subDir/eps/$fileName.eps.temp`
            status = readstring(`epstool --copy --bbox $arg $argtemp`);
            mv(subDir*"/eps/"*fileName*".eps.temp",
                subDir*"/eps/"*fileName*".eps",
                remove_destination=true)
        catch err
            error("module ElectricalEngineering: function save3fig: Binary file not found: epstool
    The software epstool may not be installed or the path may not be specified
    or the software may have caused a runtime error
    To install epstool, see http://pages.cs.wisc.edu/~ghost/gsview/epstool.htm
    on Windows or apply `sudo apt install epstool` on Linux (Mint or Ubuntu)")
        end
    end

    # Store PDF file
    mkpath(subDir*"/pdf")
    if tight == false
        savefig(subDir*"/pdf/"*fileName*".pdf")
    else
        savefig(subDir*"/pdf/"*fileName*".pdf",
            bbox_inches="tight", pad_inches=0.02)
    end
    if crop == true
        try
            arg = `$subDir/pdf/$fileName.pdf`
            status=readstring(`pdfcrop $arg $arg`);
        catch err
            error("module ElectricalEngineering: function save3fig: Binary file not found: dpfcrop
    The software pdfcrop may not be installed or the path may not be specified
    or the software may have caused a runtime error
    To install pdfcrop, see https://www.ctan.org/pkg/pdfcrop on Windows
    or apply `sudo apt install texlive-extra-utils` on Linux (Mint or Ubuntu)")
        end
    end
end
