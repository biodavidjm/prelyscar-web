bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS82, resi 82
select aroundLYS82, resi 78+79+81+83+121+407+453+
select LYS111, resi 111
select aroundLYS111, resi 69+107+108+110+115+
select LYS112, resi 112
select aroundLYS112, resi 67+68+69+77+94+95+96+99+103+108+109+113+126+
select LYS119, resi 119
select aroundLYS119, resi 68+77+78+115+116+118+120+
select LYS150, resi 150
select aroundLYS150, resi 63+95+96+97+127+128+149+151+152+184+185+186+241+242+447+
select LYS171, resi 171
select aroundLYS171, resi 132+133+135+167+168+170+172+174+
select LYS174, resi 174
select aroundLYS174, resi 170+171+173+234+470+
select LYS175, resi 175
select aroundLYS175, resi 135+138+139+172+176+179+
select LYS209, resi 209
select aroundLYS209, resi 207+208+210+213+275+
select LYS247, resi 247
select aroundLYS247, resi 217+221+245+246+248+296+
select LYS250, resi 250
select aroundLYS250, resi 246+249+251+308+472+
select LYS253, resi 253
select aroundLYS253, resi 249+252+254+308+472+
select LYS256, resi 256
select aroundLYS256, resi 252+255+257+260+262+263+264+308+310+484+
select LYS286, resi 286
select aroundLYS286, resi 211+278+282+283+285+287+324+329+330+331+332+333+334+456+
select LYS324, resi 324
select aroundLYS324, resi 283+284+286+319+320+321+323+325+332+333+334+335+
select LYS327, resi 327
select aroundLYS327, resi 326+328+331+
select LYS353, resi 353
select aroundLYS353, resi 348+349+352+354+485+
select LYS355, resi 355
select aroundLYS355, resi 351+352+354+356+
select LYS371, resi 371
select aroundLYS371, resi 16+367+368+370+372+376+463+
select LYS379, resi 379
select aroundLYS379, resi 60+91+123+125+370+375+378+380+387+450+
select LYS423, resi 423
select aroundLYS423, resi 394+397+399+405+422+424+425+437+478+
select LYS425, resi 425
select aroundLYS425, resi 53+392+393+394+397+423+424+426+437+
select LYS432, resi 432
select aroundLYS432, resi 429+430+431+433+434+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
