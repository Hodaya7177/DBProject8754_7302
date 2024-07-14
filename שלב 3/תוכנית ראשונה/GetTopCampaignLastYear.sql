CREATE OR REPLACE FUNCTION GetTopCampaignLastYear
RETURN NUMBER
IS
    v_max_donation NUMBER := 0;
BEGIN
    SELECT MAX(total_donations) INTO v_max_donation
    FROM (
        SELECT SUM(d.amount) AS total_donations
        FROM System.Campaign c
        JOIN System.Donation d ON c.campaignid = d.campaignid
        WHERE EXTRACT(YEAR FROM c.enddate) = EXTRACT(YEAR FROM SYSDATE) - 1
        GROUP BY c.campaignid
    );

    RETURN v_max_donation;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
