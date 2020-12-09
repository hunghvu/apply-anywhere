/**
 * Middleware to process request from City page.
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
    const theQuery =   "SELECT     LISTINGS.WORK_CITY, ROUND(AVG(LISTINGS.PROP_SALARY)) AS \"avg_actual\", ROUND(AVG(J.EXP_SAL)) AS \"avg_expected\" "
                        + "FROM       JOBS J "
                        + "JOIN       LISTINGS "
                        + "ON         LISTINGS.JOB_TITLE = J.JOB_TITLE "
                        + "GROUP BY   LISTINGS.WORK_CITY "
                        + "ORDER BY   ROUND(AVG(LISTINGS.PROP_SALARY)) DESC; "
    pool.query(theQuery).then(result => {
        console.log(result)
        response.render('city', {
            result: result.rows
        })
    })
}
)

module.exports = router
