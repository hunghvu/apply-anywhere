/**
 * Middleware to process request from Openings page.
 * @author Hung vu
 */

// Setup
const { Console } = require('console')
const express = require('express')
const app = express()

var router = express.Router()

let pool = require('../utilities/utils').pool

var path = require('path')
app.set('view engine', 'ejs')
app.engine('ejs', require('ejs').__express)
app.set('views', path.join(__dirname, "views"))

router.get("/", (request, response) => {
    // Info to populate table
    const theQuery =  "SELECT     DERIVED_TABLE.sum, DERIVED_TABLE.JOB_TITLE, CAREERS.INDUSTRY "
                    + "FROM       CAREERS "
                    + "FULL JOIN (    SELECT SUM(LISTINGS.JOB_OPENINGS), LISTINGS.JOB_TITLE "
                                    + "FROM LISTINGS "
                                    + "GROUP BY LISTINGS.JOB_TITLE) AS DERIVED_TABLE "
           
                    + "ON         DERIVED_TABLE.JOB_TITLE = CAREERS.JOB_TITLE "
                    + "ORDER BY   DERIVED_TABLE.SUM DESC; "
    pool.query(theQuery).then(result => {
        console.log(result)
        response.render('career', {
            result: result.rows
        })
    })
}
)

module.exports = router
