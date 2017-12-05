module Main exposing (..)

import Random exposing (..)
import Html exposing (Html, text, div, h1, h2, h4, img, span, input, p, br, button)
import Html.Attributes exposing (src, type_)
import Html.Events exposing (onInput, onClick)
import Json.Decode exposing (..)

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
    , randomNumber : Int
    , sampleJson : String
    , decodedJsonArray : Result String (List Int)
    , decodedJsonObjNameField : Result String String
    , decodedJsonObjAgeField : Result String Int 
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
        , sampleJson = "\"hello\""
        , decodedJsonArray = (decodeString (Json.Decode.list Json.Decode.int) "[1, 2, 3]")
        , decodedJsonObjNameField = (decodeString (field "name" Json.Decode.string) """{"name":"john","age":5}""")
        , decodedJsonObjAgeField = (decodeString (field "age" Json.Decode.int) """{"name":"john","age":5}""")
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
    -- side effects to fetch articles 
    -- FetchNews -> 
    --     (model, Cmd.none)
    NoOp ->
        (model, Cmd.none)



---- VIEW ----

renderHeading : Model -> Html Msg
renderHeading model = 
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working! Naisu!" ]
        , span [] [ text ( "Title: " ++ model.title ) ]
        , br [] []
        , span [] [ text ( "Random Number: " ++ (toString model.randomNumber) ) ]
        , br [] []
        , br [] []    
        ]

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
        , renderHeading model
        , button [ onClick RollRandomNumber ] [ text "Randomize Number!" ]
        , br [] []
        , br [] []
        , span [] [ text ("decoded json array: " ++ ( toString model.decodedJsonArray ) ) ]
        , br [] []
        , span [] [ text (  "decoded json object fields: Name - "
                            ++ ( toString model.decodedJsonObjNameField )
                            ++ " , Age - "
                            ++ ( toString model.decodedJsonObjAgeField )
                        ) ]
        , br [] []
        , br [] []
        , div []
            [ input
                [ type_ "text"
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
