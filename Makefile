20191206-office-talk.html: 20191206-office-talk.md References.bib
	pandoc -s -c scrollable.css -t revealjs -V theme=white -V revealjs-url=. --mathjax --toc --toc-depth=1 -o 20191206-office-talk.html --bibliography References.bib 20191206-office-talk.md
