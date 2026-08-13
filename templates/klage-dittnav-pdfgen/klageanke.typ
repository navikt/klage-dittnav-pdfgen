// Does not exist in the repo, but will exist JIT when POST [...]/klageanke is called
#let data = json("/data/klage-dittnav-pdfgen/klageanke.json")

#import "/templates/klage-dittnav-pdfgen/_shared.typ": conf, header, section-divider, signature-box, field, section-heading, personopplysninger-section

// Required fields
#let type = data.at("type")
#let ytelse = data.at("ytelse")
#let foedselsnummer = data.at("foedselsnummer")

#let sendesIPosten = data.at("sendesIPosten", default: false)
#let dato = data.at("dato", default: "")
#let fornavn = data.at("fornavn", default: "")
#let mellomnavn = data.at("mellomnavn", default: "")
#let etternavn = data.at("etternavn", default: "")
#let vedtak = data.at("vedtak", default: "")
#let saksnummer = data.at("saksnummer", default: "")
#let begrunnelse = data.at("begrunnelse", default: none)
#let oversiktVedlegg = data.at("oversiktVedlegg", default: none)
#let fullmektigId = data.at("fullmektigId", default: none)
#let fullmektigNavn = data.at("fullmektigNavn", default: "[Navn mangler]")

#let titleLabel = (
    "KLAGE": "Klage",
    "ANKE": "Anke",
).at(type)

#show: conf.with(title: titleLabel)

#let title = titleLabel + " på vedtak om " + ytelse
#header(title, sendesIPosten, dato)

#let fullmakt = if fullmektigId != none and fullmektigId != "" [
    #(titleLabel)n er innsendt av fullmektig: #(fullmektigNavn), fødselsnummer: #(fullmektigId)
] else {
   none
}

#personopplysninger-section(fornavn, mellomnavn, etternavn, foedselsnummer, fullmakt)

#section-divider()

#section-heading[Opplysninger fra saken]

#field("Dato for vedtak", vedtak)

#field("Saksnummer", saksnummer)

#section-divider()

#let typeText = (
    "KLAGE": "klagen",
    "ANKE": "anken",
).at(type)

#section-heading[Begrunnelsen i #typeText din]

#if begrunnelse != none and begrunnelse != "" [
  #begrunnelse
] else [
  Ikke angitt
]

#if oversiktVedlegg != none and oversiktVedlegg != "" and not sendesIPosten [
  #section-heading[Vedlagte dokumenter]

  #oversiktVedlegg
]

#if sendesIPosten [
  #signature-box()
]
