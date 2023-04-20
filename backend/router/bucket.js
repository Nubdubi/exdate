const express = require("express");
const router = express.Router();
const maria = require('../maria.js');

router.post("/", (req, res) => {
    maria((conn) => {
      try {
          conn.query('INSERT INTO bucket VALUES(default, ?, ?, ?, ?)',
          [
            req.body.user_id,
            req.body.name,
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
          res.send(err);
      } finally{
          conn.release();
      }
    });  
  });

  module.exports = router;