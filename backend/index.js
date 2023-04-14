var express = require("express");
// var mysql = require('mysql');
var app = express();
var apikey = "e5999307e832428b9a4e";
// http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치
var openapiurl = ` http://openapi.foodsafetykorea.go.kr/api/${apikey}/C005/josn/1/10`;

// var connection = mysql.createConnction({
//   host:,
//   user:,
//   password:,
//   database:,
// });

// connection.connect();

app.get("/", (req, res) => {
  var userHeader = req.headers["user-header"];
  console.log(userHeader);
  if (userHeader === undefined) {
    return res.json({ key: "ERR" });
  }

  res.json([
    {
      key: "Value",
    },
    {
      key: "Value",
    },
    {
      key: "Value",
    },
    {
      key: "Value",
    },
  ]);
});

// app.get("/test", (req, res) => {
//   connection.query('SELECT * FROM author',(err,result,filed)=> {return res.json(result);})
// });

app.listen(9000, (err) => {
  console.log("http://localhost:9000/");
});
