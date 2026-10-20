
CREATE DATABASE PatientHealthcare;
USE PatientHealthcare;

SELECT COUNT(*) AS TotalPatients
FROM patient;


SHOW COLUMNS FROM patient;


SELECT *
FROM patient
LIMIT 5;

ALTER TABLE patient
CHANGE COLUMN `ï»¿Patient ID` PatientID INT;

USE patienthealthcare;

SELECT COUNT(*) AS TotalDoctors
FROM doctor;

ALTER TABLE doctor
CHANGE COLUMN `ï»¿Doctor ID` DoctorID INT;

SELECT COUNT(*) AS TotalVisits
FROM visit;

ALTER TABLE visit
CHANGE COLUMN `ï»¿Visit ID` VisitID INT;

SELECT COUNT(*) AS TotalTreatments
FROM treatments;

ALTER TABLE treatments
CHANGE COLUMN `ï»¿Treatment ID` TreatmentID INT;

SELECT COUNT(*) AS TotalLabResults
FROM labresult;

ALTER TABLE labresult
CHANGE COLUMN `ï»¿Lab Result ID` LabResultID INT;


# 1.Data validation
SELECT COUNT(*) AS TotalPatients FROM patient;
SELECT COUNT(*) AS TotalDoctors FROM doctor;
SELECT COUNT(*) AS TotalVisits FROM visit;
SELECT COUNT(*) AS TotalTreatments FROM treatments;
SELECT COUNT(*) AS TotalLabResults FROM labresult;


 # 2.Data completeness check
SELECT *
FROM patient
WHERE `First Name` IS NULL
   OR LastName IS NULL;

SELECT *
FROM visit
WHERE `Visit Type` IS NULL
   OR `Visit Date` IS NULL;
   
SELECT *
FROM treatments
WHERE `Treatment Name` IS NULL
   OR Status IS NULL;
   
SELECT *
FROM labresult
WHERE `Test Name` IS NULL
   OR `Test Result` IS NULL;
   
SELECT *
FROM doctor
WHERE `Doctor Name` IS NULL
   OR Specialty IS NULL;
   
   
# 3.Data consistency check 
  
SELECT v.VisitID, v.`Patient ID`, p.PatientID
FROM visit v
LEFT JOIN patient p
    ON v.`Patient ID` = p.PatientID
WHERE p.PatientID IS NULL;

SELECT t.TreatmentID, t.`Visit ID`, v.VisitID
FROM treatments t
LEFT JOIN visit v
    ON t.`Visit ID` = v.VisitID
WHERE v.VisitID IS NULL;


# 4.Duplicate records check 

SELECT PatientID, COUNT(*) AS RecordCount
FROM patient
GROUP BY PatientID
HAVING COUNT(*) > 1;

SELECT VisitID, COUNT(*) AS RecordCount
FROM visit
GROUP BY VisitID
HAVING COUNT(*) > 1;

SELECT TreatmentID, COUNT(*) AS RecordCount
FROM treatments
GROUP BY TreatmentID
HAVING COUNT(*) > 1;

SELECT LabResultID, COUNT(*) AS RecordCount
FROM labresult
GROUP BY LabResultID
HAVING COUNT(*) > 1;

SELECT DoctorID, COUNT(*) AS RecordCount
FROM doctor
GROUP BY DoctorID
HAVING COUNT(*) > 1;


# 5.Dashboard aggregation check 

SELECT SUM(`Treatment Cost`) AS TotalTreatmentCost
FROM treatments;

SELECT AVG(Age) AS AveragePatientAge
FROM patient;

#  Performance testing

EXPLAIN ANALYZE
SELECT *
FROM visit
WHERE STR_TO_DATE(`Visit Date`, '%Y-%m-%d')
      BETWEEN '2023-01-01' AND '2023-12-31';