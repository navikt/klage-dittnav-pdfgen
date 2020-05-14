FROM navikt/pdfgen:1c6efbd2191888aebadf82ea10e3e744cbdc1ed7

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
