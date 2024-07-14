CREATE OR REPLACE FUNCTION SumOfDonorsMoreThanOneHDollar(p_event_id IN NUMBER)
RETURN NUMBER
IS
    v_sum_of_donors_more_than_one_dollar NUMBER;
BEGIN
    SELECT COUNT(DISTINCT d.donorid)
    INTO v_sum_of_donors_more_than_one_dollar
    FROM System.Donation dn
    JOIN System.Participates p ON dn.donorid = p.donorid
    WHERE p.eventid = p_event_id AND dn.amount > 1;
    
    RETURN v_sum_of_donors_more_than_one_dollar;
END;
/
