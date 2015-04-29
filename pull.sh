#!/bin/bash
if [[ -z "$1" ]]; then
    echo "Type the commit comment!" &1>2
    exit 1
fi
git pull https://github.com/char-lie/diploma
git add common/*.tex common/*.sty common/*.inc common/*.bib common/*.bst
git add README.md
git add practice/*.tex practice/index.pdf practice/*.latexmain practice/images/*.png
git add thesis/*.tex thesis/index.pdf thesis/*.latexmain
git add thesis/*/*.tex
git add thesis/data/*.csv
git add thesis/code/*.r
git add thesis/images/*.png
git add course/*.tex course/index.pdf course/*.latexmain
git add course/1_title/*.tex
git add course/code
git add course/data
git add course/images
git add prediploma_practice/*.tex prediploma_practice/index.pdf prediploma_practice/*.latexmain
git add prediploma_practice/1_title/*.tex
git add prediploma_practice/code
git add prediploma_practice/data
git add prediploma_practice/images
git add pull.sh
git commit -m "$1"
git push https://char-lie@github.com/char-lie/diploma
