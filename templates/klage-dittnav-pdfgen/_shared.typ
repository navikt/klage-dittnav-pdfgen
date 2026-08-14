#let unsupported-char-placeholder = "[?]"

// NB: dette er listen over STØTTEDE tegnområder (arabisk, tamil,
// etiopisk, kinesisk, emoji osv. ER altså støttet!). Den brukes under
// i en negert regex-klasse "[^...]" for å finne det MOTSATTE - tegn
// som IKKE er i denne listen, altså det som faktisk er ustøttet og
// skal bli til placeholder.
#let supported-char-ranges = (
  "\t\n\r" +
  "\u{0020}-\u{007E}" + // Basic Latin
  "\u{00A0}-\u{024F}" + // Latin-1 Supplement, Latin Extended-A/B
  "\u{0370}-\u{03FF}" + // Greek and Coptic
  "\u{0400}-\u{04FF}" + // Cyrillic
  "\u{0500}-\u{052F}" + // Cyrillic Supplement
  "\u{0590}-\u{05FF}" + // Hebrew
  "\u{0600}-\u{06FF}" + // Arabic
  "\u{0750}-\u{077F}" + // Arabic Supplement
  "\u{08A0}-\u{08FF}" + // Arabic Extended-A
  "\u{0900}-\u{097F}" + // Devanagari (hindi/nepali)
  "\u{0B80}-\u{0BFF}" + // Tamil
  "\u{0E00}-\u{0E7F}" + // Thai
  "\u{1200}-\u{137F}" + // Ethiopic (tigrinja/amharisk)
  "\u{1E00}-\u{1EFF}" + // Latin Extended Additional (vietnamesisk)
  "\u{2000}-\u{206F}" + // General Punctuation (anførselstegn, tankestrek, ellipse - dekket av Noto Sans base)
  "\u{3000}-\u{30FF}" + // CJK punctuation, Hiragana, Katakana (dekket av Noto Sans SC)
  "\u{3400}-\u{4DBF}" + // CJK Unified Ideographs Extension A
  "\u{4E00}-\u{9FFF}" + // CJK Unified Ideographs
  "\u{F900}-\u{FAFF}" + // CJK Compatibility Ideographs
  "\u{FF00}-\u{FFEF}" + // Halfwidth and Fullwidth Forms
  "\u{1F300}-\u{1FAFF}" // Emoji/piktogrammer (rendres med NotoColorEmoji)
)

// Den faktiske regex-en brukt i #show-regelen: "match alt som IKKE er
// i supported-char-ranges" - dette er selve ustøtte-mønsteret.
#let unsupported-char-pattern = "[^" + supported-char-ranges + "]"

#let conf(title: "", body) = {
  set document(title: title, author: "klage-dittnav-pdfgen")
  set text(
    font: (
      "Source Sans 3",
      "Noto Sans",
      "Noto Sans Arabic",
      "Noto Sans Hebrew",
      "Noto Sans SC",
      "Noto Sans Thai",
      "Noto Sans Tamil",
      "Noto Sans Ethiopic",
    ),
    size: 12pt,
    fill: black,
  )
  set page(
    paper: "a4",
    margin: (x: 2.3cm, y: 1.7cm),
    footer: context [
      #align(right)[
        #text(size: 9pt)[side #counter(page).display() av #counter(page).final().at(0)]
      ]
    ],
  )

  show heading.where(level: 1): it => text(size: 24pt, weight: "bold", it.body)
  show heading.where(level: 2): it => text(size: 15pt, weight: "bold", it.body)
  show regex(unsupported-char-pattern): unsupported-char-placeholder

  body
}

#let section-heading(title) = heading(level: 2, title)

#let header(tittel, sendesIPosten, dato) = {
  align(center)[= #tittel]
  set text(style: "italic", size: 12pt, fill: rgb("#3E3832"))
  align(center)[
    #if sendesIPosten [
      Skjema opprettet digitalt på nav.no
    ] else [
      Sendt inn digitalt via nav.no \
      #dato
    ]
  ]
}

#let section-divider() = {
  v(1em)
  line(length: 100%, stroke: 2pt + rgb("#78706A"))
  v(1em)
}

#let field(label, value) = stack(
  spacing: 1em,
  text(weight: "bold")[#label],
  value,
)

#let personopplysninger-section(fornavn, mellomnavn, etternavn, foedselsnummer, fullmakt) = {
  section-heading[Personlige opplysninger]
  grid(
      columns: (1fr, 1fr),
      row-gutter: 2em,
      field("For- og mellomnavn", fornavn + " " + mellomnavn),
      field("Etternavn", etternavn),
      field("Identifikasjonsnummer", foedselsnummer),
      if fullmakt != none and fullmakt != "" [
        #field("Fullmakt", fullmakt)
      ]
  )
}

#let signature-box() = {
  v(1em)
  box(stroke: 1pt + black, width: 100%, inset: (x: 10pt, y: 6pt))[
    #v(2em)
    #grid(
      columns: (30%, 1fr),
      gutter: 2em,
      stack(
        spacing: 6pt,
        line(length: 100%, stroke: (paint: black, thickness: 0.5pt, dash: "dotted")),
        text(size: 10pt)[Sted og dato],
      ),
      stack(
        spacing: 6pt,
        line(length: 100%, stroke: (paint: black, thickness: 0.5pt, dash: "dotted")),
        text(size: 10pt)[Underskrift],
      ),
    )
  ]
}
