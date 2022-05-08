module Main exposing (..)

import Browser

import Models exposing(..)
import Update exposing(..)
import Views exposing(..)
import Subscriptions exposing(..)

-- MAIN
main : Program Configuration Model Msg
main =
    Browser.element 
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions }