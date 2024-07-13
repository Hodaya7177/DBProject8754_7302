CREATE OR REPLACE PROCEDURE AddNewCampaign (
    p_campaign_name IN VARCHAR2,
    p_start_date IN DATE,
    p_end_date IN DATE,
    p_num_employees IN NUMBER,
    p_num_events IN NUMBER
) IS
    v_campaign_id NUMBER;
    v_max_donation NUMBER;
    v_donation_goal NUMBER;
    v_event_id NUMBER;
    v_cursor SYS_REFCURSOR;
    v_employee_id NUMBER;
    v_donor_id NUMBER;
BEGIN
    -- Generate a unique campaign ID using a sequence
    v_campaign_id := CampaignSeq.NEXTVAL;

    -- Find the top campaign from last year
    v_max_donation := GetTopCampaignLastYear;
    v_donation_goal := v_max_donation * 1.10;

    -- Insert the new campaign
    INSERT INTO System.Campaign (campaignid, campaignname, startdate, enddate, donationgoal)
    VALUES (v_campaign_id, p_campaign_name, p_start_date, p_end_date, v_donation_goal);

    -- Create launch events for the new campaign
    FOR i IN 1..p_num_events LOOP
        -- Generate a unique event ID using a sequence
        v_event_id := EventSeq.NEXTVAL;

        -- Get a donor to associate with the event
        SELECT personid
        INTO v_donor_id
        FROM (
            SELECT personid
            FROM System.Donor
            ORDER BY DBMS_RANDOM.VALUE
        )
        WHERE ROWNUM = 1;

        -- Get top employees using the function
        v_cursor := GetTopEmployees(p_num_employees);

        -- Assign the first employee to the event and insert event
        FETCH v_cursor INTO v_employee_id;
        EXIT WHEN v_cursor%NOTFOUND;
        
        -- Insert the event with the location, donorid and employeeid
        INSERT INTO System.Event (eventid, campaignid, eventdate, eventlocation, donorid_, employeeid)
        VALUES (v_event_id, v_campaign_id, p_start_date, 'Jerusalem', v_donor_id, v_employee_id);
        
        -- Assign the rest of the employees to the event
        LOOP
            FETCH v_cursor INTO v_employee_id;
            EXIT WHEN v_cursor%NOTFOUND;
            INSERT INTO System.WorksOn (employeeid, eventid) VALUES (v_employee_id, v_event_id);
        END LOOP;
        CLOSE v_cursor;
    END LOOP;

    -- Notify donors about the new campaign events
    FOR donor_rec IN (
        SELECT d.personid FROM System.Donor d
    ) LOOP
        INSERT INTO System.Participates (donorid, eventid) VALUES (donor_rec.personid, v_event_id);
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
