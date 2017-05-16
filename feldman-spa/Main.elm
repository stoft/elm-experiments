module Main exposing (main)

import Html exposing (Html)
import Json.Decode as Decode exposing (Value)
import Page.Home as Home
import Views.Page as Page exposing (ActivePage)
import Navigation exposing (Location)
import Route exposing (Route)


-- MODEL --


type alias Model =
    { pageState : PageState }


type Page
    = Home Home.Model


type PageState
    = Loaded Page


init : Value -> Location -> ( Model, Cmd Msg )
init val location =
    setRoute (Route.fromLocation location)
        { pageState = Loaded initialPage }


initialPage : Page
initialPage =
    Home Home.init



-- UPDATE --


type Msg
    = SetRoute (Maybe Route)
    | HomeMsg Home.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg msg ->
            { model | pageState = Loaded (Home Home.init) } ! []

        SetRoute maybeRoute ->
            setRoute maybeRoute model



-- _ ->
--     model ! []


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    -- let
    --   transition toMsg task =
    --           { model | pageState = TransitioningFrom (getPage model.pageState) }
    --             => Task.attempt toMsg task
    -- in
    case maybeRoute of
        Nothing ->
            model ! []

        Just (Route.Home) ->
            { model | pageState = Loaded (Home Home.init) } ! []



-- Just Route.Home ->
--     transition HomeLoaded (Home.init)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [-- pageSubscriptions (getPage model.pageState)
         -- , Sub.map SetUser sessionChange
        ]



-- VIEW --


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage True page



-- Html.text ""


viewPage : Bool -> Page -> Html Msg
viewPage isLoading page =
    let
        frame =
            Page.frame isLoading
    in
        case page of
            Home subModel ->
                Home.view subModel
                    |> frame Page.Home
                    |> Html.map HomeMsg



-- MAIN --


main : Program Value Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
