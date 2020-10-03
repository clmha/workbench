#MAKEFILE Transform source files into deliverables

odir = build
docs = \
	$(odir)\WB1-MFG-001.pdf \
	$(odir)\WB1-REQ-001.pdf
drawings = \
	$(odir)\WB1-ASY-001.pdf \
	$(odir)\WB1-MFG-002.pdf

all: directories $(docs) $(drawings)

.PHONY: clean directories

clean:
	del $(odir)\*.pdf

directories: $(odir)

$(odir):
	mkdir $(odir)

# *
# * Rules of Office Documents
# *
# The toolchain only uses soffice and assumes there is one document per PDF:
#
#                 soffice      1
# doc/*.od?-------------------->build/*.pdf
#          1
.SUFFIXES: .ods .odt

# Spreadsheets
{doc\}.ods{$(odir)\}.pdf:
	soffice --convert-to pdf --outdir $(@D) $<

# Text documents
{doc\}.odt{$(odir)\}.pdf:
	soffice --convert-to pdf --outdir $(@D) $<

# *
# * Rules for Drawings
# *
# The toolchain from drawings to built artefact is:
#
#               dwg2pdf  1           
# drawing/*.dxf---------->build/*.pdf
#              1
.SUFFIXES: .dxf

# Pattern rule for converting a sheet DXF into a sheet PDF
{drawing\}.dxf{build\}.pdf:
	dwg2pdf -f -o $@ $<
