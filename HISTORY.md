# History.md

## v0.8.0 2024-08-31
- Switch to a different model of `arrowaxes`:
    - Function `arrowaxes` is re-written to allow more felxibility. However,
      the applied changes are non-backwards compatible. Yet, user code develop
      in previous versions of ElectricalEngineering may still work, depending
      on the used function arguments.
    - The function argument `axisoverhang` and `overhang` are obsolet
      and a warning is triggered, to let the user know, that this arguments
      will be removed in a future version
    - The scaling of the figure, to which `arrowaxes` is applied, is not
      changed any more. The user has to manually rescale the figure using `xlim`
      and `ylim` in case this is required for a proper apperance of the axis.
    - Two additional arguments `yleft` and `xbelow` are used to define the
      location of `ylabel` and `xlabel`, respectively.
- Functions `phasorsine` and `phasorcosine` now use a different scaling to be
  compatible with `arrowaxes`
  
## v0.7.1 2024-08-30
- Extende dependency range in Project.toml
- Switch from save3fig to save2fig for default exporting images

## v0.7.0 2024-08-29
- Add function `pasorcosine`

## v0.6.2 2023-02-24
- Fix missing return value in function `par`

## v0.6.1 2023-02-24
- Fix error in function `par`

## v0.6.0 2023-02-16
- Add the redundant function `par` as simplified and equivalent
  implementation to `∥`

## v0.5.0 2022-10-24
- Add dependency on Unitful 0.15.0 to improve compatibility

## v0.4.8 2022-10-20
- Remove Compat package

## v0.4.7 2022-10-19
- Change lineWidth3 from 1.5 to 1
- Change lineWidth4 from 1 to 1.5
- Change lineStyle3 to dash short
- Change lineStyle4 to dash dot
- Unify gray styles

## v0.4.1 2019-03-25
- Change UUID from
  ab11b94a-4edd-11e9-29d4-ab4fb969a4dc to
  84e62fa8-74a0-5990-9214-c45bd74ae4d7
  according to https://travis-ci.org/JuliaLang/METADATA.jl/jobs/510870012

## v0.4.0 2019-03-25
- Renamed package from EE.jl to ElectricalEngineering.jl accoriding to
  https://github.com/JuliaLang/METADATA.jl/pull/22394

## v0.3.0 2019-03-23
- Update limits of arrowaxes
- Fix issue caused by upgrading to Julia 1.0

## v0.2.9 2019-03-23
- Fix issues removeaxes not removing the axes entirely

## v0.2.8 2019-03-23
- Fix issues with matplotlib calls

## v0.2.7, 2019-03-18
- Fix issue with `setproperty!`

## v0.2.6, 2019-03-18
- Fix issue with vector length when adding scalar to vector

## v0.2.5, 2019-03-18
- Fix issue with integer arguments of function `range`

## v0.2.4, 2019-03-18
- Fix issue with obsolete function `linspace`

## v0.2.3, 2019-03-18
- Fix issue with obsolete function `atan2`

## v0.2.2, 2019-03-12
- Move test example to `examples` folder
- Create test runs to check EE package

## v0.2.1, 2019-03-12
- Switch to Julia 1.X package management system

## v0.1.2, 2019-03-09
- Last version supporting Julia 0.6.4

## v0.1.1, 2018-10-20
- Fixing bug in handling the condition of complex numbers, see #2

## v0.1.0, 2018-10-11
- Initial version
