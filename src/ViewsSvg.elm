module ViewsSvg exposing(..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Models exposing (ReportDataCurrent(..))
import Models exposing (ReportDataProgression(..))
import Html exposing (Html)

svgShapeArrowUp : Svg msg
svgShapeArrowUp =
    Svg.path
        [ d "M12.5 0 L 22.5 15 L 2.5 15"
        , fill "black"]
        []

svgShapeArrowDown : Svg msg
svgShapeArrowDown =
    Svg.path 
        [ d "M12.5 45 L 22.5 30 L 2.5 30"
        , fill "black"]
        []

svgShapeCircle : String -> Svg msg
svgShapeCircle color =
    circle
        [ cx "12.5"
        , cy "22.5"
        , r "12.5"
        , fill color
        ]
        []

svgReportData : ReportDataCurrent -> ReportDataProgression -> Html msg
svgReportData current progression=
    let
        shapeProgression = 
            case progression of 
                ProgressionIncrease->[svgShapeArrowUp]
                ProgressionDecrease->[svgShapeArrowDown]
                ProgressionStable->[]
                _->[]
        color=
            case current of
                CurrentGreen->"green"
                CurrentOrange->"orange"
                CurrentRed->"red"
                CurrentUnknown->"white"
            
        shapes=shapeProgression++[svgShapeCircle color]
    in
        svg
        [ Svg.Attributes.width "25"
        , Svg.Attributes.height "45"
        , viewBox "-5 0 35 45"
        , stroke "black"
        , fill "white"
        ]
        shapes