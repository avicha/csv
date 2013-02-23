// Generated by CoffeeScript 1.4.0
(function() {
  var csv, file, readCSV;

  csv = require('../index');

  file = './goods.csv';

  readCSV = new csv(file).parse({
    headers: true,
    decode: 'gbk'
  });

  readCSV.on('error', function(err) {
    return console.log(err);
  });

  readCSV.on('end', function(jsonArr) {
    return console.log(jsonArr);
  });

}).call(this);