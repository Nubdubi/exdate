const express = require("express");
const router = express.Router();
const request = require("request");

// http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치
const apikey = "e5999307e832428b9a4e";
const openapiurl = `http://openapi.foodsafetykorea.go.kr/api/${apikey}/C005/json/1/1`;

/**
 * api 조회
 */
router.get("/", (req, res) => {
    if(req.query.bar_cd){
        const options = {
            uri: openapiurl+"/BAR_CD="+req.query.bar_cd,
        };

        request(options,function(err,response,body){
            if(err){
                console.log(err);
                res.status(422).send();
            }else{
                let data = JSON.parse(body);
                
                if(data.C005.row != undefined && req.query.bar_cd == data.C005.row[0].BAR_CD){
                    res.send(data);                        
                }else{
                    res.status(204).send();
                    
                }
                
            }
        });
    }
    else{
        res.status(400).send();
    }
});

module.exports = router;