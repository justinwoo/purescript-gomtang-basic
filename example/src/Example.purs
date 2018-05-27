module Example where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Gomtang.Basic (makeBarSeries, makeCalendar, makeChart, makeHeatMapSeries, makeTitle, makeTooltip, makeVisualMap, makeXAxis, makeYAxis, setOption)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

renderChart option elId = do
  ele
     <- getElementById elId
    <<< toNonElementParentNode
    =<< document
    =<< window
  case ele of
    Nothing ->
      log $ "could not find element " <> elId
    Just ele' -> do
      chart <- makeChart ele'
      setOption option chart
      log $ "mounted " <> elId

main :: Effect Unit
main = do
  renderChart mainOption "main"
  renderChart heatMapOption "heatmap"
  where
    mainOption =
      { title: makeTitle { text: "Bar Example" }
      , xAxis: makeXAxis
          { data:
              [ "shirt"
              , "cardigan"
              , "chiffon"
              , "pants"
              , "heels"
              , "socks"
              ]
          }
      , yAxis: makeYAxis {}
      , series: pure $ makeBarSeries
        { name: "sales"
        , data: [5.0, 20.0, 36.0, 10.0, 10.0, 20.0]
        }
      }
    heatMapOption =
      { tooltip: makeTooltip { position: "top" }
      , visualMap: makeVisualMap
          { min: 0.0
          , max: 10.0
          , calculable: true
          }
      , calendar: makeCalendar
          { range: ["2017-10-20", "2018-2-17"]
          , cellSize: ["auto", "auto"]
          }
      , series: pure $ makeHeatMapSeries $
          { coordinateSystem: "calendar"
          , calendarIndex: 0
          , data:
              [ ["2017-10-28", "3"]
              , ["2017-11-18", "8"]
              , ["2017-11-23", "4"]
              , ["2017-12-18", "6"]
              , ["2017-01-01", "1"]
              , ["2018-01-15", "9"]
              , ["2018-02-12", "2"]
              ]
        }
      }
