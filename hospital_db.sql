

-- =====================================================
-- 1. DEPARTMENTS
-- =====================================================
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    location VARCHAR(50)
);

-- =====================================================
-- 2. WARDS
-- =====================================================
CREATE TABLE Wards (
    ward_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    type VARCHAR(20) CHECK (type IN ('ICU','General','Private'))
);

-- =====================================================
-- 3. PATIENTS
-- =====================================================
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    phone VARCHAR(15) UNIQUE,
    blood_type VARCHAR(5),
    allergies VARCHAR(255)
);

-- =====================================================
-- 4. DOCTORS
-- =====================================================
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- =====================================================
-- 5. ADMISSIONS
-- =====================================================
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    ward_id INT NOT NULL,
    doctor_id INT,
    admission_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    discharge_date DATETIME,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (ward_id) REFERENCES Wards(ward_id) ON DELETE RESTRICT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL
);

-- =====================================================
-- 6. APPOINTMENTS
-- =====================================================
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled'
        CHECK (status IN ('Scheduled','Completed','Cancelled','No-Show')),
    notes VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- =====================================================
-- 7. TREATMENTS
-- =====================================================
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT NOT NULL,
    doctor_id INT NOT NULL,
    treatment_name VARCHAR(100) NOT NULL,
    treatment_date DATE NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    notes VARCHAR(255),
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE RESTRICT
);

-- =====================================================
-- 8. BILLING
-- =====================================================
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    admission_id INT,
    bill_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Pending'
        CHECK (status IN ('Pending','Partial','Paid','Overdue')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id) ON DELETE SET NULL
);

-- =====================================================
-- DEPARTMENTS DATA
-- =====================================================
INSERT INTO Departments (name, location) VALUES
('Cardiology', 'Block A - Floor 2'),
('Neurology', 'Block B - Floor 3'),
('Orthopedics', 'Block C - Floor 1'),
('Pediatrics', 'Block A - Floor 1'),
('Oncology', 'Block D - Floor 4'),
('Emergency', 'Ground Floor'),
('Radiology', 'Block B - Floor 1'),
('General Surgery', 'Block C - Floor 2');

-- =====================================================
-- WARDS DATA
-- =====================================================
INSERT INTO Wards (name, capacity, type) VALUES
('ICU-1', 10, 'ICU'),
('ICU-2', 8, 'ICU'),
('General-A', 30, 'General'),
('General-B', 30, 'General'),
('General-C', 25, 'General'),
('Private-1', 10, 'Private'),
('Private-2', 12, 'Private'),
('Private-3', 6, 'Private');

-- =====================================================
-- DOCTORS DATA
-- =====================================================
INSERT INTO Doctors (first_name, last_name, specialization, phone, email, department_id) VALUES
('James','Carter','Cardiologist','555-1001','j.carter@hospital.com',1),
('Emily','Nguyen','Neurologist','555-1002','e.nguyen@hospital.com',2),
('Michael','Osei','Orthopedic Surgeon','555-1003','m.osei@hospital.com',3),
('Sarah','Patel','Pediatrician','555-1004','s.patel@hospital.com',4),
('David','Kim','Oncologist','555-1005','d.kim@hospital.com',5),
('Laura','Mensah','Emergency Physician','555-1006','l.mensah@hospital.com',6),
('Robert','Silva','Radiologist','555-1007','r.silva@hospital.com',7),
('Anna','Bennett','General Surgeon','555-1008','a.bennett@hospital.com',8),
('Kwame','Boateng','Cardiologist','555-1009','k.boateng@hospital.com',1),
('Olivia','Brown','Neurologist','555-1010','o.brown@hospital.com',2);

-- =====================================================
-- 30 PATIENTS
-- =====================================================
INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, blood_type, allergies) VALUES
('John','Smith','1985-03-12','Male','555-2001','O+','Penicillin'),
('Mary','Johnson','1990-07-22','Female','555-2002','A+','None'),
('Peter','Williams','1978-11-05','Male','555-2003','B+','Peanuts'),
('Grace','Brown','2000-01-15','Female','555-2004','AB-','Latex'),
('Henry','Davis','1965-09-30','Male','555-2005','O-','Aspirin'),
('Linda','Miller','1995-04-18','Female','555-2006','A-','None'),
('Samuel','Wilson','1982-12-02','Male','555-2007','B-','Shellfish'),
('Patricia','Moore','1970-06-25','Female','555-2008','O+','Sulfa drugs'),
('Daniel','Taylor','1988-08-14','Male','555-2009','A+','None'),
('Jennifer','Anderson','1993-02-09','Female','555-2010','AB+','Ibuprofen'),
('Charles','Thomas','1955-10-21','Male','555-2011','O+','Penicillin'),
('Barbara','Jackson','1968-05-17','Female','555-2012','B+','None'),
('Matthew','White','1999-03-03','Male','555-2013','A-','Pollen'),
('Susan','Harris','1975-09-11','Female','555-2014','O-','Latex'),
('Joseph','Martin','1983-07-29','Male','555-2015','AB+','None'),
('Karen','Thompson','1991-11-19','Female','555-2016','A+','Codeine'),
('Thomas','Garcia','1960-01-08','Male','555-2017','B-','None'),
('Nancy','Martinez','1987-04-27','Female','555-2018','O+','Eggs'),
('Christopher','Robinson','1996-12-13','Male','555-2019','AB-','Aspirin'),
('Lisa','Clark','1972-08-06','Female','555-2020','A+','None'),
('Anthony','Rodriguez','1980-02-24','Male','555-2021','O-','Penicillin'),
('Betty','Lewis','1963-06-30','Female','555-2022','B+','None'),
('Donald','Lee','1994-10-16','Male','555-2023','A-','Nuts'),
('Sandra','Walker','1977-03-21','Female','555-2024','O+','Latex'),
('Mark','Hall','1989-05-09','Male','555-2025','AB+','None'),
('Ashley','Allen','1998-09-02','Female','555-2026','A+','Sulfa drugs'),
('Paul','Young','1958-11-27','Male','555-2027','B-','None'),
('Kimberly','King','1986-01-31','Female','555-2028','O+','Shellfish'),
('Steven','Wright','1974-07-14','Male','555-2029','A+','None'),
('Donna','Scott','1992-04-05','Female','555-2030','AB-','Ibuprofen');

-- =====================================================
-- 40 APPOINTMENTS
-- =====================================================
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, notes) VALUES
(1,1,'2024-01-05 09:00:00','Completed','Routine cardiac checkup'),
(2,2,'2024-01-06 10:30:00','Completed','Migraine consultation'),
(3,3,'2024-01-07 11:00:00','Completed','Knee pain evaluation'),
(4,4,'2024-01-08 14:00:00','Completed','Child vaccination'),
(5,5,'2024-01-09 08:30:00','Completed','Chemotherapy follow-up'),
(6,6,'2024-01-10 16:00:00','Completed','Emergency fever'),
(7,7,'2024-01-11 09:15:00','Completed','X-ray review'),
(8,8,'2024-01-12 13:00:00','Completed','Post-op checkup'),
(9,9,'2024-01-13 10:00:00','Completed','Hypertension consult'),
(10,10,'2024-01-14 15:30:00','Completed','Seizure evaluation'),
(11,1,'2024-01-15 09:00:00','Completed','Chest pain'),
(12,2,'2024-01-16 11:30:00','Cancelled','Patient rescheduled'),
(13,3,'2024-01-17 14:45:00','Completed','Fracture follow-up'),
(14,4,'2024-01-18 10:00:00','Completed','Growth assessment'),
(15,5,'2024-01-19 09:30:00','Completed','Tumor scan review'),
(16,6,'2024-01-20 17:00:00','Completed','Sprained ankle'),
(17,7,'2024-01-21 08:00:00','Completed','MRI results'),
(18,8,'2024-01-22 12:00:00','Completed','Hernia consult'),
(19,9,'2024-01-23 10:30:00','No-Show','—'),
(20,10,'2024-01-24 13:30:00','Completed','Neuropathy check'),
(21,1,'2024-01-25 09:45:00','Completed','ECG review'),
(22,2,'2024-01-26 11:00:00','Completed','Memory loss consult'),
(23,3,'2024-01-27 15:00:00','Scheduled','Shoulder pain'),
(24,4,'2024-01-28 10:15:00','Completed','Asthma follow-up'),
(25,5,'2024-01-29 14:30:00','Completed','Biopsy results'),
(26,6,'2024-01-30 18:00:00','Completed','Allergic reaction'),
(27,7,'2024-01-31 09:00:00','Completed','CT scan review'),
(28,8,'2024-02-01 11:30:00','Scheduled','Gallbladder consult'),
(29,9,'2024-02-02 13:00:00','Completed','Arrhythmia check'),
(30,10,'2024-02-03 15:45:00','Completed','Stroke follow-up'),
(1,5,'2024-02-04 10:00:00','Completed','Oncology screening'),
(2,6,'2024-02-05 16:30:00','Completed','Chest infection'),
(3,7,'2024-02-06 08:30:00','Scheduled','Bone density scan'),
(4,8,'2024-02-07 12:45:00','Completed','Appendix follow-up'),
(5,9,'2024-02-08 09:15:00','Completed','Heart murmur'),
(6,10,'2024-02-09 14:00:00','Completed','Dizziness'),
(7,1,'2024-02-10 11:00:00','Scheduled','Annual checkup'),
(8,2,'2024-02-11 13:30:00','Completed','Back pain'),
(9,3,'2024-02-12 15:00:00','Completed','Joint stiffness'),
(10,4,'2024-02-13 10:30:00','Scheduled','Vaccination booster');

-- =====================================================
-- 25 ADMISSIONS
-- =====================================================
INSERT INTO Admissions (patient_id, ward_id, doctor_id, admission_date, discharge_date, diagnosis) VALUES
(1,3,1,'2024-01-05 10:00:00','2024-01-08 12:00:00','Hypertension'),
(2,4,2,'2024-01-06 11:00:00','2024-01-10 09:00:00','Chronic migraine'),
(3,5,3,'2024-01-07 09:30:00','2024-01-12 14:00:00','Fractured tibia'),
(4,3,4,'2024-01-08 13:00:00','2024-01-09 10:00:00','Pneumonia'),
(5,1,5,'2024-01-09 08:00:00','2024-01-20 11:00:00','Lymphoma'),
(6,6,6,'2024-01-10 17:00:00','2024-01-11 09:00:00','Severe dehydration'),
(7,4,7,'2024-01-11 10:30:00','2024-01-13 15:00:00','Kidney stones'),
(8,7,8,'2024-01-12 12:00:00','2024-01-18 10:00:00','Appendicitis'),
(9,3,9,'2024-01-13 09:00:00','2024-01-15 12:00:00','Arrhythmia'),
(10,5,10,'2024-01-14 14:00:00','2024-01-19 09:30:00','Epilepsy'),
(11,2,1,'2024-01-15 08:30:00','2024-01-22 10:00:00','Myocardial infarction'),
(12,3,2,'2024-01-16 11:00:00','2024-01-18 13:00:00','Vertigo'),
(13,4,3,'2024-01-17 15:00:00','2024-01-21 09:00:00','ACL tear'),
(14,5,4,'2024-01-18 09:00:00','2024-01-20 11:30:00','Bronchitis'),
(15,1,5,'2024-01-19 10:00:00','2024-01-30 14:00:00','Leukemia'),
(16,6,6,'2024-01-20 16:00:00','2024-01-21 10:00:00','Allergic reaction'),
(17,7,7,'2024-01-21 08:00:00','2024-01-24 12:00:00','Fractured hip'),
(18,3,8,'2024-01-22 12:30:00','2024-01-26 09:00:00','Gallstones'),
(19,4,9,'2024-01-23 10:00:00','2024-01-25 15:00:00','Atrial fibrillation'),
(20,5,10,'2024-01-24 13:00:00','2024-01-28 10:00:00','Stroke recovery'),
(21,8,1,'2024-01-25 09:30:00','2024-01-27 11:00:00','Angina'),
(22,3,2,'2024-01-26 11:00:00','2024-01-29 14:00:00','Dementia evaluation'),
(23,4,3,'2024-01-27 14:00:00','2024-01-30 10:00:00','Shoulder dislocation'),
(24,5,4,'2024-01-28 10:00:00','2024-01-31 12:00:00','Asthma attack'),
(25,2,5,'2024-01-29 08:30:00','2024-02-05 09:00:00','Breast cancer');

-- =====================================================
-- 30 TREATMENTS
-- =====================================================
INSERT INTO Treatments (admission_id, doctor_id, treatment_name, treatment_date, cost, notes) VALUES
(1,1,'Blood pressure monitoring','2024-01-05',250.00,'Daily readings'),
(1,1,'ECG','2024-01-06',400.00,'Normal sinus rhythm'),
(2,2,'MRI Brain','2024-01-06',1200.00,'No abnormalities'),
(2,2,'IV Medication','2024-01-07',350.00,'Sumatriptan'),
(3,3,'X-Ray Tibia','2024-01-07',300.00,'Fracture confirmed'),
(3,3,'Cast Application','2024-01-07',500.00,'Below knee cast'),
(4,4,'Chest X-Ray','2024-01-08',280.00,'Consolidation seen'),
(4,4,'Antibiotic Therapy','2024-01-08',450.00,'IV Amoxicillin'),
(5,5,'Chemotherapy Session','2024-01-10',3500.00,'Cycle 1'),
(5,5,'Blood Transfusion','2024-01-12',900.00,'2 units'),
(6,6,'IV Fluids','2024-01-10',200.00,'Normal saline'),
(7,7,'CT Scan Abdomen','2024-01-11',950.00,'Stone detected'),
(7,7,'Lithotripsy','2024-01-12',2200.00,'Successful'),
(8,8,'Appendectomy','2024-01-12',4500.00,'Laparoscopic'),
(8,8,'Post-op Care','2024-01-13',600.00,'Observation'),
(9,9,'Holter Monitor','2024-01-13',750.00,'24-hour'),
(10,10,'EEG','2024-01-14',850.00,'Abnormal waves'),
(10,10,'Anti-epileptic Therapy','2024-01-15',400.00,'Levetiracetam'),
(11,1,'Angioplasty','2024-01-15',8500.00,'Stent placed'),
(11,1,'Cardiac Rehab','2024-01-18',700.00,'Session 1'),
(12,2,'Vestibular Therapy','2024-01-16',300.00,'Exercises'),
(13,3,'ACL Reconstruction','2024-01-17',6500.00,'Arthroscopic'),
(14,4,'Nebulization','2024-01-18',180.00,'Albuterol'),
(15,5,'Bone Marrow Biopsy','2024-01-19',1800.00,'Confirms leukemia'),
(16,6,'Epinephrine Injection','2024-01-20',150.00,'Anaphylaxis'),
(17,7,'Hip Replacement','2024-01-21',12000.00,'Total replacement'),
(18,8,'Cholecystectomy','2024-01-22',5200.00,'Laparoscopic'),
(19,9,'Cardioversion','2024-01-23',1500.00,'Successful'),
(20,10,'Physiotherapy','2024-01-24',400.00,'Stroke rehab'),
(21,1,'Stress Test','2024-01-25',600.00,'Positive for ischemia'),
(22,2,'Cognitive Assessment','2024-01-26',350.00,'Mild impairment'),
(23,3,'Closed Reduction','2024-01-27',900.00,'Shoulder relocated'),
(24,4,'Bronchodilator Therapy','2024-01-28',250.00,'Nebulized'),
(25,5,'Mastectomy','2024-01-29',9500.00,'Left breast'),
(25,5,'Radiation Therapy','2024-02-01',2800.00,'Session 1'),
(5,5,'PET Scan','2024-01-15',2400.00,'Staging'),
(8,8,'Pain Management','2024-01-14',300.00,'Morphine drip'),
(11,1,'Beta Blocker Therapy','2024-01-16',200.00,'Metoprolol'),
(15,5,'Platelet Transfusion','2024-01-22',750.00,'Low count'),
(20,10,'Speech Therapy','2024-01-25',350.00,'Dysarthria');

-- =====================================================
-- 30 BILLING RECORDS
-- =====================================================
INSERT INTO Billing (patient_id, admission_id, bill_date, total_amount, paid_amount, status) VALUES
(1,1,'2024-01-08',1250.00,1250.00,'Paid'),
(2,2,'2024-01-10',1850.00,1000.00,'Partial'),
(3,3,'2024-01-12',2100.00,2100.00,'Paid'),
(4,4,'2024-01-09',980.00,0.00,'Pending'),
(5,5,'2024-01-20',7800.00,5000.00,'Partial'),
(6,6,'2024-01-11',350.00,350.00,'Paid'),
(7,7,'2024-01-13',3450.00,3450.00,'Paid'),
(8,8,'2024-01-18',5700.00,5700.00,'Paid'),
(9,9,'2024-01-15',1100.00,500.00,'Partial'),
(10,10,'2024-01-19',1650.00,0.00,'Overdue'),
(11,11,'2024-01-22',9600.00,9600.00,'Paid'),
(12,12,'2024-01-18',600.00,600.00,'Paid'),
(13,13,'2024-01-21',7200.00,3000.00,'Partial'),
(14,14,'2024-01-20',480.00,480.00,'Paid'),
(15,15,'2024-01-30',11200.00,6000.00,'Partial'),
(16,16,'2024-01-21',400.00,400.00,'Paid'),
(17,17,'2024-01-24',12600.00,12600.00,'Paid'),
(18,18,'2024-01-26',5600.00,0.00,'Pending'),
(19,19,'2024-01-25',1850.00,1850.00,'Paid'),
(20,20,'2024-01-28',1500.00,750.00,'Partial'),
(21,21,'2024-01-27',1450.00,1450.00,'Paid'),
(22,22,'2024-01-29',950.00,0.00,'Pending'),
(23,23,'2024-01-30',1200.00,1200.00,'Paid'),
(24,24,'2024-01-31',680.00,680.00,'Paid'),
(25,25,'2024-02-05',15800.00,8000.00,'Partial'),
(26,NULL,'2024-02-01',300.00,300.00,'Paid'),
(27,NULL,'2024-02-02',450.00,0.00,'Pending'),
(28,NULL,'2024-02-03',700.00,700.00,'Paid'),
(29,NULL,'2024-02-04',900.00,450.00,'Partial'),
(30,NULL,'2024-02-05',1100.00,0.00,'Overdue');

-- =====================================================
-- VERIFICATION
-- =====================================================
SELECT 'Departments' AS table_name, COUNT(*) AS rows_inserted FROM Departments
UNION ALL SELECT 'Wards', COUNT(*) FROM Wards
UNION ALL SELECT 'Doctors', COUNT(*) FROM Doctors
UNION ALL SELECT 'Patients', COUNT(*) FROM Patients
UNION ALL SELECT 'Appointments', COUNT(*) FROM Appointments
UNION ALL SELECT 'Admissions', COUNT(*) FROM Admissions
UNION ALL SELECT 'Treatments', COUNT(*) FROM Treatments
UNION ALL SELECT 'Billing', COUNT(*) FROM Billing;