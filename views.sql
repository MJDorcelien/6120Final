-- Views: ---------------------------------------
CREATE VIEW view_visit_details AS
SELECT 
    v.visit_id,
    v.patient_id,
    CONCAT(p.last_name, ', ', p.first_name) AS patient_name,
    v.provider_id,
    CONCAT(r.last_name, ', ', r.first_name) AS provider_name,
    v.visit_date,
    v.facility,
    v.reason
FROM visits v
JOIN patients p ON v.patient_id = p.patient_id
JOIN providers r ON v.provider_id = r.provider_id;

-- View: Provider and their patients with visit IDs
CREATE VIEW view_providers_patient_details AS
SELECT
    CONCAT(r.first_name, ' ', r.last_name) AS provider_name,
    v.visit_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name
FROM visits v
JOIN providers r ON v.provider_id = r.provider_id
JOIN patients p ON v.patient_id = p.patient_id;

-- View: List of providers and the patients they’ve seen
CREATE VIEW view_providers_details AS
SELECT 
    CONCAT(r.first_name, ' ', r.last_name) AS provider_name, 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name
FROM visits v
JOIN providers r ON v.provider_id = r.provider_id
JOIN patients p ON v.patient_id = p.patient_id
ORDER BY r.last_name;

-- View: Patient demographic and insurance info
CREATE VIEW view_patient_info AS
SELECT 
    patient_id, 
    CONCAT(first_name, ' ', last_name) AS patient_name, 
    address, 
    phone_number,
    email,
    insurance_id,
    dob
FROM patients
ORDER BY patient_id;

-- View: Patients and their providers
CREATE VIEW view_patients_providers AS
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name, 
    CONCAT(r.first_name, ' ', r.last_name) AS provider_name
FROM visits v
JOIN patients p ON v.patient_id = p.patient_id
JOIN providers r ON v.provider_id = r.provider_id
ORDER BY p.last_name;
