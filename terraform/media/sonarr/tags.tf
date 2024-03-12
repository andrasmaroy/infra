resource "sonarr_tag" "DoVi" {
  label = "dv"
}

resource "sonarr_tag" "DoViAtmos" {
  label = "dvatmos"
}

resource "sonarr_auto_tag" "DoVi" {
  name                      = "Dolby Vision"
  remove_tags_automatically = true
  tags                      = [sonarr_tag.DoVi.id]

  specifications = [
    {
      name           = "Dolby Vision"
      implementation = "QualityProfileSpecification"
      negate         = false
      required       = true
      value          = "9"
    },
  ]
}

resource "sonarr_auto_tag" "DoViAtmos" {
  name                      = "Dolby Vision + Atmos"
  remove_tags_automatically = true
  tags                      = [sonarr_tag.DoViAtmos.id]

  specifications = [
    {
      name           = "Dolby Vision + Atmos"
      implementation = "QualityProfileSpecification"
      negate         = false
      required       = true
      value          = "8"
    },
  ]
}
