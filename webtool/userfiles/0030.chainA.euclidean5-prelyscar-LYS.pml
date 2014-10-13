bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS36, resi 36
select aroundLYS36, resi 35+37+
select LYS46, resi 46
select aroundLYS46, resi 45+47+60+154+155+156+
select LYS138, resi 138
select aroundLYS138, resi 72+73+134+135+136+137+139+176+
select LYS144, resi 144
select aroundLYS144, resi 140+141+143+145+
select LYS146, resi 146
select aroundLYS146, resi 55+145+147+148+149+
select LYS163, resi 163
select aroundLYS163, resi 162+164+172+
select LYS169, resi 169
select aroundLYS169, resi 166+168+170+
select LYS199, resi 199
select aroundLYS199, resi 197+198+200+228+
select LYS207, resi 207
select aroundLYS207, resi 203+204+206+208+
select LYS210, resi 210
select aroundLYS210, resi 206+208+209+211+
select LYS232, resi 232
select aroundLYS232, resi 229+231+233+
select LYS235, resi 235
select aroundLYS235, resi 212+234+236+
select LYS239, resi 239
select aroundLYS239, resi 216+236+238+240+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
