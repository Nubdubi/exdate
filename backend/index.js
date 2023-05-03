const cors = require("cors");
const express = require("express");
const app = express();
const maria = require("./maria.js");
const https = require("https");
const fs = require("fs");

var path = require("path");


app.use(
  cors({
    origin: true,
    credentials: true,
  })
);
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

const port = 9001;
const httpsPort = 9000;

app.listen(port, (err) => {
  console.log(`http://localhost:${port}/`);
});

//https 설정
const options = {
  key: fs.readFileSync("./keys/privkey.pem"),
  cert: fs.readFileSync("./keys/fullchain.pem"),
};
https.createServer(options, app).listen(httpsPort, () => {
  console.log(`https port ${httpsPort}`);
});


/**
 * 데이터 설정
 */
const apikey = "e5999307e832428b9a4e";
// http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치
const openapiurl = `http://openapi.foodsafetykoea.go.kr/api/${apikey}/C005/json/1/1`;
app.use(express.static(path.join(__dirname, "../frontend/build/web")));
app.get("/", (req, res) => {
  res.sendFile(path.resolve(__dirname, "../frontend/build/web/index.html"));
});
app.use("/bucket", require("./router/bucket.js"));
app.use("/product", require("./router/product.js"));
