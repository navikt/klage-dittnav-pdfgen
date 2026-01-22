# klage-dittnav-pdfgen
PDF-generator for skjema generert i https://github.com/navikt/klage-dittnav. Bruker https://github.com/navikt/pdfgen.
## Lokal kjøring 
Kjør lokalt docker image med  `./run_development.sh`.

Kan verifiseres med denne kommandoen fra konsoll: 
```
curl --request POST \
  --url http://localhost:8080/api/v1/genpdf/klage-dittnav-pdfgen/klageanke \
  --header 'Content-Type: application/json' \
  --output 'output.pdf' \
  --data @./data/klage-dittnav-pdfgen/klage_anke_all_possible_values_example.json
```