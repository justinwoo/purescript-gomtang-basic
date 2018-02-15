# PureScript-Gomtang-Basic

Another wrapper for [ECharts](http://echarts.baidu.com/) using `Union` to take records of subsets of allowed fields. Based off of the ideas in [React-Basic](https://github.com/lumihq/purescript-react-basic).

Named for the Korean soup ["Gomtang"](https://en.wikipedia.org/wiki/Gomguk) and the Union-based approach "-basic".

![](https://i.imgur.com/qHhWz11.jpg)

More advanced uses of ECharts can be accomplished with [PureScript-ECharts](https://github.com/slamdata/purescript-echarts/).

## Example

```hs
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
```

Looks like this:

![](https://i.imgur.com/vvgL2lW.png)
