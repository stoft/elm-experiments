module StateTracker exposing (..)

import Statey exposing (..)
import Main exposing (Model)


type alias User =
    StateRecord Model


notAuthenticated =
    makeState "not-authenticated"


authenticated =
    makeState "authenticated"


stateMachine : StateMachine Model
stateMachine =
    { states = [ notAuthenticated, authenticated ]
    , transitions =
        [ ( notAuthenticated, authenticated )
        , ( authenticated, notAuthenticated )
        ]
    , guards = []
    }

canTransition : StateMachine -> State -> StateRecord -> Bool
canTransition stateMachine state stateRecord =
