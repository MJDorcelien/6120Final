-- Create SQL users for MySQL-level access (used with GRANT privileges)
CREATE USER 'patient'@'localhost' IDENTIFIED BY 'patientpass';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employeepass';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpass';

-- Grant permissions to patient user
-- Patients can read data from various views and tables
GRANT SELECT ON 6120_project_2.clinical_notes TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.insurance TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.prescriptions TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.providers TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.tests TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.visits TO 'patient'@'localhost';
GRANT SELECT ON 6120_project_2.view_patients_providers TO 'patient'@'localhost';

-- Patients can insert and update their visit and insurance info
GRANT INSERT ON 6120_project_2.providers TO 'patient'@'localhost';
GRANT INSERT ON 6120_project_2.visits TO 'patient'@'localhost';
GRANT UPDATE ON 6120_project_2.insurance TO 'patient'@'localhost';
GRANT UPDATE ON 6120_project_2.visits TO 'patient'@'localhost';
GRANT DELETE ON 6120_project_2.visits TO 'patient'@'localhost';

-- Grant permissions to employee user
GRANT SELECT ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.tests TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.visits TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.view_patients_providers TO 'employee'@'localhost';
GRANT SELECT ON 6120_project_2.view_providers_patients TO 'employee'@'localhost';

-- Employees can insert data into all relevant tables
GRANT INSERT ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.tests TO 'employee'@'localhost';
GRANT INSERT ON 6120_project_2.visits TO 'employee'@'localhost';

-- Employees can update all relevant data
GRANT UPDATE ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.tests TO 'employee'@'localhost';
GRANT UPDATE ON 6120_project_2.visits TO 'employee'@'localhost';

-- Employees can delete data they manage
GRANT DELETE ON 6120_project_2.clinical_notes TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.insurance TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.patients TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.prescriptions TO 'employee'@'localhost';
GRANT DELETE ON 6120_project_2.tests TO 'employee'@'localhost';

-- Grant full access to the admin
GRANT ALL ON 6120_project_2.* TO 'admin'@'localhost';

-- ---------------------------------------------------------------------
-- Application-Level User Role Management (Optional, inside DB)
-- ---------------------------------------------------------------------

-- Create Roles Table to define user roles
CREATE TABLE Roles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(255) UNIQUE NOT NULL
);

-- Insert common roles
INSERT INTO Roles (RoleName) VALUES ('Provider'), ('Receptionist');

-- Users Table (for application login system)
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Example users
INSERT INTO Users (Username, Password, RoleID)
VALUES 
('MJ', '12345A', (SELECT RoleID FROM Roles WHERE RoleName = 'Provider')),
('Sydney', '12345B', (SELECT RoleID FROM Roles WHERE RoleName = 'Receptionist'));

-- Stored Procedure to check general role
DELIMITER $$
CREATE PROCEDURE CheckUserRole(
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255),
    OUT roleName VARCHAR(255)
)
BEGIN
    SELECT r.RoleName INTO roleName
    FROM Users u
    JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.Username = p_username AND u.Password = p_password;
END$$
DELIMITER ;

-- Check if user is a Provider
DELIMITER $$
CREATE PROCEDURE CheckProviderLogin(
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT r.RoleName
    FROM Users u
    JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.Username = p_username AND u.Password = p_password AND r.RoleName = 'Provider';
END$$
DELIMITER ;

-- Check if user is a Receptionist
DELIMITER $$
CREATE PROCEDURE CheckReceptionistLogin(
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT r.RoleName
    FROM Users u
    JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.Username = p_username AND u.Password = p_password AND r.RoleName = 'Receptionist';
END$$
DELIMITER ;
