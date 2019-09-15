/* SETUP HERE
// ---------------
// This section will setup all dependencies and variables required to run the server.
*/

// Express
const express = require('express');
const app = express();
const cors = require('cors');

app.use(cors());

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

// BodyParser
const bodyParser = require('body-parser');

// Server info
const path = require('path');
const hostname = '127.0.0.1';
const port = 3001;

// PostgresQL
const db = require('./queries/queries');

/* MAIN LOGIC HERE
// ---------------
// This section will serve all the main function and attributes we'll use in the server
*/

// bodyParser logic
app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true
  })
);

//app.use(express.static(__dirname + '/components'));

// viewed at http://localhost:3000
app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname + '/index.html'));
});


// app.get('/patients/:search/:filter', db.getLikeListingsFilter);
//Patient
app.get('/patients', db.getAllPatients);
app.get('/patients/:search', db.getPatient);
//Doctor
app.get('/doctors', db.getAllDoctors);
app.get('/doctors/:search', db.getDoctor);
//Hospital
app.get('/hospitals', db.getAllHospitals);
app.get('/hospitals/:search', db.getHospital);
//Doctors and Hospitals
app.get('/docsandhosps', db.getHospitalsAndDoctors);
//Max insurance id
app.get('/maxinsuranceid', db.getMaxInsuranceID);
//Get primary doc id
app.get('/primarydocname/:docName', db.getDoctorIDByName);
//Post new patient
app.get('/newpatient/:name/:dob/:address/:ssn/:phoneNumber/:insuranceid/:primarydoctorid/:age', db.postNewPatient)

// app.get('/listingsFilter/:filter', db.getHouseTypeListings);
// app.get('/listings', db.getAllListings);

/*
//  Search Page Redirect
*/
app.get('/search', function(req, res) {
  // eslint-disable-next-line no-undef
  listings = 'WADDUP';
  res.render('search', {
    search: req.query.search,
    filter: req.query.filter,
  });
});

app.get('/signup', function(req, res) {
  // eslint-disable-next-line no-undef
  res.render('signup', {
  });
});

// so we can just click on the server link
app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
