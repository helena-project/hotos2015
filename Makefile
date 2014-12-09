all: proposal.pdf

%.pdf:
	latexmk -output-directory=out -pdf $*.tex

clean:
	rm -rf out
