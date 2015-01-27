bg_color white
hide all
show cartoon, all
set cartoon_transparency, 0.7
color gray85, all
select heteroatoms, (hetatm and not resn HOH)
show sticks, heteroatoms
color magenta, heteroatoms
select LYS31, resi 31
select aroundLYS31, resi 30+32+646+
select LYS36, resi 36
select aroundLYS36, resi 25+28+30+35+37+38+53+571+
select LYS42, resi 42
select aroundLYS42, resi 18+22+23+41+43+44+45+49+88+365+654+655+
select LYS46, resi 46
select aroundLYS46, resi 41+43+44+45+
select LYS47, resi 47
select aroundLYS47, resi 45+48+49+544+545+546+548+593+655+659+
select LYS52, resi 52
select aroundLYS52, resi 37+51+53+54+71+98+164+166+515+516+517+591+
select LYS56, resi 56
select aroundLYS56, resi 54+55+57+91+92+93+94+95+96+352+355+356+510+513+514+
select LYS58, resi 58
select aroundLYS58, resi 33+34+55+57+59+61+521+574+592+
select LYS70, resi 70
select aroundLYS70, resi 66+67+69+71+74+145+167+168+169+624+
select LYS119, resi 119
select aroundLYS119, resi 118+120+121+122+501+662+
select LYS124, resi 124
select aroundLYS124, resi 120+121+123+125+128+253+280+281+283+284+502+
select LYS148, resi 148
select aroundLYS148, resi 109+146+147+149+150+151+183+186+212+528+529+531+622+
select LYS184, resi 184
select aroundLYS184, resi 182+183+185+187+192+225+226+227+228+229+230+234+518+540+
select LYS196, resi 196
select aroundLYS196, resi 195+197+
select LYS232, resi 232
select aroundLYS232, resi 194+230+231+233+601+621+645+
select LYS258, resi 258
select aroundLYS258, resi 245+254+255+257+614+615+
select LYS259, resi 259
select aroundLYS259, resi 255+256+260+262+267+269+278+635+
select LYS292, resi 292
select aroundLYS292, resi 81+82+155+159+161+289+290+291+293+547+551+552+623+660+
select LYS302, resi 302
select aroundLYS302, resi 301+303+
select LYS321, resi 321
select aroundLYS321, resi 26+317+318+320+
select LYS339, resi 339
select aroundLYS339, resi 337+338+340+670+672+
select LYS357, resi 357
select aroundLYS357, resi 353+354+356+358+
select LYS366, resi 366
select aroundLYS366, resi 14+15+16+17+363+365+367+369+370+506+507+638+652+
select LYS373, resi 373
select aroundLYS373, resi 369+370+371+372+
show sticks, LYS*
color red, LYS*
color tv_blue, around*
select histidines, resn his
show sticks, histidines
show spheres, heteroatoms
deselect
