CREATE OR REPLACE FUNCTION SumOfDonorsMoreThanOneHDollar(p_EventID IN NUMBER) RETURN NUMBER IS
    v_sum_of_donors NUMBER;
BEGIN
    -- Function to count distinct donors who donated more than $1 for a given event ID
    SELECT COUNT(DISTINCT d.DonorID) INTO v_sum_of_donors
    FROM Donation d
    JOIN Event e ON d.DonorID = e.DonorID_
    WHERE e.EventID = p_EventID
      AND d.Amount > 1;
    
    RETURN v_sum_of_donors;
EXCEPTION
    -- Exception handling: if any error occurs, return 0
    WHEN OTHERS THEN
        RETURN 0;
END SumOfDonorsMoreThanOneHDollar;
