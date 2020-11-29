/**
 * A helper class to obtain a pool of DB connection.
 * This is used by utils.js
 * 
 * @author Hung Vu
 */
//A Pool of DB connections. 
const { Pool } = require('pg')

// Use this for local testing and development.
const pool = new Pool({
    connectionString: process.env.DATABASE_URL
    // Use this to work around with SSL rejection on local server
        || 'postgresql://postgres:root@localhost:5432/postgres',
    ssl: process.env.DATABASE_URL ? true : false
})

// Use this for deployment.
// const pool = new Pool({
//     connectionString: process.env.DATABASE_URL,
//     ssl: {
//         rejectUnauthorized: false
//     }
// })


module.exports = pool