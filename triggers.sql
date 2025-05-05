-- ============================================
-- TRIGGERS
-- ============================================
CREATE TABLE event_log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  event_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  user VARCHAR(100),
  table_name VARCHAR(100),
  operation_type VARCHAR(20),
  old_value TEXT,
  new_value TEXT
);

-- Triggers for the patients table

DELIMITER //

-- Log new patient inserts
CREATE TRIGGER patient_insert_trigger
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'patients', 'INSERT',
    NULL,
    CONCAT('ID: ', NEW.patient_id, ', Name: ', NEW.first_name, ' ', NEW.last_name)
  );
END;
//

-- Log patient updates
CREATE TRIGGER patient_update_trigger
AFTER UPDATE ON patients
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'patients', 'UPDATE',
    CONCAT('ID: ', OLD.patient_id, ', Name: ', OLD.first_name, ' ', OLD.last_name),
    CONCAT('ID: ', NEW.patient_id, ', Name: ', NEW.first_name, ' ', NEW.last_name)
  );
END;
//

-- Log patient deletions
CREATE TRIGGER patient_delete_trigger
AFTER DELETE ON patients
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'patients', 'DELETE',
    CONCAT('ID: ', OLD.patient_id, ', Name: ', OLD.first_name, ' ', OLD.last_name),
    NULL
  );
END;
//

-- Triggers for the visits table

-- Log new visit inserts
CREATE TRIGGER visit_insert_trigger
AFTER INSERT ON visits
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'visits', 'INSERT',
    NULL,
    CONCAT('Visit ID: ', NEW.visit_id, ', Patient ID: ', NEW.patient_id, ', Date: ', NEW.visit_date)
  );
END;
//

-- Log visit updates
CREATE TRIGGER visit_update_trigger
AFTER UPDATE ON visits
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'visits', 'UPDATE',
    CONCAT('Visit ID: ', OLD.visit_id, ', Patient ID: ', OLD.patient_id, ', Date: ', OLD.visit_date),
    CONCAT('Visit ID: ', NEW.visit_id, ', Patient ID: ', NEW.patient_id, ', Date: ', NEW.visit_date)
  );
END;
//

-- Log visit deletions
CREATE TRIGGER visit_delete_trigger
AFTER DELETE ON visits
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'visits', 'DELETE',
    CONCAT('Visit ID: ', OLD.visit_id, ', Patient ID: ', OLD.patient_id, ', Date: ', OLD.visit_date),
    NULL
  );
END;
//

-- Trigger for the tests table

-- Log new test inserts
CREATE TRIGGER test_insert_trigger
AFTER INSERT ON tests
FOR EACH ROW
BEGIN
  INSERT INTO event_log (user, table_name, operation_type, old_value, new_value)
  VALUES (
    USER(), 'tests', 'INSERT',
    NULL,
    CONCAT('Test: ', NEW.test_name, ', Visit ID: ', NEW.visit_id)
  );
END;
//

DELIMITER ;
