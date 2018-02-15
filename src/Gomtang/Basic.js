var echarts = require("echarts");

exports.makeChart_ = function(node) {
  return function() {
    return echarts.init(node);
  };
};

exports.setOption_ = function(option) {
  return function(chart) {
    return function() {
      return chart.setOption(option);
    };
  };
};
