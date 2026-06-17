-- ============================================
-- AGGREGATE FUNCTION
-- ============================================
SELECT 
    COUNT(invoiceid) AS total_invoices_issued,
    SUM(amount) AS total_revenue_generated,
    AVG(amount) AS average_bill_amount,
    MAX(amount) AS highest_single_bill
FROM invoice;

SELECT 
    COUNT(labtestid) AS total_tests_conducted,
    COUNT(*) - COUNT(result) AS total_pending_results
FROM labtest;
-- ============================================
-- GROUP BY + HAVING CLAUSES
-- ============================================
SELECT 
    d.deptid AS department_code, 
    COUNT(a.appointmentid) AS total_department_appointments
FROM appointment a
JOIN doctor d ON a.doctorid = d.doctorid
GROUP BY d.deptid
HAVING COUNT(a.appointmentid) >= 1
ORDER BY total_department_appointments DESC;

SELECT 
    status AS payment_status, 
    COUNT(invoiceid) AS total_invoices,
    SUM(amount) AS total_monetary_value
FROM invoice
GROUP BY status
HAVING SUM(amount) > 100.00;
-- ============================================
-- VIEW CREATION
-- ============================================
DROP VIEW IF EXISTS active_patient_billing;
CREATE OR REPLACE VIEW active_patient_billing AS
SELECT 
    p.patientid,
    p.name AS patient_name,
    p.phone AS patient_contact,
    a.appointmentid,
    a.appointmentdate,
    i.invoiceid,
    i.amount AS total_due,
    i.status AS payment_status
FROM patient p
JOIN appointment a ON p.patientid = a.patientid
JOIN invoice i ON a.appointmentid = i.appointmentid;
SELECT * FROM active_patient_billing;

CREATE OR REPLACE VIEW medical_distribution_log AS
SELECT 
    d.name AS prescribing_doctor,
    p.name AS patient_name,
    pr.medicinename,
    pr.dosage,
    pr.duration
FROM doctor d
JOIN appointment a ON d.doctorid = a.doctorid
JOIN patient p ON a.patientid = p.patientid
JOIN prescription pr ON a.appointmentid = pr.appointmentid;
SELECT * FROM medical_distribution_log;
-- ============================================
-- SUBQUERIES/ NESTED QUERIES
-- ============================================
SELECT 
    patientid, 
    name AS patient_name, 
    wardid
FROM patient
WHERE wardid IN (
    SELECT wardid 
    FROM ward 
    WHERE capacity >= (SELECT AVG(capacity) FROM ward)
);

SELECT 
    appointmentid, 
    patientid, 
    doctorid, 
    appointmentdate
FROM appointment
WHERE appointmentid IN (
    SELECT appointmentid 
    FROM invoice 
    WHERE amount > (SELECT AVG(amount) FROM invoice)
);

