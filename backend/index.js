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
  console.log(`https://localhost:${httpsPort}/`);
});

app.use("/bucket", require("./router/bucket.js"));
app.use("/product", require("./router/product.js"));
app.use("/barcode", require("./router/barcode.js"));