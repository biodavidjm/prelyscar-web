bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS15, resi 15
select aroundLYS15, resi 14+16+
select LYS22, resi 22
select aroundLYS22, resi 16+17+18+19+20+21+23+136+140+209+
select LYS41, resi 41
select aroundLYS41, resi 37+40+42+
select LYS61, resi 61
select aroundLYS61, resi 48+49+51+53+60+62+
select LYS102, resi 102
select aroundLYS102, resi 98+99+101+106+127+131+
select LYS103, resi 103
select aroundLYS103, resi 99+100+101+104+
select LYS105, resi 105
select aroundLYS105, resi 101+104+106+
select LYS108, resi 108
select aroundLYS108, resi 104+107+109+
select LYS125, resi 125
select aroundLYS125, resi 126+128+
select LYS168, resi 168
select aroundLYS168, resi 166+167+169+177+178+179+
select LYS188, resi 188
select aroundLYS188, resi 43+44+46+47+163+182+183+184+185+186+187+189+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
