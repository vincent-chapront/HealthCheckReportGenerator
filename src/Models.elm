module Models exposing(..)

type Msg
    = ChangeValue Int Int ReportData 
    | SelectRow Int
    | Apply
    | Edit

type ReportDataCurrent
    = CurrentUnknown
    | CurrentRed
    | CurrentOrange
    | CurrentGreen

type ReportDataProgression
    = ProgressionUnknown
    | ProgressionIncrease
    | ProgressionStable
    | ProgressionDecrease

type ReportData = ReportData ReportDataCurrent ReportDataProgression

type alias Configuration =
    { category: List String
    , teams: List String
    }

type alias ModelRow=
    { title:String
    , value: List ReportData
    , isEdit: Bool
    }

type alias Model = 
    { teams: List String
    , rows:List ModelRow
    }

newRow : String->Int->ModelRow
newRow title nbTeams =
    { title=title
    , value=nbTeams |> List.range 1|> List.map (\_ -> ReportData CurrentUnknown ProgressionUnknown)
    , isEdit=False
    }


init : Configuration-> (Model,Cmd Msg)
init config =
    let 
        teams = config.teams
        category = config.category|> List.map (\t-> (newRow t (List.length teams)))
    in
        ( { teams = config.teams, rows = category}
        , Cmd.none
        )