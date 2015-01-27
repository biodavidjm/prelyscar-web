bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS56, resi 56
select aroundLYS56, resi 48+50+55+57+
select LYS79, resi 79
select aroundLYS79, resi 75+76+78+80+
select LYS83, resi 83
select aroundLYS83, resi 80+81+82+84+
select LYS97, resi 97
select aroundLYS97, resi 95+96+98+356+
select LYS114, resi 114
select aroundLYS114, resi 110+111+112+113+115+118+365+368+369+
select LYS137, resi 137
select aroundLYS137, resi 46+129+130+136+138+
select LYS166, resi 166
select aroundLYS166, resi 161+165+167+497+499+500+
select LYS169, resi 169
select aroundLYS169, resi 160+168+170+
select LYS175, resi 175
select aroundLYS175, resi 173+174+176+178+179+445+449+
select LYS180, resi 180
select aroundLYS180, resi 176+177+179+181+490+493+494+
select LYS211, resi 211
select aroundLYS211, resi 148+207+208+209+210+212+221+222+223+231+236+289+
select LYS215, resi 215
select aroundLYS215, resi 212+213+214+216+222+
select LYS243, resi 243
select aroundLYS243, resi 239+240+242+244+269+270+271+
select LYS248, resi 248
select aroundLYS248, resi 246+247+249+325+
select LYS251, resi 251
select aroundLYS251, resi 246+249+250+252+310+313+314+
select LYS253, resi 253
select aroundLYS253, resi 242+244+245+246+252+254+264+268+269+
select LYS267, resi 267
select aroundLYS267, resi 265+266+268+281+
select LYS317, resi 317
select aroundLYS317, resi 249+313+314+316+318+320+328+
select LYS333, resi 333
select aroundLYS333, resi 229+230+234+241+309+329+330+332+334+337+
select LYS342, resi 342
select aroundLYS342, resi 338+339+341+343+346+361+559+560+561+562+
select LYS358, resi 358
select aroundLYS358, resi 104+105+109+350+357+359+
select LYS360, resi 360
select aroundLYS360, resi 109+110+113+346+359+361+362+
select LYS405, resi 405
select aroundLYS405, resi 393+403+404+406+
select LYS449, resi 449
select aroundLYS449, resi 174+175+178+445+446+447+448+450+453+
select LYS459, resi 459
select aroundLYS459, resi 150+154+155+156+157+162+456+457+458+460+
select LYS468, resi 468
select aroundLYS468, resi 42+464+465+467+469+472+474+
select LYS473, resi 473
select aroundLYS473, resi 467+472+474+
select LYS485, resi 485
select aroundLYS485, resi 479+484+486+488+489+
select LYS492, resi 492
select aroundLYS492, resi 477+478+479+488+489+491+493+496+
select LYS511, resi 511
select aroundLYS511, resi 481+482+483+510+512+
select LYS532, resi 532
select aroundLYS532, resi 121+124+126+371+372+373+374+375+528+529+531+533+536+
select LYS546, resi 546
select aroundLYS546, resi 542+543+544+545+547+548+549+
select LYS557, resi 557
select aroundLYS557, resi 553+554+556+558+560+561+
select LYS573, resi 573
select aroundLYS573, resi 260+420+572+574+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
