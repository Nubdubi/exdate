const express = require("express");
const router = express.Router();
const maria = require('../maria.js');

/**
 * 버킷조회 총 데이터 개수 조회
 */
router.get("/first", (req, res) => {
  if(req.query.user_id){
    maria(async (conn) => {
      try {
          const results = {
            limit: parseInt(req.query.limit) || 10,
            page: 1,
          };

          await conn.beginTransaction();

          var sql1 = 'SELECT count(*) as cnt FROM bucket WHERE user_id = ? AND delete_flag = 0';
          await conn.query(sql1, [req.query.user_id], function(err, rs, fields){
            if(err){ res.status(422).send(); }
            else{ results.cnt = rs[0].cnt; }
          });

          await conn.query('SELECT bucket_id, name, create_date, update_date FROM bucket WHERE user_id = ? AND delete_flag = 0 ORDER BY bucket_id DESC LIMIT ?', 
            [
              req.query.user_id, 
              results.limit
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
 * 버킷 조회
 */
router.get("/", (req, res) => {
  if(req.query.user_id){
    maria((conn) => {
      try {
          const results = {
            limit: parseInt(req.query.limit) || 10,
            page: parseInt(req.query.page) || 1,
          };
          
          conn.query('SELECT bucket_id, name, create_date, update_date FROM bucket WHERE user_id = ? AND delete_flag = 0 ORDER BY bucket_id DESC LIMIT ? OFFSET ?;',
          [
            req.query.user_id,
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
 * 버킷 등록
 */
router.post("/", (req, res) => {
  if(req.body.user_id && req.body.name && req.body.date){
    maria((conn) => {
      try {
          conn.query('INSERT INTO bucket (user_id, name, create_date, update_date) VALUES(?, ?, ?, ?)',
          [
            req.body.user_id,
            req.body.name,
            req.body.date,
            req.body.date
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
   * 버킷 삭제
   */
  router.delete("/", (req, res) => {
    if(req.body.bucket_id && req.body.update_date){
      maria((conn) => {
        try {
            conn.query('UPDATE bucket SET delete_flag = 1,update_date = ?  WHERE bucket_id = ?',
            [
              req.body.update_date,
              req.body.bucket_id
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
   * 버킷 수정
   */
  router.patch("/", (req, res) => {
    if(req.body.bucket_id && req.body.update_date){
      var set_query="";
      const keys = Object.keys(req.body);
      for(var i=0; i<keys.length; i++){
        if(keys[i] != "bucket_id" && keys[i] != "user_id"){
          set_query += keys[i]+"='"+req.body[keys[i]]+"',";
        }
      }
      set_query = set_query.slice(0,-1);

      maria((conn) => {
        try {
            conn.query('UPDATE bucket SET '+set_query+' WHERE bucket_id = ?',
            [
              req.body.bucket_id
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