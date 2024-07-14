CREATE OR REPLACE FUNCTION SumOfDonorsForEvent(p_EventID IN NUMBER) RETURN NUMBER IS
    v_sum_of_donors NUMBER;
BEGIN
    -- Function to count the number of distinct donors for a given event ID
    SELECT COUNT(DISTINCT DonorID_) INTO v_sum_of_donors
    FROM Event
    WHERE EventID = p_EventID;
    
    RETURN v_sum_of_donors;
EXCEPTION
    -- Exception handling: if any error occurs, return 0
    WHEN OTHERS THEN
        RETURN 0;
END SumOfDonorsForEvent;
