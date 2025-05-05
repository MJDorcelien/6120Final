
-- Patient Queries
ALTER PROCEDURE patientsInsertSelectUpdateDelete (@patient_id  INTEGER,
                                                  @first_name VARCHAR(45),
                                                  @last_name VARCHAR(45),
                                                  @address VARCHAR(100),
                                                  @phone_number BIGINT,
                                                  @email VARCHAR(100),
                                                  @insurance_id INT,
                                                  @dob YEAR)
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO patients
                        (patient_id,
                         first_name,
                         last_name,
                         address,
                         phone_number,
                         email,
                         insurance_id,
                         dob)
            VALUES     ( @patient_id,
                         @first_name,
                         @last_name,
                         @address,
                         @phone_number,
                         @email,
                         @insurance_id,
                         @dob)
        END

      IF @StatementType = 'Select'
        BEGIN
            SELECT *
            FROM   patients
        END

      IF @StatementType = 'Update'
        BEGIN
            UPDATE employee
            SET    patient_id = @patient_id,
                   first_name = @first_name,
                   last_name = @last_name,
                   address = @address,
                   phone_number = @phone_number,
                   email = @email,
                   insurance_id = @insurance_id,
                   dob = @dob
            WHERE  patient_id = @patient_id
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM patients
            WHERE  patient_id = @patient_id
        END
  END

DELIMITER $$
CREATE PROCEDURE patientRecords(
    IN PatientID INT,
    IN VisitID INT
)
BEGIN
    SELECT 
       v.visit_id,
       p.patient_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,
       v.visit_date,
       v.reason
    FROM visits as v, patients as p, providers as r
    WHERE p.patient_id = PatientID AND v.visit_id = VisitID;
END $$
DELIMITER ;

-- p5. Patients born after 2008 and with insurance
CREATE PROCEDURE selectAllPatients
AS
SELECT * FROM patients 
WHERE dob > 2008 AND insurance_id IS NOT NULL
GO;
-- p6. Count the number of patients
CREATE PROCEDURE countAllPatients
AS
SELECT COUNT(*) AS total_patients FROM patients
GO;

-- p7. Update patient first name
DELIMITER $$
CREATE PROCEDURE updatePatients(
    IN PatientID INT,
    IN pVisitID INT,
    IN FirstName TEXT,
    IN LastName TEXT,
    IN Address TEXT,
    IN PhoneNumber INT,
    IN Email TEXT,
    IN InsuranceID INT,
    IN DOB DATE
)
BEGIN
    UPDATE patients
    SET 
        patient_id = PatientID,
        first_name = FirstName,
        last_name = LastName,
        address = Address,
        phone_number = PhoneNumber,
        email = Email,
        insurance_id = InsuranceID,
        dob = DOB
    WHERE patient_id = PatientID;
END $$
DELIMITER ;
-- p8. Patients with at least one visit
CREATE PROCEDURE patientsOneVisit
AS
SELECT DISTINCT p.* 
FROM patients p
JOIN visits v ON p.patient_id = v.patient_id
GO;
-- p9. Patients who haven't had a visit yet
CREATE PROCEDURE patientsNoVisits
AS
SELECT * FROM patients 
WHERE patient_id NOT IN (SELECT patient_id FROM visits)
GO;

-- Provider Queries
-- r4. Providers who have seen more than 10 patients
SELECT provider_id, COUNT(DISTINCT patient_id) AS patient_count
FROM visits
GROUP BY provider_id
HAVING patient_count > 10;

-- r5. Total revenue per provider (assumes a price column exists; you may need to adjust if not)
-- Remove this if there's no `price` field anywhere
-- SELECT pr.provider_id, pr.first_name, pr.last_name, SUM(v.price) AS total_revenue
-- FROM providers pr
-- JOIN visits v ON pr.provider_id = v.provider_id
-- GROUP BY pr.provider_id;

-- r6. Most common specialty
SELECT specialty, COUNT(*) AS count
FROM providers
GROUP BY specialty
ORDER BY count DESC
LIMIT 1;

-- Visit Queries
-- v1. Get all visits
SELECT * FROM visits;

-- v2. All visits of a specific patient
SELECT * FROM visits WHERE patient_id = 1;

-- v3. Visits in last 30 days
SELECT * FROM visits WHERE visit_date >= CURDATE() - INTERVAL 30 DAY;

-- v4. All visits of a specific provider
SELECT * FROM visits WHERE provider_id = 3;

-- v5. Most recent visit for each patient
SELECT * FROM visits WHERE visit_date = (SELECT MAX(visit_date) FROM visits);

-- v6. Patient name, provider name, facility
SELECT v.visit_id, v.visit_date, 
       CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,
       v.facility
FROM visits v
JOIN patients p ON v.patient_id = p.patient_id
JOIN providers pr ON v.provider_id = pr.provider_id;

-- v7. Visits in descending date
SELECT * FROM visits ORDER BY visit_date DESC;

-- v8. Number of visits per patient
SELECT patient_id, COUNT(*) AS visit_count
FROM visits
GROUP BY patient_id;

-- Clinical Notes Queries
-- c1. Get all clinical notes
SELECT * FROM clinical_notes;

-- c2. Clinical notes with a prescription (join prescriptions)
SELECT cn.*
FROM clinical_notes cn
JOIN prescriptions p ON cn.visit_id = p.visit_id;

-- c3. Notes by provider (via visits)
SELECT cn.note_id,
       CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,
       cn.signs_symptoms, cn.diagnosis
FROM clinical_notes cn
JOIN visits v ON cn.visit_id = v.visit_id
JOIN providers pr ON v.provider_id = pr.provider_id;

-- Extras Queries
-- e1. Get all extras
SELECT * FROM extras;

-- e2. Extras where supplies exist (join supplies)
SELECT e.* 
FROM extras e
JOIN supplies s ON e.visit_id = s.visit_id;

-- e3. Patient & provider names where supplies were NOT used
SELECT e.extra_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name
FROM extras e
JOIN visits v ON e.visit_id = v.visit_id
JOIN patients p ON v.patient_id = p.patient_id
JOIN providers pr ON v.provider_id = pr.provider_id
WHERE v.visit_id NOT IN (SELECT visit_id FROM supplies);

-- e4. Extras by a specific provider
SELECT e.extra_id,
       CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name
FROM extras e
JOIN visits v ON e.visit_id = v.visit_id
JOIN providers pr ON v.provider_id = pr.provider_id
WHERE pr.provider_id = 2;