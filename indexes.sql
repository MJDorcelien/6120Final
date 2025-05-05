-- INDEXES ----------------------------------------------------------

CREATE INDEX idx_patients ON patients(last_name, first_name);
CREATE INDEX idx_patients_last ON patients(last_name);
CREATE INDEX idx_patients_first ON patients(first_name);
-- p1. Get all patients
SHOW INDEX FROM patients;
-- p2. Get patient details by last name
SHOW INDEX FROM patients WHERE Column_name = 'Smith';
-- p3. get all patients whose first name  starts with a specific letter
SHOW INDEX FROM patients WHERE Column_name like 'A%';
-- p4. get all patients whose last name starts with a specific letter
SHOW INDEX FROM patients where Column_name like 'D%';

CREATE INDEX idx_providers ON providers(last_name, first_name);
CREATE INDEX idx_providers_last ON providers(last_name);
CREATE INDEX idx_providers_first ON providers(first_name);
CREATE INDEX idx_providers_specality ON providers(specialty);
-- r1. Get all providers
SHOW INDEX FROM providers;
-- r2. Get provider details by specialty
SHOW INDEX FROM providers where Column_name = 'Cardiology';
-- r3. get providers whose specialty starts ends with a speicific letter
SHOW INDEX FROM providers where Column_name like '% nurse';

CREATE INDEX idx_visits ON visits(visit_id);
CREATE INDEX idx_visits_patients ON visits(patinet_id);
CREATE INDEX idx_visits_providers ON visits(provider_id);
CREATE INDEX idx_visits_date ON visits(vist_date);
-- v1. Get all visits
SHOW INDEX FROM visits;
-- v2. get all the visits of a specific patient
SHOW INDEX FROM visits WHERE Column_name = 1;
-- v4.get all visits of a specific provider
SHOW INDEX FROM visits WHERE Column_name = 3;
-- v5. Get the most recent visit for each patient
SELECT * FROM visits ORDER BY visit_date DESC LIMIT 1;

-- c1. Get all clinical notes
CREATE INDEX idx_notes ON clinical_notes(note_id);
SHOW INDEX FROM clinical_notes;