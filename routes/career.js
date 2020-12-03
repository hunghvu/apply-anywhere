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
     response.render('career', {})
     // Info for drop down menu
//      const theQuery = "SELECT JOB_TITLE FROM JOBS;" 
//      pool.query(theQuery)
//          .then(result => {
//              job_title = result.rows
//          })
//      next()
//  }, (request, response) => {
//      // Info to populate table
//      value = [request.query.job_title]
//      const theQuery = " SELECT JOBS.JOB_TITLE, JOBS.EXP_SAL, CAREERS.INDUSTRY, LISTINGS.COMPANY "
//                              + "FROM   JOBS "
//                              + "JOIN   CAREERS "
//                              + "ON     JOBS.JOB_TITLE = CAREERS.JOB_TITLE " 
//                              + "JOIN   LISTINGS "
//                              + "ON     JOBS.JOB_TITLE = LISTINGS.JOB_TITLE "
//                              + "WHERE  JOBS.JOB_TITLE = $1;"
//      pool.query(theQuery, value).then(result => {
//          console.log(result)
//          response.render('career', {
//              job_title : job_title,
//              result : result.rows
//          })
//      })
 }
 )
 
 module.exports = router
 