bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS126, resi 126
select aroundLYS126, resi 127+219+
select LYS176, resi 176
select aroundLYS176, resi 172+173+175+177+
select LYS235, resi 235
select aroundLYS235, resi 234+236+237+268+326+650+651+
select LYS274, resi 274
select aroundLYS274, resi 273+275+276+299+300+316+318+
select LYS301, resi 301
select aroundLYS301, resi 272+273+300+302+303+318+328+
select LYS331, resi 331
select aroundLYS331, resi 327+328+330+332+334+335+
select LYS383, resi 383
select aroundLYS383, resi 379+380+382+384+
select LYS419, resi 419
select aroundLYS419, resi 224+225+228+417+418+420+653+654+655+656+657+658+
select LYS437, resi 437
select aroundLYS437, resi 291+436+438+441+442+559+581+583+585+589+590+593+
select LYS445, resi 445
select aroundLYS445, resi 443+444+446+483+
select LYS522, resi 522
select aroundLYS522, resi 503+504+518+519+520+521+523+
select LYS578, resi 578
select aroundLYS578, resi 432+577+579+580+600+617+
select LYS602, resi 602
select aroundLYS602, resi 581+582+601+603+605+613+616+
select LYS610, resi 610
select aroundLYS610, resi 436+582+583+584+605+606+607+609+611+625+631+632+635+
select LYS612, resi 612
select aroundLYS612, resi 608+609+611+613+
select LYS616, resi 616
select aroundLYS616, resi 602+613+615+617+
select LYS637, resi 637
select aroundLYS637, resi 333+336+337+340+633+634+636+638+655+657+
select LYS693, resi 693
select aroundLYS693, resi 390+393+689+690+691+692+694+696+713+714+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
