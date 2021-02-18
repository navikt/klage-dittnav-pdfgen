FROM navikt/pdfgen:033e6bc50f1af8532951cbc55be1af1ba7e53919

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
