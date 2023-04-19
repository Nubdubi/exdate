const maria = require('mysql');

const pool = maria.createPool({
    host:'localhost',
    port:3306,
    user:'root',
    password:'root',
    database:'tt',
    connectionLimit: 20
});

function getConnection(callback){
    pool.getConnection(function(err, conn){
        if(err){throw err;}
        callback(conn);
    });
}

module.exports = getConnection;