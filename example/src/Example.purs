module Example where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToNonElementParentNode)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (ElementId(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Gomtang.Basic (makeBarSeries, makeCalendar, makeChart, makeHeatMapSeries, makeTitle, makeTooltip, makeVisualMap, makeXAxis, makeYAxis, setOption)

renderChart option elId = do
  ele
     <- getElementById elId
    <<< htmlDocumentToNonElementParentNode
    =<< document
    =<< window
  case ele of
    Nothing ->
      log $ "could not find element " <> unwrap elId
    Just ele' -> do
      chart <- makeChart ele'
      setOption option chart
      log $ "mounted " <> unwrap elId

main :: forall e. Eff (dom :: DOM, console :: CONSOLE | e) Unit
main = do
  renderChart mainOption (ElementId "main")
  renderChart heatMapOption (ElementId "heatmap")
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
