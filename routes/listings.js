/**
 * Middleware to process request from Listings page.
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

var listings
router.get("/", (request, response, next) => {
    const theQuery = "SELECT * FROM LISTINGS"
    pool.query(theQuery)
        .then(result => {
            listings = result.rows
        })
    next()
}, (request, response) => {
    value = [request.query.company]
    const theQuery =    "SELECT * FROM EMPLOYERS WHERE EMPLOYERS.COMPANY = $1"
    pool.query(theQuery, value).then(result => {
        console.log(result)
        response.render('listings', {
            listings: listings,
            company: result.rows
        })
    })
}
)

module.exports = router
