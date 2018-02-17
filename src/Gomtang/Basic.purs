module Gomtang.Basic where

import Prelude

import Control.Monad.Eff (Eff)
import DOM.Node.Types (Element)
import Data.Record (insert)
import Data.Symbol (SProxy(..))
import Type.Prelude (class RowLacks)
import Unsafe.Coerce (unsafeCoerce)

foreign import data Instance :: Type

foreign import makeChart_ :: forall e
   . Element -> Eff e Instance
foreign import setOption_ :: forall option e
   . option -> Instance -> Eff e Unit

makeChart
  :: forall e
   . Element
  -> Eff e Instance
makeChart = makeChart_

setOption
  :: forall e options option option'
   . Union option option' Option
  => Record option
  -> Instance
  -> Eff e Unit
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
   . Union fields fields' Title
  => Record fields
  -> TitleOption
makeTitle = unsafeCoerce

makeTooltip
  :: forall fields fields'
   . Union fields fields' Tooltip
  => Record fields
  -> TooltipOption
makeTooltip = unsafeCoerce

makeXAxis
  :: forall e fields fields'
   . Union fields fields' XAxis
  => Record fields
  -> XAxisOption
makeXAxis = unsafeCoerce

makeYAxis
  :: forall e fields fields'
   . Union fields fields' YAxis
  => Record fields
  -> YAxisOption
makeYAxis = unsafeCoerce

makeVisualMap
  :: forall e fields fields'
   . Union fields fields' VisualMap
  => Record fields
  -> VisualMapOption
makeVisualMap = unsafeCoerce

makeCalendar
  :: forall e fields fields'
   . Union fields fields' Calendar
  => Record fields
  -> CalendarOption
makeCalendar = unsafeCoerce

makeBarSeries
  :: forall fields fields' trash
   . Union fields fields' BarSeries
  => RowLacks "type" fields
  => RowCons "type" String fields trash
  => Record fields
  -> SeriesOption
makeBarSeries r = unsafeCoerce $ insert (SProxy :: SProxy "type") "bar" r

makeHeatMapSeries
  :: forall fields fields' trash
   . Union fields fields' HeatMapSeries
  => RowLacks "type" fields
  => RowCons "type" String fields trash
  => Record fields
  -> SeriesOption
makeHeatMapSeries r = unsafeCoerce $ insert (SProxy :: SProxy "type") "heatmap" r
