EventEmitter = require('events').EventEmitter
iconv = require 'iconv-lite'
fs = require 'fs'
class csv extends EventEmitter
    constructor:(csvfile)->
        @init csvfile
    init : (csvfile)->
        @csvfile = csvfile
        @
    parse : (options={})->
        self = @
        if !self.csvfile
            self.emit 'error',{msg:"please input the csvfile"}
        else
            CSVToArray = (str,split)->
                objPattern = new RegExp "(\\#{split}|\\r?\\n|\\r|^)(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|([^\"\\#{split}\\r\\n]*))","gi"
                arrData = [[]]
                arrMatches = null
                while arrMatches = objPattern.exec str
                    strMatchedDelimiter = arrMatches[1]
                    if strMatchedDelimiter.length &&strMatchedDelimiter != split
                        arrData.push [] 
                    if arrMatches[2]
                        strMatchedValue = arrMatches[2].replace new RegExp( "\"\"", "g" ),"\""
                    else 
                        strMatchedValue = arrMatches[3]
                    arrData[arrData.length-1].push strMatchedValue
                arrData[0]
            fs.readFile self.csvfile,(err,buffer)->
                if err
                    self.emit 'error',{msg:"read file error:#{err}"}
                else
                    if options.decode
                        data = iconv.decode buffer,options.decode
                    else
                        data = buffer.toString()
                    split = options.split || ','
                    rows = data.split '\n'
                    jsonArr = []
                    rows.forEach (row)->
                        rowData = CSVToArray row,split
                        if options.headers
                            if !self.headers
                                self.headers = rowData
                            else
                                obj = {}
                                rowData.forEach (d,i)->
                                    header = self.headers[i]
                                    obj[header] = d
                                jsonArr.push obj
                        else
                            jsonArr.push rowData
                    self.emit 'end',jsonArr
        self
module.exports = csv