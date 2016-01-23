SOURCE = GeoTopo

make:
	sketch figures/torus.sketch > figures/torus.tex
	pdflatex $(SOURCE).tex -interaction=batchmode -output-format=pdf # aux-files for makeindex / makeglossaries
	makeindex $(SOURCE)
	pdflatex $(SOURCE).tex -interaction=batchmode -output-format=pdf # include index
	pdflatex $(SOURCE).tex -interaction=batchmode -output-format=pdf # include symbol table
	make clean # remove intermediate files like *.log and *.aux

ebook:
	latexml --dest=$(SOURCE).xml $(SOURCE).tex
	latexmlpost -dest=$(SOURCE).html $(SOURCE).xml
	ebook-convert $(SOURCE).html $(SOURCE).epub --language de --no-default-epub-cover

all:
	cd definitions;make
	sed -i 's/\\newif\\ifAFive\\AFivefalse/\\newif\\ifAFive\\AFivetrue/' GeoTopo.tex
	make
	mv GeoTopo.pdf other-formats/GeoTopo-A5.pdf
	sed -i 's/\\newif\\ifAFive\\AFivetrue/\\newif\\ifAFive\\AFivefalse/' GeoTopo.tex
	make


clean:
	rm -rf  $(TARGET) *.class *.html *.log *.aux *.out *.thm *.idx *.toc *.ind *.ilg figures/torus.tex *.glg *.glo *.gls *.ist *.xdy *.fdb_latexmk *.bak
