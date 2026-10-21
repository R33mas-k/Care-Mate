-- CAREMATE DATABASE IMPLEMENTATION

-- DROP
DROP DATABASE IF EXISTS CareMate2;
CREATE DATABASE CareMate2;
USE CareMate2;

-- Caregiver
CREATE TABLE Caregiver (
    caregiver_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    email VARCHAR(100),
    password VARCHAR(255),
    address VARCHAR(255),
    UNIQUE KEY unique_full_name (first_name, last_name)
);

INSERT INTO Caregiver (first_name, last_name, contact_number, email, password, address) 
VALUES 
('Sara', 'Caregiver', '0500000001', 'caregiver1@example.com', 'password1', 'Riyadh, Saudi Arabia'),
('Mona', 'Caregiver', '0500000002', 'caregiver2@example.com', 'password2', 'Jeddah, Saudi Arabia'),
('Huda', 'Caregiver', '0500000003', 'caregiver3@example.com', 'password3', 'Dammam, Saudi Arabia'),
('Lina', 'Caregiver', '0500000004', 'caregiver4@example.com', 'password4', 'Mecca, Saudi Arabia');

SELECT * FROM Caregiver;

-- Doctor
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Specialization VARCHAR(100),
    HireDate DATE
);

INSERT INTO Doctor (Doctor_ID, Name, Email, PhoneNumber, Specialization, HireDate)
VALUES 
(101, 'Dr. One', 'doctor1@example.com', '0500000011', 'Cardiology', '2015-03-01'),
(102, 'Dr. Two', 'doctor2@example.com', '0500000012', 'Neurology', '2018-09-15'),
(103, 'Dr. Three', 'doctor3@example.com', '0500000013', 'Pediatrics', '2020-06-10'),
(104, 'Dr. Four', 'doctor4@example.com', '0500000014', 'Orthopedics', '2017-11-22');

SELECT * FROM Doctor;

-- Clinic
CREATE TABLE Clinic (
    clinic_id INT AUTO_INCREMENT PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL UNIQUE,
    clinic_address VARCHAR(255),
    phone_number VARCHAR(15)
);

INSERT INTO Clinic (clinic_name, clinic_address, phone_number)
VALUES 
('City Health Clinic', 'King Fahd Rd, Riyadh', '05553333'),
('Pediatrics Clinic', 'Al-Muruj, Jeddah', '05554444'),
('Al Amal Medical Center', 'Olaya St, Riyadh', '05555555'),
('Nour Specialty Clinic', 'Al Rawdah, Dammam', '05556666');

SELECT * FROM Clinic;

-- Patient
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Birth_date DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Blood_Type VARCHAR(5),
    Address VARCHAR(255),
    caregiver_id INT,
    FOREIGN KEY (caregiver_id) REFERENCES Caregiver(caregiver_id) ON DELETE SET NULL
);

INSERT INTO Patient (Patient_ID, Full_Name, Birth_date, Gender, Blood_Type, Address, caregiver_id)
VALUES 
(1, 'Aryam', '2004-04-02', 'Female', 'A+', 'Tabuk, Saudi Arabia', 1),
(2, 'Remas', '2004-04-01', 'Female', 'A+', 'Jubail, Saudi Arabia', 2),
(3, 'Nora', '2004-04-02', 'Female', 'B+', 'Dammam, Saudi Arabia', 3),
(4, 'Ibtesam', '2004-04-01', 'Female', 'O+', 'Riyadh, Saudi Arabia', 4),
(5, 'Saud', '1990-04-01', 'Male', 'O+', 'Khobar, Saudi Arabia', 4);

SELECT * FROM Patient;

-- Patient_Doctor
CREATE TABLE Patient_Doctor (
    patient_id INT,
    doctor_id INT,
    start_date DATE,
    end_date DATE,
    notes TEXT,
    PRIMARY KEY (patient_id, doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(Doctor_ID)
);

INSERT INTO Patient_Doctor (patient_id, doctor_id, start_date, end_date, notes)
VALUES 
(1, 101, '2024-01-01', NULL, 'Routine check-ups'),
(2, 102, '2024-04-01', NULL, 'Migraine treatment'),
(3, 103, '2024-05-10', NULL, 'Child vaccination'),
(4, 104, '2024-06-15', NULL, 'Fracture follow-up');

SELECT * FROM Patient_Doctor;

-- Medication
CREATE TABLE Medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    medication_time TIME NOT NULL,
    start_date DATE NOT NULL, 
    end_date DATE NOT NULL,  
    type ENUM('Tablet', 'Capsule', 'Syrup', 'Injection') NOT NULL,  
    instructions TEXT,  
    last_taken DATETIME,  
    next_dose DATETIME,  
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    UNIQUE (patient_id, medication_name, start_date)
);

INSERT INTO Medication (patient_id, medication_name, dosage, medication_time, start_date, end_date, type, instructions, last_taken, next_dose) 
VALUES 
(2, 'Paracetamol', '500mg', '08:00:00', '2024-03-01', '2024-03-10', 'Tablet', 'Take after food', '2024-03-02 08:00:00', '2024-03-02 20:00:00'),
(3, 'Amoxicillin', '250mg', '09:00:00', '2024-03-05', '2024-03-12', 'Capsule', 'Take with water', '2024-03-06 09:00:00', '2024-03-06 21:00:00');

SELECT * FROM Medication;

-- Appointment
CREATE TABLE Appointment (
    
    patient_id INT NOT NULL,
    doctor_id INT,
    caregiver_id INT,
    clinic_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason TEXT,
    appointment_id INT AUTO_INCREMENT PRIMARY KEY, -- Weak Entity
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE SET NULL,
    FOREIGN KEY (caregiver_id) REFERENCES Caregiver(caregiver_id) ON DELETE SET NULL,
    FOREIGN KEY (clinic_id) REFERENCES Clinic(clinic_id) ON DELETE SET NULL,
    UNIQUE (patient_id, appointment_date, appointment_time) 
);

INSERT INTO Appointment (patient_id, doctor_id, caregiver_id, clinic_id, appointment_date, appointment_time, reason)
VALUES 
(1, 101, 1, 1, '2024-04-15', '09:30:00', 'Routine Checkup'),
(2, 102, 2, 2, '2024-04-20', '11:00:00', 'Follow-up Visit'),
(3, 103, 3, 3, '2024-04-25', '10:00:00', 'Child Vaccination'),
(4, 104, 4, 4, '2024-04-30', '14:00:00', 'Fracture Follow-up');

SELECT * FROM Appointment;

-- Insert example
INSERT INTO Patient (Patient_ID, Full_Name, Birth_date, Gender, Blood_Type, Address, caregiver_id)
VALUES (6, 'Abrar', '2005-06-10', 'Female', 'AB+', 'Hofuf, Saudi Arabia', 2);


SELECT * FROM Patient;

-- Update example
UPDATE Doctor SET Email = 'newemail@example.com' WHERE Doctor_ID = 102;
SELECT * FROM Doctor;

-- Delete example
DELETE FROM Appointment WHERE appointment_id = 2;
SELECT * FROM Appointment;

-- View example
CREATE VIEW PatientProfile AS
SELECT p.Patient_ID, p.Full_Name, c.first_name AS CaregiverFirstName, d.Name AS DoctorName
FROM Patient p
LEFT JOIN Caregiver c ON p.caregiver_id = c.caregiver_id
LEFT JOIN Patient_Doctor pd ON p.Patient_ID = pd.patient_id
LEFT JOIN Doctor d ON pd.doctor_id = d.Doctor_ID;

SELECT * FROM PatientProfile;

-- Stored Procedure: Add Appointment Safely
DELIMITER $$
CREATE PROCEDURE AddAppointment (
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_caregiver_id INT,
    IN p_clinic_id INT,
    IN p_date DATE,
    IN p_time TIME,
    IN p_reason TEXT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM Appointment 
        WHERE patient_id = p_patient_id 
        AND appointment_date = p_date 
        AND appointment_time = p_time
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment already exists for this patient at this time';
    ELSE
        INSERT INTO Appointment (
            patient_id, doctor_id, caregiver_id, clinic_id, appointment_date, appointment_time, reason
        ) VALUES (
            p_patient_id, p_doctor_id, p_caregiver_id, p_clinic_id, p_date, p_time, p_reason
        );
    END IF;
END $$
DELIMITER ;

-- DROP PROCEDURE IF EXISTS AddAppointment;

-- Trigger: Log Medication Insertions
CREATE TABLE Medication_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    medication_id INT,
    action_time DATETIME,
    action_type VARCHAR(20)
);

DELIMITER $$
CREATE TRIGGER After_Medication_Insert
AFTER INSERT ON Medication
FOR EACH ROW
BEGIN
    INSERT INTO Medication_Log (medication_id, action_time, action_type)
    VALUES (NEW.medication_id, NOW(), 'INSERT');
END $$
DELIMITER ;

-- Users and Privileges
-- CREATE USER 'admin_user'@'localhost' IDENTIFIED BY '<choose_a_password>';
-- CREATE USER 'normal_user'@'localhost' IDENTIFIED BY '<choose_a_password>';

-- GRANT ALL PRIVILEGES ON CareMate2.* TO 'admin_user'@'localhost';
-- GRANT SELECT, INSERT ON CareMate2.Patient TO 'normal_user'@'localhost';

-- DROP USERS
-- DROP USER IF EXISTS 'admin_user'@'localhost';
-- DROP USER IF EXISTS 'normal_user'@'localhost';

-- Composite attribute
SELECT first_name, last_name
FROM Caregiver;

-- Multi-value column (Allergies)
CREATE TABLE Patient_Allergies (
    patient_id INT,
    allergy VARCHAR(50),
    FOREIGN KEY (patient_id) 
    REFERENCES Patient(Patient_ID) ON DELETE CASCADE);

INSERT INTO Patient_Allergies VALUES
(1, 'Peanuts'),
(1, 'Dust'),
(2, 'Pollen');
select*from Patient_Allergies;

-- Computed column (Age)
SELECT Full_Name, '19' AS Age
FROM Patient WHERE Full_Name='Abrar';


-- ADVANCED SQL QUERIES SECTION

-- 1. UNION: 
SELECT Full_Name AS Name FROM Patient
UNION SELECT Name FROM Doctor;

-- 2. INTERSECT 
SELECT Full_Name FROM Patient
WHERE Full_Name IN (SELECT TRIM(SUBSTRING_INDEX(Name, ' ', -1)) FROM Doctor);

-- 3. LIKE: 
SELECT* FROM Patient
WHERE Full_Name LIKE'A%';

-- 4. IN: 
SELECT*FROM Patient
WHERE Blood_Type IN ('A+','B+');

-- 5. BETWEEN: 
SELECT* FROM Doctor
WHERE HireDate BETWEEN'2017-01-01' AND'2020-12-31';

-- 6. IS NULL: 
SELECT* FROM Appointment WHERE doctor_id IS NULL;

-- 7. DISTINCT: 
SELECT DISTINCT Specialization FROM Doctor;

-- 8. GROUP BY+ HAVING:
SELECT caregiver_id, COUNT(*) AS total_patients
FROM Patient
GROUP BY caregiver_id
HAVING COUNT(*) > 1;

-- 9. ORDER BY: 
SELECT * from Patient
ORDER BY Birth_date ASC;

-- 10. Aggregate: 
SELECT COUNT(*) AS total_doctors FROM Doctor;

-- 11. CASE:
SELECT Full_Name,
CASE
    WHEN Blood_Type = 'A+' THEN 'Group A'
    WHEN Blood_Type = 'O+' THEN 'Group O'
    else 'Other Group'
END AS BloodGroupType
from Patient;

-- 12. Subquery: 
SELECT Full_Name FROM Patient
WHERE Patient_ID IN(
    SELECT patient_id FROM Patient_Doctor
    WHERE doctor_id IN (SELECT Doctor_ID FROM Doctor WHERE Specialization = 'Pediatrics'));

-- 13. ALL:
SELECT*FROM Patient
where Birth_date < ALL(SELECT Birth_date 
from Patient 
WHERE Birth_date >'2005-01-01');

-- 14. Like + And: 
SELECT * 
FROM Patient
WHERE Full_Name LIKE 'A%' AND Blood_Type = 'A+';


-- 15. INTO:
CREATE TABLE TempFemalePatients AS
SELECT *FROM Patient WHERE Gender = 'Female';
SELECT*FROM TempFemalePatients;
