module Model exposing (Model)

import Statey exposing (StateRecord, State)


type alias Model =
    StateRecord { user : String, password : String }
