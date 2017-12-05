module Main exposing (..)

import Random exposing (..)
import Html exposing (Html, text, div, h1, h2, h4, img, span, input, p, br, button)
import Html.Attributes exposing (src, type_)
import Html.Events exposing (onInput, onClick)

import Header

---- MODEL ----

type alias NewsItem =
    { id : Int
    , title : String
    , content : String
    }

type alias Model =
    { title : String
    , newsList : List NewsItem
    , randomNumber: Int
    }


init : ( Model, Cmd Msg )
init =
    (
        { title = "Hello Elm!"
        , newsList =
            [ { id = 1
                , title = "Hello"
                , content = "lorem ipsum dolor.."
            }
            , { id = 2
                , title = "Hellow"
                , content = "lorem ipsum doler.."
                }
            ]
        , randomNumber = 0
        }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = UpdateTitle String
    | RollRandomNumber
    | UpdateNumber Int
    | NoOp


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
    UpdateTitle title ->
        ({ model | title = title }, Cmd.none)
    -- this update number is pure, the side effect is controlled on RollRandomNumber
    UpdateNumber newNumber ->
        ({ model | randomNumber = newNumber }, Cmd.none)
    -- side effects since it randomizes a number
    RollRandomNumber ->
        (model , Random.generate UpdateNumber (Random.int 1 10))
    NoOp ->
        (model, Cmd.none)



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
        [ Header.view
        , img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working! Naisu!" ]
        , span [] [ text ( "Title: " ++ model.title ) ]
        , span [] [ text ( "Random Number: " ++ (toString model.randomNumber) ) ]
        , br [] []
        , br [] []
        , button [ onClick RollRandomNumber ] [ text "Randomize Number!" ]
        , br [] []
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
