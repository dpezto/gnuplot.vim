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
syn region  gnuplotDatablock matchgroup=gnuplotDatablockName
      \ start="^\s*\$\h\w*\s*<<\s*\z(\h\w*\)" end="^\s*\z1\s*$"
syn match   gnuplotDatablockName "\$\h\w*"

" Macros --------------------------------------------------------------------
syn match   gnuplotMacro "@\h\w*"

" Numbers -------------------------------------------------------------------
" gnuplot folds a unit suffix into the number itself (10cm, 3.0in, 0.5pt).
syn match   gnuplotNumber "\<\d\+\%(\.\d*\)\?\%([eE][-+]\?\d\+\)\?\%(cm\|in\|pt\)\?\>"
syn match   gnuplotNumber "\<\.\d\+\%([eE][-+]\?\d\+\)\?\%(cm\|in\|pt\)\?\>"
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
syn match   gnuplotOperator "[-+*/%^!~?:.]"
syn match   gnuplotOperator "\*\*"
syn match   gnuplotOperator "[=!<>]="
syn match   gnuplotOperator "[<>]"
syn match   gnuplotOperator "<<\|>>"
syn match   gnuplotOperator "&&\|||\|[&|]"
syn match   gnuplotOperator "="
syn keyword gnuplotOperator eq ne

" Shell escape --------------------------------------------------------------
syn match   gnuplotShell "^\s*!.*$"

" Keywords ------------------------------------------------------------------
" >>> generated by scripts/gen-syntax.mjs — do not edit by hand
" 724 keywords across 6 groups. Regenerate with
" `npm run gen:syntax` after updating keywords.json.
" Groups are emitted in reverse-priority order: Vim resolves a keyword
" defined twice to the last definition.

syn keyword gnuplotValue acspline[s] all all[windows] anchor ansi ansi256
syn keyword gnuplotValue ansirgb any avg axis ba[ckward] ba[se] base[line]
syn keyword gnuplotValue bd[efault] beveled bezier big blacktext bo[th] brief
syn keyword gnuplotValue butt button1 button2 button3 cartesian cauchy ccw
syn keyword gnuplotValue classic clockwise close cnormal colortext colourtext
syn keyword gnuplotValue columnsfirst context counterclockwise cp1250 cp1251
syn keyword gnuplotValue cp1252 cp1254 cp4[37] cp850 cp852 cp950 cspline[s]
syn keyword gnuplotValue cumulative cw cylindrical dashed day[s] def[aults]
syn keyword gnuplotValue defaultplex downwards duplex dynamic eject empty eps
syn keyword gnuplotValue errors expl[icit] fix fixed float fnormal fo[rward]
syn keyword gnuplotValue fort[ran] frequency full fullwidth gauss geo[graphic]
syn keyword gnuplotValue giant gnuplot gray hann hex hour[s] imp[licit]
syn keyword gnuplotValue iso[_8859_1] iso_8859_15 iso_8859_2 iso_8859_9
syn keyword gnuplotValue kdensity keep[fix] keypress koi8[r] koi8u landscape
syn keyword gnuplotValue large latex level1 level3 leveldefault li[near]
syn keyword gnuplotValue mcs[plines] medium minu[tes] mitered mon[ths] mono
syn keyword gnuplotValue mpoints nodraw none nops_allcF normalpoints nounit
syn keyword gnuplotValue numeric off off[set] on parallel path pdf pdftricks2
syn keyword gnuplotValue perl perltkx pixels png podo poly[gon] portrait
syn keyword gnuplotValue ps_allcF pstricks python results rexx round[ed]
syn keyword gnuplotValue rowsfirst ruby sbezier script sec[onds] session
syn keyword gnuplotValue simplex sj[is] small smallpoints solid spherical
syn keyword gnuplotValue splines square sum swarm tcl tex texarrows texpoints
syn keyword gnuplotValue texthidden textnormal textrigid textspecial time
syn keyword gnuplotValue timedate tiny tinypoints trans[parent] trip undefined
syn keyword gnuplotValue unique unit unwrap upwards utf[8] v4 v5 week[s] x0 x1
syn keyword gnuplotValue xx xy xyz xz y0 y1 year[s] yy yz z0

syn keyword gnuplotFlag alt[diagonal] antialias attributes auxfile ba[ck]
syn keyword gnuplotFlag backhead backheads behind bent[over] box box[ed]
syn keyword gnuplotFlag char[acter] clipcb columnhead[ers]
syn keyword gnuplotFlag cov[ariancevariables] crop ctrl ctrlq depth[order]
syn keyword gnuplotFlag enh[anced] equal err[orvariables] errors[caling]
syn keyword gnuplotFlag ext[end] externalimages feed filled fir[st] fr[ont]
syn keyword gnuplotFlag ftriangles fulldoc gparrows gppoints gr[aph] head
syn keyword gnuplotFlag heads hypertext inlineimages inter[lace] interactive
syn keyword gnuplotFlag inv[ert] light[ing] mi[rror] noalt[diagonal] noanimate
syn keyword gnuplotFlag noantialias noattributes noauxfile nobent[over]
syn keyword gnuplotFlag nobo[rder] nobox nobox[ed] noclipcb nocolumnhead[ers]
syn keyword gnuplotFlag nocontours nocov[ariancevariables] nocrop noctrl
syn keyword gnuplotFlag noctrlq noenh[anced] noequal noerr[orvariables]
syn keyword gnuplotFlag noerrors[caling] noext[end] noexternalimages nofeed
syn keyword gnuplotFlag nofilled nofpe_trap noftriangles nofulldoc nogparrows
syn keyword gnuplotFlag nogppoints nogrid nohead noheads nohidden[3d]
syn keyword gnuplotFlag nointer[lace] noinv[ert] nolight[ing] nolog[file]
syn keyword gnuplotFlag nomi[rror] noopaque nooriginreset nooutl[iers]
syn keyword gnuplotFlag nopersist nopicenvironment nopoint noprescale
syn keyword gnuplotFlag noproportional nopspoints norange[limited]
syn keyword gnuplotFlag noreplotonresize norev[erse] norot[ate] norottext
syn keyword gnuplotFlag nostandalone nosurf[ace] notightboundingbox
syn keyword gnuplotFlag notikzarrows notrue[color] nover[tical] nowe[dge]
syn keyword gnuplotFlag nowri[teback] opaque originreset outl[iers] persist
syn keyword gnuplotFlag picenvironment prescale psarrows pspoints
syn keyword gnuplotFlag range[limited] replotonresize rev[erse] rot[ate]
syn keyword gnuplotFlag rottext sc[reen] scroll sec[ond] standalone
syn keyword gnuplotFlag tightboundingbox tikzarrows true[color] ver[tical]
syn keyword gnuplotFlag we[dge] wri[teback]

syn keyword gnuplotOption Le[ft] Ri[ght] a[bsolute] a[utotitle] add an[gles]
syn keyword gnuplotOption angle append arc arr[ow] arrowstyle as aspect at
syn keyword gnuplotOption au[tojustify] auto auto[freq] auto[scale] azimuth
syn keyword gnuplotOption b[ars] b[spline] bmar[gin] bor[der] bot[tom]
syn keyword gnuplotOption box[width] boxdepth bs by c[ubicspline] cai[rolatex]
syn keyword gnuplotOption can[vas] cbda[ta] cbdtic[s] cblab[el] cbmtic[s]
syn keyword gnuplotOption cbran[ge] cbtic[s] center cg[m] charsize clip
syn keyword gnuplotOption clust[ered] cntrl[abel] cntrp[aram] col[umnheader]
syn keyword gnuplotOption color colorb[ox] colormap colorn[ames] colorsequence
syn keyword gnuplotOption columns columns[tacked] conto[urs] contourfill
syn keyword gnuplotOption cornerp[oles] cube[helix] cycle cycles d[egrees]
syn keyword gnuplotOption dashl[ength] dasht[ype] dataf[ile] dec[imalsign]
syn keyword gnuplotOption def[ault] def[ined] delay dg[rid3d] discrete dl
syn keyword gnuplotOption do[mterm] doub[leclick] dt du[mb] du[mmy] dx[f]
syn keyword gnuplotOption e[pscairo] em[f] enc[oding] epsl[atex] errorbars
syn keyword gnuplotOption f[ig] fc file fill[style] fillc[olor] fillchar
syn keyword gnuplotOption first[linetype] fit2rgb[formulae] flush font
syn keyword gnuplotOption fontscale fontsize form[at] fraction from fs fsize
syn keyword gnuplotOption fun[ctions] g[if] gamma gap gr[id] grad[ient] h[pgl]
syn keyword gnuplotOption header height hid[den3d] hor[izontal] in[cremental]
syn keyword gnuplotOption ins[ide] inside[color] interv[al] iso[samples]
syn keyword gnuplotOption isosurf[ace] isotropic j[peg] jitter jsdir k[ey]
syn keyword gnuplotOption keyw[idth] kit[tycairo] kittyg[d] l[ua] lab[el]
syn keyword gnuplotOption layerd[efault] lc le[vels] lef[t] limit limit_abs
syn keyword gnuplotOption linec[olor] lines[tyle] linetype linew[idth] link
syn keyword gnuplotOption lmar[gin] load[path] locale log[scale] logf[ile]
syn keyword gnuplotOption loop ls lt lw map map[ping] mar[gins] maxc[olors]
syn keyword gnuplotOption maxcol[s] maxiter maxrow[s] mcbtic[s]
syn keyword gnuplotOption medianlinewidth micro minus[sign] mix[ed] mo[use]
syn keyword gnuplotOption mono[chrome] mouseformat mrtic[s] mttic[s]
syn keyword gnuplotOption multi[plot] mutic[s] mvtic[s] mvxtic[s] mvytic[s]
syn keyword gnuplotOption mvztic[s] mx2tic[s] mxtic[s] mxytic[s] my2tic[s]
syn keyword gnuplotOption mytic[s] mztic[s] neg[ative] new noa[utotitle]
syn keyword gnuplotOption nodoub[leclick] noheader noinside[color]
syn keyword gnuplotOption nokey[separators] nologf[ile] nonli[near]
syn keyword gnuplotOption nopolardistance nopolardistancedeg
syn keyword gnuplotOption nopolardistancetan nora[tio] noruler nover[bose]
syn keyword gnuplotOption nozoomco[ordinates] nozoomj[ump] num[bers] o[ne]
syn keyword gnuplotOption o[rder] o[utput] obj[ect] off[sets] onecolor
syn keyword gnuplotOption or[igin] outs[ide] over[lap] overflow pa[rametric]
syn keyword gnuplotOption pal[ette] palfuncparam paxis pc[l5] pd[fcairo] pi
syn keyword gnuplotOption pi[ct2e] pixm[ap] plotsize pm3d pn pngc[airo]
syn keyword gnuplotOption po[stscript] poi[ntsize] point pointi[nterval]
syn keyword gnuplotOption pointint[ervalbox] pointn[umber] pointscale
syn keyword gnuplotOption pointsmax pointt[ype] pol[ar] polardistance
syn keyword gnuplotOption polardistancedeg polardistancetan pos[itive]
syn keyword gnuplotOption projection psdir psl[atex] pste[x] pt q[t] qnorm
syn keyword gnuplotOption quality quiet r[adial] r[adians] r[elative] ra[tio]
syn keyword gnuplotOption ra[xis] rad[ius] range rda[ta] rdtic[s] resolution
syn keyword gnuplotOption rgb[formulae] rgbmax rig[ht] rlab[el] rmar[gin]
syn keyword gnuplotOption rmtic[s] rows[tacked] rran[ge] rtic[s] rto ruler
syn keyword gnuplotOption s[ixelgd] sam[ples] samplen saturation scale
syn keyword gnuplotOption separation si[ze] sorted sp[acing] spider[plot]
syn keyword gnuplotOption spot[light] spread st[yle] start su[rface] sv[g]
syn keyword gnuplotOption t[erminal] t[wo] ta[ble] tc tda[ta] tdtic[s]
syn keyword gnuplotOption tek40[xx] tek41[0x] termoption tex[draw] textc[olor]
syn keyword gnuplotOption theta ti[kz] tic[s] timef[mt] times[tamp] tit[le]
syn keyword gnuplotOption tk[canvas] tlab[el] tmar[gin] tmtic[s] to to[p]
syn keyword gnuplotOption tran[ge] triang[les] trianglepattern ttic[s]
syn keyword gnuplotOption u[nknown] u[ser] uda[ta] udtic[s] ulab[el] umtic[s]
syn keyword gnuplotOption units unsorted uran[ge] utic[s] v[ariables] v[ttek]
syn keyword gnuplotOption vda[ta] vdtic[s] ve[rsion] ver[bose] vgrid vi[ew]
syn keyword gnuplotOption vlab[el] vmtic[s] vran[ge] vtic[s] vxda[ta]
syn keyword gnuplotOption vxdtic[s] vxlab[el] vxmtic[s] vxran[ge] vxtic[s]
syn keyword gnuplotOption vyda[ta] vydtic[s] vylab[el] vymtic[s] vyran[ge]
syn keyword gnuplotOption vytic[s] vzda[ta] vzdtic[s] vzlab[el] vzmtic[s]
syn keyword gnuplotOption vzran[ge] vztic[s] w[ebp] wall[s] wid[th] window
syn keyword gnuplotOption wrap wx[t] x2da[ta] x2dtic[s] x2lab[el] x2mtic[s]
syn keyword gnuplotOption x2ran[ge] x2tic[s] x2zeroa[xis] x[11] xda[ta]
syn keyword gnuplotOption xdtic[s] xlab[el] xmtic[s] xran[ge] xt[erm] xtic[s]
syn keyword gnuplotOption xyda[ta] xydtic[s] xylab[el] xymtic[s] xyp[lane]
syn keyword gnuplotOption xyran[ge] xytic[s] xzeroa[xis] y2da[ta] y2dtic[s]
syn keyword gnuplotOption y2lab[el] y2mtic[s] y2ran[ge] y2tic[s] y2zeroa[xis]
syn keyword gnuplotOption yda[ta] ydtic[s] ylab[el] ymtic[s] yran[ge] ytic[s]
syn keyword gnuplotOption yzeroa[xis] z[ero] zda[ta] zdtic[s] zeroa[xis]
syn keyword gnuplotOption zlab[el] zmtic[s] zoomco[ordinates] zoomfa[ctors]
syn keyword gnuplotOption zoomj[ump] zran[ge] ztic[s] zzeroa[xis]

syn keyword gnuplotStyle arr[ows] boxerrorbars boxes boxplot boxxyerror
syn keyword gnuplotStyle candlesticks circ[le] circles d[ata] d[ots] ell[ipse]
syn keyword gnuplotStyle ellipses errorl[ines] f[unction] filledc[urves]
syn keyword gnuplotStyle fillsteps fin[ancebars] fsteps hist[ogram]
syn keyword gnuplotStyle hist[ograms] histeps hs[teps] i[mpulses] ima[ge]
syn keyword gnuplotStyle l[ine] l[ines] lab[els] linesp[oints] lp mask
syn keyword gnuplotStyle p[oints] parallel[axis] parallelaxes polygons
syn keyword gnuplotStyle rect[angle] rgbalpha rgbimage sec[tors] st[eps]
syn keyword gnuplotStyle textbox vec[tors] watch[point] xerrorbar[s]
syn keyword gnuplotStyle xerrorlines xyerrorbar[s] xyerrorlines yerrorbar[s]
syn keyword gnuplotStyle yerrorlines zerror[fill]

syn keyword gnuplotAttribute axes binrange bins binvalue binwidth every
syn keyword gnuplotAttribute i[ndex] if not[itle] perpendicular scan smooth
syn keyword gnuplotAttribute u[sing] w[ith] watch

syn keyword gnuplotCommand bind break call cd cl[ear] continue eval[uate]
syn keyword gnuplotCommand ex[it] f[it] he[lp] hist[ory] import l[oad] low[er]
syn keyword gnuplotCommand p[lot] pa[use] pr[int] printerr[or] pwd q[uit]
syn keyword gnuplotCommand ra[ise] ref[resh] remulti[plot] rep[lot] reread
syn keyword gnuplotCommand reset sa[ve] se[t] sh[ow] sp[lot] stats test toggle
syn keyword gnuplotCommand und[efine] uns[et] vclear warn
" <<< end generated block

" Built-in constants --------------------------------------------------------
" After the generated block on purpose: `pi` is also the two-letter spelling of
" `pointinterval`, and a bare `pi` is far more often the constant.
syn keyword gnuplotConstant pi NaN Inf

" Literals the dictionary does not carry -------------------------------------
" keywords.json only covers tokens the grammar resolves through its scanner
" tiers. A handful of words are plain literals in the grammar instead, so they
" are listed here by hand.
syn keyword gnuplotValue  whitespace tab comma
syn keyword gnuplotOption binary matrix

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
" The tier names come from the grammar's capture taxonomy: `cmd` is a command
" verb, `opt`/`arg` name a set/show option or one of its suboptions, `flag` is
" a toggle, `mod` an enumerated value, `attr` a plot-element modifier, and
" `plt_st` a plot style.
hi def link gnuplotComment         Comment
hi def link gnuplotTodo            Todo
hi def link gnuplotString          String
hi def link gnuplotEscape          SpecialChar
hi def link gnuplotFormat          SpecialChar
hi def link gnuplotDatablock       String
hi def link gnuplotDatablockName   Label
hi def link gnuplotMacro           Macro
hi def link gnuplotNumber          Number
hi def link gnuplotConstant        Constant
hi def link gnuplotBuiltinVar      Identifier
hi def link gnuplotFunction        Function
hi def link gnuplotBuiltinFunction Function
hi def link gnuplotOperator        Operator
hi def link gnuplotShell           PreProc
hi def link gnuplotCommand         Statement
hi def link gnuplotOption          Identifier
hi def link gnuplotFlag            PreProc
hi def link gnuplotValue           Constant
hi def link gnuplotAttribute       Keyword
hi def link gnuplotStyle           Type
hi def link gnuplotConditional     Conditional
hi def link gnuplotRepeat          Repeat

let b:current_syntax = 'gnuplot'

let &cpoptions = s:cpo_save
unlet s:cpo_save
