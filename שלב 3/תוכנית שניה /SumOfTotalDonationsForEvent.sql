CREATE OR REPLACE FUNCTION SumOfTotalDonationsForEvent(p_event_id IN NUMBER)
RETURN NUMBER
IS
    v_sum_of_total_donations NUMBER;
BEGIN
    SELECT SUM(dn.amount)
    INTO v_sum_of_total_donations
    FROM System.Donation dn
    JOIN System.Participates p ON dn.donorid = p.donorid
    WHERE p.eventid = p_event_id;
    
    RETURN v_sum_of_total_donations;
END;
/
