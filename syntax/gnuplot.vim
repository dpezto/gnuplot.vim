" Vim syntax file
" Language:    gnuplot 6
" Maintainer:  Dai López Jacinto <dpezto@gmail.com>
" URL:         https://github.com/dpezto/gnuplot.vim
" License:     MIT
"
" The keyword lists at the bottom of this file are generated from
" keywords.json, a pinned copy of the dictionary emitted by the
" tree-sitter-gnuplot grammar. Every gnuplot keyword may be abbreviated down to
" some minimum length, and Vim's `syn keyword` spells that natively as
" `xr[ange]` — so the abbreviation rules are carried over exactly without a
" single regex. Edit keywords.json and run `npm run gen:syntax`; do not edit
" between the generated markers.
scriptencoding utf-8


if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" gnuplot identifiers are [A-Za-z_][A-Za-z0-9_]*, and several built-in
" variables (GPVAL_TERM, STATS_mean_y) rely on '_' being a keyword character.
syn iskeyword @,48-57,_

" Comments ------------------------------------------------------------------
" A trailing backslash continues a comment onto the next line.
syn match   gnuplotComment "#.*\%(\\\n.*\)*$" contains=gnuplotTodo,@Spell
syn keyword gnuplotTodo contained TODO FIXME XXX BUG NOTE HACK

" Strings -------------------------------------------------------------------
" Double quotes interpret backslash escapes; single quotes do not.
syn match   gnuplotEscape contained "\\\%([\\abfnrtv"']\|[0-7]\{1,3}\|x\x\{1,2}\|u\x\{4}\|U\x\{8}\)"
syn match   gnuplotFormat  contained "%[-+ #0]*\d*\%(\.\d\+\)\?[hlLqjzt]*[diouxXeEfgGcsSpP%]"
syn region  gnuplotString  start=+"+ skip=+\\.+ end=+"+ contains=gnuplotEscape,gnuplotFormat,@Spell
syn region  gnuplotString  start=+'+ end=+'+ contains=gnuplotFormat,@Spell

" Datablocks ----------------------------------------------------------------
" `$data << EOD ... EOD` — the terminator is user-chosen, so match the whole
" block generically rather than pinning it to EOD.
" Column references in a using spec (`using ($1+$2)`). Digits, so this can
" never collide with the `$name` forms below.
syn match   gnuplotColumnRef "\$\d\+"

" The reference form (`plot $data`) is defined FIRST: when two items can start
" at the same position Vim prefers the one defined later, so a trailing match
" on `$name` would out-rank the region and stop it opening at all.
syn match   gnuplotDatablockRef "\$\h\w*"
syn region  gnuplotDatablock matchgroup=gnuplotDatablockName contains=NONE
      \ start="^\s*\$\h\w*\s*<<\s*\z(\h\w*\)" end="^\s*\z1\s*$"
syn match   gnuplotOperator "<<" containedin=gnuplotDatablockName

" Macros --------------------------------------------------------------------
syn match   gnuplotMacro "@\h\w*"

" Numbers -------------------------------------------------------------------
" gnuplot folds a unit suffix into the number itself (10cm, 3.0in, 0.5pt). The
" full set is the grammar's typographic-unit alternation; `inch` has to precede
" `in` or the longer spelling never matches.
syn match   gnuplotNumber "\<\d\+\%(\.\d*\)\?\%([eE][-+]\?\d\+\)\?\%(cm\|inch\|in\|mm\|pt\|pc\|bp\|dd\|cc\|pi\)\?\>"
syn match   gnuplotNumber "\<\.\d\+\%([eE][-+]\?\d\+\)\?\%(cm\|inch\|in\|mm\|pt\|pc\|bp\|dd\|cc\|pi\)\?\>"
syn match   gnuplotNumber "\<0[xX]\x\+\>"

" Built-in variables --------------------------------------------------------
" GPVAL_*, MOUSE_*, FIT_*, ARG*, and the `stats`/`fit` output variables, whose
" prefix the user chooses (`stats … prefix "FOO"`).
syn match   gnuplotBuiltinVar "\<\%(GPVAL\|MOUSE\|FIT\)_\w\+\>"
syn match   gnuplotBuiltinVar "\<ARG\%(C\|V\|\d\+\)\>"
syn match   gnuplotBuiltinVar "\<\w\+_\%(mean\|stddev\|skewness\|kurtosis\)\%(_err\)\?\%(_x\|_y\)\?\>"
syn match   gnuplotBuiltinVar "\<\w\+_\%(min\|max\|sdd\|adev\|median\|sum\%(sq\)\?\|\%(lo\|up\)_quartile\)\%(_x\|_y\)\?\>"
syn match   gnuplotBuiltinVar "\<\w\+_\%(slope\|intercept\)\%(_err\)\?\>"
syn match   gnuplotBuiltinVar "\<\w\+_\%(records\|headers\|outofrange\|invalid\|blank\|blocks\|correlation\|sumxy\|columns\|column_header\|size_x\|size_y\)\>"
syn keyword gnuplotBuiltinVar GNUTERM VoxelDistance GridDistance

" Functions -----------------------------------------------------------------
" Any identifier immediately followed by '(' reads as a call; the built-in list
" is defined afterwards so it wins on the same match position.
syn match   gnuplotFunction "\<\h\w*\ze("
syn match   gnuplotBuiltinFunction "\<\%(abs\|acosh\|acos\|airy\|arg\|asinh\|asin\|atan2\|atanh\|atan\|cbrt\|ceil\|conj\|cosh\|cos\|exp\|floor\|imag\|int\|log10\|log\|norm\|rand\|real\|round\|sgn\|sinh\|sin\|sqrt\|tanh\|tan\)\ze("
syn match   gnuplotBuiltinFunction "\<\%(bes[ijy][01n]\|Ai\|Bi\|Bessel[HIJKY]1\?2\?\|Elliptic[EKP]i\?\|erfc\|erfi\|erf\|expint\|gamma\|ibeta\|igamma\|inverf\|invibeta\|invigamma\|invnorm\|LambertW\|lgamma\|lnGamma\|SynchrotronF\|uigamma\|voigt\|zeta\)\ze("
syn match   gnuplotBuiltinFunction "\<\%(cdawson\|cerf\|faddeeva\|Fresnel[CS]\|VP\%(_fwhm\)\?\)\ze("
syn match   gnuplotBuiltinFunction "\<\%(gprintf\|sprintf\|strlen\|strstrt\|substr\|split\|join\|trim\|word\|words\|system\)\ze("
syn match   gnuplotBuiltinFunction "\<\%(column\|columnhead\%(er\)\?\|stringcolumn\|strcol\|exists\|valid\|value\|hsv2rgb\|palette\|rgbcolor\|voxel\|index\)\ze("
syn match   gnuplotBuiltinFunction "\<\%(time\%(column\)\?\|strftime\|strptime\|tm_\w\+\|weekdate_\%(iso\|cdc\)\)\ze("

" Operators -----------------------------------------------------------------
syn match   gnuplotOperator "[-+*/%^!~?:.,]"
syn match   gnuplotOperator "\*\*"
syn match   gnuplotOperator "[=!<>]="
syn match   gnuplotOperator "[<>]"
syn match   gnuplotOperator "<<\|>>"
syn match   gnuplotOperator "&&\|||\|[&|]"
syn match   gnuplotOperator "="
" The grammar gives the word operators their own node, so they get their own
" group here too.
syn keyword gnuplotKeywordOperator eq ne

syn match   gnuplotBracket "[][(){}]"

" An open range end (`[*:*]`, `A[*]`) is a wildcard; a bare `*` between
" operands is multiplication. Only the bracket-adjacent form is special.
syn match   gnuplotWildcard "\[\zs\*"
syn match   gnuplotWildcard "\*\ze[]:]"
syn match   gnuplotWildcard "[:[]\zs\*\ze\]"

" Connectors ----------------------------------------------------------------
" `at`, `via`, `from`, `to`, `by` join a clause to its argument. The grammar
" aliases them to one tier and the queries capture that as @keyword.function.
syn keyword gnuplotConnector at via from to by inverse sample

" Pseudo plot-elements: they fill an element slot without naming a data source.
syn keyword gnuplotPseudoElement newhistogram newspiderplot keyentry

" `variable` in a style slot means "take the value from the data".
syn keyword gnuplotStyleVariable variable

" Named colours and palette presets.
syn keyword gnuplotColorName viridis black bgnd background

" Shell escape --------------------------------------------------------------
" Only the `!` itself is the command; the rest of the line is a shell command,
" which the tree-sitter side highlights by injecting bash. Vim has no
" equivalent, so it is left unstyled rather than painted as one blob.
syn match   gnuplotShell "^\s*!"
" The grammar aliases `system` and `!` to the same command. `system` is also a
" string function, and a keyword would out-rank the function match above and
" break `system("ls")` — so the command form is a match that excludes a call.
syn match   gnuplotCommand "\<system\>\%(\s*(\)\@!"

" Keywords ------------------------------------------------------------------
" >>> generated by scripts/gen-syntax.mjs — do not edit by hand
" 724 keywords across 6 groups. Regenerate with
" `npm run gen:syntax` after updating keywords.json.
" Groups are emitted in reverse-priority order: Vim resolves a keyword
" defined twice to the last definition.

syn keyword gnuplotValue acsplines all allwindows anchor ansi ansi256 ansirgb
syn keyword gnuplotValue any avg axis backward base baseline bdefault beveled
syn keyword gnuplotValue bezier big blacktext both brief butt button1 button2
syn keyword gnuplotValue button3 cartesian cauchy ccw classic clockwise close
syn keyword gnuplotValue cnormal colortext colourtext columnsfirst context
syn keyword gnuplotValue counterclockwise cp1250 cp1251 cp1252 cp1254 cp437
syn keyword gnuplotValue cp850 cp852 cp950 csplines cumulative cw cylindrical
syn keyword gnuplotValue dashed days defaultplex defaults downwards duplex
syn keyword gnuplotValue dynamic eject empty eps errors explicit fix fixed
syn keyword gnuplotValue float fnormal fortran forward frequency full
syn keyword gnuplotValue fullwidth gauss geographic giant gnuplot gray hann
syn keyword gnuplotValue hex hours implicit iso_8859_1 iso_8859_15 iso_8859_2
syn keyword gnuplotValue iso_8859_9 kdensity keepfix keypress koi8r koi8u
syn keyword gnuplotValue landscape large latex level1 level3 leveldefault
syn keyword gnuplotValue linear mcsplines medium minutes mitered mono months
syn keyword gnuplotValue mpoints nodraw none nooffset nops_allcF normalpoints
syn keyword gnuplotValue nosquare notransparent noundefined nounit numeric off
syn keyword gnuplotValue offset on parallel path pdf pdftricks2 perl perltkx
syn keyword gnuplotValue pixels png podo polygon portrait ps_allcF pstricks
syn keyword gnuplotValue python results rexx rounded rowsfirst ruby sbezier
syn keyword gnuplotValue script seconds session simplex sjis small smallpoints
syn keyword gnuplotValue solid spherical splines square sum swarm tcl tex
syn keyword gnuplotValue texarrows texpoints texthidden textnormal textrigid
syn keyword gnuplotValue textspecial time timedate tiny tinypoints trip
syn keyword gnuplotValue undefined unique unit unwrap upwards utf8 v4 v5 weeks
syn keyword gnuplotValue x0 x1 xx xy xyz xz y0 y1 years yy yz z0

syn keyword gnuplotFlag altdiagonal antialias attributes auxfile back backhead
syn keyword gnuplotFlag backheads behind bentover box boxed character clipcb
syn keyword gnuplotFlag columnheaders covariancevariables crop ctrl ctrlq
syn keyword gnuplotFlag depthorder enhanced equal errorscaling errorvariables
syn keyword gnuplotFlag externalimages feed filled first front ftriangles
syn keyword gnuplotFlag fulldoc gparrows gppoints graph head heads hypertext
syn keyword gnuplotFlag inlineimages interactive interlace invert lighting
syn keyword gnuplotFlag mirror noaltdiagonal noanimate noantialias
syn keyword gnuplotFlag noattributes noauxfile nobentover noborder nobox
syn keyword gnuplotFlag noboxed noclipcb nocolumnheaders nocontours
syn keyword gnuplotFlag nocovariancevariables nocrop noctrl noctrlq noenhanced
syn keyword gnuplotFlag noequal noerrorscaling noerrorvariables noextend
syn keyword gnuplotFlag noexternalimages nofeed nofilled nofpe_trap
syn keyword gnuplotFlag noftriangles nofulldoc nogparrows nogppoints nogrid
syn keyword gnuplotFlag nohead noheads nohidden3d nointerlace noinvert
syn keyword gnuplotFlag nolighting nologfile nomirror noopaque nooriginreset
syn keyword gnuplotFlag nooutliers nopersist nopicenvironment nopoint
syn keyword gnuplotFlag noprescale noproportional nopspoints norangelimited
syn keyword gnuplotFlag noreplotonresize noreverse norotate norottext
syn keyword gnuplotFlag nostandalone nosurface notightboundingbox notikzarrows
syn keyword gnuplotFlag notruecolor novertical nowedge nowriteback opaque
syn keyword gnuplotFlag originreset outliers persist picenvironment prescale
syn keyword gnuplotFlag psarrows pspoints rangelimited replotonresize reverse
syn keyword gnuplotFlag rotate rottext screen scroll second standalone
syn keyword gnuplotFlag tightboundingbox tikzarrows truecolor vertical wedge
syn keyword gnuplotFlag writeback

syn keyword gnuplotOption Left Right absolute add angle angles append arc
syn keyword gnuplotOption arrow arrowstyle as aspect at auto autofreq
syn keyword gnuplotOption autojustify autoscale autotitle azimuth bars bmargin
syn keyword gnuplotOption border bottom boxdepth boxwidth bs bspline by
syn keyword gnuplotOption cairolatex canvas cbdata cbdtics cblabel cbmtics
syn keyword gnuplotOption cbrange cbtics center cgm charsize clip clustered
syn keyword gnuplotOption cntrlabel cntrparam color colorbox colormap
syn keyword gnuplotOption colornames colorsequence columnheader columns
syn keyword gnuplotOption columnstacked contourfill contours cornerpoles
syn keyword gnuplotOption cubehelix cubicspline cycle cycles dashlength
syn keyword gnuplotOption dashtype datafile decimalsign default defined
syn keyword gnuplotOption degrees delay dgrid3d discrete dl domterm
syn keyword gnuplotOption doubleclick dt dumb dummy dxf emf encoding epscairo
syn keyword gnuplotOption epslatex errorbars fc fig file fillchar fillcolor
syn keyword gnuplotOption fillstyle firstlinetype fit2rgbformulae flush font
syn keyword gnuplotOption fontscale fontsize format fraction from fs fsize
syn keyword gnuplotOption functions gamma gap gif gradient grid header height
syn keyword gnuplotOption hidden3d horizontal hpgl incremental inside
syn keyword gnuplotOption insidecolor interval isosamples isosurface isotropic
syn keyword gnuplotOption jitter jpeg jsdir key keywidth kittycairo kittygd
syn keyword gnuplotOption label layerdefault lc left levels limit limit_abs
syn keyword gnuplotOption linecolor linestyle linetype linewidth link lmargin
syn keyword gnuplotOption loadpath locale logfile logscale loop ls lt lua lw
syn keyword gnuplotOption map mapping margins maxcolors maxcols maxiter
syn keyword gnuplotOption maxrows mcbtics medianlinewidth micro minussign
syn keyword gnuplotOption mixed monochrome mouse mouseformat mrtics mttics
syn keyword gnuplotOption multiplot mutics mvtics mvxtics mvytics mvztics
syn keyword gnuplotOption mx2tics mxtics mxytics my2tics mytics mztics
syn keyword gnuplotOption negative new noautotitle noborder noclip
syn keyword gnuplotOption nodoubleclick noheader nohidden3d noinsidecolor
syn keyword gnuplotOption nokeyseparators nolink nologfile nologscale
syn keyword gnuplotOption nonlinear noo[utput] nopolar nopolardistance
syn keyword gnuplotOption nopolardistancedeg nopolardistancetan noratio
syn keyword gnuplotOption noruler notimestamp notit[le] noverbose
syn keyword gnuplotOption nozoomcoordinates nozoomjump numbers o[utput] object
syn keyword gnuplotOption offsets one onecolor order origin outside overflow
syn keyword gnuplotOption overlap palette palfuncparam parametric paxis pcl5
syn keyword gnuplotOption pdfcairo pi pict2e pixmap plotsize pm3d pn pngcairo
syn keyword gnuplotOption point pointinterval pointintervalbox pointnumber
syn keyword gnuplotOption pointscale pointsize pointsmax pointtype polar
syn keyword gnuplotOption polardistance polardistancedeg polardistancetan
syn keyword gnuplotOption positive postscript projection ps psdir pslatex
syn keyword gnuplotOption pstex pt qnorm qt quality quiet radial radians
syn keyword gnuplotOption radius range ratio raxis rdata rdtics relative
syn keyword gnuplotOption resolution rgbformulae rgbmax right rlabel rmargin
syn keyword gnuplotOption rmtics rowstacked rrange rtics rto ruler samplen
syn keyword gnuplotOption samples saturation scale separation sixelgd size
syn keyword gnuplotOption sorted spacing spiderplot spotlight spread style
syn keyword gnuplotOption surface svg t[erminal] table tc tdata tdtics tek40xx
syn keyword gnuplotOption tek410x termoption texdraw textcolor theta tics tikz
syn keyword gnuplotOption timefmt timestamp tit[le] tkcanvas tlabel tmargin
syn keyword gnuplotOption tmtics to top trange trianglepattern triangles ttics
syn keyword gnuplotOption two udata udtics ulabel umtics units unknown
syn keyword gnuplotOption unsorted urange user utics variables vdata vdtics
syn keyword gnuplotOption verbose version vgrid view vlabel vmtics vrange
syn keyword gnuplotOption vtics vttek vxdata vxdtics vxlabel vxmtics vxrange
syn keyword gnuplotOption vxtics vydata vydtics vylabel vymtics vyrange vytics
syn keyword gnuplotOption vzdata vzdtics vzlabel vzmtics vzrange vztics walls
syn keyword gnuplotOption webp width window wrap wxt x11 x2data x2dtics
syn keyword gnuplotOption x2label x2mtics x2range x2tics x2zeroaxis xdata
syn keyword gnuplotOption xdtics xlabel xmtics xrange xterm xtics xydata
syn keyword gnuplotOption xydtics xylabel xymtics xyplane xyrange xytics
syn keyword gnuplotOption xzeroaxis y2data y2dtics y2label y2mtics y2range
syn keyword gnuplotOption y2tics y2zeroaxis ydata ydtics ylabel ymtics yrange
syn keyword gnuplotOption ytics yzeroaxis zdata zdtics zero zeroaxis zlabel
syn keyword gnuplotOption zmtics zoomcoordinates zoomfactors zoomjump zrange
syn keyword gnuplotOption ztics zzeroaxis

syn keyword gnuplotStyle arrows boxerrorbars boxes boxplot boxxyerror
syn keyword gnuplotStyle candlesticks circle circles data dots ellipse
syn keyword gnuplotStyle ellipses errorlines filledcurves fillsteps
syn keyword gnuplotStyle financebars fsteps function histeps histogram
syn keyword gnuplotStyle histograms hsteps image impulses l[ines] labels line
syn keyword gnuplotStyle linesp[oints] lp mask nolabels p[oints] parallelaxes
syn keyword gnuplotStyle parallelaxis polygons rectangle rgbalpha rgbimage
syn keyword gnuplotStyle sectors steps textbox vectors watchpoint xerrorbars
syn keyword gnuplotStyle xerrorlines xyerrorbars xyerrorlines yerrorbars
syn keyword gnuplotStyle yerrorlines zerrorfill

syn keyword gnuplotAttribute axes binrange bins binvalue binwidth every if
syn keyword gnuplotAttribute index not[itle] perpendicular scan smooth u[sing]
syn keyword gnuplotAttribute w[ith] watch

syn keyword gnuplotCommand bind break call cd clear continue evaluate exit fit
syn keyword gnuplotCommand help history import load lower noraise p[lot] pause
syn keyword gnuplotCommand print printerror pwd quit raise refresh remultiplot
syn keyword gnuplotCommand rep[lot] reread reset save set show sp[lot] stats
syn keyword gnuplotCommand test toggle undefine unset vclear warn

" Spelled like :syn arguments, so these cannot be keywords.
syn match gnuplotFlag "\<extend\>"
syn match gnuplotOption "\<start\>"
syn match gnuplotValue "\<transparent\>"
" <<< end generated block

" Built-in constants --------------------------------------------------------
" After the generated block on purpose: `pi` is also the two-letter spelling of
" `pointinterval`, and a bare `pi` is far more often the constant.
syn keyword gnuplotConstant pi NaN Inf

" Literals the dictionary does not carry -------------------------------------
" keywords.json only covers tokens the grammar resolves through its scanner
" tiers. A handful of words are plain literals in the grammar instead, so they
" are listed here by hand.
" Values
syn keyword gnuplotValue  whitespace tab comma
syn keyword gnuplotValue  above below closed between
" `title columnheader` takes no parentheses but is still the builtin. Defined
" after the generated block so it out-ranks the option-tier entry for the same
" word.
syn keyword gnuplotBuiltinFunction columnheader columnhead

" The queries class these as @attribute rather than enumerated values.
" `transparent` is spelled like a :syn argument, so it can only be a match.
syn match   gnuplotStyle  "\<transparent\>"
syn keyword gnuplotStyle  solid separator monochrome nobackground
syn keyword gnuplotStyle  animate input units_opt RGB CMY HSV
" Sub-keywords the grammar spells as self-named key() aliases, which its
" dictionary generator skips on purpose because the parse tables already
" describe them. They still need naming here.
syn keyword gnuplotOption binary matrix via name
syn keyword gnuplotFlag   nooutput
syn keyword gnuplotOption rgbcolor rgb fill func[tion] increment
syn keyword gnuplotOption defined maxcolors gamma
syn keyword gnuplotCommand shell

" The rest of that same class, recovered by mining every terminal out of the
" grammar's src/grammar.json and subtracting what this file already names.
" Grouped by where the grammar puts them; `npm run gen:syntax` never touches
" any of it, so a word that later appears in keywords.json must be deleted
" here or Vim will resolve it to whichever definition comes last.
syn keyword gnuplotCommand vfill vgfill
" `set pm3d` bodies: clip modes, corners2color, lighting and spotlight.
syn keyword gnuplotOption clip1in clip4in corners2color zclip interpolate
syn keyword gnuplotOption primary specular spec2 rot_x rot_z
syn keyword gnuplotValue  geomean harmean rms c1 c2 c3 c4
" Option heads and suboptions the grammar spells as bare literals.
syn keyword gnuplotOption changes datablocks commentschars missing colour
syn keyword gnuplotOption model pattern layout length position prefix frac
syn keyword gnuplotOption whiskerbars
" Axis names. `cb`, `x2`, `y2` and the voxel axes are one alternation in the
" grammar; the single-letter members are left out for the same reason
" abbreviations are — a bare `r` or `t` is far more often a variable.
syn keyword gnuplotOption cb x2 y2 vx vy vz
syn keyword gnuplotValue  x1y1 x1y2 x2y1 x2y2
" Toggles that take no `no` counterpart.
syn keyword gnuplotFlag   long restore retrace noautoscale
" Datafile modifiers: the `binary`/`matrix` keywords and the plot-element
" filters that sit alongside `every`/`using`.
syn keyword gnuplotAttribute record filetype endian dx dy dz transpose
syn keyword gnuplotAttribute flipx flipy flipz nonuniform sparse expand
syn keyword gnuplotAttribute convexhull concavehull rowheaders sharpen
syn keyword gnuplotAttribute volatile zsort unitweights bandwidth period
syn keyword gnuplotValue  scansautomatic scansforward scansbackward
syn keyword gnuplotValue  little middle pdp swab swap
" `with isosurface level <n>`, and the plural error-bar styles.
syn keyword gnuplotStyle  level xyerrors yerrors zerrors
" Assorted values: `exit message`, `at beginning`, `set terminal push|pop`.
syn keyword gnuplotValue  beginning message status next previous push pop
" Spelled like :syn arguments, so these can only be matches — same quirk the
" generated block works around for `extend` and `start`.
syn match   gnuplotAttribute "\<skip\>"
syn match   gnuplotValue     "\<end\>"

" Control flow --------------------------------------------------------------
" These are plain literals in the grammar rather than tier keywords, so they do
" not appear in keywords.json and are listed by hand. Defined after the
" generated block so they win over it: `if` is also the plot-element data
" filter (`plot 'f' if ($1>0)`), which the dictionary classes as an attribute,
" and reading it as a conditional is the better default.
syn keyword gnuplotConditional if else
syn keyword gnuplotRepeat      do while for in
syn keyword gnuplotCommand     array sum

" Highlight links -----------------------------------------------------------
" The group names come from the grammar's capture taxonomy, where an alias
" names the clause family a word belongs to rather than the word itself: `cmd`
" is a command verb, `opt`/`arg` a set/show option or one of its suboptions,
" `flag` a toggle, `mod` an enumerated value, `attr` a plot-element modifier,
" `plt_st` a plot style.
"
" Under Neovim the links point at the same treesitter capture groups that
" queries/highlights.scm uses in tree-sitter-gnuplot, so a buffer highlighted
" by this plugin and one highlighted by the grammar pick up identical colours
" from the colorscheme. Neovim ships default highlights for every standard
" capture, so this holds even without a treesitter parser installed.
"
" Vim has no such groups, so it falls back to the standard ones.
if has('nvim')
  hi def link gnuplotComment           @comment
  hi def link gnuplotTodo              @comment.todo
  hi def link gnuplotString            @string
  hi def link gnuplotEscape            @string.escape
  hi def link gnuplotFormat            @string.special
  hi def link gnuplotDatablock         @string
  hi def link gnuplotDatablockName     @label
  hi def link gnuplotDatablockRef      @module
  hi def link gnuplotColumnRef         @variable.parameter
  hi def link gnuplotMacro             @function.macro
  hi def link gnuplotNumber            @number
  hi def link gnuplotConstant          @constant.builtin
  hi def link gnuplotBuiltinVar        @variable.builtin
  hi def link gnuplotFunction          @function.call
  hi def link gnuplotBuiltinFunction   @function.builtin
  hi def link gnuplotOperator          @operator
  hi def link gnuplotKeywordOperator   @keyword.operator
  hi def link gnuplotBracket           @punctuation.bracket
  hi def link gnuplotWildcard          @character.special
  hi def link gnuplotShell             @keyword
  hi def link gnuplotCommand           @keyword
  hi def link gnuplotPseudoElement     @keyword
  hi def link gnuplotConnector         @keyword.function
  hi def link gnuplotOption            @variable.member
  hi def link gnuplotFlag              @keyword.directive
  hi def link gnuplotValue             @constant
  hi def link gnuplotAttribute         @property
  hi def link gnuplotStyle             @attribute
  hi def link gnuplotStyleVariable     @variable.parameter
  hi def link gnuplotColorName         @variable.parameter.builtin
  hi def link gnuplotConditional       @keyword.conditional
  hi def link gnuplotRepeat            @keyword.repeat
else
  hi def link gnuplotComment           Comment
  hi def link gnuplotTodo              Todo
  hi def link gnuplotString            String
  hi def link gnuplotEscape            SpecialChar
  hi def link gnuplotFormat            SpecialChar
  hi def link gnuplotDatablock         String
  hi def link gnuplotDatablockName     Label
  hi def link gnuplotDatablockRef      Identifier
  hi def link gnuplotColumnRef         Special
  hi def link gnuplotMacro             Macro
  hi def link gnuplotNumber            Number
  hi def link gnuplotConstant          Constant
  hi def link gnuplotBuiltinVar        Identifier
  hi def link gnuplotFunction          Function
  hi def link gnuplotBuiltinFunction   Function
  hi def link gnuplotOperator          Operator
  hi def link gnuplotKeywordOperator   Operator
  hi def link gnuplotBracket           Delimiter
  hi def link gnuplotWildcard          Special
  hi def link gnuplotShell             Statement
  hi def link gnuplotCommand           Statement
  hi def link gnuplotPseudoElement     Statement
  hi def link gnuplotConnector         Function
  hi def link gnuplotOption            Identifier
  hi def link gnuplotFlag              PreProc
  hi def link gnuplotValue             Constant
  hi def link gnuplotAttribute         Structure
  hi def link gnuplotStyle             Type
  hi def link gnuplotStyleVariable     Special
  hi def link gnuplotColorName         Constant
  hi def link gnuplotConditional       Conditional
  hi def link gnuplotRepeat            Repeat
endif

let b:current_syntax = 'gnuplot'

let &cpoptions = s:cpo_save
unlet s:cpo_save
