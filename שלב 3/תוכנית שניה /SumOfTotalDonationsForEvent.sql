CREATE OR REPLACE FUNCTION SumOfTotalDonationsForEvent(p_EventID IN NUMBER) RETURN NUMBER IS
    v_sum_of_donations NUMBER;
BEGIN
    -- Function to sum up the total donations for a given event ID
    SELECT SUM(d.Amount) INTO v_sum_of_donations
    FROM Donation d
    JOIN Event e ON d.DonorID = e.DonorID_
    WHERE e.EventID = p_EventID;
    
    RETURN v_sum_of_donations;
EXCEPTION
    -- Exception handling: if any error occurs, return 0
    WHEN OTHERS THEN
        RETURN 0;
END SumOfTotalDonationsForEvent;
