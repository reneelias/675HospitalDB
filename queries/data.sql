INSERT into patient
VALUES (DEFAULT, 'Diana Yu', '01/02/1996', 'sf ave', '123456789', '0123456789', '0'),
(DEFAULT, 'Rene Elias', '03/03/1991', '2546 26th', '987654321', '0123546789', '1'),
(DEFAULT, 'Giovanni TJ Marin', '08/19/1996', 'TJ Ave', '000000000', '1234554321', '2'),
(DEFAULT, 'Carina Kalaydjian', '02/01/1997', 'Daly City', '999888777', '1234554321', '3'),
(DEFAULT, 'Hector Aguirre', '05/03/1995', 'San Diego', '111222333', '5432112345', '4'),
(DEFAULT, 'Maria Perez', '02/29/1990', 'West Side', '000000222', '5151561651', '6'),
(DEFAULT, 'William James', '05/01/1997', 'South Park', '222888777', '1234554320', '7'),
(DEFAULT, 'Kanye West', '06/06/1966', 'Chicago', '111222000', '5432112340', '8'),
																						

INSERT INTO pharmacy
VALUES (DEFAULT, 'rojo', 'tylenol', '1111111111'),
(DEFAULT, 'azul', 'planb', '2222222222'),
(DEFAULT, 'amarillo', 'advil', '3333333333'),
(DEFAULT, 'rosa', 'teraflu', '4444444444'),
(DEFAULT, 'verde', 'prospan', '5555555555')


INSERT INTO hospital
VALUES (DEFAULT, 'CA', 'CA ave', '1111111112'),
(DEFAULT, 'NY', 'NY ave', '2222222223'),
(DEFAULT, 'FL', 'FL ave', '3333333334'),
(DEFAULT, 'TX', 'TX ave', '4444444445'),
(DEFAULT, 'MA', 'MA ave', '5555555556');

INSERT INTO primarydoctor
VALUES (DEFAULT, 'WI', 'WI ave', '1111111113'),
(DEFAULT, 'NV', 'NV ave', '2222222224'),
(DEFAULT, 'OR', 'OR ave', '3333333335'),
(DEFAULT, 'NJ', 'NJ ave', '4444444446'),
(DEFAULT, 'PA', 'PA ave', '5555555557');

INSERT INTO has
VALUES ((SELECT patient_id FROM patient WHERE patient_id = 1), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 2), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 3), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 2)),
 ((SELECT patient_id FROM patient WHERE patient_id = 4), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 2)),
 ((SELECT patient_id FROM patient WHERE patient_id = 5), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 3)),
INSERT INTO has
VALUES ((SELECT patient_id FROM patient WHERE patient_id = 6), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 7), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 3)),
((SELECT patient_id FROM patient WHERE patient_id = 8), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 9), 
(SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 2));

SELECT P.name, P.dob
FROM patient P, has H
WHERE H.patient_id = P.patient_id
GROUP BY H.primary_doctor_id
HAVING COUNT(*) > 1;

SELECT P.name, P.dob
FROM patient P, has H
WHERE H.patient_id = P.patient_id;


SELECT COUNT(*), H.primary_doctor_id
FROM has H
GROUP BY H.primary_doctor_id

SELECT COUNT(*) as patient_count, H.primary_doctor_id
FROM has H
GROUP BY H.primary_doctor_id
HAVING COUNT(*) > 2


SELECT P.dname AS Doctor_Name, COUNT(*) as patient_count
FROM has H, primarydoctor P
WHERE P.primary_doctor_id = H.primary_doctor_id 																			
GROUP BY P.dname
HAVING COUNT(*) > 2	

INSERT INTO attends
VALUES ((SELECT patient_id FROM patient WHERE patient_id = 1), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 2), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 6), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 8), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 3), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 5), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 4), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT patient_id FROM patient WHERE patient_id = 5), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 2)),
((SELECT patient_id FROM patient WHERE patient_id = 7), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 2));


INSERT INTO employs
VALUES ((SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 1), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 3), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 1)),
((SELECT primary_doctor_id FROM primarydoctor WHERE primary_doctor_id = 2), 
(SELECT hospital_id FROM hospital WHERE hospital_id = 2));

