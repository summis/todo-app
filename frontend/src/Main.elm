-- TODO: save and get todos from backend
module Main exposing (main)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput, targetValue)
import Json.Decode as Json
import Validation exposing (ValidationResult)


main : Program () Form Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
  { name : String
  --, todos : List String
  }


type alias Form =
  { name : ValidationResult String
  }


init : Form
init =
  { name = Validation.Initial
  }


type Msg
  = SetName (ValidationResult String)
  | Submit Model


update : Msg -> Form -> Form
update msg form =
  case msg of
    SetName result ->
      { form | name = result }
    Submit model ->
      let
        _ =  model
      in
      form


view : Form -> Html Msg
view form =
  let
    nameValid =
      Validation.validate isRequired
    formState =
      Validation.valid Model
        |> Validation.andMap form.name
  in
  div [ class "form" ]
    [ div [ class "form__field" ]
      [ label [ for "name" ] [ text "Name" ]
      , input
        ([ type_ "text"
          , name "name"
          , onInput (Validation.unvalidated >> SetName)
          , onBlur (nameValid >> SetName)
          ]
            ++ validInputStyle form.name
        )
        []
    , div [ class "form__error" ]
      [ text
        (Validation.message form.name
          |> Maybe.withDefault ""
        )
      ]
    ]
    , div [ class "form__submit" ]
      (case formState of
        Validation.Valid model ->
          [ button [ onClick (Submit model) ] [ text "Save" ]
          ]
        _ -> []
      )
    , div [] [ text "ata" ]
    ]


validInputStyle : ValidationResult x -> List (Attribute msg)
validInputStyle result =
    if Validation.isInvalid result then
        [ style "background-color" "pink" ]

    else
        []


isRequired : String -> Result String String
isRequired raw =
    if String.length raw < 1 then
      Err "Required"
    else if String.length raw > 14 then
      Err "Too long input"
    else
        Ok raw


onBlur : (String -> msg) -> Html.Attribute msg
onBlur tagger =
    on "blur" (Json.map tagger targetValue)