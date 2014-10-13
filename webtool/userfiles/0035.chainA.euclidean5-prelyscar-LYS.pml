bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS19, resi 19
select aroundLYS19, resi 15+16+18+20+
select LYS24, resi 24
select aroundLYS24, resi 23+25+28+93+
select LYS58, resi 58
select aroundLYS58, resi 57+60+61+62+72+
select LYS59, resi 59
select aroundLYS59, resi 57+60+75+
select LYS86, resi 86
select aroundLYS86, resi 70+71+85+87+108+118+119+156+228+230+
select LYS100, resi 100
select aroundLYS100, resi 97+99+101+104+
select LYS113, resi 113
select aroundLYS113, resi 109+110+112+114+120+121+122+124+125+128+142+
select LYS136, resi 136
select aroundLYS136, resi 115+116+133+134+135+137+
select LYS142, resi 142
select aroundLYS142, resi 108+109+110+112+113+117+118+119+120+121+124+140+141+143+156+157+
select LYS163, resi 163
select aroundLYS163, resi 60+61+62+63+73+162+164+
select LYS196, resi 196
select aroundLYS196, resi 192+193+195+197+200+347+
select LYS212, resi 212
select aroundLYS212, resi 210+211+213+214+215+245+247+248+275+
select LYS220, resi 220
select aroundLYS220, resi 162+165+219+221+
select LYS335, resi 335
select aroundLYS335, resi 251+274+290+306+307+308+309+310+333+334+336+
select LYS356, resi 356
select aroundLYS356, resi 353+355+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
