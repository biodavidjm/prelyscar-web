bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS27, resi 27
select aroundLYS27, resi 24+26+28+30+42+46+124+127+128+160+
select LYS77, resi 77
select aroundLYS77, resi 75+76+78+204+205+207+237+238+239+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
