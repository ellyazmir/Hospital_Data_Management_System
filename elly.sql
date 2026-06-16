-- ELLY'S TABLES (Hospital, Ward, Department, Doctor, Patient)

/*
================
  CREATE TABLE
================
*/

-- HOSPITAL
CREATE TABLE Hospital (
    HospitalID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

-- WARD
CREATE TABLE Ward (
    WardID VARCHAR(10) PRIMARY KEY,
    WardType VARCHAR(50) NOT NULL,
    Capacity INT CHECK (Capacity > 0),
    HospitalID VARCHAR(10) NOT NULL REFERENCES Hospital(HospitalID)
);

-- DEPARTMENT
CREATE TABLE Department (
    DeptID VARCHAR(10) PRIMARY KEY,
    HospitalID VARCHAR(10) NOT NULL REFERENCES Hospital(HospitalID),
    DeptName VARCHAR(100) NOT NULL,
    HeadDoctorID VARCHAR(10) REFERENCES Doctor(DoctorID)
);

-- DOCTOR
CREATE TABLE Doctor (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DeptID VARCHAR(10) NOT NULL REFERENCES Department(DeptID),
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- PATIENT
CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    Phone VARCHAR(20),
    WardID VARCHAR(10) REFERENCES Ward(WardID),
    AdmissionDate DATE
);

/*
==========================
  INSERT DATA INTO TABLE
==========================
*/

-- HOSPITAL
INSERT INTO Hospital VALUES ('H001', 'MMU Medical Center', 'Jalan Multimedia, Cyberjaya', '03-83125000');
INSERT INTO Hospital VALUES ('H002', 'Cyberjaya General Hospital', 'Persiaran Bestari, Cyberjaya', '03-83126000');

-- WARD
INSERT INTO Ward VALUES ('W001', 'General Ward', 20, 'H001');
INSERT INTO Ward VALUES ('W002', 'ICU', 10, 'H001');
INSERT INTO Ward VALUES ('W003', 'Pediatric Ward', 15, 'H002');

-- DEPARTMENT
INSERT INTO Department VALUES ('D001', 'H001', 'Cardiology', 'DOC001');
INSERT INTO Department VALUES ('D002', 'H001', 'Pediatrics', 'DOC003');
INSERT INTO Department VALUES ('D003', 'H002', 'Emergency', 'DOC004');

-- DOCTOR
INSERT INTO Doctor VALUES ('DOC001', 'D001', 'Dr. Zhao Yufan', '012-3456789', 'zhaoyufan@hospital.com');
INSERT INTO Doctor VALUES ('DOC002', 'D001', 'Dr. Chen Feiyu', '012-9876543', 'chenfeiyu@hospital.com');
INSERT INTO Doctor VALUES ('DOC003', 'D002', 'Dr. Xiao Nai', '013-4567890', 'xiaonai@hospital.com');
INSERT INTO Doctor VALUES ('DOC004', 'D003', 'Dr. Sui Yuanqing', '014-5678901', 'suiyuanqing@hospital.com');
INSERT INTO Doctor VALUES ('DOC005', 'D001', 'Dr. Gu Weiyi', '019-3456789', 'guweiyi@hospital.com');
INSERT INTO Doctor VALUES ('DOC006', 'D005', 'Dr. Duan Jiaxu', '016-7890123', 'duanjiaxu@hospital.com');
INSERT INTO Doctor VALUES ('DOC007', 'D003', 'Dr. Zi Qi', '017-8901234', 'ziqi@hospital.com');
INSERT INTO Doctor VALUES ('DOC008', 'D001', 'Dr. Xiao Heng', '018-1234567', 'xiaoheng@hospital.com');
INSERT INTO Doctor VALUES ('DOC009', 'D002', 'Dr. Ji Bozai', '018-2345678', 'jibozai@hospital.com');
INSERT INTO Doctor VALUES ('DOC010', 'D003', 'Dr. Daoming Si', '018-3456789', 'daomingsi@hospital.com');

-- PATIENT
INSERT INTO Patient VALUES ('P001', 'John Bin Abdullah', '1985-05-15', 'M', '011-1234567', 'W001', '2026-06-10');
INSERT INTO Patient VALUES ('P002', 'Sarah A/p Tan', '1990-08-22', 'F', '011-2345678', 'W002', '2026-06-11');
INSERT INTO Patient VALUES ('P003', 'Muhammad Bin Ravi', '1978-03-10', 'M', '011-3456789', 'W001', '2026-06-12');
INSERT INTO Patient VALUES ('P004', 'Ling Mei Ling', '2000-12-01', 'F', '011-4567890', 'W003', '2026-06-13');
INSERT INTO Patient VALUES ('P005', 'Kumar a/l Segar', '1995-07-19', 'M', '011-5678901', NULL, '2026-06-14');