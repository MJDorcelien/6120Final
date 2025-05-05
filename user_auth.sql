CREATE USER 'patient'@'localhost' IDENTIFIED BY 'patientpass';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employeepass';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpass';

--select for patients
GRANT SELECT ON 6120_project_2.clinical_notes TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.insurance TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.prescriptions TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.providers TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.tests TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.visits TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.view_patients_providers TO 'patient'@'localhost';
--insert for patients
GRANT INSERT ON 6120_project_2.providers TO 'patient'@'localhost';
GRANT INSERT ON 6120_project_2.visits TO 'patient'@'localhost';
--update for patients
GRANT UPDATE ON 6120_project_2.insurance TO 'patient'@'localhost';
GRANT UPDATE ON 6120_project_2.visits TO 'patient'@'localhost';
--delete for patients
GRANT DELETE ON 6120_project_2.visits TO 'patient'@'localhost';

--select for employees
GRANT SELECT ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.tests TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.visits TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.view_patients_providers TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.view_providers_patients TO 'employee'@'localhost';
--insert for employees
GRANT INSERT ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.tests TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.visits TO 'employee'@'localhost';
--update for employees
GRANT UPDATE ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.tests TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.visits TO 'employee'@'localhost';
--delete for employees
GRANT DELETE ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.tests TO 'employee'@'localhost';

GRANT ALL ON 6120_project2.* TO 'admin'@'localhost';