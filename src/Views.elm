module Views exposing(..)

import Html.Events exposing (onClick)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing(..)
import ViewsSvg exposing (..)

view : Model -> Html Msg
view model =
    let
        header = [tr[](th[][text "Equipe"] :: (model.teams |> List.map (\t->th[][text t])))]
        dataRows2 = 
            model.rows
            |> List.indexedMap (\ indexRow r -> viewRowForm r indexRow)
    in
        div [ Html.Attributes.class "float-container"]
        [ div[Html.Attributes.class "float-child"]
            [ h2[][text "Résultat"]
            , div[][text "Date : ",input[][]]
            , table [Html.Attributes.id "result"] (header ++ dataRows2)
            , button [hidden (model.rows |> List.all (\r->not r.isEdit)), onClick Apply][text "Appliquer"]      
            , button [hidden (model.rows |> List.any (\r->r.isEdit)), onClick Edit][text "Modifier"]      
            ]     
        ]

viewRowForm : ModelRow -> Int -> Html Msg
viewRowForm model indexRow=
    let 
        showIcon s =
            case s of
                ReportData current progression -> svgReportData current progression

        cellTitle = td[onClick (SelectRow indexRow)][span[][text model.title ]]

        generateTd (ReportData valueCurrent valueProgression) i current progression=
            let
                isselected=valueCurrent==current && valueProgression==progression
                cssClass=if isselected then "selected" else ""
            in
                td[onClick(ChangeValue indexRow i (ReportData current progression)),Html.Attributes.class cssClass][ svgReportData current progression]

        cellData i x=
            if model.isEdit 
                then    
                    td[onClick (SelectRow indexRow)]
                    [
                        table[Html.Attributes.id "choice"]
                            [ tr[]
                                [ generateTd x i CurrentRed ProgressionDecrease
                                , generateTd x i CurrentRed ProgressionStable
                                , generateTd x i CurrentRed ProgressionIncrease
                                ]
                            , tr[]
                                [ generateTd x i CurrentOrange ProgressionDecrease
                                , generateTd x i CurrentOrange ProgressionStable
                                , generateTd x i CurrentOrange ProgressionIncrease
                                ]
                            , tr[]
                                [ generateTd x i CurrentGreen ProgressionDecrease
                                , generateTd x i CurrentGreen ProgressionStable
                                , generateTd x i CurrentGreen ProgressionIncrease
                                ]
                            ]
                    ]
                else
                     td[onClick (SelectRow indexRow)][showIcon x]

        rows=
            model.value
            |> List.indexedMap (\ i x -> cellData i x)       
    in
        tr[] (cellTitle :: rows)
