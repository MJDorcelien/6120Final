-- VIEWS ------------------------------------------------------

CREATE VIEW view_visit_details
SELECT 
    v.visit_id,
    v.patient_id,
    concat(p.last_name, ', ', p.first_name) AS patient_name,
    v.provider_id,
    concat(r.last_name, ', ', r.first_name) AS provider_name,
    v.visit_date,
    v.facility,
    v.reason
FROM visits as v, patients as p, providers as r
JOIN 
    v.patient_id = p.patient_id
JOIN
    v.visit_id = r.provider_id;

CREATE VIEW view_providers_patient_details AS
SELECT
    concat(r.first_name, ' ', r.last_name) as provider_name,
    v.visit_id,
    concat(p.first_name, ' ', p.last_name) as patient_name,
FROM 
    vists as v, providers as r, patients as p;

-- see a list of the providers and the patients they've seen
CREATE VIEW view_providers_details AS
SELECT 
    concat(providers.first_name, ' ', providers.last_name) as provider_name, 
    concat(patients.first_name, ' ', patients.last_name) as patient_name
From providers
order by last_name
join visits.patient_id = visits.provider_id;

-- patient info
CREATE VIEW view_patient_info AS
SELECT 
    patient_id, 
    concat(first_name, ' ', last_name) as patient_name, 
    address, 
    phone_number,
    email,
    insurance_id,
    dob
FROM patients 
ORDER BY patient_id;

-- list of tests and how old the patients were
CREATE VIEW view_patients_providers AS
SELECT concat(patients.first_name, ' ', patients.last_name) as patient_name, concat(providers.first_name, ' ', providers.last_name) as provider_name
From providers, patients
order by patients.last_name
join visits.patient_id = visits.provider_id;