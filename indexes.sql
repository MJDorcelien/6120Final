-- INDEXES ----------------------------------------------------------

-- Patient's Last and First Name
CREATE INDEX idx_patients_last_first_name ON patients(last_name, first_name);
CREATE INDEX idx_patients_last_name ON patients(last_name);
CREATE INDEX idx_patients_first_name ON patients(first_name);

-- Provider's Last and First Name
CREATE INDEX idx_providers_last_first_name ON providers(last_name, first_name);
CREATE INDEX idx_providers_last_name ON providers(last_name);
CREATE INDEX idx_providers_first_name ON providers(first_name);
CREATE INDEX idx_providers_specialty ON providers(specialty);

-- Visit's Primary Columns
CREATE INDEX idx_visits ON visits(visit_id);
CREATE INDEX idx_visits_patient_id ON visits(patient_id);
CREATE INDEX idx_visits_provider_id ON visits(provider_id);
CREATE INDEX idx_visits_visit_date ON visits(visit_date);

-- Clinical Notes
CREATE INDEX idx_clinical_notes_note_id ON clinical_notes(note_id);

-- ----------------------------------------------------------
-- QUERY EXAMPLES:

-- p1. Get all patients (Index will speed up queries involving last_name, first_name)
SHOW INDEX FROM patients;

-- p2. Get patient details by last name (Effective when querying by last name)
SHOW INDEX FROM patients WHERE Column_name = 'last_name';

-- p3. Get all patients whose first name starts with a specific letter (first_name index will help)
SHOW INDEX FROM patients WHERE Column_name LIKE 'A%';

-- p4. Get all patients whose last name starts with a specific letter
SHOW INDEX FROM patients WHERE Column_name LIKE 'D%';

-- r1. Get all providers (Primary index for performance on queries for last_name, first_name)
SHOW INDEX FROM providers;

-- r2. Get provider details by specialty
SHOW INDEX FROM providers WHERE Column_name = 'specialty';

-- r3. Get providers whose specialty ends with a specific letter
SHOW INDEX FROM providers WHERE Column_name LIKE '%nurse';

-- v1. Get all visits (Index on visit_id will help)
SHOW INDEX FROM visits;

-- v2. Get all visits of a specific patient (patient_id index helps)
SHOW INDEX FROM visits WHERE patient_id = 1;

-- v3. Get all visits of a specific provider (provider_id index helps)
SHOW INDEX FROM visits WHERE provider_id = 3;

-- v4. Get the most recent visit for each patient (Index on visit_date for sorting)
SELECT * FROM visits ORDER BY visit_date DESC LIMIT 1;

-- c1. Get all clinical notes (Index on note_id for performance)
SHOW INDEX FROM clinical_notes;
