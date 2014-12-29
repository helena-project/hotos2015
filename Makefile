all: paper.pdf

%.pdf:
	latexmk -output-directory=out -pdf $*.tex

clean:
	rm -rf out

osx: paper.pdf
	open out/paper.pdf
