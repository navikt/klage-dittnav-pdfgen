#let conf(title: "", body) = {
  set document(title: title, author: "klage-dittnav-pdfgen")
  set text(font: "Source Sans 3", size: 12pt, fill: black)
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
