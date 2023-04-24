const maria = require("mysql");

const pool = maria.createPool({
  host: "castpro.site",
  port: 4885,
  user: "tt",
  password: "tt",
  database: "tt",
  connectionLimit: 20,
});

function getConnection(callback) {
  pool.getConnection(function (err, conn) {
    if (err) {
      throw err;
    }
    callback(conn);
  });
}

module.exports = getConnection;
