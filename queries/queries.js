// Creates a pool of connections for querying PostgresQL database.

// Require PostgresQL module from Node packages
var pg = require('pg');
delete pg.native;
const Pool = pg.Pool;
// Create a new connection from Pool
const pool = new Pool({
	// Enter username here:
	user: 'postgres',
	// Enter server address here
	host: 'gatorstate.tk',
	// Enter which database you'd like to connect to
	database: 'postgres',
	// Enter password here
	password: 'T3am06S19p0st!',
	// Enter which port PostgresQL is using
	port: '5432',
})
//PATIENTS BITCH
const getAllPatients = (request, response) => {

	pool.query(`SELECT P.*, E.dname, H.hname
	FROM patient_has P, primarydoctor_employed E, hospital H
	WHERE P.primary_doctor_id = E.primary_doctor_id AND E.hospital_id = H.hospital_id`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

const getPatient = (request, response) => {
	const search = request.params.search.toLowerCase();

	pool.query(`SELECT P.*, E.dname, H.hname
	FROM patient_has P, primarydoctor_employed E, hospital H
	WHERE P.primary_doctor_id = E.primary_doctor_id AND E.hospital_id = H.hospital_id AND LOWER(name) LIKE '%${search}%'`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

//Doctor BEACHHHHHHHHH!!!!!!!
const getAllDoctors = (request, response) => {

	pool.query(`SELECT * FROM primarydoctor_employed`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

const getDoctor = (request, response) => {
	const search = request.params.search.toLowerCase();

	pool.query(`SELECT * FROM primarydoctor_employed WHERE LOWER(dname) LIKE '%${search}%'`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

//HOSPITALSSSSSSSSSSSSSSSSSS!!!! 
const getAllHospitals = (request, response) => {

	pool.query(`SELECT * FROM hospital`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

const getHospital = (request, response) => {
	const search = request.params.search.toLowerCase();

	pool.query(`SELECT * FROM hospital WHERE LOWER(hname) LIKE '%${search}%'`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

const getHospitalsAndDoctors = (request, response) => {
	pool.query(`SELECT H.hname, E.dname, H.hospital_id, E.primary_doctor_id
	FROM hospital H, primarydoctor_employed E
	WHERE E.hospital_id = H.hospital_id
	GROUP BY H.hname, E.dname, H.hospital_id, E.primary_doctor_id`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

const getMaxInsuranceID = (request, response) => {

	console.log('Max');

	pool.query(`SELECT MAX(insurance_id) AS max_id
	FROM patient_has`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

const postNewPatient = (request, response) => {
	///newpatient/:name/:dob/:address/:ssn/:phoneNumber/:insuranceid/:primarydoctorid/:age
	const name = request.params.name.replace(/\+/g, ' ');
	const dob = request.params.dob.replace(/\+/g, '/');
	const address = request.params.address.replace(/\+/g, ' ').replace(/\+/g, ' ');
	const ssn = request.params.ssn;
	const phoneNumber = request.params.phoneNumber;
	const insuranceid = request.params.insuranceid;
	const primarydoctorid = request.params.primarydoctorid;
	const age = request.params.age;

	console.log('posting!');

	
	pool.query(`INSERT INTO public.patient_has(
		patient_id, name, dob, paddress, snn, pphone_number, insurance_id, primary_doctor_id, age)
		VALUES (DEFAULT, '${name}', '${dob}', '${address}', '${ssn}', '${phoneNumber}', ${insuranceid}, ${primarydoctorid}, ${age})`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(`User added with name ${name}`);
	})
}

const getDoctorIDByName = (request, response) => {
	const docName = request.params.docName;
	console.log("docName");
	console.log(docName);

	pool.query(`SELECT primary_doctor_id
	FROM primarydoctor_employed
	WHERE dname = '${docName}'`, (error, results) => {
		if (error) {
		throw error
		}
		response.status(200).json(results.rows)
	})
}

module.exports = {
	getAllPatients,
	getPatient,
	getAllDoctors,
	getDoctor,
	getAllHospitals,
	getHospital,
	getHospitalsAndDoctors,
	getMaxInsuranceID,
	postNewPatient,
	getDoctorIDByName,
}
