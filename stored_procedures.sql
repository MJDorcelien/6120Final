
-- Patient Queries
DELIMITER $$

-- p5. Patients born after 2008 and with insurance
CREATE PROCEDURE GetYoungInsuredPatients()
BEGIN
    SELECT * FROM patients 
    WHERE dob > '2008-01-01' AND insurance_id IS NOT NULL;
END$$

-- p6. Count the number of patients
CREATE PROCEDURE CountAllPatients()
BEGIN
    SELECT COUNT(*) AS total_patients FROM patients;
END$$

-- p7. Update patient first name
CREATE PROCEDURE UpdatePatientFirstName(
    IN pPatientID INT,
    IN pNewFirstName VARCHAR(100)
)
BEGIN
    UPDATE patients 
    SET first_name = pNewFirstName 
    WHERE patient_id = pPatientID;
END$$

-- p8. Patients with at least one visit
CREATE PROCEDURE GetPatientsWithVisits()
BEGIN
    SELECT DISTINCT p.* 
    FROM patients p
    JOIN visits v ON p.patient_id = v.patient_id;
END$$

-- p9. Patients who haven't had a visit yet
CREATE PROCEDURE GetPatientsWithoutVisits()
BEGIN
    SELECT * FROM patients 
    WHERE patient_id NOT IN (SELECT patient_id FROM visits);
END$$

-- Provider-Related Procedures
-- r4. Providers who have seen more than 10 patients
CREATE PROCEDURE GetHighVolumeProviders()
BEGIN
    SELECT provider_id, COUNT(DISTINCT patient_id) AS patient_count
    FROM visits
    GROUP BY provider_id
    HAVING patient_count > 10;
END$$

-- r6. Most common specialty
CREATE PROCEDURE GetMostCommonSpecialty()
BEGIN
    SELECT specialty, COUNT(*) AS count
    FROM providers
    GROUP BY specialty
    ORDER BY count DESC
    LIMIT 1;
END$$

-- Visit-Related Procedures
-- v1. Get all visits
CREATE PROCEDURE GetAllVisits()
BEGIN
    SELECT * FROM visits;
END$$

-- v2. All visits of a specific patient
CREATE PROCEDURE GetVisitsByPatient(IN pPatientID INT)
BEGIN
    SELECT * FROM visits WHERE patient_id = pPatientID;
END$$

-- v3. Visits in last 30 days
CREATE PROCEDURE GetRecentVisits()
BEGIN
    SELECT * FROM visits 
    WHERE visit_date >= CURDATE() - INTERVAL 30 DAY;
END$$

-- v4. All visits of a specific provider
CREATE PROCEDURE GetVisitsByProvider(IN pProviderID INT)
BEGIN
    SELECT * FROM visits WHERE provider_id = pProviderID;
END$$

-- v5. Most recent visit for each patient
CREATE PROCEDURE GetMostRecentVisitPerPatient()
BEGIN
    SELECT * FROM visits v
    WHERE visit_date = (
        SELECT MAX(visit_date) 
        FROM visits v2 
        WHERE v2.patient_id = v.patient_id
    );
END$$

-- v6. Patient name, provider name, and facility
CREATE PROCEDURE GetVisitDetails()
BEGIN
    SELECT v.visit_id, v.visit_date, 
           CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
           CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,
           v.facility
    FROM visits v
    JOIN patients p ON v.patient_id = p.patient_id
    JOIN providers pr ON v.provider_id = pr.provider_id;
END$$

-- v7. Visits in descending order by date
CREATE PROCEDURE GetVisitsDesc()
BEGIN
    SELECT * FROM visits ORDER BY visit_date DESC;
END$$

-- v8. Number of visits per patient
CREATE PROCEDURE CountVisitsPerPatient()
BEGIN
    SELECT patient_id, COUNT(*) AS visit_count
    FROM visits
    GROUP BY patient_id;
END$$

-- Clinical Notes Procedures
-- c1. Get all clinical notes
CREATE PROCEDURE GetAllClinicalNotes()
BEGIN
    SELECT * FROM clinical_notes;
END$$

-- c2. Clinical notes with a prescription
CREATE PROCEDURE GetNotesWithPrescriptions()
BEGIN
    SELECT cn.*
    FROM clinical_notes cn
    JOIN prescriptions p ON cn.visit_id = p.visit_id;
END$$

-- c3. Notes by provider
CREATE PROCEDURE GetNotesByProvider()
BEGIN
    SELECT cn.note_id,
           CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,
           cn.signs_symptoms, cn.diagnosis
    FROM clinical_notes cn
    JOIN visits v ON cn.visit_id = v.visit_id
    JOIN providers pr ON v.provider_id = pr.provider_id;
END$$

-- Extras & Supplies Procedures
-- e1. Get all extras
CREATE PROCEDURE GetAllExtras()
BEGIN
    SELECT * FROM extras;
END$$

-- e2. Extras where supplies exist
CREATE PROCEDURE GetExtrasWithSupplies()
BEGIN
    SELECT e.* 
    FROM extras e
    JOIN supplies s ON e.visit_id = s.visit_id;
END$$

-- e3. Names where supplies not used
CREATE PROCEDURE GetExtrasWithoutSupplies()
BEGIN
    SELECT e.extra_id,
           CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
           CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name
    FROM extras e
    JOIN visits v ON e.visit_id = v.visit_id
    JOIN patients p ON v.patient_id = p.patient_id
    JOIN providers pr ON v.provider_id = pr.provider_id
    WHERE v.visit_id NOT IN (SELECT visit_id FROM supplies);
END$$

-- e4. Extras by specific provider
CREATE PROCEDURE GetExtrasByProvider(IN pProviderID INT)
BEGIN
    SELECT e.extra_id,
           CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name
    FROM extras e
    JOIN visits v ON e.visit_id = v.visit_id
    JOIN providers pr ON v.provider_id = pr.provider_id
    WHERE pr.provider_id = pProviderID;
END$$

DELIMITER ;
