bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS383, resi 383
select aroundLYS383, resi 377+378+379+380+381+382+384+385+386+387+518+521+525+583+586+587+590+591+
select LYS524, resi 524
select aroundLYS524, resi 519+522+523+525+526+527+528+
select LYS611, resi 611
select aroundLYS611, resi 358+362+365+489+493+496+497+500+547+550+604+606+607+608+609+610+612+621+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
