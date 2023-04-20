const cors = require('cors');
const express = require("express");
const app = express();
const maria = require('./maria.js');

/**
 * express 설정
 */
app.use(cors({
  origin: true,
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded( {extended : false } ));
app.listen(9000, (err) => {
  console.log("http://localhost:9000/");
});

/**
 * 데이터 설정
 */
const apikey = "e5999307e832428b9a4e";
// http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치
const openapiurl = `http://openapi.foodsafetykorea.go.kr/api/${apikey}/C005/json/1/1`;

app.use("/bucket", require("./router/bucket.js"));
app.use("/product", require("./router/product.js"));