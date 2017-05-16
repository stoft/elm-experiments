module Route exposing (Route(..), href, modifyUrl, fromLocation)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing (parseHash, s, (</>), string, oneOf, Parser)


type Route
    = Home


route : Parser (Route -> a) a
route =
    oneOf [ Url.map Home (s "") ]



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        parseHash route location



-- INTERNAL --


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    []
    in
        "#/" ++ (String.join "/" pieces)
