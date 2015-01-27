bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS39, resi 39
select aroundLYS39, resi 35+36+37+38+40+429+502+507+527+
select LYS42, resi 42
select aroundLYS42, resi 38+41+43+50+264+265+387+482+484+502+535+
select LYS69, resi 69
select aroundLYS69, resi 67+68+70+317+319+320+
select LYS78, resi 78
select aroundLYS78, resi 74+75+77+79+537+
select LYS83, resi 83
select aroundLYS83, resi 24+25+29+81+82+83+84+537+
select LYS105, resi 105
select aroundLYS105, resi 101+102+103+104+106+468+485+
select LYS135, resi 135
select aroundLYS135, resi 131+132+133+134+136+
select LYS191, resi 191
select aroundLYS191, resi 111+190+192+339+341+416+420+538+
select LYS196, resi 196
select aroundLYS196, resi 195+197+223+226+227+243+346+409+413+441+447+556+
select LYS199, resi 199
select aroundLYS199, resi 198+200+201+202+347+425+432+448+
select LYS216, resi 216
select aroundLYS216, resi 208+210+215+217+218+390+391+
select LYS236, resi 236
select aroundLYS236, resi 232+233+234+235+237+256+467+479+
select LYS238, resi 238
select aroundLYS238, resi 229+230+231+237+239+254+256+363+364+399+414+442+463+
select LYS271, resi 271
select aroundLYS271, resi 235+266+267+268+270+272+274+275+483+513+
select LYS283, resi 283
select aroundLYS283, resi 224+225+226+282+284+360+
select LYS285, resi 285
select aroundLYS285, resi 222+223+224+284+286+287+360+363+
select LYS292, resi 292
select aroundLYS292, resi 291+293+337+338+339+391+449+459+538+
select LYS296, resi 296
select aroundLYS296, resi 170+171+172+173+295+297+333+334+335+451+469+470+496+549+
select LYS328, resi 328
select aroundLYS328, resi 181+311+312+313+314+316+326+327+329+330+435+473+534+560+
select LYS375, resi 375
select aroundLYS375, resi 241+249+251+276+373+374+376+377+380+381+382+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
