bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS23, resi 23
select aroundLYS23, resi 22+24+
select LYS80, resi 80
select aroundLYS80, resi 68+76+77+79+81+85+
select LYS121, resi 121
select aroundLYS121, resi 59+60+61+119+120+122+
select LYS158, resi 158
select aroundLYS158, resi 155+157+159+201+202+
select LYS172, resi 172
select aroundLYS172, resi 171+173+174+177+178+198+
select LYS197, resi 197
select aroundLYS197, resi 176+177+178+179+180+192+196+198+206+
select LYS222, resi 222
select aroundLYS222, resi 221+223+
select LYS225, resi 225
select aroundLYS225, resi 221+224+249+
select LYS226, resi 226
select aroundLYS226, resi 218+227+228+250+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
