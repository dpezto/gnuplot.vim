" Vim syntax file
" Language:     Gnuplot 5.5
" Creator:      Dai López Jacinto <dpezto@gmail.com>
" Last Change:  Mar 28, 2022
" Filenames:    *.plt *.plot *.gp *.gnuplot *.gnu
" URL:          http://www.github/dpezto/gnuplot.vim/

" Use :syn w/in a buffer to see language element breakdown

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Number -------------------------------------------------------------------{{{
syn keyword gnuNumber pi NaN I
syn match   gnuNumber "\v<\d*((\.\d+)?((e|E)(-|\+)?\d+)?)?"
syn match   gnuNumber "\v(<\d*((\.\d+)?((e|E)(-|\+)?\d+)?)?)@<=(cm|in|pt)"
hi def link gnuNumber Number
" }}}

" User-defined -------------------------------------------------------------{{{
syn match   gnuDef "\v\w+(\(\p*)@=" " function
syn match   gnuDef "\v\w+(\[[^:]+)@=" " array
hi def link gnuDef Define
" }}}

" Commands ------------------------------------------------------------------{{{
syn keyword gnuCmd array break cd call clear continue do
syn keyword gnuCmd exit fit help history if else for import
syn keyword gnuCmd load lower pause print pwd quit raise refresh reread
syn keyword gnuCmd reset save set shell show stats sum system
syn keyword gnuCmd test toggle undefine unset update vclear vfill while
syn match   gnuCmd "\v(<eval(uate)?>|<rep(l(o(t)?)?)?>|<s?p(l(o(t)?)?)?>)"
hi def link gnuCmd Statement
" }}}

" Gnuplot-defined variables ------------------------------------------------{{{
syn match   gnuVar "\v(GPVAL_)(\1)@<=(\w+>)"
" Stats
syn match   gnuVar "\v\w+(_records|_headers|_outofrange|_invalid|_blank|_blocks)@=(\1)"
syn match   gnuVar "\v\w+(_columns|_column_header|_index(_min|_max)(_x|_y)?)@=(\1)"
syn match   gnuVar "\v\w+(_min(_x|_y)?|_max(_x|_y)?|_mean(_err)?(_x|_y)?|_stddev(_err)?(_x|_y)?)@=(\1)"
syn match   gnuVar "\v\w+(_ssd(_x|_y)?|_(lo|up)_quartile(_x|_y)?|_median(_x|_y)?|_sum(sq)?(_x|_y)?)@=(\1)"
syn match   gnuVar "\v\w+(_skewness(_err)?(_x|_y)?|_kurtosis(_err)?(_x|_y)?|_adev(_x|_y)?)@=(\1)"
syn match   gnuVar "\v\w+(_correlation|_slope(_err)?|_intercept(_err)?)@=(\1)"
syn match   gnuVar "\v\w+(_sumxy|_pos(_min|_max)_y)@=(\1)"
syn match   gnuVar "\v\w+(_size(_x|_y))@=(\1)"
" Mouse
syn match   gnuVar "\v(MOUSE_)(\1)@<=(\w+>)"
hi def link gnuVar Constant
" }}}

" Fit ----------------------------------------------------------------------{{{
syn match   fitOpt "\v(fit .*)@<=(<i(n(d(ex?)?)?)?>|every|skip)"
syn match   fitOpt "\v(fit .*)@<=(<u(s(i(ng?)?)?)?>|(x|y|xy|x)error)"
syn match   fitOpt "\v(fit .*)@<=(errors|via)"
hi def link fitOpt Keyword
" }}}

" Pause --------------------------------------------------------------------{{{
syn match   pauseOpt "\v(pause .*)@<=(mouse)"
hi def link pauseOpt Structure
" Mouse
syn match   pa_mouseOpt "\v(pause mouse .*)@<=(keypress|button1|button2|button3|close|any)"
hi def link pa_mouseOpt Identifier
"  }}}

" Plot/Splot ---------------------------------------------------------------{{{
syn match   pltOpt "\v(<s?p(l(ot?)?)?>.*\s|(\\\s*\n)+.*\s)@<=(keyentry|binary|nonuniform|sparse|matrix|<i(n(d(ex?)?)?)?>)"
syn match   pltOpt "\v(<s?p(l(ot?)?)?>.*\s|(\\\s*\n)+.*\s)@<=(every|skip|<u(s(i(ng?)?)?)?>)"
syn match   pltOpt "\v(<s?p(l(ot?)?)?>.*\s|(\\\s*\n)+.*\s)@<=(<w(i(th?)?)?>|smooth|bins|mask|convexhull|zsort)"
syn match   pltOpt "\v(<s?p(l(ot?)?)?>.*\s|(\\\s*\n)+.*\s)@<=(<(no)?t(it)?(le)?>)"
hi def link pltOpt Keyword
" Smooth
syn match   plt_smtOpt "\v(smooth )@<=(unique|frequency|fnormal|cumulative|cnormal)"
syn match   plt_smtOpt "\v(smooth )@<=(csplines|acsplines|mcsplines|path|bezier)"
syn match   plt_smtOpt "\v(smooth )@<=(sbezier|kdensity|convexhull|unwrap)"
hi def link plt_smtOpt Identifier
" With
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(<l(ines)?>|<p(oints)?>|linespoints|<lp>)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(financebars|<d(ots)?>|impulses|labels)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(surface|(f|hi)?steps|arrows|v(ec)?(tors)?)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=((x|y)error(bar|lines)|xyerror(bars|lines))"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(parallelaxes|spiderplot)"
syn match   plt_withOpt "\v(p(l(ot?)?)?.*\s|(\\\s*\n)+.*\s)@<=(newspiderplot)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(boxes|boxerrorbars|boxxyerror|isosurface)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(boxplot|candlesticks|circles|zerrorfill)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(ellipses|filledcurves?|fillsteps|histograms)"
syn match   plt_withOpt "\v(<w(i(th?)?)?> )@<=(image|pm3d|rgbalpha|rgbimage|polygons)"
hi def link plt_withOpt Identifier
" filledcurves
syn match   plt_fillcOpt "\v(filledcurves? .*)@<=(closed|above|below|between)"
hi def link plt_fillcOpt Constant
" subattributes
syn match   plts_withOpt "\v((p(l(ot?)?)?.*\s|(\\\s*\n)+.*\s))@<=(<ls>|<lt>|<lw>|<lc>|<pt>|<ps>)"
hi def link plts_withOpt Constant
" Title
syn match   plt_titOps "\v(<(no)?t(it)?(le)? )@<=(<columnheader|<at>|<(no)?enhanced)"
hi def link plt_titOps Identifier
" subattributes
syn match   plts_titOps "\v(<(no)?t(it)?(le)? .*at .*)@<=(beginning|end)"
hi def link plts_titOps Constant
" }}}

" Reset --------------------------------------------------------------------{{{
syn match   resOpt "\v(reset )@<=(bind|errors|session)"
hi def link resOpt Structure
" }}}

" Set/show -----------------------------------------------------------------{{{
syn match   setOpt "\v(((un)?set|show) .*)@<=(<angles>|<arrow>|<autoscale>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<bind>|<border>|<boxwidth>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<boxdepth>|<color>|<colormap>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<colorsequence>|<clabel>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<clip>|<cntrlabel>|<cntrparam>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<colorbox>|<colornames>|<contour>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<cornerpoles>|<dashtype>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<dataf(ile)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<decimalsign>|<dgrid3d>|<dummy>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<encoding>|<errorbars>|<fit>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<fontpath>|<format>|<grid>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<hidden3d>|<historysize>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<history>|<isosamples>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<isosurface>|<isotropic>|<jitter>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<k(ey)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<lab(el)?>|<linetype>|<link>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<loadpath>|<locale>|<logscale>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<macros>|<mapping>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(b|l|r|t)?m(ar)?(gin)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<micro>|<minussign>|<monochrome>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<mouse>|<multiplot>|<nonlinear>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<object>|<offsets>|<origin>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<o(ut)?(put)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<overflow>|<palette>|<parametric>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<paxis>|<pixmap>|<pm3d>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<pointintervalbox>|<pointsize>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<polar>|<print>|<psdir>|<raxis>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<rgbmax>|<sa(mples)?>|<size>|<spiderplot>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<style>|<surface>|<table>|<term?(inal)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<termoption>|<theta>|<tics>|<ticslevel>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<ticscale>|<timestamp>|<timefmt>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<tit?(le)?>|<version>|<vgrid>|<view>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb)dat(a)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb)lab(el)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<m?(x|y|z|x2|y2|cb|r|t|u|v)tics>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb)dtics>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb)mtics>|xyplane)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2)?zeroaxis>)"
hi def link setOpt Structure
" }}}

" Set-angles ---------------------------------------------------------------{{{
syn match   set_anglOpt "\v(angles .*)@<=(degrees|radians)"
hi def link set_anglOpt Identifier
"  }}}
" Set-arrow ----------------------------------------------------------------{{{
syn match   set_arroOpt "\v(arrow .*)@<=(from|to|arrowstyle|<as>|(no|back)?head(s)?)"
syn match   set_arroOpt "\v(arrow .*)@<=(size|fixed|(no)?filled|empty|noborder)"
syn match   set_arroOpt "\v(arrow .*)@<=(front|back|linestyle|<ls>|linetype|<lt>|linewidth|<lw>|linecolor|<lc>|dashtype|<dt>)"
syn match   set_arroOpt "\v(arrow .*)@<=(first|second|graph|screen|character)"
hi def link set_arroOpt Identifier
" }}}
" Set-border ---------------------------------------------------------------{{{
syn match   set_bordOpt "\v(border .*)@<=(front|back|behind|linestyle|<ls>|linetype|<lt>)"
syn match   set_bordOpt "\v(border .*)@<=(linewidth|<lw>|linecolor|<lc>|dashtype|<dt>|polar)"
hi def link set_bordOpt Identifier
" }}}
" Set-datafile -------------------------------------------------------------{{{
syn match   set_datafOpt "\v(dataf(ile)? .*)@<=(columnheaders|fortran|nofpe_trap)"
syn match   set_datafOpt "\v(dataf(ile)? .*)@<=(missing|sep(arator)?|commentschars)"
syn match   set_datafOpt "\v(dataf(ile)? .*)@<=(binary)"
hi def link set_datafOpt Identifier
" subattributes
syn match   sets_datafOpt "\v(sep(arator)? )@<=(whitespace|tab|comma)"
hi def link sets_datafOpt Constant
" }}}
" Set-encoding -------------------------------------------------------------{{{
syn match   set_encodOpt "\v(encoding .*)@<=(default|iso_8859_(1>|15|2|9)|koi8(r|u))"
syn match   set_encodOpt "\v(encoding .*)@<=(cp(437|85(0|2)|950|125(0|1|2|4))|sjis|utf8)"
hi def link set_encodOpt Identifier
" }}}
" Set-fit ------------------------------------------------------------------{{{
syn match   set_fitOpt "\v(fit .*)@<=(<(no)?log(file)?>|default|<(no)?quiet>|results)"
syn match   set_fitOpt "\v(fit .*)@<=(brief|verbose|<(no)?errorv(ariables)?>)"
syn match   set_fitOpt "\v(fit .*)@<=(<(no)?co(variancevariables)?>|<(no)?errors(caling)?>)"
syn match   set_fitOpt "\v(fit .*)@<=((no)?prescale|maxiter|limit(_abs)?|start-lambda|lambda-factor|script|v4|v5)"
hi def link set_fitOpt Identifier
" }}}
" Set-format ---------------------------------------------------------------{{{
syn match   set_formatOpt "\v(format \w*)@<=(x|y|z|x2|y2|cb)"
hi def link set_formatOpt Identifier
" }}}
" Set-grid -----------------------------------------------------------------{{{
syn match   set_gridOpt "\v(grid.*\s)@<=((no)?(m)?(x|y|z|x2|y2|cb|r|t|u|v)tics|(no)?polar)"
syn match   set_gridOpt "\v(grid.*\s)@<=(layerdefault|front|back|(no)?vertical)"
syn match   set_gridOpt "\v(grid.*\s)@<=(linewidth|<lw>|linecolor|<lc>|linetype|<lt>|dashtype|<dt>)"
hi def link set_gridOpt Identifier
" }}}
" Set-hidden3d -------------------------------------------------------------{{{
syn match   set_hidOpt "\v(hidden3d .*)@<=(defaults|front|back|(no)?offset|trianglepattern)"
syn match   set_hidOpt "\v(hidden3d .*)@<=((no)?undefined|(no)?altdiagonal|(no)?bentover)"
hi def link set_hidOpt Identifier
" }}}
" Set-key ------------------------------------------------------------------{{{
syn match   set_keyOpt "\v( k(ey)? .*)@<=(<on>|<off>|default|<(no)?enhanced>)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(<(no)?a(utotitle)?>|<(no)?box>)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(<(no)?opaque>|width|height|vertical)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(horizontal|maxcols|maxrows|columns)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(keywidth|Left|Right|<(no)?rev(erse)?>)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(<(no)?invert>|samplen|spacing|title)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(font|textcolor|<tc>|<lw>|linewidth|<dt>|dashtype|inside|outside|fixed)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(<(b|l|r|t)?m(ar)?(gin)?>|at|<l(eft)?>)"
syn match   set_keyOpt "\v( k(ey)? .*)@<=(<r(ight)?>|<t(op)?>|<b(ottom)?>|<c(enter)?>)"
hi def link set_keyOpt Identifier
" subattributes
syn match   sets_keyOpt "\v((<a(utotitle))?> )@<=(columnheader)"
syn match   sets_keyOpt "\v((maxcols|maxrows) )@<=(auto)"
syn match   sets_keyOpt "\v((textcolor|<tc>) )@<=(default|<lt>|<ls>|<pal(ette)?>|rgb)"
syn match   sets_keyOpt "\v((title) )@<=((no)?enhanced|<c(enter)?>|<l(eft)?>|<r(ight)?>)"
hi def link sets_keyOpt Constant
" }}}
" Set-label ----------------------------------------------------------------{{{
syn match   set_labOpt "\v(lab(el)? .*)@<=(<at>|<l(eft)?>|<c(enter)?>|<r(ight)?>)"
syn match   set_labOpt "\v(lab(el)? .*)@<=(<(no)?rot(ate)?>|by|font|<(no)?enhanded>)"
syn match   set_labOpt "\v(lab(el)? .*)@<=(front|back|textcolor|<tc>|<(no)?point>)"
syn match   set_labOpt "\v(lab(el)? .*)@<=(offset|nobox|boxed|hypertext)"
hi def link set_labOpt Identifier
" subattributes
syn match   sets_labOpt "\v((textcolor|<tc>) )@<=(default|<lt>|<ls>|pal(ette)?|rgb)"
syn match   sets_labOpt "\v(boxed )@<=(bs)"
hi def link sets_labOpt Constant
" }}}
" Set-logscale -------------------------------------------------------------{{{
syn match   set_logOpt "\v(logscale \w*)@<=(x|y|z|x2|y2|r|cb)"
hi def link set_logOpt Identifier
" }}}
" Set-mouse ----------------------------------------------------------------{{{
syn match   set_mousOpt "\v(mouse .*)@<=((no)?doubleclick|(no)?zoomcoordinates)"
syn match   set_mousOpt "\v(mouse .*)@<=(zoomfactors|(no)?ruler|(no)?polardistance)"
syn match   set_mousOpt "\v(mouse .*)@<=((mouse)?format|function|(no)?lab(els)?)"
syn match   set_mousOpt "\v(mouse .*)@<=((no)?zoomjump|(no)?verbose)"
hi def link set_mousOpt Identifier
" }}}
" Set-multiplot ------------------------------------------------------------{{{
syn match   set_mulpOpt "\v(multiplot .*)@<=(<t(it)?(le)?>|layout)"
hi def link set_mulpOpt Identifier
" subattributes
syn match   sets_mulpOpt "\v(<t(it)?(le)? .*)@<=(font|(no)?enhanced)"
syn match   sets_mulpOpt "\v(layout .*)@<=(rowsfirst|columnsfirst|downwards|upwards)"
syn match   sets_mulpOpt "\v(layout .*)@<=(scale|offset|margins|spacing)"
hi def link sets_mulpOpt Constant
" }}}
" Set-paxis ----------------------------------------------------------------{{{
syn match   set_paxOpt "\v(paxis .*)@<=(ran(ge)?|tics|lab(el)?|offset)"
hi def link set_paxOpt Identifier
"  }}}
" Set-palette --------------------------------------------------------------{{{
syn match   set_palOpt "\v(palette .*)@<=(gray|color|gamma|rgbformulae|defined)"
syn match   set_palOpt "\v(palette .*)@<=(file|colormap|functions|cubehelix|viridis)"
syn match   set_palOpt "\v(palette .*)@<=(model|positive|negative|nops_allcF)"
syn match   set_palOpt "\v(palette .*)@<=(ps_allcF|maxcolors)"
hi def link set_palOpt Identifier
" subattributes
syn match   sets_palOpt "\v(palette .*cubehelix .*)@<=(start|cycles|saturation)"
syn match   sets_palOpt "\v(palette .*model )@<=(rgb|RGB|cmy|CMY|hsv|HSV)"
hi def link sets_palOpt Constant
" }}}
" Set-pm3d -----------------------------------------------------------------{{{
syn match   set_pmOpt "\v(pm3d .*)@<=(<at>|<interpolate>|<scansautomatic>|<scansforward>)"
syn match   set_pmOpt "\v(pm3d .*)@<=(<scansbackward>|<depthorder>|<flush>|<(no)?ftriangles>)"
syn match   set_pmOpt "\v(pm3d .*)@<=(<clip>|<clip1in>|<clip4in>|<(no)?clipcb>|<corners2color>)"
syn match   set_pmOpt "\v(pm3d .*)@<=(<(no)?lighting>|<(no)?border>|<implicit>|<explicit>)"
syn match   set_pmOpt "\v(pm3d .*)@<=(<map>)"
hi def link set_pmOpt Identifier
" subattributes
syn match   sets_pmOpt "\v(pm3d .*flush )@<=(<begin>|<center>|<end>)"
syn match   sets_pmOpt "\v(pm3d .*corners2color )@<=(<mean>|<geomean>|<harmean>|<rms>)"
syn match   sets_pmOpt "\v(pm3d .*corners2color )@<=(<median>|<min>|<max>|<c1>|<c2>|<c3>|<c4>)"
syn match   sets_pmOpt "\v(pm3d .*lighting .*)@<=(primary|specular|spec2)"
hi def link sets_pmOpt Constant
" }}}
" Set-size -----------------------------------------------------------------{{{
syn match   set_sizOpt "\v(size .*)@<=((no)?square|(no)?ratio)"
hi def link set_sizOpt Identifier
" }}}
" Set-style ----------------------------------------------------------------{{{
syn match   set_stOpt "\v(style .*)@<=(arrow|boxplot|data|fill|function|increment)"
syn match   set_stOpt "\v(style .*)@<=(lines?|circle|rectangle|ellipse|parallelaxis)"
syn match   set_stOpt "\v(style .*)@<=(spiderplot|textbox)"
hi def link set_stOpt Identifier
" Style arrow {{{
syn match   set_stArr "\v(style .*arrow .*)@<=(default|(no|back)?heads?|size|<(no)?filled>)"
syn match   set_stArr "\v(style .*arrow .*)@<=(empty|noborder|front|back|linestyle|<ls>)"
syn match   set_stArr "\v(style .*arrow .*)@<=(linetype|<lt>|linewidth|<lw>|linecolor|<lc>)"
syn match   set_stArr "\v(style .*arrow .*)@<=(dashtype|<dt>)"
hi def link set_stArr Constant
" }}}
" Style boxplot {{{
syn match   set_stBoxp "\v(boxplot .*)@<=(ran(ge)?|fraction|(no)?out(liers)?|pointtype)"
syn match   set_stBoxp "\n(boxplot .*)@<=(candlesticks|financebars|medianlinewidth|separation)"
syn match   set_stBoxp "\n(boxplot .*)@<=(labels|off|auto|<x>|<x2>|(un)?sorted)"
hi def link set_stBoxp Constant
" }}}
" Style fill {{{
syn match   set_stFill "\v(style .*fill .*)@<=(empty|transparent|solid|pattern|<lt>|<lc>|<(no)?border>)"
hi def link set_stFill Constant
" }}}
" Style-function {{{
syn match   set_stFunc "\v(style .*function .*)@<=(<l(ines)?>|<p(oints)?>|linespoints|<lp>)"
syn match   set_stFunc "\v(style .*function .*)@<=(financebars|<d(ots)?>|impulses|labels)"
syn match   set_stFunc "\v(style .*function .*)@<=(surface|(f|hi)?steps|arrows|v(ec)?(tors)?)"
syn match   set_stFunc "\v(style .*function .*)@<=((x|y)error(bar|lines)|xyerror(bars|lines))"
syn match   set_stFunc "\v(style .*function .*)@<=(parallelaxes|spiderplot)"
syn match   set_stFunc "\v(style .*function .*)@<=(boxes|boxerrorbars|boxxyerror|isosurface)"
syn match   set_stFunc "\v(style .*function .*)@<=(boxplot|candlesticks|circles|zerrorfill)"
syn match   set_stFunc "\v(style .*function .*)@<=(ellipses|filledcurves|fillsteps|histograms)"
syn match   set_stFunc "\v(style .*function .*)@<=(image|pm3d|rgbalpha|rgbimage|polygons)"
hi def link set_stFunc Constant
"  }}}
" Style increment {{{
syn match   set_stInc "\v(style .*increment .*)@<=(default|user)"
hi def link set_stInc Constant
" }}}
" Style line {{{
syn match   set_stLine "\v(style .*line .*)@<=(linetype|<lt>|linecolor|<lc>)"
syn match   set_stLine "\v(style .*line .*)@<=(linewidth|<lw>|pointtype|<pt>)"
syn match   set_stLine "\v(style .*line .*)@<=(pointsize|<ps>|pointinverval|<pi>)"
syn match   set_stLine "\v(style .*line .*)@<=(pointnumber|<pn>|dashtype|<dt>|palette)"
hi def link set_stLine Constant
" }}}
" Style circle {{{
syn match   set_stCirc "\v(style .*circle .*)@<=(radius|graph|screen|(no)?wedge|(no)?clip)"
hi def link set_stCirc Constant
" }}}
" Style rectangle {{{
syn match   set_stRect "\v(style .*rectangle .*)@<=(front|back|<lw>|linewidth)"
syn match   set_stRect "\v(style .*rectangle .*)@<=(fillcolor|fs)"
hi def link set_stRect Constant
" }}}
" Style ellipse {{{
syn match   set_stElli "\v(style .*ellipse.*)@<=(units|xx|xy|yy|size|graph|screen)"
syn match   set_stElli "\v(style .*ellipse.*)@<=(angle|(no)?clip)"
hi def link set_stElli Constant
" }}}
" Style parallelaxis {{{
syn match   set_stPara "\v(style .*parallelaxis.*)@<=(front|back)"
hi def link set_stPara Constant
" }}}
" Style spiderplot {{{
syn match   set_stSpid "\v(style .*spiderplot.*)@<=(fillstyle|<fs>|linewidth|<lw>|linecolor|<lc>|dashtype|<dt>)"
syn match   set_stSpid "\v(style .*spiderplot.*)@<=(linetype|<lt>|pointsize|<ps>|pointtype|<pt>|pointcolor|<pc>)"
hi def link set_stSpid Constant
" }}}
" Style textbox {{{
syn match   set_stTexb "\v(style .*textbox .*)@<=(opaque|transparent|fillcolor|<fc>|(no)?border)"
syn match   set_stTexb "\v(style .*textbox .*)@<=(linewidth|<lw>|margins)"
hi def link set_stTexb Constant
" }}}
" }}}
" Set-surface --------------------------------------------------------------{{{
syn match   set_surfOpt "\v(surface .*)@<=(implicit|explicit)"
hi def link set_surfOpt Identifier
"  }}}
" Set-view -----------------------------------------------------------------{{{
syn match   set_viewOpt "\v(view .*)@<=(map\s+scale|projection\s+(xy|xz|yz)|(no)?equal\s+(<xy>|<xyz>)|azimuth)"
hi def link set_viewOpt Identifier
"  }}}
" Set-xtics ----------------------------------------------------------------{{{
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=(axis|border|(no)?mirror)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=(in|out|scale|default)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=((no)?rotate|(no)?offset)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=(<l(eft)?>|<r(ight)?>|<c(enter)?>|autojustify)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=(add|autofreq|format|font)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=((no)?enhanced|numeric|timedate)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=(geographic|(no)?logscale)"
syn match   set_ticsOpt "\v(<m?(x|y|z|x2|y2|cb|r|t|u|v)?tics> .*)@<=((no)?rangelimit(ed)?|textcolor)"
hi def link set_ticsOpt Identifier
" }}}
" Set-xlabel ----------------------------------------------------------------{{{
syn match   set_xlabOpt "\v(<(x|y|z|x2|y2|cb)lab(el)?>)@<=(offset|font|textcolor|(no)?enhanced)"
syn match   set_xlabOpt "\v(<(x|y|z|x2|y2|cb)lab(el)?>)@<=((no)?rotate (by|parallel)?)"
hi def link set_xlabOpt Identifier
" }}}
" Set-xrange ----------------------------------------------------------------{{{
syn match   set_ranOpt "\v(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?> .*)@<=((no)?rev(erse)?)"
syn match   set_ranOpt "\v(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?> .*)@<=((no)?writeback)"
syn match   set_ranOpt "\v(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?> .*)@<=((no)?extend|restore)"
hi def link set_ranOpt Identifier
" }}}
" Set-xyplane --------------------------------------------------------------{{{
syn match   set_xyplOpt "\v(xyplane .*)@<=(at|relative)"
hi def link set_xyplOpt Identifier
" }}}
" Set-zeroaxis -------------------------------------------------------------{{{
syn match   set_zeroaOpt "\v((x|y|z|x2|y2)?zeroaxis .*)@<=(linestyle|<ls>|linetype|<lt>)"
syn match   set_zeroaOpt "\v((x|y|z|x2|y2)?zeroaxis .*)@<=(linewidth|<lw>|linecolor|<lc>|dashtype|<dt>)"
hi def link set_zeroaOpt Identifier
" }}}

" Stats --------------------------------------------------------------------{{{
syn match   statsOpt "\v(stats .*)@<=(matrix| u(sing)?>| i(ndex)?>|name|(no)?output)"
hi def link statsOpt Keyword
" }}}

" Operators ----------------------------------------------------------------{{{
" Unary Operators
syn match   gnuOp "[-+~!|$]"
" Binary Operators
syn match   gnuOp "\*\*"
syn match   gnuOp "[*/%&^.]"
syn match   gnuOp "=="
syn match   gnuOp "!="
syn match   gnuOp "<"
syn match   gnuOp "<="
syn match   gnuOp ">"
syn match   gnuOp ">="
syn match   gnuOp "<<"
syn match   gnuOp ">>"
syn match   gnuOp "&&"
syn match   gnuOp "||"
syn match   gnuOp "="
syn match   gnuOp "\v(\([^\)]*)@<=,([^\(]*\))@="
syn match   gnuOp "\v<eq>"
syn match   gnuOp "\v<ne>"
" Ternary Operators
syn match   gnuOp "\v(\p+)@<=\?(\p+:\p+)@=" " ?
syn match   gnuOp "\v(\p+\?[^:]+)@<=:(\p+)@=" " :
hi def link gnuOp Operator
" }}}

" Functions ----------------------------------------------------------------{{{
" Math built-in Functions
syn match   gnuFn "\v(abs|acos|acosh|airy|arg|asin|asinh)(\(\p*)@="
syn match   gnuFn "\v(atan|atan2|atanh|besj0|besj1|besjn)(\(\p*)@="
syn match   gnuFn "\v(besy0|besy1|besyn|besi0|besi1|cbrt)(\(\p*)@="
syn match   gnuFn "\v(ceil|conj|cos|cosh|EllipticK)(\(\p*)@="
syn match   gnuFn "\v(EllipticE|EllipticPi|erf|erfc)(\(\p*)@="
syn match   gnuFn "\v(exp|expint|floor|gamma|ibeta)(\(\p*)@="
syn match   gnuFn "\v(inverf|igamma|imag|int|invnorm)(\(\p*)@="
syn match   gnuFn "\v(invibeta|invigamma|LambertW|lambertw)(\(\p*)@="
syn match   gnuFn "\v(lgamma|lnGamma|log|log10|norm)(\(\p*)@="
syn match   gnuFn "\v(rand|real|round|sgn|Sign)(\(\p*)@="
syn match   gnuFn "\v(sin|sinh|sqrt|SynchrotronF)(\(\p*)@="
syn match   gnuFn "\v(tan|tanh|uigamma|voigt|zeta)(\(\p*)@="
" Special functions from libcerf if available
syn match   gnuFn "\v(cerf|cdawson|faddeeva|erfi)(\(\p*)@="
syn match   gnuFn "\v(FresnelC|FresnelS|VP|VP_fwhm)(\(\p*)@="
" Complex special functions from Amos if available
syn match   gnuFn "\v(Ai|Bi|BesselH1|BesselH2)(\(\p*)@="
syn match   gnuFn "\v(BesselJ|BesselY|BesselI|BesselK)(\(\p*)@="
" String Functions
syn match   gnuFn "\v(gprintf|sprintf|strlen|strstrt)(\(\p*)@="
syn match   gnuFn "\v(substr|strftime|system|trim)(\(\p*)@="
syn match   gnuFn "\v(word|words)(\(\p*)@="
" Time Functions
syn match   gnuFn "\v(time|timecolumn|tm_hour|tm_mday|tm_min)(\(\p*)@="
syn match   gnuFn "\v(tm_mon|tm_sec|tm_wday|tm_week|tm_yday)(\(\p*)@="
syn match   gnuFn "\v(tm_year|weekdate_iso|weekdate_cdc)(\(\p*)@="
" Other gnuplot Functions
syn match   gnuFn "\v(column|columnhead|exists|hsv2rgb|index)(\(\p*)@="
syn match   gnuFn "\v(palette|rgbcolor|stringcolumn|valid|value|voxel)(\(\p*)@="
hi def link gnuFn Function
" }}}

" Macros -------------------------------------------------------------------{{{
syn match   gnuMacro "@\w\+"
hi def link gnuMacro Macro
" }}}

" Strings ------------------------------------------------------------------{{{
syn region  gnuString start=+"+ skip=+\\"+ end=+"+
syn region  gnuString start="'" end="'"
hi def link gnuString String
" }}}

" Terminals ----------------------------------------------------------------{{{
syn match   gnuTerminal "\v(<push>|<pop>|<aifm>|<aqua>|<be>|<block>|<caca>|<cairolatex>|<canvas>)"
syn match   gnuTerminal "\v(<cgm>|<context>|<domterm>|<dumb>|<dxf>|<emf>|<epscairo>|<epslatex>)"
syn match   gnuTerminal "\n(<fig>|<gif>|<hpgl>|<jpeg>|<lua>|<mf>|<mp>|<pc15>|<pdfcairo>|<pict2e>|<pm>)"
syn match   gnuTerminal "\v(<png>|<pngcairo>|<postscript>|<pslatex>|<pstex>|<pstricks>|<qt>)"
syn match   gnuTerminal "\v(<sixelgd>|<svg>|<tek40\d\d>|<tek410\d>|<texdraw>|<tikz>|<tkcanvas>)"
syn match   gnuTerminal "\v(<webp>|<windows>|<wxt>|<x11>|<xlib>)"
hi def link gnuTerminal Identifier
" Cairolatex
syn match   cairoOpt "\v(cairolatex .*)@<=(eps|pdf|png|standalone|input|resolution)"
syn match   cairoOpt "\v(cairolatex .*)@<=(blacktext|colou?rtext|(no)?header)"
syn match   cairoOpt "\v(cairolatex .*)@<=(mono|color|(no)?transparent|(no)?crop)"
syn match   cairoOpt "\v(cairolatex .*)@<=(background|<font>|fontscale|linewidth|<lw>)"
syn match   cairoOpt "\v(cairolatex .*)@<=(rounded|butt|square|dashlenght|dl|size)"
hi def link cairoOpt Constant
" Pdfcairo
syn match   pdfcaOpt "\v(pdfcairo .*)@<=((no)?enhanced|mono|color|font(scale)?)"
syn match   pdfcaOpt "\v(pdfcairo .*)@<=(linewidth|<lw>|rounded|butt|square|dashlength)"
syn match   pdfcaOpt "\v(pdfcairo .*)@<=(<dl>|background|size)"
hi def link pdfcaOpt Constant
" Png
syn match   pngOpt "\v(png .*)@<=((no)?enhanced|(no)?transparent|(no)?interlace)"
syn match   pngOpt "\n(png .*)@<=((no)?truecolor|rounded|butt|linewidth|<lw>|dashlenght|<dl>)"
syn match   pngOpt "\v(png .*)@<=(tiny|small|medium|large|giant|font|fontscale|size|(no)?crop|background)"
hi def link pngOpt Constant
" Pngcairo
syn match   pngcaOpt "\v(pngcairo .*)@<=((no)?enhanced|mono|color|(no)?transparent)"
syn match   pngcaOpt "\v(pngcairo .*)@<=((no)?crop|background|<font>|fontscale|linewidth|<lw>)"
syn match   pngcaOpt "\v(pngcairo .*)@<=(rounded|butt|square|dashlength|<dl>|pointscale|<ps>|size)"
hi def link pngcaOpt Constant
" Qt
syn match   qtOpt "\v(qt .*)@<=(size|position|t(it)?(le)?|font)"
syn match   qtOpt "\v(qt .*)@<=((no)?enhanced|linewidth|<lw>|dashlength|<dl>|(no)?persist)"
syn match   qtOpt "\v(qt .*)@<=((no)?raise|(no)?ctrl|close|widget)"
hi def link qtOpt Constant
" Svg
" Texdraw
" Tikz
" Wxt
" }}}

" Properties ----------------------------------------------------------------{{{
syn match   propOpt "\v((linecolor|<lc>|textcolor|<tc>|fillcolor|<fc>|linetype|<lt>) .*)@<=(<rgb(color)?>|<pal(ette)?>|<bgnd>|black|variable)"
syn match   propOpt "\v((dashtype|<dt>) .*)@<=(solid|dashed)"
syn match   propOpt "\v((fillstyle|<fs>) .*)@<=(empty|transparent|solid|pattern|<lt>|<lc>|<(no)?border>)"
syn match   propOpt "\v(tics .*)@<=(axis|border|(no)?mirror)"
syn match   propOpt "\v(tics .*)@<=(<in>|<out>|scale|default)"
syn match   propOpt "\v(tics .*)@<=((no)?rotate|(no)?offset)"
syn match   propOpt "\v(tics .*)@<=(<l(eft)?>|<r(ight)?>|<c(enter)?>|autojustify)"
syn match   propOpt "\v(tics .*)@<=(add|autofreq|format|font)"
syn match   propOpt "\v(tics .*)@<=((no)?enhanced|numeric|timedate)"
syn match   propOpt "\v(tics .*)@<=(geographic|(no)?logscale)"
syn match   propOpt "\v(tics .*)@<=((no)?rangelimit(ed)?|textcolor)"
syn match   propOpt "\v(ran(ge)? .*)@<=((no)?rev(erse)?|(no)?writeback|(no)?extend)"
hi def link propOpt Constant
" }}}

" Comment ------------------------------------------------------------------{{{
syn region  plotComment start="#" skip="\\" end="\n" contains=plotTodo
hi def link plotComment Comment
" }}}

" Todo ---------------------------------------------------------------------{{{
syn keyword plotTodo contained TODO FIXME XXX BUG NOTE HACK
hi def link plotTodo Todo
" }}}

let b:current_syntax = "gnuplot"
