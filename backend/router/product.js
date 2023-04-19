const express = require("express");
const router = express.Router();
const maria = require('../maria.js');

router.post("/", (req, res) => {
    maria((conn) => {
      try {
          conn.query('INSERT INTO product VALUES(DEFAULT, ?, ?, ?, ?, ?)',
          [
            req.body.bucket_id,
            req.body.name,
            req.body.bar_cd,
            req.body.date,
            req.body.date
          ],
          function(err, rows, fields){
            if(err){
              res.send("등록에러");
            }else{
              res.send('추가성공');
            }
          });
      } catch (error) {
          console.log("db error");
          res.send(error);
      } finally{
          conn.release();
      }
    });
  });

  module.exports = router;