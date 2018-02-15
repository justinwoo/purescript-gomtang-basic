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
import Gomtang.Basic (makeBarSeries, makeChart, makeTitle, makeXAxis, makeYAxis, setOption)

main :: forall e. Eff (dom :: DOM, console :: CONSOLE | e) Unit
main = do
  main_
     <- getElementById (ElementId "main")
    <<< htmlDocumentToNonElementParentNode
    =<< document
    =<< window
  case main_ of
    Nothing ->
      log "could not find 'main' element"
    Just ele -> do
      chart <- makeChart ele
      setOption option chart
      log "started"
  where
    option =
      { title
      , xAxis
      , yAxis
      , series
      }
    title = makeTitle { text: "Bar Example" }
    xAxis = makeXAxis
      { data:
          [ "shirt"
          , "cardigan"
          , "chiffon"
          , "pants"
          , "heels"
          , "socks"
          ]
      }
    yAxis = makeYAxis {}
    series = [ seriesOption ]
    seriesOption = makeBarSeries
      { name: "sales"
      , data: [5.0, 20.0, 36.0, 10.0, 10.0, 20.0]
      }
