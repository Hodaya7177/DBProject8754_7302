CREATE OR REPLACE FUNCTION SumOfDonorsForEvent(p_event_id IN NUMBER)
RETURN NUMBER
IS
    v_sum_of_donors NUMBER;
BEGIN
    SELECT COUNT(DISTINCT d.donorid)
    INTO v_sum_of_donors
    FROM System.Donation dn
    JOIN System.Participates p ON dn.donorid = p.donorid
    WHERE p.eventid = p_event_id;
    
    RETURN v_sum_of_donors;
END;
/
