/**
 * @author Hung Vu
 */
const express = require('express')
const app = express()

const bodyParser = require("body-parser")
app.use(bodyParser.json())

var path = require('path')

app.use("/", express.static('pages'))


app.listen(process.env.PORT || 5000, () => {
    console.log("Server up and running on port: " + (process.env.PORT || 5000));
})