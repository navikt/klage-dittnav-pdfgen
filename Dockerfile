FROM ghcr.io/navikt/pdfgen:1.5.1

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
