csv = require '../index'
file = './goods.csv'
readCSV = new csv(file).parse headers:true,decode:'gbk'
readCSV.on 'error',(err)->
    console.log err
readCSV.on 'end',(jsonArr)->
    console.log jsonArr