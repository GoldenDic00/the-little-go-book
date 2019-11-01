SOURCE_FILE_NAME = go.md
BOOK_FILE_NAME = go


# --latex-engine xelatex 

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--pdf-engine lualatex \
	--template ../common/pdf-template.tex \
	--listings

EPUB_BUILDER = pandoc
EPUB_BUILDER_FLAGS = \
	--epub-cover-image \
	--fontsize 10

MOBI_BUILDER = kindlegen


mm/go.pdf:
	cd mm && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(SOURCE_FILE_NAME) -o $(BOOK_FILE_NAME).pdf

mm/go.epub: mm/title.png mm/title.txt mm/go.md
	$(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) $^ -o $@

mm/go.mobi: mm/go.epub
	$(MOBI_BUILDER) $^

all: mm/go.pdf mm/go.mobi

clean:
	rm -f */$(BOOK_FILE_NAME).pdf
	rm -f */$(BOOK_FILE_NAME).epub
	rm -f */$(BOOK_FILE_NAME).mobi
