bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS31, resi 31
select aroundLYS31, resi 30+32+55+57+95+96+97+
select LYS63, resi 63
select aroundLYS63, resi 61+62+64+67+79+
select LYS71, resi 71
select aroundLYS71, resi 67+68+70+72+
select LYS72, resi 72
select aroundLYS72, resi 42+68+69+71+73+
select LYS84, resi 84
select aroundLYS84, resi 81+83+85+
select LYS88, resi 88
select aroundLYS88, resi 78+79+80+85+87+89+91+
select LYS95, resi 95
select aroundLYS95, resi 31+91+92+94+96+
select LYS113, resi 113
select aroundLYS113, resi 109+110+112+114+135+
select LYS119, resi 119
select aroundLYS119, resi 115+116+117+118+120+142+144+
select LYS133, resi 133
select aroundLYS133, resi 128+129+130+132+134+444+
select LYS137, resi 137
select aroundLYS137, resi 135+136+138+140+141+
select LYS167, resi 167
select aroundLYS167, resi 163+164+166+168+170+403+
select LYS169, resi 169
select aroundLYS169, resi 165+166+168+170+173+175+261+262+263+
select LYS198, resi 198
select aroundLYS198, resi 186+190+193+197+199+375+376+377+381+
select LYS221, resi 221
select aroundLYS221, resi 218+219+220+222+223+
select LYS256, resi 256
select aroundLYS256, resi 127+253+254+255+257+260+
select LYS277, resi 277
select aroundLYS277, resi 237+239+245+246+247+276+278+
select LYS281, resi 281
select aroundLYS281, resi 232+278+280+282+339+340+342+
select LYS288, resi 288
select aroundLYS288, resi 229+284+285+287+289+335+336+339+342+
select LYS310, resi 310
select aroundLYS310, resi 308+309+311+314+321+322+324+327+352+353+354+
select LYS329, resi 329
select aroundLYS329, resi 325+326+328+330+332+333+
select LYS334, resi 334
select aroundLYS334, resi 289+316+317+330+331+333+
select LYS335, resi 335
select aroundLYS335, resi 285+288+289+331+332+336+337+338+339+342+343+344+346+
select LYS369, resi 369
select aroundLYS369, resi 358+359+360+361+365+366+368+370+
select LYS374, resi 374
select aroundLYS374, resi 348+349+355+370+371+373+375+
select LYS382, resi 382
select aroundLYS382, resi 187+189+190+381+383+410+411+412+413+
select LYS403, resi 403
select aroundLYS403, resi 164+167+391+393+401+402+404+405+469+470+471+
select LYS421, resi 421
select aroundLYS421, resi 410+411+412+416+417+418+420+422+425+463+465+
select LYS432, resi 432
select aroundLYS432, resi 47+48+51+53+54+428+429+431+433+436+
select LYS442, resi 442
select aroundLYS442, resi 143+144+145+440+441+443+
select LYS450, resi 450
select aroundLYS450, resi 166+170+449+451+453+454+
select LYS461, resi 461
select aroundLYS461, resi 457+458+460+462+465+466+467+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
