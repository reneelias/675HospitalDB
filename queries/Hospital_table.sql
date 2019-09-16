CREATE TABLE hospital (
hospital_id serial,
hname char(50),
haddress char(50),
hphone_number char(10),
age int 
PRIMARY KEY (hospital_id)
);


CREATE TABLE pharmacy_contained (
pharmacy_id serial,
pharname char(50), 
prescriptions varchar(100),
pphone_number char(10),
hospital_id int NOT NULL,
PRIMARY KEY (pharmacy_id),
FOREIGN KEY (hospital_id) REFERENCES hospital (hospital_id)
ON DELETE CASCADE
);


CREATE TABLE primarydoctor_employed (
primary_doctor_id serial,
dname char(50),
daddress char(50),
dphone_number char(10),
hospital_id int NOT NULL,
PRIMARY KEY (primary_doctor_id),
FOREIGN KEY (hospital_id) REFERENCES hospital (hospital_id)
ON DELETE CASCADE
);


CREATE TABLE patient_has(
patient_id serial,
name char(50),
dob char(50),
paddress char(50),
snn char(9),
pphone_number char(10),
insurance_id int,
Age int,
primary_doctor_id int NOT NULL,
PRIMARY KEY (patient_id),
FOREIGN KEY (primary_doctor_id) REFERENCES primarydoctor_employed (primary_doctor_id)
ON DELETE CASCADE
);


CREATE TABLE attends(
patient_id int NOT NULL,
hospital_id int NOT NULL,
PRIMARY KEY (patient_id, hospital_id),
FOREIGN KEY (patient_id) REFERENCES patient_has (patient_id)
ON DELETE CASCADE,
FOREIGN KEY (hospital_id) REFERENCES hospital (hospital_id)
ON DELETE CASCADE
);

