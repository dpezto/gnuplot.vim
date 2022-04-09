" Vim syntax file
" Language:     Gnuplot 5.5
" Creator:      Dai López-Jacinto <dpezto@gmail.com>
" Last Change:  Mar 28, 2022
" Filenames:    *.plt *.gpi *.gih *.gp *.gnuplot *.gnu
" URL:          http://www.github/dpezto/syntax/

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

" Commands ------------------------------------------------------------------{{{
syn keyword gnuCmd array break cd call clear continue do
syn keyword gnuCmd exit fit help history if else for import
syn keyword gnuCmd load lower pause print pwd quit raise refresh reread
syn keyword gnuCmd reset save set shell show stats sum system
syn keyword gnuCmd test toggle undefine unset update vclear vfill while
syn match   gnuCmd "\v(<eval(uate)?>|<rep(lot)?>|<s?p(lot)?>)"
hi def link gnuCmd Statement
" }}}

" Gnuplot-defined variables ------------------------------------------------{{{
syn match   gnuVar "\v(GPVAL_)(\1)@<=(\w+>)"
" Stats
syn match   gnuVar "\v\w+(_records|_outofrange|_invalid|_blank|_blocks)@=(\1)"
syn match   gnuVar "\v\w+(_columns|_column_header|_index(_min|_max)(_x|_y)?)@=(\1)"
syn match   gnuVar "\v\w+(_min(_x|_y)?|_max(_x|_y)?|_mean(_err)?|_stddev(_err)?)@=(\1)"
syn match   gnuVar "\v\w+(_ssd|_lo_quartile|_median|_up_quartile|_sum|_sumsq)@=(\1)"
syn match   gnuVar "\v\w+(_skewness(_err)?|_kurtosis(_err)?|_adev|_mean_err)@=(\1)"
syn match   gnuVar "\v\w+(_correlation|_slope(_err)?|_intercept(_err)?)@=(\1)"
syn match   gnuVar "\v\w+(_sumxy|_pos(_min|_max)_y)@=(\1)"
syn match   gnuVar "\v\w+(_size(_x|_y))@=(\1)"
" Mouse
syn match   gnuVar "\v(MOUSE_)(\1)@<=(\w+>)"
hi def link gnuVar Constant
" }}}

" Fit ----------------------------------------------------------------------{{{
syn match   fitOpt "\v(fit .*)@<=(<i(ndex)?>|every|skip|<u(sing)?>|(x|y|xy|x)error)"
syn match   fitOpt "\v(fit .*)@<=(errors|via)"
hi def link fitOpt Keyword
" }}}

" Plot/Splot ---------------------------------------------------------------{{{
syn match   pltOpt "\v((s)?p(lot)? .*\s|(\\\s*\n)+.*\s)@<=(binary|nonuniform|sparse|matrix|<i(ndex)?>|every|skip|<u(sing)?>)"
syn match   pltOpt "\v((s)?p(lot)? .*\s|(\\\s*\n)+.*\s)@<=(<w(ith)?>|smooth|bins|mask|convexhull|zsort)"
syn match   pltOpt "\v((s)?p(lot)? .*\s|(\\\s*\n)+.*\s)@<=(<(no)?t(it)?(le)?>)"
hi def link pltOpt Keyword
" Smooth
syn match   smtOpt "\v(smooth )@<=(unique|frequency|fnormal|cumulative|cnormal)"
syn match   smtOpt "\v(smooth )@<=(csplines|acsplines|mcsplines|path|bezier)"
syn match   smtOpt "\v(smooth )@<=(sbezier|kdensity|convexhull|unwrap)"
hi def link smtOpt Identifier
" With
syn match   withOpt "\v(<w(ith)?> )@<=(<l(ines)?>|<p(oints)?>|linespoints|lp)"
syn match   withOpt "\v(<w(ith)?> )@<=(financebars|<d(ots)?>|impulses|labels)"
syn match   withOpt "\v(<w(ith)?> )@<=(surface|(f|hi)?steps|arrows|v(ec)?(tors)?)"
syn match   withOpt "\v(<w(ith)?> )@<=((x|y)error(bar|lines)|xyerror(bars|lines))"
syn match   withOpt "\v(<w(ith)?> )@<=(parallelaxes)"
syn match   withOpt "\v(<w(ith)?> )@<=(boxes|boxerrorbars|boxxyerror|isosurface)"
syn match   withOpt "\v(<w(ith)?> )@<=(boxplot|candlesticks|circles|zerrorfill)"
syn match   withOpt "\v(<w(ith)?> )@<=(ellipses|filledcurves|fillsteps|histograms)"
syn match   withOpt "\v(<w(ith)?> )@<=(image|pm3d|rgbalpha|rgbimage|polygons)"
hi def link withOpt Identifier
" subattributes
syn match   swithOpt "\v((p(lot)? .*\s|(\\\s*\n)+.*\s))@<=(<ls>|<lt>|<lw>|<lc>|<pt>|<ps>)"
hi def link swithOpt Constant
" Title
syn match   titOps "\v(<(no)?t(it)?(le)? )@<=(<columnheader|<at>|<(no)?enhanced)"
hi def link titOps Identifier
" subattributes
syn match   stitOps "\v(<(no)?t(it)?(le)? .*at .*)@<=(beginning|end)"
hi def link stitOps Constant

" Colorspec p. 60 {{{
"syn keyword slcOpt white black dark-grey red web-green web-blue dark-magenta
"syn keyword slcOpt dark-cyan dark-orange dark-yellow royalblue goldenrod
"syn keyword slcOpt dark-spring-green purple orchid aquamarine brown yellow turquoise
"syn keyword slcOpt grey0 grey10 grey20 grey30 grey40 grey50 grey60 grey70 grey
"syn keyword slcOpt grey80 grey90 grey100 light-red light-green light-blue
"syn keyword slcOpt light-magenta light-cyan light-goldenrod light-pink light-turquoise
"syn keyword slcOpt gold green dark-green spring-green forest-green sea-green blue
"syn keyword slcOpt dark-blue midnight-blue navy medium-blue skyblue cyan magenta
"syn keyword slcOpt dark-turquoise dark-pink coral light-coral orange-red dark-salmon
"syn keyword slcOpt khaki dark-khaki dark-goldenrod beige olive orange violet dark-violet
"syn keyword slcOpt plum dark-plum dark-olivegreen orangered4 brown4 sienna4 orchid4
"syn keyword slcOpt mediumpurple3 slateblue1 yellow4 sienna1 tan1 sandybrown light-salmon
"syn keyword slcOpt pink khaki1 lemonchiffon bisque honeydew slategrey seagreen antiquewhite
"syn keyword slcOpt chartreuse greenyellow gray light-gray light-grey slategray gray0
"syn keyword slcOpt gra10 gra20 gra30 gray40 gray50 gray60 gray70 gray80 gray90 gray100
" }}}
syn match   slcOpt "\v((<lc>|<tc>|<fc>) )@<=(<rgb(color)?>|<pal(ette)?>|<bgnd>|black)"
hi def link slcOpt Constant
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
syn match   setOpt "\v(((un)?set|show) .*)@<=(<m?(x|y|z|x2|y2|cb|r)tics>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb)dtics>)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2|cb)mtics>|xyplane)"
syn match   setOpt "\v(((un)?set|show) .*)@<=(<(x|y|z|x2|y2)zeroaxis>)"
hi def link setOpt Structure
" }}}

" Set-arrow-----------------------------------------------------------------{{{
syn match   sarroOpt "\v(arrow .*)@<=(from|to|arrowstyle|<as>|(no|back)?head(s)?)"
syn match   sarroOpt "\v(arrow .*)@<=(size|fixed|(no)?filled|empty|noborder)"
syn match   sarroOpt "\v(arrow .*)@<=(front|back|<ls>|<lt>|<lw>|<lc>|<dt>)"
syn match   sarroOpt "\v(arrow .*)@<=(first|second|graph|screen|character)"
hi def link sarroOpt Identifier
" }}}
" Set-border ---------------------------------------------------------------{{{
syn match   sbordOpt "\v(border .*)@<=(front|back|behind|linestyle|<ls>|linetype|<lt>)"
syn match   sbordOpt "\v(border .*)@<=(linewidth|<lw>|linecolor|<lc>|dashtype|<dt>|polar)"
hi def link sbordOpt Identifier
" }}}
" Set-datafile -------------------------------------------------------------{{{
syn match   sdatafOpt "\v(dataf(ile)? .*)@<=(columnheaders|fortran|nofpe_trap)"
syn match   sdatafOpt "\v(dataf(ile)? .*)@<=(missing|sep(arator)?|commentschars)"
syn match   sdatafOpt "\v(dataf(ile)? .*)@<=(binary)"
hi def link sdatafOpt Identifier
" }}}
" Set-fit ------------------------------------------------------------------{{{
syn match   sfitOpt "\v(fit .*)@<=(<(no)?log(file)?>|default|<(no)?quiet>|results)"
syn match   sfitOpt "\v(fit .*)@<=(brief|verbose|<(no)?errorv(ariables)?>)"
syn match   sfitOpt "\v(fit .*)@<=(<(no)?cov(variancevables)?>|<(no)?errors(caling)?>)"
hi def link sfitOpt Identifier
" }}}
" Set-format ---------------------------------------------------------------{{{
syn match   sforOpt "\v(format \w*)@<=(x|y|z|x2|y2|cb)"
hi def link sforOpt Identifier
" }}}
" Set-grid -----------------------------------------------------------------{{{
syn match   sgridOpt "\v(grid .*)@<=((no)?(m)?(x|y|z|x2|y2|r|cb)tics|polar)"
syn match   sgridOpt "\v(grid .*)@<=(layerdefault|front|back|(no)?vertical)"
hi def link sgridOpt Identifier
" }}}
" Set-hidden3d -------------------------------------------------------------{{{
syn match   shidOpt "\v(hidden3d .*)@<=(defaults|front|back|(no)?offset|trianglepattern)"
syn match   shidOpt "\v(hidden3d .*)@<=((no)?undefined|(no)?altdiagonal|(no)?bentover)"
hi def link shidOpt Identifier
" }}}
" Set-key ------------------------------------------------------------------{{{
syn match   skeyOpt "\v( k(ey)? .*)@<=(<on>|<off>|default|<(no)?enhanced>)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(<(no)?a(utotitle)?>|<(no)?box>)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(<(no)?opaque>|width|height|vertical)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(horizontal|maxcols|maxrows|columns)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(keywidth|Left|Right|<(no)?rev(erse)?>)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(<(no)?invert>|samplen|spacing|title)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(font|textcolor|<tc>|inside|outside|fixed)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(<(b|l|r|t)?m(ar)?(gin)?>|at|<l(eft)?>)"
syn match   skeyOpt "\v( k(ey)? .*)@<=(<r(ight)?>|<t(op)?>|<b(ottom)?>|<c(enter)?>)"
hi def link skeyOpt Identifier
" subattributes
syn match   sskeyOpt "\v((<a(utotitle))?> )@<=(columnheader)"
syn match   sskeyOpt "\v((maxcols|maxrows) )@<=(auto)"
syn match   sskeyOpt "\v((textcolor|<tc>) )@<=(default|<lt>|<ls>|<pal(ette)?>|rgb)"
syn match   sskeyOpt "\v((title) )@<=((no)?enhanced|<c(enter)?>|<l(eft)?>|<r(ight)?>)"
hi def link sskeyOpt Constant
" }}}
" Set-label ----------------------------------------------------------------{{{
syn match   slabOpt "\v(lab(el)? .*)@<=(<at>|<l(eft)?>|<c(enter)?>|<r(ight)?>)"
syn match   slabOpt "\v(lab(el)? .*)@<=(<(no)?rot(ate)?>|by|font|<(no)?enhanded>)"
syn match   slabOpt "\v(lab(el)? .*)@<=(front|back|textcolor|<tc>|<(no)?point>)"
syn match   slabOpt "\v(lab(el)? .*)@<=(offset|nobox|boxed|hypertext)"
hi def link slabOpt Identifier
" subattributes
syn match   sslabOpt "\v((textcolor|<tc>) )@<=(default|<lt>|<ls>|pal(ette)?|rgb)"
syn match   sslabOpt "\v(boxed )@<=(bs)"
hi def link sslabOpt Constant
" }}}
" Set-logscale -------------------------------------------------------------{{{
syn match   slogOpt "\v(logscale \w*)@<=(x|y|z|x2|y2|r|cb)"
hi def link slogOpt Identifier
" }}}
" Set-mouse ----------------------------------------------------------------{{{
syn match   smousOpt "\v(mouse .*)@<=((no)?doubleclick|(no)?zoomcoordinates)"
syn match   smousOpt "\v(mouse .*)@<=(zoomfactors|(no)?ruler|(no)?polardistance)"
syn match   smousOpt "\v(mouse .*)@<=((mouse)?format|function|(no)?lab(els)?)"
syn match   smousOpt "\v(mouse .*)@<=((no)?zoomjump|(no)?verbose)"
hi def link smousOpt Identifier
" }}}
" Set-multiplot ------------------------------------------------------------{{{
syn match   smulpOpt "\v(multiplot .*)@<=(<t(it)?(le)?|layout)"
hi def link smulpOpt Identifier
" subattributes
syn match   ssmulpOpt "\v(<t(it)?(le)? .*)@<=(font|(no)?enhanced)"
syn match   ssmulpOpt "\v(layout .*)@<=(rowsfirst|columnsfirst|downwards|upwards)"
syn match   ssmulpOpt "\v(layout .*)@<=(scale|offset|margins|spacing)"
hi def link ssmulpOpt Constant
" }}}
" Set-palette --------------------------------------------------------------{{{
syn match   spalOpt "\v(palette .*)@<=(gray|color|gamma|rgbformulae|defined)"
syn match   spalOpt "\v(palette .*)@<=(file|colormap|functions|cubehelix|viridis)"
syn match   spalOpt "\v(palette .*)@<=(model|positive|negative|nops_allcF)"
syn match   spalOpt "\v(palette .*)@<=(ps_allcF|maxcolors)"
hi def link spalOpt Identifier
" subattributes
syn match   sspalOpt "\v(palette .*cubehelix .*)@<=(start|cycles|saturation)"
syn match   sspalOpt "\v(palette .*model )@<=(rgb|RGB|cmy|CMY|hsv|HSV)"
hi def link sspalOpt Constant
" }}}
" Set-pm3d -----------------------------------------------------------------{{{
syn match   spmOpt "\v(pm3d .*)@<=(<at>|<interpolate>|<scansautomatic>|<scansforward>)"
syn match   spmOpt "\v(pm3d .*)@<=(<scansbackward>|<depthorder>|<flush>|<(no)?ftriangles>)"
syn match   spmOpt "\v(pm3d .*)@<=(<clip>|<clip1in>|<clip4in>|<(no)?clipcb>|<corners2color>)"
syn match   spmOpt "\v(pm3d .*)@<=(<(no)?lighting>|<(no)?border>|<implicit>|<explicit>)"
syn match   spmOpt "\v(pm3d .*)@<=(<map>)"
hi def link spmOpt Identifier
" subattributes
syn match   sspmOpt "\v(pm3d .*flush )@<=(<begin>|<center>|<end>)"
syn match   sspmOpt "\v(pm3d .*corners2color )@<=(<mean>|<geomean>|<harmean>|<rms>)"
syn match   sspmOpt "\v(pm3d .*corners2color )@<=(<median>|<min>|<max>|<c1>|<c2>|<c3>|<c4>)"
syn match   sspmOpt "\v(pm3d .*lighting .*)@<=(primary|specular|spec2)"
hi def link sspmOpt Constant
" }}}
" Set-size -----------------------------------------------------------------{{{
syn match   ssizOpt "\v(size .*)@<=((no)?square|(no)?ratio)"
hi def link ssizOpt Identifier
" }}}
" Set-style ----------------------------------------------------------------{{{
syn match   sstOpt "\v(style .*)@<=(arrow|boxplot|data|fill|function|increment)"
syn match   sstOpt "\v(style .*)@<=(line|circle|rectangle|ellipse|parallelaxis)"
syn match   sstOpt "\v(style .*)@<=(spiderplot|textbox)"
hi def link sstOpt Identifier
" Style arrow {{{
syn match   stArr "\v(style .*arrow .*)@<=(default|(no|back)?heads?|size|<(no)?filled>)"
syn match   stArr "\v(style .*arrow .*)@<=(empty|noborder|front|back|linestyle|<ls>)"
syn match   stArr "\v(style .*arrow .*)@<=(linetype|<lt>|linewidth|<lw>|linecolor|<lc>)"
syn match   stArr "\v(style .*arrow .*)@<=(dashtype|<dt>)"
hi def link stArr Constant
" }}}
" Style boxplot {{{
syn match   sboxpOpt "\v(boxplot .*)@<=(ran(ge)?|fraction|(no)?out(liers)?|pointtype)"
syn match   sboxpOpt "\n(boxplot .*)@<=(candlesticks|financebars|medianlinewidth|separation)"
syn match   sboxpOpt "\n(boxplot .*)@<=(labels|off|auto|<x>|<x2>|(un)?sorted)"
hi def link sboxpOpt Constant
" }}}
" Style fill {{{
syn match   stFill "\v(style .*fill .*)@<=(empty|transparent|solid|pattern|<(no)?border>)"
hi def link stFill Constant
" }}}
" Style increment {{{
syn match   stInc "\v(style .*increment .*)@<=(default|user)"
hi def link stInc Constant
" }}}
" Style line {{{
syn match   stLine "\v(style .*line .*)@<=(linetype|<lt>|linecolor|<lc>)"
syn match   stLine "\v(style .*line .*)@<=(linewidth|<lw>|pointtype|<pt>)"
syn match   stLine "\v(style .*line .*)@<=(pointsize|<ps>|pointinverval|<pi>)"
syn match   stLine "\v(style .*line .*)@<=(pointnumber|<pn>|dashtype|<dt>|palette)"
hi def link stLine Constant
" }}}
" Style circle {{{
syn match   stCirc "\v(style .*circle .*)@<=(radius|graph|screen|(no)?wedge|(no)?clip)"
hi def link stCirc Constant
" }}}
" Style rectangle {{{
syn match   stRect "\v(style .*rectangle .*)@<=(front|back|<lw>|linewidth)"
syn match   stRect "\v(style .*rectangle .*)@<=(fillcolor|fs)"
hi def link stRect Constant
" }}}
" Style ellipse {{{
syn match   stElli "\v(style .*ellipse.*)@<=(units|xx|xy|yy|size|graph|screen)"
syn match   stElli "\v(style .*ellipse.*)@<=(angle|(no)?clip)"
hi def link stElli Constant
" }}}
" Style parallelaxis {{{
syn match   stPara "\v(style .*parallelaxis.*)@<=(front|back)"
hi def link stPara Constant
" }}}
" Style spiderplot {{{
syn match   stSpid "\v(style .*spiderplot.*)@<=(fillstyle)"
hi def link stSpid Constant
" }}}
" Style textbox {{{
syn match   stTexb "\v(style .*textbox .*)@<=(default|(no|back)?heads?)"
hi def link stTexb Constant
" }}}
" }}}
" Set-surface --------------------------------------------------------------{{{
syn match   stsurf "\v(surface .*)@<=(implicit|explicit)"
hi def link stsurf Identifier
"  }}}
" Set-xtic -----------------------------------------------------------------{{{
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=(axis|border|(no)?mirror)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=(in|out|scale|default)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=((no)?rotate|(no)?offset)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=(<l(eft)?>|<r(ight)?>|<c(enter)?>|autojustify)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=(add|autofreq|format|font)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=((no)?enhanced|numeric|timedate)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=(geographic|(no)?logscale)"
syn match   sticsOpt "\v(<m?(x|y|z|x2|y2|cb|r)tics> .*)@<=((no)?rangelimit(ed)?|textcolor)"
hi def link sticsOpt Identifier
" }}}
" Set-xlabel ----------------------------------------------------------------{{{
syn match   sxlabOpt "\v(<(x|y|z|x2|y2|cb)lab(el)?>)@<=(offset|font|textcolor|(no)?enhanced)"
syn match   sxlabOpt "\v(<(x|y|z|x2|y2|cb)lab(el)?>)@<=((no)?rotate (by|parallel)?)"
hi def link sxlabOpt Identifier
" }}}
" Set-xrange ----------------------------------------------------------------{{{
syn match   sranOpt "\v(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?> .*)@<=((no)?rev(erse)?)"
syn match   sranOpt "\v(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?> .*)@<=((no)?writeback)"
syn match   sranOpt "\v(<(x|y|z|x2|y2|cb|r|t|u|v)ran(ge)?> .*)@<=((no)?extend|restore)"
hi def link sranOpt Identifier
" }}}
" Set-xyplane --------------------------------------------------------------{{{
syn match   sxyplOpt "\v(xyplane .*)@<=(at|relative)"
hi def link sxyplOpt Identifier
" }}}

" Stats --------------------------------------------------------------------{{{
syn match   statOpt "\v(stats .*)@<=(matrix| u(sing)?>|name|(no)?output)"
hi def link statOpt Keyword
" }}}

" User-defined -------------------------------------------------------------{{{
syn match   plotDef "\v\w+(\(\p*)@=" " function
syn match   plotDef "\v(array )@<=\w+(\[\p*)@=" " array
hi def link plotDef Define
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
syn match   gnuOp "\v(\(.*)@<=,(.*\))@="
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
syn keyword gnuTerminal push pop
syn keyword gnuTerminal aifm aqua be block caca cairolatex canvas cgm
syn keyword gnuTerminal context domterm dumb dxf emf epscairo epslatex
syn keyword gnuTerminal fig gif hpgl jpeg lua mf mp pcl5 pdfcairo
syn keyword gnuTerminal pict2e pm png pngcairo postscript pslatex pstex
syn keyword gnuTerminal pstricks qt sixelgd svg
syn match   gnuTerminal "\v<tek40\d\d>"
syn match   gnuTerminal "\v<tek410\d>"
syn keyword gnuTerminal texdraw tikz tkcanvas webp windows wxt x11 xlib
hi def link gnuTerminal Identifier
" Cairolatex
syn match   cairoOpt "\v(cairolatex .*)@<=(eps|pdf|png|standalone|input|resolution)"
syn match   cairoOpt "\v(cairolatex .*)@<=(blacktext|colou?rtext|(no)?header)"
syn match   cairoOpt "\v(cairolatex .*)@<=(mono|color|(no)?transparent|(no)?crop)"
syn match   cairoOpt "\v(cairolatex .*)@<=(background|font|fontscale|linewidth|lw)"
syn match   cairoOpt "\v(cairolatex .*)@<=(rounded|butt|square|dashlenght|dl|size)"
hi def link cairoOpt Constant
" Pdfcairo
syn match   pdfcaOpt "\v(pdfcairo .*)@<=((no)?enhanced|mono|color|font(scale)?)"
syn match   pdfcaOpt "\v(pdfcairo .*)@<=(linewidth|<lw>|rounded|butt|square|dashlength)"
syn match   pdfcaOpt "\v(pdfcairo .*)@<=(<dl>|background|size)"
hi def link pdfcaOpt Constant
" Png
syn match   pngOpt
hi def link pngOpt Constant
" Pngcairo
" Qt
" Svg
" Texdraw
" Tikz
" Wxt
" }}}

" Comment ------------------------------------------------------------------{{{
syn region  plotComment start="#" skip="\\" end="\n" contains=plotTodo
hi def link plotComment Comment
" }}} 

" Todo ---------------------------------------------------------------------{{{
syn keyword plotTodo contained TODO FIXME XXX
hi def link plotTodo Todo
" }}} 

let b:current_syntax = "gnuplot"
