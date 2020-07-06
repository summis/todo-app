-- TODO: save and get todos from backend
module Main exposing (main)


import Browser
import Html exposing (Html, div, input, text, button, ul, li)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput, onClick)


-- MAIN
main: Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
  { content : String
  , todos : List String
  }

init : Model
init =
  { content = ""
  , todos = ["Osta maitoa", "Kastele kukat"] }


-- UPDATE
type Msg
  = Change String
  | AddToList

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
    AddToList ->
      { model | todos = model.todos ++ [ model.content ], content = "" }


-- VIEW
renderList : List String -> Html msg
renderList lst =
    ul []
        (List.map (\l -> li [] [ text l ]) lst)


view : Model -> Html Msg
view model =
  div []
    [ div [] [ input [ placeholder "What is on your mind", value model.content, onInput Change ] [] ]
    , button [ onClick AddToList ] [ text "Add to List" ]
    , div [] [ renderList model.todos ]
    ]