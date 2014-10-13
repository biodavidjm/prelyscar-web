bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS40, resi 40
select aroundLYS40, resi 10+36+37+39+41+284+305+361+392+
select LYS43, resi 43
select aroundLYS43, resi 7+39+42+44+47+67+68+284+326+
select LYS58, resi 58
select aroundLYS58, resi 57+59+60+62+63+180+181+184+190+245+306+342+373+
select LYS61, resi 61
select aroundLYS61, resi 59+60+62+293+308+342+389+393+400+
select LYS75, resi 75
select aroundLYS75, resi 71+72+74+76+77+300+309+386+
select LYS96, resi 96
select aroundLYS96, resi 91+94+95+97+136+139+140+144+311+380+390+
select LYS104, resi 104
select aroundLYS104, resi 11+16+102+103+105+118+295+372+375+391+397+
select LYS108, resi 108
select aroundLYS108, resi 23+106+107+276+333+374+
select LYS109, resi 109
select aroundLYS109, resi 23+28+110+116+328+374+
select LYS117, resi 117
select aroundLYS117, resi 114+115+116+118+119+123+127+369+
select LYS147, resi 147
select aroundLYS147, resi 9+143+144+146+148+336+382+395+
select LYS150, resi 150
select aroundLYS150, resi 1+9+146+149+151+156+157+158+337+395+
select LYS173, resi 173
select aroundLYS173, resi 14+21+76+77+78+156+170+171+172+174+319+320+366+
select LYS194, resi 194
select aroundLYS194, resi 93+95+193+195+196+197+285+330+
select LYS202, resi 202
select aroundLYS202, resi 186+187+188+189+198+199+201+216+235+243+376+
select LYS203, resi 203
select aroundLYS203, resi 196+199+200+204+331+376+410+
select LYS208, resi 208
select aroundLYS208, resi 207+209+210+215+266+317+
select LYS214, resi 214
select aroundLYS214, resi 206+209+212+213+215+216+237+
select LYS218, resi 218
select aroundLYS218, resi 81+82+84+85+125+128+205+217+219+220+233+292+354+385+403+404+406+
select LYS242, resi 242
select aroundLYS242, resi 19+29+59+60+238+240+241+244+
select LYS243, resi 243
select aroundLYS243, resi 29+187+188+202+235+236+237+241+244+
select LYS253, resi 253
select aroundLYS253, resi 50+51+52+251+252+254+256+314+
select LYS267, resi 267
select aroundLYS267, resi 45+48+263+264+266+268+281+294+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
