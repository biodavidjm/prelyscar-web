bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS5, resi 5
select aroundLYS5, resi 3+4+6+7+17+18+19+
select LYS7, resi 7
select aroundLYS7, resi 5+6+8+17+
select LYS14, resi 14
select aroundLYS14, resi 11+12+13+15+35+124+163+164+166+169+
select LYS48, resi 48
select aroundLYS48, resi 28+46+47+49+231+
select LYS51, resi 51
select aroundLYS51, resi 50+52+54+
select LYS66, resi 66
select aroundLYS66, resi 64+65+67+68+69+81+116+117+
select LYS72, resi 72
select aroundLYS72, resi 67+70+71+73+368+369+370+372+373+
select LYS79, resi 79
select aroundLYS79, resi 73+74+75+76+77+78+80+
select LYS87, resi 87
select aroundLYS87, resi 63+65+85+86+88+91+125+126+127+371+
select LYS105, resi 105
select aroundLYS105, resi 104+106+235+236+238+301+
select LYS108, resi 108
select aroundLYS108, resi 50+54+55+56+57+58+106+107+109+293+
select LYS171, resi 171
select aroundLYS171, resi 167+168+169+170+172+
select LYS174, resi 174
select aroundLYS174, resi 156+172+173+175+194+196+
select LYS228, resi 228
select aroundLYS228, resi 27+28+140+141+142+226+227+229+
select LYS242, resi 242
select aroundLYS242, resi 238+239+241+243+298+301+302+305+
select LYS244, resi 244
select aroundLYS244, resi 240+241+243+245+280+
select LYS246, resi 246
select aroundLYS246, resi 243+245+247+250+302+
select LYS258, resi 258
select aroundLYS258, resi 254+255+257+259+
select LYS261, resi 261
select aroundLYS261, resi 260+263+265+349+437+
select LYS262, resi 262
select aroundLYS262, resi 259+263+264+265+266+
select LYS273, resi 273
select aroundLYS273, resi 268+269+270+272+274+
select LYS274, resi 274
select aroundLYS274, resi 270+272+273+277+278+
select LYS275, resi 275
select aroundLYS275, resi 248+249+252+270+271+272+276+
select LYS294, resi 294
select aroundLYS294, resi 236+290+291+293+295+
select LYS300, resi 300
select aroundLYS300, resi 296+297+299+301+303+
select LYS324, resi 324
select aroundLYS324, resi 322+323+325+481+527+530+
select LYS375, resi 375
select aroundLYS375, resi 361+364+365+366+374+376+
select LYS407, resi 407
select aroundLYS407, resi 86+90+403+404+406+408+410+411+
select LYS420, resi 420
select aroundLYS420, resi 364+377+419+421+
select LYS496, resi 496
select aroundLYS496, resi 405+408+439+441+442+466+467+495+497+508+
select LYS512, resi 512
select aroundLYS512, resi 101+488+489+490+491+492+494+511+513+
select LYS529, resi 529
select aroundLYS529, resi 198+525+526+528+530+532+
select LYS541, resi 541
select aroundLYS541, resi 537+538+539+540+542+
select LYS556, resi 556
select aroundLYS556, resi 425+550+551+552+554+555+557+601+602+603+604+607+
select LYS566, resi 566
select aroundLYS566, resi 562+563+564+565+567+569+617+618+619+
select LYS576, resi 576
select aroundLYS576, resi 572+573+574+575+577+579+
select LYS588, resi 588
select aroundLYS588, resi 360+362+587+589+590+600+
select LYS598, resi 598
select aroundLYS598, resi 360+361+364+424+425+557+558+559+590+597+599+
select LYS606, resi 606
select aroundLYS606, resi 585+586+587+601+602+603+605+607+
select LYS608, resi 608
select aroundLYS608, resi 604+605+607+609+612+
select LYS615, resi 615
select aroundLYS615, resi 560+611+612+614+616+619+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
