-- TRIGGERS ----------------------------------------------------------

-- Trigger 1: Log when a new patient is added
DELIMITER |
CREATE TRIGGER after_patient_insert
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
  INSERT INTO event_log (event_type, message)
  VALUES ('New Patient', CONCAT('Patient ', NEW.first_name, ' ', NEW.last_name, ' was added.'));
END; |
DELIMITER ;

-- Trigger 2: Log when a new visit is recorded
DELIMITER |
CREATE TRIGGER after_visit_insert
AFTER INSERT ON visits
FOR EACH ROW
BEGIN
  INSERT INTO event_log (event_type, message)
  VALUES ('New Visit', CONCAT('Visit recorded for patient ID ', NEW.patient_id, ' on ', NEW.visit_date));
END; |
DELIMITER ;

-- Trigger 3: Log when a test is added for a visit
DELIMITER |
CREATE TRIGGER after_test_insert
AFTER INSERT ON tests
FOR EACH ROW
BEGIN
  INSERT INTO event_log (event_type, message)
  VALUES ('New Test', CONCAT('Test "', NEW.test_name, '" added for visit ID ', NEW.visit_id));
END; |
DELIMITER ;