--GROUPING AGGREGATION
SELECT E.dname AS Doctor_Name, COUNT(*) as patient_count
FROM patient_has P, primarydoctor_employed E
WHERE P.primary_doctor_id = E.primary_doctor_id 
GROUP BY E.dname
HAVING COUNT(*) > 2

SELECT H.hospital_id, H.hname 
FROM hospital H
WHERE H.hospital_id = (SELECT H.hospital_id
	                 FROM primarydoctor_employed E
	                 WHERE E.hospital_id = H.hospital_id
	                 GROUP BY H.hospital_id
	                 HAVING COUNT(*) > 1)

--SUBQUERY
SELECT P.name, P.dob, E.dname
FROM patient_has P, primarydoctor_employed E
WHERE P.primary_doctor_id = E.primary_doctor_id 
AND P.primary_doctor_id IN
(SELECT E.primary_doctor_id
FROM primarydoctor_employed E 
WHERE p.dob LIKE '%1996%')

SELECT P.name, P.age
FROM patient_has P
WHERE P.age >= ALL (SELECT P2.age
	                FROM patient_has P2)

--INDEXES
SELECT name, age 
FROM patient_has WHERE age BETWEEN 23 AND 30

CREATE INDEX nameAge ON patient_has USING btree(age, name);