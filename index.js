/**
 * Index file for root directory.
 * 
 * @author Hung Vu
 */

 // Set up required element for index.jsjs
const express = require("express")
const app = express()

const bodyParser = require("body-parser")
app.use(bodyParser.json())

var path = require("path")

// Using EJS for dynamic front end.
app.set("view engine", "ejs")
app.engine("ejs", require("ejs").__express)
app.set("views", path.join(__dirname, "views"))

const favicon = require("serve-favicon")

// Serve static files.
app.use(express.static("public"))
app.use(favicon(path.join(__dirname, "public", "favicon.ico")))

// app.use("/", express.static("pages"))

// For local testing and development.
// app.use("/", express.static("demo-site"))
// app.use("/search", require("./demo-routes/home_demo.js"))
// app.use("/search", require("./demo-routes/home_demo.js"))

// End point for home page, Jobs page, Openings page, City Overview and Compare Salary page.
app.get("/", (request, response) => {
    response.render("index", {})
})

app.use("/offer", require("./routes/offer.js"))
app.use("/career", require("./routes/career.js"))
app.use("/salarypercity", require("./routes/city.js"))
app.use("/salarypercompany", require("./routes/company.js"))
app.use("/listings", require("./routes/listings.js"))

// Not implement.
// app.get("/project", (request, response) => {
//     response.render("project")
// })

app.listen(process.env.PORT || 5000, () => {
    console.log("Server up and running on port: " + (process.env.PORT || 5000));
})