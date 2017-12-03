module Header exposing (..)

import Html exposing (Html, h1, div, text)
import Html.Attributes exposing (style)


view : Html msg
view = 
  div [ style []
      ]
      [ h1 [] [ text "Elm News Portal" ]
      ]