module Views.Page exposing (ActivePage(..), frame)

import Html exposing (Html, div, nav, div, a, text, footer)
import Html.Attributes exposing (href)
import Route exposing (Route)


type ActivePage
    = Home


frame : Bool -> ActivePage -> Html msg -> Html msg
frame isLoading page content =
    div []
        [ viewHeader page isLoading
        , content
        , viewFooter
        ]


viewHeader : ActivePage -> Bool -> Html msg
viewHeader page isLoading =
    nav []
        [ div []
            [ a [ Route.href Route.Home ] [ text "Home" ]
            ]
        ]


viewFooter : Html msg
viewFooter =
    footer []
        [ div []
            [ text "Some footer..."
            , a [ href "https://www.google.com" ] [ text "Google" ]
            ]
        ]
