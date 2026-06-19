-- =============
-- TRIGGER
-- =============

CREATE TABLE AppointmentLog (
    LogID         SERIAL PRIMARY KEY,
    AppointmentID VARCHAR(10),
    OldStatus     VARCHAR(20),
    NewStatus     VARCHAR(20),
    ChangedAt     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_appointment_status_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO AppointmentLog (AppointmentID, OldStatus, NewStatus)
        VALUES (OLD.appointmentid, OLD.status, NEW.status);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_appointment_status
AFTER UPDATE ON appointment
FOR EACH ROW
EXECUTE FUNCTION log_appointment_status_change();

UPDATE appointment SET status = 'Completed' WHERE appointmentid = 'APP001';
SELECT * FROM AppointmentLog;


-- =====================
-- STORED PROCEDURE
-- =====================

CREATE OR REPLACE PROCEDURE register_appointment(
    p_appointmentid VARCHAR(10),
    p_patientid     VARCHAR(10),
    p_doctorid      VARCHAR(10),
    p_date          DATE,
    p_time          TIME
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO appointment (appointmentid, patientid, doctorid, appointmentdate, appointmenttime, status)
    VALUES (p_appointmentid, p_patientid, p_doctorid, p_date, p_time, 'Scheduled');

    RAISE NOTICE 'Appointment % successfully registered for Patient % with Doctor %.',
        p_appointmentid, p_patientid, p_doctorid;
END;
$$;

-- Test the stored procedure
CALL register_appointment('APP011', 'P011', 'DOC002', '2026-06-25', '10:00:00');
SELECT * FROM appointment WHERE appointmentid = 'APP011';


-- ============================================
-- NOT-IN-LECTURE QUERY 1: CASE STATEMENT
-- ============================================

SELECT 
    invoiceid,
    appointmentid,
    amount,
    CASE 
        WHEN amount < 200 THEN 'Low Cost'
        WHEN amount BETWEEN 200 AND 400 THEN 'Medium Cost'
        ELSE 'High Cost'
    END AS CostCategory,
    status
FROM invoice
ORDER BY amount;


-- ============================================
-- NOT-IN-LECTURE QUERY 2: RANK WINDOW FUNCTION
-- ============================================

SELECT 
    doctorid,
    COUNT(appointmentid) AS total_appointments,
    RANK() OVER (ORDER BY COUNT(appointmentid) DESC) AS workload_rank
FROM appointment
GROUP BY doctorid
ORDER BY workload_rank;
