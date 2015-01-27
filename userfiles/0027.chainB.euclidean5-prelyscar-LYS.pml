bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS18, resi 18
select aroundLYS18, resi 14+15+17+19+218+219+220+
select LYS27, resi 27
select aroundLYS27, resi 26+28+29+
select LYS61, resi 61
select aroundLYS61, resi 41+42+43+59+60+62+63+
select LYS85, resi 85
select aroundLYS85, resi 82+83+84+86+108+109+131+133+181+226+
select LYS123, resi 123
select aroundLYS123, resi 114+116+117+121+122+124+
select LYS143, resi 143
select aroundLYS143, resi 140+142+144+147+
select LYS146, resi 146
select aroundLYS146, resi 142+145+147+
select LYS155, resi 155
select aroundLYS155, resi 153+154+156+158+161+
select LYS168, resi 168
select aroundLYS168, resi 159+163+167+171+
select LYS169, resi 169
select aroundLYS169, resi 100+101+102+167+170+
select LYS175, resi 175
select aroundLYS175, resi 157+158+159+162+171+172+174+176+
select LYS188, resi 188
select aroundLYS188, resi 20+183+184+187+189+
select LYS192, resi 192
select aroundLYS192, resi 191+193+
select LYS229, resi 229
select aroundLYS229, resi 130+132+209+210+211+228+230+231+
select LYS247, resi 247
select aroundLYS247, resi 243+244+246+248+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
