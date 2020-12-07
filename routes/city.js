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

var job_title
router.get("/", (request, response, next) => {
    // Info for drop down menu
    const theQuery = "SELECT JOB_TITLE FROM JOBS;"
    pool.query(theQuery)
        .then(result => {
            job_title = result.rows
        })
    next()
}, (request, response) => {
    // Info to populate table
    value = [request.query.job_title]
    const theQuery =   "SELECT     LISTINGS.WORK_CITY, ROUND(AVG(LISTINGS.PROP_SALARY)) AS \"avg_actual\", ROUND(AVG(J.EXP_SAL)) AS \"avg_expected\" "
                        + "FROM       JOBS J "
                        + "JOIN       LISTINGS "
                        + "ON         LISTINGS.JOB_TITLE = J.JOB_TITLE "
                        + "GROUP BY   LISTINGS.WORK_CITY "
                        + "ORDER BY   ROUND(AVG(LISTINGS.PROP_SALARY)) DESC; "
    pool.query(theQuery).then(result => {
        console.log(result)
        response.render('city', {
            job_title: job_title,
            result: result.rows
        })
    })
}
)

module.exports = router
