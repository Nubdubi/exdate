const express = require("express");
const router = express.Router();
const maria = require('../maria.js');

/**
 * 상품조회
 */
router.get("/", (req, res) => {
  if(req.body.bucket_id){
    maria((conn) => {
      try {
          conn.query('SELECT product_id, name, bar_cd, create_date, update_date FROM product WHERE bucket_id = ? AND delete_flag = 0 ORDER BY product_id DESC LIMIT 20',
          [
            req.body.bucket_id
          ],
          function(err, rows, fields){
            if(err){
              res.send("조회에러");
            }else{
              res.send(rows);
            }
          });
      } catch (error) {
          console.log("db error");
          res.send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.send("필수 request가 없음");
  }
});


/**
 * 상품 등록
 */
router.post("/", (req, res) => {
  if(req.body.bucket_id && req.body.name && req.body.date){
    maria((conn) => {
      try {
          conn.query('INSERT INTO product VALUES(default, ?, ?, ?, default, ?, ?)',
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
              res.send('등록성공');
            }
          });
      } catch (error) {
          console.log("db error");
          res.send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.send("필수 request가 없음");
  }
});


/**
 * 상품 삭제
 */
router.delete("/", (req, res) => {
  if(req.body.product_id && req.body.update_date){
    maria((conn) => {
      try {
          conn.query('UPDATE product SET delete_flag = 1,update_date = ? WHERE product_id = ?',
          [
            req.body.update_date,
            req.body.product_id
          ],
          function(err, rows, fields){
            if(err){
              res.send("삭제에러");
            }else{
              res.send('삭제성공');
            }
          });
      } catch (error) {
          console.log("db error");
          res.send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.send("필수 request가 없음");
  }
});


/**
 * 상품 수정
 */
router.patch("/", (req, res) => {
  if(req.body.product_id && req.body.update_date){
    var set_query="";
    const keys = Object.keys(req.body);
    for(var i=0; i<keys.length; i++){
      if(keys[i] != "product_id" && keys[i] != "bucket_id"){
        set_query += keys[i]+"='"+req.body[keys[i]]+"',";
      }
    }
    set_query = set_query.slice(0,-1);

    maria((conn) => {
      try {
          conn.query('UPDATE product SET '+set_query+' WHERE product_id = ?',
          [
            req.body.product_id,
          ],
          function(err, rows, fields){
            if(err){
              res.send("수정에러");
            }else{
              res.send('수정성공');
            }
          });
      } catch (error) {
          console.log("db error");
          res.send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.send("필수 request가 없음");
  }
});

module.exports = router;