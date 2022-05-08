module Update exposing(..)

import Models exposing(..)

update : Msg -> Model -> (Model,Cmd Msg)
update msg model =
    case msg of
        ChangeValue id indexValue newValue->
            let
                rows=
                    model.rows
                    |> List.indexedMap (\ idxRow r -> {r | value=r.value|>List.indexedMap (\ i v -> (if idxRow==id && i==indexValue then newValue else v))})
            in
                ( {model | rows=rows}
                , Cmd.none
                )

        SelectRow i->
            let
                rows=
                    model.rows                    
                    |> List.indexedMap (\ indexRow row -> {row|isEdit=(indexRow ==i)})
            in
                ( {model | rows=rows}
                , Cmd.none
                )

        Edit->
            let
                rows=
                    model.rows                    
                    |> List.indexedMap (\ indexRow row -> {row|isEdit=True})
            in
                ( {model | rows=rows}
                , Cmd.none
                )

        Apply ->
            let
                rows=
                    model.rows
                    |> List.map (\t -> {t|isEdit=False})
            in
                ( {model | rows=rows}
                , Cmd.none
                )