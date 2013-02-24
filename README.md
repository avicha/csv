csv
===

读取CSV文件，并把CSV内容转换成JSON对象
##安装
<pre>
    npm -g install yi-csv
</pre>
##使用

引入模块
```javascript
var CSV = require('yi-csv');
var csvfile = 'xxx.csv';
```
初始化要转换的csv文件
```javascript
var readCSV = new CSV(csvfile);
```
或者 `new CSV().init(csvfile);`

调用转换函数parse，或者你可以添加相应参数，decode指定你读取的csv文件编码，默认为utf8，split指定csv文件的分隔符，默认为逗号，headers指定是否读取表头，默认不读取

`//readCSV.parse({decode:'gbk',split:',',headers:true});`
```javascript
readCSV.parse();
```
转换出现错误，则触发error事件
```javascript
readCSV.on('error',function(err){
    console.log(err);
});
```
读取完毕，触发end事件，返回数据
```javascript
readCSV.on('end',function(data){
    console.log(data);
});
```