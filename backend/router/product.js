const express = require("express");
const router = express.Router();
const maria = require('../maria.js');

/**
 * 상품조회
 */
router.get("/first", (req, res) => {
  if(req.query.bucket_id){
    maria(async (conn) => {
      try {
        const results = {
          limit: parseInt(req.query.limit) || 10,
          page: 1,
        };
        
        await conn.beginTransaction();

        var sql1 = 'SELECT count(*) as cnt FROM product WHERE bucket_id = ? AND delete_flag = 0';
        await conn.query(sql1, [req.query.bucket_id], function(err, rs, fields){
          if(err){ res.status(422).send(); }
          else{ results.cnt = rs[0].cnt; }
        });

        await conn.query('SELECT product_id, name, bar_cd, amount, expiration_date, create_date, update_date FROM product WHERE bucket_id = ? AND delete_flag = 0 ORDER BY product_id DESC LIMIT ?',
        [
          req.query.bucket_id,
          results.limit,
        ],
        function(err, rs, fields){
          if(err){ res.status(422).send(); }
          else{ 
            results.list = rs;
            res.status(200).send(results);
          }
        });

        await conn.commit();

      } catch (error) {
        res.status(503).send(error);
      } finally{
        conn.release();
      }
    });
  }else{
    res.status(400).send();
  }
});

/**
 * 상품조회
 */
router.get("/", (req, res) => {
  if(req.query.bucket_id){
    maria((conn) => {
      try {
        const results = {
          limit: parseInt(req.query.limit) || 10,
          page: parseInt(req.query.page) || 1,
        };

        conn.query('SELECT product_id, name, bar_cd, amount, expiration_date, create_date, update_date FROM product WHERE bucket_id = ? AND delete_flag = 0 ORDER BY product_id DESC LIMIT ? OFFSET ?',
        [
          req.query.bucket_id,
          results.limit,
          (results.page-1)*results.limit
        ],
        function(err, rs, fields){
          if(err){ res.status(422).send(); }
          else{ 
            results.list = rs;
            res.status(200).send(results);
          }
        });
      } catch (error) {
        res.status(503).send(error);
      } finally{
        conn.release();
      }
    });
  }else{
    res.status(400).send();
  }
});


/**
 * 상품 등록
 */
router.post("/", (req, res) => {
  if(
    req.body.bucket_id 
    && req.body.name 
    && req.body.date 
    && req.body.amount
    && req.body.expiration_date
    && req.body.bar_cd != undefined
  ){
    maria((conn) => {
      try {
          conn.query('INSERT INTO product (bucket_id, name, bar_cd, create_date, update_date, amount, expiration_date) VALUES(?, ?, ?, ?, ?, ?, ?)',
          [
            req.body.bucket_id,
            req.body.name,
            req.body.bar_cd,
            req.body.date,
            req.body.date,
            req.body.amount,
            req.body.expiration_date
          ],
          function(err, rows, fields){
            if(err){ res.status(422).send(); }
            else{ res.status(200).send(); }
          });
      } catch (error) {
        res.status(503).send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.status(400).send();
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
            if(err){ res.status(422).send(); }
            else{ res.status(200).send(); }
          });
      } catch (error) {
        res.status(503).send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.status(400).send();
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
            if(err){ res.status(422).send(); }
            else{ res.status(200).send(); }
          });
      } catch (error) {
        res.status(503).send(error);
      } finally{
          conn.release();
      }
    });
  }else{
    res.status(400).send();
  }
});

module.exports = router;