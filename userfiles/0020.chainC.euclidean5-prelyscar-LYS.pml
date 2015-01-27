bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS362, resi 362
select aroundLYS362, resi 358+359+360+361+363+368+375+
select LYS401, resi 401
select aroundLYS401, resi 398+399+400+402+409+410+411+
select LYS416, resi 416
select aroundLYS416, resi 413+414+415+417+422+
select LYS449, resi 449
select aroundLYS449, resi 323+324+360+386+389+445+446+448+450+
select LYS467, resi 467
select aroundLYS467, resi 465+466+468+469+470+732+733+
select LYS472, resi 472
select aroundLYS472, resi 458+459+460+461+462+463+468+469+471+473+476+728+
select LYS481, resi 481
select aroundLYS481, resi 307+308+309+310+311+477+478+480+482+484+485+
select LYS492, resi 492
select aroundLYS492, resi 313+488+489+491+493+
select LYS520, resi 520
select aroundLYS520, resi 424+427+516+517+518+519+521+523+524+
select LYS529, resi 529
select aroundLYS529, resi 525+526+528+530+531+533+535+
select LYS531, resi 531
select aroundLYS531, resi 526+529+530+532+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
