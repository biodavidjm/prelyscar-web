bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS2, resi 2
select aroundLYS2, resi 3+4+45+46+
select LYS82, resi 82
select aroundLYS82, resi 78+79+80+81+83+121+407+
select LYS111, resi 111
select aroundLYS111, resi 69+107+108+110+477+
select LYS112, resi 112
select aroundLYS112, resi 68+69+77+94+95+96+99+103+108+109+113+126+462+477+
select LYS119, resi 119
select aroundLYS119, resi 68+77+78+115+116+118+120+
select LYS150, resi 150
select aroundLYS150, resi 63+95+96+97+127+128+149+151+152+184+185+186+241+242+447+
select LYS171, resi 171
select aroundLYS171, resi 135+167+168+170+172+501+
select LYS174, resi 174
select aroundLYS174, resi 170+173+234+
select LYS175, resi 175
select aroundLYS175, resi 135+138+172+176+179+502+
select LYS209, resi 209
select aroundLYS209, resi 207+208+210+213+275+
select LYS247, resi 247
select aroundLYS247, resi 217+221+245+246+248+296+460+508+
select LYS250, resi 250
select aroundLYS250, resi 246+249+251+308+490+
select LYS253, resi 253
select aroundLYS253, resi 249+252+254+308+491+
select LYS256, resi 256
select aroundLYS256, resi 252+255+257+260+262+263+264+308+310+491+
select LYS286, resi 286
select aroundLYS286, resi 211+278+283+285+287+329+330+331+332+333+334+335+458+
select LYS324, resi 324
select aroundLYS324, resi 283+284+317+319+320+321+323+325+332+333+334+335+336+474+
select LYS327, resi 327
select aroundLYS327, resi 326+328+331+515+
select LYS353, resi 353
select aroundLYS353, resi 348+349+352+354+
select LYS355, resi 355
select aroundLYS355, resi 351+352+354+356+
select LYS371, resi 371
select aroundLYS371, resi 16+367+368+370+372+376+492+
select LYS379, resi 379
select aroundLYS379, resi 60+91+123+125+370+375+378+380+387+430+483+484+485+
select LYS423, resi 423
select aroundLYS423, resi 394+397+399+422+424+425+437+453+482+
select LYS425, resi 425
select aroundLYS425, resi 53+392+393+394+397+423+424+426+437+438+
select LYS432, resi 432
select aroundLYS432, resi 429+430+431+433+434+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
