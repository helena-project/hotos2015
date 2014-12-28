all: paper.pdf

%.pdf:
	latexmk -output-directory=out -pdf $*.tex

clean:
	rm -rf out
