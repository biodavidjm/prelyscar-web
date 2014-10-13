bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS2, resi 2
select aroundLYS2, resi 1+3+22+53+54+55+467+
select LYS72, resi 72
select aroundLYS72, resi 70+71+73+417+476+
select LYS95, resi 95
select aroundLYS95, resi 26+27+28+91+92+94+96+345+346+349+430+444+452+455+
select LYS99, resi 99
select aroundLYS99, resi 94+97+98+100+103+104+
select LYS120, resi 120
select aroundLYS120, resi 118+119+121+122+123+131+315+318+319+480+493+
select LYS133, resi 133
select aroundLYS133, resi 129+130+132+134+136+137+173+174+
select LYS145, resi 145
select aroundLYS145, resi 115+116+117+118+144+146+147+181+182+183+207+209+256+311+371+393+412+
select LYS198, resi 198
select aroundLYS198, resi 194+195+197+199+201+226+227+423+485+
select LYS221, resi 221
select aroundLYS221, resi 217+218+220+222+225+249+250+251+
select LYS308, resi 308
select aroundLYS308, resi 113+206+230+307+309+369+388+389+406+422+435+462+483+510+
select LYS362, resi 362
select aroundLYS362, resi 8+40+41+44+361+363+381+400+416+468+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
