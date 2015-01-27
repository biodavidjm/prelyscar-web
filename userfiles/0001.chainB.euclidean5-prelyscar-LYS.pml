bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS39, resi 39
select aroundLYS39, resi 35+36+38+40+42+434+492+509+
select LYS42, resi 42
select aroundLYS42, resi 38+39+41+43+50+264+265+387+484+492+509+
select LYS69, resi 69
select aroundLYS69, resi 67+68+70+317+319+320+490+
select LYS78, resi 78
select aroundLYS78, resi 74+75+77+79+481+
select LYS83, resi 83
select aroundLYS83, resi 24+81+82+83+84+
select LYS105, resi 105
select aroundLYS105, resi 101+102+104+106+
select LYS135, resi 135
select aroundLYS135, resi 131+132+134+136+
select LYS191, resi 191
select aroundLYS191, resi 111+190+192+193+339+341+343+397+408+415+421+425+487+
select LYS196, resi 196
select aroundLYS196, resi 195+197+223+226+227+243+346+418+445+451+467+
select LYS199, resi 199
select aroundLYS199, resi 198+200+201+202+347+348+396+430+437+452+
select LYS216, resi 216
select aroundLYS216, resi 208+210+215+217+218+390+391+527+534+535+549+
select LYS236, resi 236
select aroundLYS236, resi 232+233+234+235+237+256+473+482+
select LYS238, resi 238
select aroundLYS238, resi 229+230+231+237+239+254+256+363+364+365+404+419+446+488+
select LYS271, resi 271
select aroundLYS271, resi 266+267+268+270+272+274+275+485+
select LYS283, resi 283
select aroundLYS283, resi 224+225+226+282+284+352+356+360+493+504+505+526+
select LYS285, resi 285
select aroundLYS285, resi 222+223+224+284+286+287+360+361+363+364+
select LYS292, resi 292
select aroundLYS292, resi 291+293+337+338+339+453+464+538+
select LYS296, resi 296
select aroundLYS296, resi 169+170+171+172+294+295+297+333+334+335+422+455+
select LYS328, resi 328
select aroundLYS328, resi 181+311+312+313+314+316+326+327+329+330+440+476+498+
select LYS375, resi 375
select aroundLYS375, resi 31+241+249+251+276+373+374+376+377+380+381+382+515+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
