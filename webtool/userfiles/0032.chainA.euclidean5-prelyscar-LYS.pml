bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS211, resi 211
select aroundLYS211, resi 209+210+212+274+275+319+320+
select LYS219, resi 219
select aroundLYS219, resi 217+218+220+241+242+315+
select LYS226, resi 226
select aroundLYS226, resi 224+225+227+229+230+231+232+233+309+311+
select LYS261, resi 261
select aroundLYS261, resi 245+246+247+248+259+260+
select LYS262, resi 262
select aroundLYS262, resi 248+263+
select LYS286, resi 286
select aroundLYS286, resi 279+284+285+287+288+296+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
