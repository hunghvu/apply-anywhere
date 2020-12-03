/**
 * This node provide Offer page with dynamic drop down menu.
 * @author Hung Vu
 */
const express = require('express')
const app = express()

var router = express.Router()

let pool = require('../utilities/utils').pool

var path = require('path')
app.set('view engine', 'ejs')
app.engine('ejs', require('ejs').__express)
app.set('views', path.join(__dirname, "views"))

router.get("/", (request, response) => {
    // const value = request.query.last_name
    // vulnerable to sql injection?
    const theQuery = "SELECT JOB_TITLE FROM JOBS;" 
    // console.log(value)

    pool.query(theQuery)
        .then(result => {
            // console.log(result.rows[0].job_title),

            console.log(result)
            // response.send({
            //     job_title: result.job_title
            // }),
            // response.sendFile(path.join(__dirname, "../demo-site/project.html"))
            response.render('offer', {
                job_title: result.rows
            })
        }
        )
})

module.exports = router
