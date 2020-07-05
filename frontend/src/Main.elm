module Main exposing (main)

import Html exposing (img, div)
import Html.Attributes exposing (src)

main =
  div []
    [
      img [ src "/random_image" ] []
    ]