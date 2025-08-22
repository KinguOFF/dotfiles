$dvi_previewer = 'start xdvi -watchfile 1.5';
$ps_previewer  = 'start zathura';
$pdf_previewer = 'start zathura';

$pdf_mode = 1;        # tex -> pdf

$aux_dir = '.latexmk/aux';
$out_dir = '.latexmk/out';

sub asy {return system("asy -o '$_[0]' '$_[0]'");}
add_cus_dep("asy","eps",0,"asy");
add_cus_dep("asy","pdf",0,"asy");
add_cus_dep("asy","tex",0,"asy");
push @generated_exts, "pre", "%R-[0-9]*.pdf", "%R-[0-9]*.prc", "%R-[0-9]*.tex", "%R-[0-9]*.out", "%R-[0-9]*.pbsdat", "%R.pbsdat", "%R-[0-9]*.eps", "%R-*.asy"

