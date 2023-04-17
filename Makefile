# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = ADQL

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 2.1

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2021-05-28

# What is it you're writing: NOTE, WD, PR, or REC
DOCTYPE = PR

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex ivoa-cite.tex role_diagram.pdf

# List of pixel image files to be included in submitted package
FIGURES = role_diagram.svg

# List of PDF figures (for vector graphics)
VECTORFIGURES =

include ivoatex/Makefile

# Shortcut aliases
pdf: $(DOCNAME).pdf

draft: $(DOCNAME)-draft.pdf

html: $(DOCNAME).html

zip: package

bnf: adql-bnf.html

# Custom target for generating a hyperlinked HTML version of the BNF.
# This is not currently run by default during the build.
BNFHTML_INTRO = \
   <p>The SELECT statement is found at \
   <a href='\#query_specification'>\&lt;query_specification\&gt;</a>. \
   </p>
   
adql-bnf.html: adql.bnf
	@( echo "ADQL 2.1"; cat $< ) \
        | perl bnf2html.pl \
        | sed -e's/#xref-  */#xref-/g' \
              -e's/href="#  */href="#/g' \
              -e's/name="  */name="/g' \
              -e's/&lt;  */\&lt;/g' \
        | sed -e"s%</h1>%</h1>\n$(BNFHTML_INTRO)%" \
        > $@ && echo "=> HTML version of BNF successfully generated in: $@"
