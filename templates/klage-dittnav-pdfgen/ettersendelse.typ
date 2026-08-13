// Does not exist in the repo, but will exist JIT when POST [...]/ettersendelse is called
#let data = json("/data/klage-dittnav-pdfgen/ettersendelse.json")

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
#let ettersendelseTilKa = data.at("ettersendelseTilKa", default: false)

#let typeLabel = (
    "KLAGE_ETTERSENDELSE": "klage",
    "ANKE_ETTERSENDELSE": "anke",
).at(type)

#show: conf.with(title: "Ettersendelse til " + typeLabel)

#let title = "Ettersendelse til " + typeLabel + " på vedtak om " + ytelse
#header(title, sendesIPosten, dato)

#personopplysninger-section(fornavn, mellomnavn, etternavn, foedselsnummer)

#section-divider()

#section-heading[Opplysninger fra saken]

#if type == "KLAGE_ETTERSENDELSE" [
  #field(
    "Har du mottatt et brev fra klageinstansen eller en annen enhet i Nav om at saken din er sendt til klageinstansen?",
    if ettersendelseTilKa { "Ja" } else { "Nei" },
  )
]

#field("Dato for vedtak", vedtak)

#field("Saksnummer", saksnummer)

#section-divider()

#section-heading[Årsak til ettersendelse]

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
