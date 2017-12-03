module Main exposing (..)

import Html exposing (Html, text, div, h1, h2, h4, img, span, input, p)
import Html.Attributes exposing (src, type_)
import Html.Events exposing (onInput)


---- MODEL ----

type alias NewsItem =
    { id : Int
    , title : String
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
        , newsList =
            [ { id = 1, title = "Hello", content = "lorem ipsum dolor.." }
            , { id = 2, title = "Hellow", content = "lorem ipsum doler.." }
            ]
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

renderNewsItem : NewsItem -> Html Msg
renderNewsItem newsItem =
    div []
        [ h4 [] [ text newsItem.title ]
        , p [] [ text newsItem.content ]
        ]

renderNewsList : List NewsItem -> Html Msg
renderNewsList newsList =
    let
        newsItem =
            List.map renderNewsItem newsList
    in
        div [] newsItem

view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working! Naisu!" ]
        , span [] [ text ( "Title: " ++ model.title ) ]
        , div []
            [ input
                [ type_ "password"
                , onInput UpdateTitle
                ]
                []
            ]
        , div []
            [ h2 [] [ text "News List" ]
            , renderNewsList model.newsList
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
