-- TODO: save and get todoNotes from backend
module Main exposing (main)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- MAIN
main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
  { newTodoNote : String
  , todoNotes : List String
  }

init : Model
init =
  { newTodoNote = ""
  , todoNotes = ["Osta maitoa", "Kastele kukat"]}


-- UPDATE
type Msg
  = ChangeNote String
  | AddToList

update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeNote newTodoNote ->
      { model | newTodoNote = newTodoNote }
    AddToList ->
      { model | todoNotes = model.todoNotes ++ [ model.newTodoNote ], newTodoNote = "" }


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ img [ src "/random_image" ] []
    , viewInput "text" "What is on your mind?" model.newTodoNote ChangeNote
    , viewValidation model
    , renderList model.todoNotes 
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  div[] [ input [ type_ t, placeholder p, value v, onInput toMsg ] [] ]

viewValidation : Model -> Html Msg
viewValidation model =
  if String.length model.newTodoNote < 1 then
    div [ ] [ button [ disabled True ] [ text "Add to List" ] ]
  else if String.length model.newTodoNote > 140 then
    div [ ]
      [ button [ disabled True ] [ text "Add to List" ]
      , span [ style "color" "red", style "margin-left" "0.5em" ] [ text "Too long input!" ]
      ]
  else
    div [ ] [ button [ onClick AddToList ] [ text "Add to List" ] ]

renderList : List String -> Html Msg
renderList lst =
  ul []
    (List.map (\l -> li [] [ text l ]) lst)