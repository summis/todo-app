-- TODO: save and get todos from backend
module Main exposing (main)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


-- MAIN
main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
  { name : String
  , todos : List String
  }

init : Model
init =
  { name = ""
  , todos = ["Osta maitoa", "Kastele kukat"]}


-- UPDATE
type Msg
  = Name String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  div[] [ input [ type_ t, placeholder p, value v, onInput toMsg ] [] ]

viewValidation : Model -> Html msg
viewValidation model =
  if model.name == "asdf" then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]