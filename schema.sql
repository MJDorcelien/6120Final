CREATE DATABASE 6120_project2;
USE 6120_project2;

-- Insurance Table
CREATE TABLE insurance(
  insurance_id INT PRIMARY KEY AUTO_INCREMENT,
  insurance_name VARCHAR(45) NOT NULL
);

-- Patients Table
CREATE TABLE patients(
  patient_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone_number BIGINT NOT NULL,
  email VARCHAR(100),
  insurance_id INT,
  dob YEAR NOT NULL CHECK (dob BETWEEN 1900 AND 2025),
  FOREIGN KEY (insurance_id) REFERENCES insurance(insurance_id)
);

-- Providers Table
CREATE TABLE providers(
  provider_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  specialty VARCHAR(45) NOT NULL
);

-- Visits Table
CREATE TABLE visits(
  visit_id INT PRIMARY KEY AUTO_INCREMENT,
  patient_id INT NOT NULL,
  provider_id INT NOT NULL,
  visit_date DATE NOT NULL,
  facility VARCHAR(100) NOT NULL,
  reason VARCHAR(500) NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
  FOREIGN KEY (provider_id) REFERENCES providers(provider_id) ON DELETE CASCADE
);

-- Clinical Notes Table (Symptoms and Diagnosis Only)
CREATE TABLE clinical_notes(
  note_id INT PRIMARY KEY AUTO_INCREMENT,
  visit_id INT NOT NULL UNIQUE,
  signs_symptoms VARCHAR(255) NOT NULL,
  diagnosis VARCHAR(255) NOT NULL,
  FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);

-- Prescriptions Table (Separated from Clinical Notes)
CREATE TABLE prescriptions(
  prescription_id INT PRIMARY KEY AUTO_INCREMENT,
  visit_id INT NOT NULL,
  prescription_name VARCHAR(100) NOT NULL,
  FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);

-- Tests Table (Separated from Clinical Notes)
CREATE TABLE tests(
  test_id INT PRIMARY KEY AUTO_INCREMENT,
  visit_id INT NOT NULL,
  test_name VARCHAR(100) NOT NULL,
  FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);

-- Supplies Table (Separated from Extras)
CREATE TABLE supplies(
  supply_id INT PRIMARY KEY AUTO_INCREMENT,
  visit_id INT NOT NULL,
  supply_name VARCHAR(100) NOT NULL,
  FOREIGN KEY (visit_id) REFERENCES visits(visit_id) ON DELETE CASCADE
);