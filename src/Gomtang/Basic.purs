module Gomtang.Basic where

import Prelude

import Data.Symbol (SProxy(..))
import Effect (Effect)
import Prim.Row as Row
import Record as Record
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM.Element (Element)

foreign import data Instance :: Type

foreign import makeChart_ :: Element -> Effect Instance
foreign import setOption_ :: forall option. option -> Instance -> Effect Unit

makeChart
  :: Element
  -> Effect Instance
makeChart = makeChart_

setOption
  :: forall option option'
   . Row.Union option option' Option
  => Record option
  -> Instance
  -> Effect Unit
setOption = setOption_

-- types

type Option =
  ( title :: TitleOption
  , tooltip :: TooltipOption
  , xAxis :: XAxisOption
  , yAxis :: YAxisOption
  , visualMap :: VisualMapOption
  , calendar :: CalendarOption
  , series :: Array SeriesOption
  )

data TitleOption
data TooltipOption
data XAxisOption
data YAxisOption
data VisualMapOption
data CalendarOption
data SeriesOption

type Title =
  ( text :: String
  )

type Tooltip =
  ( position :: String
  )

type XAxis =
  ( data :: Array String
  )

type YAxis =
  ( data :: Array String
  )

type VisualMap =
  ( min :: Number
  , max :: Number
  , calculable :: Boolean
  , orient :: String
  , left :: String
  , bottom :: String
  )

type Calendar =
  ( cellSize :: Array String
  , range :: Array String
  )

type BarSeries =
  ( name :: String
  , data :: Array Number
  )

type HeatMapSeries =
  ( name :: String
  , data :: Array (Array String)
  , coordinateSystem :: String
  , calendarIndex :: Int
  )

-- helpers

makeTitle
  :: forall fields fields'
   . Row.Union fields fields' Title
  => { | fields }
  -> TitleOption
makeTitle = unsafeCoerce

makeTooltip
  :: forall fields fields'
   . Row.Union fields fields' Tooltip
  => { | fields }
  -> TooltipOption
makeTooltip = unsafeCoerce

makeXAxis
  :: forall fields fields'
   . Row.Union fields fields' XAxis
  => { | fields }
  -> XAxisOption
makeXAxis = unsafeCoerce

makeYAxis
  :: forall fields fields'
   . Row.Union fields fields' YAxis
  => { | fields }
  -> YAxisOption
makeYAxis = unsafeCoerce

makeVisualMap
  :: forall fields fields'
   . Row.Union fields fields' VisualMap
  => { | fields }
  -> VisualMapOption
makeVisualMap = unsafeCoerce

makeCalendar
  :: forall fields fields'
   . Row.Union fields fields' Calendar
  => { | fields }
  -> CalendarOption
makeCalendar = unsafeCoerce

makeBarSeries
  :: forall fields fields' trash
   . Row.Union fields fields' BarSeries
  => Row.Lacks "type" fields
  => Row.Cons "type" String fields trash
  => { | fields }
  -> SeriesOption
makeBarSeries r = unsafeCoerce $ Record.insert (SProxy :: SProxy "type") "bar" r

makeHeatMapSeries
  :: forall fields fields' trash
   . Row.Union fields fields' HeatMapSeries
  => Row.Lacks "type" fields
  => Row.Cons "type" String fields trash
  => { | fields }
  -> SeriesOption
makeHeatMapSeries r = unsafeCoerce $ Record.insert (SProxy :: SProxy "type") "heatmap" r
