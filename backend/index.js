var express = require("express");
var app = express();

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

app.listen(9000, (err) => {
  console.log("http://localhost:9000/");
});
