port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Navigation
import UrlParser
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


main : Program Never Model Msg
main =
    Navigation.program OnChangeLocation
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )


initialModel : Route -> Model
initialModel route =
    Model (User "" "") "" route


-- MODEL

type alias Model =
    { user : User
     , token : String
     , route : Route }


type alias User =
    { email : String
    , password : String
    }


-- ROUTING

type Route =
     DashRoute
    | NotFoundRoute


matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [
         UrlParser.map DashRoute (UrlParser.s "dashboard")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case (UrlParser.parsePath matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute


dashPath = "/dashboard"


onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed message)

-- UPDATE

type Msg =
    UpdateEmail String
    | UpdatePassword String
    | ChangeLocation String
    | OnChangeLocation Navigation.Location


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UpdateEmail email ->
            ( { model | user = User email model.user.password }, Cmd.none )
        UpdatePassword password ->
            ( { model | user = User model.user.email password }, Cmd.none )
        ChangeLocation path ->
            ( model, Navigation.newUrl path )
        OnChangeLocation location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )



-- VIEW

view : Model -> Html Msg
view model =
    currentPage model


currentPage : Model -> Html Msg
currentPage model =
    case model.route of
        DashRoute ->
            dashboardPage model
        NotFoundRoute ->
            notFoundPage




notFoundPage : Html Msg
notFoundPage =
    text "page not found"

dashboardPage : Model -> Html Msg
dashboardPage model =
    text "dashboard page"



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none