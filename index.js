/**
 * Index file for root directory.
 * 
 * @author Hung Vu
 */
const express = require('express')
const app = express()

const bodyParser = require("body-parser")
app.use(bodyParser.json())

var path = require('path')
app.set('view engine', 'ejs')
app.engine('ejs', require('ejs').__express)
app.set('views', path.join(__dirname, "views"))

// app.use("/", express.static('pages'))

// For local testing and development.
// app.use("/", express.static('demo-site'))
// app.use("/search", require('./demo-routes/home_demo.js'))
app.get("/", (request, response) => {
    response.render('index', {})
})
app.get("/project", (request, response) => {
    response.render('project')
})
app.use("/search", require('./demo-routes/home_demo.js'))


app.listen(process.env.PORT || 5000, () => {
    console.log("Server up and running on port: " + (process.env.PORT || 5000));
})