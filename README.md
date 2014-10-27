#Goal-oriented Git

We use Git for a reason: to safely store the history of our documents.
This practical book will teach you how to record the changes you make to
your files, and how to use that record as a powerful tool for
collaboration and problem solving.

## Building the book

There are a few dependencies to build this book:

* [Ghostscript](http://www.ghostscript.com/)
* [Hub](https://github.com/github/hub)
* [ImageMagick](http://www.imagemagick.org/)
* [LaTeX](http://www.latex-project.org/) with
  [upquote](http://www.ctan.org/pkg/upquote) and
  [cm-super](http://www.ctan.org/pkg/cm-super)
* [Pandoc](http://johnmacfarlane.net/pandoc/)
* [Ruby](https://www.ruby-lang.org/en/) with
  [Bundler](http://bundler.io/)
* The fonts
  [Proxima Nova](https://www.dropbox.com/s/sptt0ii6cdi9w6e/Proxima%20Nova.zip)
  and [Inconsolata](http://www.levien.com/type/myfonts/inconsolata.html)

Once the dependencies are installed, you can build Markdown, HTML, PDF, epub and
mobi versions of the book by running `make`. Remove generated files by running
`make clean`
