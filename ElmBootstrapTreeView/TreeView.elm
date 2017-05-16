module TreeView exposing (..)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import List exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events as Events
import Style
import Chae.Id as Id exposing (Id)
import Chae.Node as Node exposing (Node)
import Chae.Tree as Tree exposing (Tree)


{--| Basically a port of this snippet:
  http://bootsnipp.com/snippets/featured/bootstrap-30-treeview
--}
-- Model


type alias Item =
    { id : String, name : String, parentIds : List String }


type alias Model =
    { items : Tree Item, opened : List Id }



-- Update


type Msg
    = NoOp
    | Toggle Id
    | NodeSelected Id


update : Msg -> Model -> ( Model, Cmd Msg )
update cmd model =
    case cmd of
        NoOp ->
            model ! []

        NodeSelected id ->
            let
                m =
                    Debug.log "Selected: " id
            in
                model ! []

        Toggle id ->
            case partition (\o -> o == id) model.opened of
                ( [], rest ) ->
                    { model | opened = id :: rest } ! []

                ( _, rest ) ->
                    { model | opened = rest } ! []



-- View


isOpened : List Id -> Node a -> Bool
isOpened list node =
    member (Node.id node) list


itemView : Model -> Node (Item) -> Html Msg
itemView model node =
    let
        item =
            Node.root node

        open =
            isOpened (.opened model) node

        symbol =
            if length (Node.children node) > 0 then
                if open then
                    "[-] "
                else
                    "[+] "
            else
                "[ ] "

        symbol2 =
            if length (Node.children node) > 0 then
                if open then
                    "fa fa-minus-circle"
                else
                    "fa fa-plus-circle"
            else
                ""
    in
        li [ style [ ( "display", "list-item" ) ] ]
            [ i [ class symbol2, Events.onClick (Toggle (Node.id node)) ] []
            , a [ Events.onClick (NodeSelected (Node.id node)) ]
                [ text (" " ++ item.name) ]
            , if open then
                listView model (Node.children node)
              else
                text ""
            ]


listView : Model -> Tree Item -> Html Msg
listView model items =
    ul [ class "tree" ]
        (List.map (\n -> itemView model n) items)


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet
        , CDN.fontAwesome
        , node "style" [] [ text Style.listStyle ]
        , Grid.row []
            [ Grid.col [ Col.md4 ]
                [ listView model (.items model) ]
            ]
        ]
