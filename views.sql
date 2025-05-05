-- VIEWS ------------------------------------------------------
-- see a list of the providers and the patients they've seen
CREATE VIEW view_providers_patients AS
SELECT concat(providers.first_name, ' ', providers.last_name) as provider_name, concat(patients.first_name, ' ', patients.last_name) as patient_name
From providers, patients
order by providers.last_name
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