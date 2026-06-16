/*
============================================
QUERY 1: STRING CONCATENATION
============================================

PURPOSE:
This query concatenates multiple columns from different tables 
to create a readable, human-friendly lab test report. It combines:
- Patient name (from Patient table)
- Test type (from LabTest table)  
- Technician name (from LabTechnician table)
- Test result (with NULL handling using COALESCE)
- Formatted test date

This is useful for generating reports that are easy to read 
without needing to look at multiple separate tables.

TECHNIQUE USED:
- String concatenation using the || operator
- COALESCE to handle NULL results
- TO_CHAR for date formatting
- Multiple JOINs to bring data from related tables
*/

SELECT 
    lt.labtestid,
    'Patient: ' || p.name AS patient_name,
    'Test Type: ' || lt.testtype AS test_type,
    'Technician: ' || t.name AS technician_name,
    'Result: ' || COALESCE(lt.result, 'Pending...') AS result_status,
    'Date: ' || TO_CHAR(lt.testdate, 'DD-Mon-YYYY') AS formatted_date
FROM labtest lt
JOIN appointment a ON lt.appointmentid = a.appointmentid
JOIN patient p ON a.patientid = p.patientid
JOIN labtechnician t ON lt.technicianid = t.technicianid
ORDER BY lt.testdate DESC;

/*
============================================
QUERY 2: TOP N RECORDS (LIMIT)
============================================

PURPOSE:
This query identifies the top 3 patients with the highest 
total spending on invoices. It:
- Groups invoices by patient
- Calculates the total amount spent per patient
- Sorts from highest to lowest
- Limits results to only the top 3

This is useful for identifying VIP patients, 
targeting high-value customers for promotions, 
or analyzing spending patterns.

TECHNIQUE USED:
- GROUP BY with aggregate function (SUM, COUNT)
- ORDER BY DESC for descending order
- LIMIT to restrict to top N records
- Multiple JOINs across Patient, Appointment, and Invoice tables
*/

SELECT 
    p.patientid,
    p.name AS patient_name,
    COUNT(i.invoiceid) AS number_of_invoices,
    SUM(i.amount) AS total_spent
FROM patient p
JOIN appointment a ON p.patientid = a.patientid
JOIN invoice i ON a.appointmentid = i.appointmentid
GROUP BY p.patientid, p.name
ORDER BY total_spent DESC
LIMIT 3;