module StateTracker exposing (..)

import Statey exposing (StateMachine, StateRecord, makeState, State, transition, getStates)
import Model exposing (Model)


notAuthenticated : State
notAuthenticated =
    makeState "not-authenticated"


authenticated : State
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


canTransition : StateMachine a -> State -> StateRecord a -> Bool
canTransition stateMachine newState stateRecord =
    let
        result =
            transition stateMachine newState stateRecord
    in
        case result of
            Ok _ ->
                True

            _ ->
                False


getAllowedFutureStates : StateMachine a -> StateRecord a -> List State
getAllowedFutureStates stateMachine stateRecord =
    List.filter (\newState -> canTransition stateMachine newState stateRecord)
        (getStates stateMachine)
