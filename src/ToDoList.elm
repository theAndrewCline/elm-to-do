module ToDoList exposing (..)

import Browser exposing (..)
import Html exposing (Attribute, Html, button, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Id exposing (Id)
import Json.Decode as Json
import List exposing (..)
import Random exposing (Seed, initialSeed)



-- MAIN


main =
    Browser.element { init = init, subscriptions = subscriptions, update = update, view = view }


makeId : Seed -> ( Id, Seed )
makeId seed =
    Random.step Id.generator seed



-- MODEL


type alias Todo =
    { content : String
    , completed : Bool
    , id : Id
    }


type alias Model =
    { todos : List Todo
    , input : String
    , idSeed : Seed
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { todos = []
      , input = ""
      , idSeed = initialSeed 4321
      }
    , Cmd.none
    )



-- UPDATE


createTodo : Model -> ( Model, Cmd msg )
createTodo model =
    let
        ( newId, newSeed ) =
            makeId model.idSeed
    in
    ( { todos =
            append model.todos
                [ { content = model.input
                  , completed = False
                  , id = newId
                  }
                ]
      , input = ""
      , idSeed = newSeed
      }
    , Cmd.none
    )


type Msg
    = CreateTodo
    | CompleteTodo Todo
    | DeleteTodo Todo
    | ClearCompleted
    | UpdateInput String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        CreateTodo ->
            createTodo model

        CompleteTodo targetTodo ->
            ( { model
                | todos =
                    List.map
                        (\item ->
                            if item.id == targetTodo.id then
                                { item | completed = not item.completed }

                            else
                                item
                        )
                        model.todos
              }
            , Cmd.none
            )

        DeleteTodo targetTodo ->
            ( { model | todos = filter (\item -> not (item.id == targetTodo.id)) model.todos }
            , Cmd.none
            )

        ClearCompleted ->
            ( { model
                | todos =
                    filter (\item -> not (item.completed == True)) model.todos
              }
            , Cmd.none
            )

        UpdateInput string ->
            ( { model | input = string }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg

            else
                Json.fail "not ENTER"
    in
    on "keydown" (Json.andThen isEnter keyCode)


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input
                [ placeholder "To do"
                , value model.input
                , onInput UpdateInput
                , onEnter CreateTodo
                ]
                []
            , button [ onClick CreateTodo ] [ text "Add Todo" ]
            , button [ onClick ClearCompleted ] [ text "ClearCompleted" ]
            ]
        , ul []
            (List.map
                (\todo ->
                    if todo.completed == True then
                        li
                            [ onClick (CompleteTodo todo)
                            , style "text-decoration" "line-through"
                            ]
                            [ text todo.content
                            , button [ onClick (DeleteTodo todo) ] [ text "x" ]
                            ]

                    else
                        li
                            [ onClick (CompleteTodo todo)
                            ]
                            [ text todo.content
                            , button [ onClick (DeleteTodo todo) ] [ text "x" ]
                            ]
                )
                model.todos
            )
        ]
