#!/usr/bin/env bash
# Generates test PDFs locally via the running pdfgen container.
#
# Assumes the service is already running (e.g. via `docker compose watch`).
#
# Usage:
#   ./scripts/test.sh

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

BASE_URL="${BASE_URL:-http://localhost:8080/api/v1/genpdf/klage-dittnav-pdfgen}"

OUTPUT_DIR="./output"
mkdir -p "$OUTPUT_DIR"

# format: <endpoint>:<data-file>:<output-file>
jobs=(
  "klageanke:klage_anke_post.json:klage_anke_post.pdf"
  "klageanke:klage_anke_digital.json:klage_anke_digital.pdf"
  "ettersendelse:klage_ettersendelse_digital.json:klage_ettersendelse_digital.pdf"
  "ettersendelse:klage_ettersendelse_post_til_ka.json:klage_ettersendelse_post_til_ka.pdf"
)

for job in "${jobs[@]}"; do
  IFS=":" read -r endpoint input output <<< "$job"
  echo "-> Generating $OUTPUT_DIR/$output ($endpoint <- $input) ..."
  curl --fail --silent --show-error --request POST \
    --url "$BASE_URL/$endpoint" \
    --header 'Content-Type: application/json' \
    --output "$OUTPUT_DIR/$output" \
    --data @"./data/$input"
done

echo "Done! Generated $(echo "${jobs[@]}" | wc -w | tr -d ' ') PDFs."
