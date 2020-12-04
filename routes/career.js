/**
 * Middleware to process request from Career page.
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
    // response.render('career', {})
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
    const theQuery =  "SELECT     DERIVED_TABLE.sum, DERIVED_TABLE.JOB_TITLE, CAREERS.INDUSTRY "
                    + "FROM       CAREERS "
                    + "FULL JOIN (    SELECT SUM(LISTINGS.JOB_OPENINGS), LISTINGS.JOB_TITLE "
                                    + "FROM LISTINGS "
                                    + "GROUP BY LISTINGS.JOB_TITLE) AS DERIVED_TABLE "
           
                    + "ON         DERIVED_TABLE.JOB_TITLE = CAREERS.JOB_TITLE "
                    // + "WHERE      DERIVED_TABLE.JOB_TITLE = $1 "
                    + "ORDER BY   DERIVED_TABLE.SUM DESC; "
    pool.query(theQuery).then(result => {
        console.log(result)
        response.render('career', {
            job_title: job_title,
            result: result.rows
        })
    })
}
)

module.exports = router
