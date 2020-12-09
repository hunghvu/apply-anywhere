/**
 * Middleware to process request from Compare Salary page.
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
    const theQuery =    "SELECT     E.COMPANY, ROUND(E.AVG_SAL - ( SELECT AVG(PROP_SALARY) FROM LISTINGS)) AS \"company_vs_market_avg\" "
                        + "FROM       EMPLOYERS E, LISTINGS L "
                        + "WHERE      E.COMPANY = L.COMPANY "
                        + "GROUP BY   E.COMPANY "
                        + "ORDER BY   ROUND(E.AVG_SAL - (     SELECT AVG(PROP_SALARY) FROM LISTINGS)) DESC; "
    pool.query(theQuery).then(result => {
        console.log(result)
        response.render('company', {
            job_title: job_title,
            result: result.rows
        })
    })
}
)

module.exports = router
