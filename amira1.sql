/*
================
  CREATE TABLE
================
*/

-- LAB TECHNICIAN
CREATE TABLE labtechnician (
    technicianid VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- APPOINTMENT
CREATE TABLE appointment (
    appointmentid VARCHAR(10) PRIMARY KEY,
    patientid VARCHAR(10) NOT NULL REFERENCES patient(patientid),
    doctorid VARCHAR(10) NOT NULL REFERENCES doctor(doctorid),
    appointmentdate DATE NOT NULL,
    appointmenttime TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled' CHECK (status IN ('Scheduled', 'Completed', 'Cancelled'))
);

-- PRESCRIPTION
CREATE TABLE prescription (
    prescriptionid VARCHAR(10) PRIMARY KEY,
    appointmentid VARCHAR(10) NOT NULL REFERENCES appointment(appointmentid),
    doctorid VARCHAR(10) NOT NULL REFERENCES doctor(doctorid),
    medicinename VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    duration VARCHAR(50)
);

-- INVOICE
CREATE TABLE invoice (
    invoiceid VARCHAR(10) PRIMARY KEY,
    appointmentid VARCHAR(10) NOT NULL REFERENCES appointment(appointmentid),
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    invoicedate DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Paid', 'Refunded'))
);

-- LAB TEST
CREATE TABLE labtest (
    labtestid VARCHAR(10) PRIMARY KEY,
    appointmentid VARCHAR(10) NOT NULL REFERENCES appointment(appointmentid),
    technicianid VARCHAR(10) NOT NULL REFERENCES labtechnician(technicianid),
    testtype VARCHAR(50) NOT NULL,
    result TEXT,
    testdate DATE NOT NULL
);


/*
==========================
  INSERT DATA
==========================
*/

-- LAB TECHNICIAN
INSERT INTO labtechnician (technicianid, name, phone, email)
VALUES 
    ('TECH001', 'Ahmad Bin Hassan', '012-3456789', 'ahmad.hassan@hospital.com'),
    ('TECH002', 'Siti Binti Rahman', '012-9876543', 'siti.rahman@hospital.com'),
    ('TECH003', 'Tan Wei Ming', '016-2345678', 'tan.weiming@hospital.com');

-- APPOINTMENT
INSERT INTO appointment (appointmentid, patientid, doctorid, appointmentdate, appointmenttime, status)
VALUES 
    ('APP001', 'P001', 'DOC001', '2026-06-20', '09:30:00', 'Scheduled'),
    ('APP002', 'P002', 'DOC005', '2026-06-20', '10:45:00', 'Scheduled'),
    ('APP003', 'P003', 'DOC007', '2026-06-21', '14:00:00', 'Completed'),
    ('APP004', 'P004', 'DOC003', '2026-06-21', '15:30:00', 'Scheduled'),
    ('APP005', 'P005', 'DOC002', '2026-06-22', '08:00:00', 'Scheduled'),
    ('APP006', 'P006', 'DOC009', '2026-06-22', '11:00:00', 'Completed'),
    ('APP007', 'P007', 'DOC006', '2026-06-23', '09:00:00', 'Scheduled'),
    ('APP008', 'P008', 'DOC004', '2026-06-23', '13:30:00', 'Cancelled'),
    ('APP009', 'P009', 'DOC008', '2026-06-24', '10:00:00', 'Scheduled'),
    ('APP010', 'P010', 'DOC010', '2026-06-24', '16:00:00', 'Scheduled');

-- PRESCRIPTION
INSERT INTO prescription (prescriptionid, appointmentid, doctorid, medicinename, dosage, duration)
VALUES 
    ('PRES001', 'APP001', 'DOC001', 'Amoxicillin', '500mg', '7 days'),
    ('PRES002', 'APP002', 'DOC005', 'Lisinopril', '10mg', '30 days'),
    ('PRES003', 'APP003', 'DOC007', 'Nitroglycerin', '0.4mg', 'As needed'),
    ('PRES004', 'APP004', 'DOC003', 'Paracetamol', '500mg', '5 days'),
    ('PRES005', 'APP005', 'DOC002', 'Metformin', '850mg', '60 days'),
    ('PRES006', 'APP006', 'DOC009', 'Amoxicillin', '250mg', '7 days'),
    ('PRES007', 'APP007', 'DOC006', 'Omeprazole', '20mg', '14 days'),
    ('PRES008', 'APP009', 'DOC008', 'Atorvastatin', '40mg', '90 days'),
    ('PRES009', 'APP010', 'DOC010', 'Ciprofloxacin', '500mg', '10 days');

-- INVOICE
INSERT INTO invoice (invoiceid, appointmentid, amount, invoicedate, status)
VALUES 
    ('INV001', 'APP001', 250.00, '2026-06-20', 'Pending'),
    ('INV002', 'APP002', 180.50, '2026-06-20', 'Paid'),
    ('INV003', 'APP003', 450.00, '2026-06-21', 'Refunded'),
    ('INV004', 'APP004', 120.00, '2026-06-21', 'Pending'),
    ('INV005', 'APP005', 350.00, '2026-06-22', 'Paid'),
    ('INV006', 'APP006', 210.00, '2026-06-22', 'Paid'),
    ('INV007', 'APP007', 500.00, '2026-06-23', 'Pending'),
    ('INV008', 'APP008', 75.00, '2026-06-23', 'Pending'),
    ('INV009', 'APP009', 290.00, '2026-06-24', 'Paid'),
    ('INV010', 'APP010', 410.00, '2026-06-24', 'Pending');

-- LAB TEST
INSERT INTO labtest (labtestid, appointmentid, technicianid, testtype, result, testdate)
VALUES 
    ('LAB001', 'APP001', 'TECH001', 'Complete Blood Count', 'Normal', '2026-06-20'),
    ('LAB002', 'APP002', 'TECH002', 'Blood Culture', NULL, '2026-06-20'),
    ('LAB003', 'APP003', 'TECH003', 'Chest X-Ray', 'No abnormalities detected', '2026-06-21'),
    ('LAB004', 'APP004', 'TECH001', 'Lipid Panel', NULL, '2026-06-21'),
    ('LAB005', 'APP005', 'TECH002', 'Urinalysis', 'Normal', '2026-06-22'),
    ('LAB006', 'APP006', 'TECH003', 'MRI Brain', 'Normal', '2026-06-22'),
    ('LAB007', 'APP007', 'TECH001', 'ECG', 'Abnormal - Further tests required', '2026-06-23'),
    ('LAB008', 'APP009', 'TECH002', 'Blood Glucose Test', 'Elevated', '2026-06-24'),
    ('LAB009', 'APP010', 'TECH003', 'CT Scan', NULL, '2026-06-24');


/*
==========================
  VERIFICATION
==========================
*/

-- Count records in all tables
SELECT 'labtechnician' AS table_name, COUNT(*) AS count FROM labtechnician
UNION ALL
SELECT 'appointment', COUNT(*) FROM appointment
UNION ALL
SELECT 'prescription', COUNT(*) FROM prescription
UNION ALL
SELECT 'invoice', COUNT(*) FROM invoice
UNION ALL
SELECT 'labtest', COUNT(*) FROM labtest;

