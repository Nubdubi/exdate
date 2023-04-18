var express = require("express");
// var mysql = require('mysql');
var app = express();
var apikey = "e5999307e832428b9a4e";
// http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치
var openapiurl = `http://openapi.foodsafetykorea.go.kr/api/${apikey}/C005/json/1/1`;

app.use(express.json());
app.use(express.urlencoded( {extended : false } ));
app.listen(9000, (err) => {
  console.log("http://localhost:9000/");
});

app.get("/", (req, res) => {
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

app.post("/product", (req, res) => {
  const config = {
    method: "post"
  };
  console.log(openapiurl+"/BAR_CD="+req.body.BAR_CD);
  fetch(openapiurl+"/BAR_CD="+req.body.BAR_CD, config)
  .then((response) => {
    console.log(JSON.stringify(response));
    res.json(response);
  })
  .catch((error) => res.send(error));
  

  // res.json([
  //   { SITE_ADDR: "Value",},
  //   { PRDLST_NM: "Value",},
  //   { BAR_CD: "Value",},
  //   { POG_DAYCNT: "Value",},
  //   { PRDLST_DCNM: "Value",},
  //   { BSSH_NM: "Value",},
  //   { INDUTY_NM: "Value",},
  // ]);
});


