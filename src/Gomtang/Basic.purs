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
  , xAxis :: XAxisOption
  , yAxis :: YAxisOption
  , series :: Array SeriesOption
  )

data TitleOption
data XAxisOption
data YAxisOption
data SeriesOption

type Title =
  ( text :: String
  )

type XAxis =
  ( data :: Array String
  )

type YAxis =
  ( data :: Array String
  )

type BarSeries =
  ( name :: String
  , data :: Array Number
  )

-- helpers

makeTitle
  :: forall fields fields'
   . Union fields fields' Title
  => Record fields
  -> TitleOption
makeTitle = unsafeCoerce

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

makeBarSeries
  :: forall fields fields' trash
   . Union fields fields' BarSeries
  => RowLacks "type" fields
  => RowCons "type" String fields trash
  => Record fields
  -> SeriesOption
makeBarSeries r = unsafeCoerce $ insert (SProxy :: SProxy "type") "bar" r
