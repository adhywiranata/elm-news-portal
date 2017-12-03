module Main exposing (..)

import Html exposing (Html, text, div, h1, img, span, input)
import Html.Attributes exposing (src, type_)
import Html.Events exposing (onInput)


---- MODEL ----

type alias NewsItem =
    { id : Int
    , title : String
    , image: String
    , content: String
    }

type alias Model =
    { title : String
    , newsList : List NewsItem
    }


init : ( Model, Cmd Msg )
init =
    (
        { title = "Hello Elm!"
        , newsList = []
        }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = UpdateTitle String
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
    UpdateTitle title ->
        ( { model | title = title }, Cmd.none)
    _ ->
        ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working! Naisu!" ]
        , span [] [ text model.title ]
        , div []
            [
                input
                    [ type_ "password"
                    , onInput UpdateTitle
                    ]
                    []
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
