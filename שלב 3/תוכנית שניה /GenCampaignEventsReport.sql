CREATE OR REPLACE PROCEDURE GenCampaignEventsReport (p_CampaignID NUMBER) IS
    -- Cursor to fetch the specific campaign
    CURSOR c_campaign IS
        SELECT CampaignID, CampaignName, StartDate, EndDate
        FROM System.Campaign
        WHERE CampaignID = p_CampaignID;
        
    -- Cursor to fetch events for the specific campaign
    CURSOR c_events(p_CampaignID NUMBER) IS
        SELECT EventID, EventDate
        FROM System.Event
        WHERE CampaignID = p_CampaignID;

    -- Record type to hold event data
    TYPE t_event_record IS RECORD (
        EventDate         DATE,
        SumOfDonors       NUMBER,
        SumOfDonorsMoreThanOneDollar NUMBER,
        SumOfTotalDonations NUMBER
    );
    
    -- Record type to hold campaign data
    TYPE t_campaign_record IS RECORD (
        CampaignName      VARCHAR2(50),
        StartDate         DATE,
        EndDate           DATE
    );
    
    -- Variables to hold record data
    v_campaign_record c_campaign%ROWTYPE;
    v_events_record c_events%ROWTYPE;

    v_event_data t_event_record;
    v_campaign_data t_campaign_record;

    v_sum_of_donors NUMBER;
    v_sum_of_donors_more_than_one_dollar NUMBER;
    v_sum_of_total_donations NUMBER;

    -- Counter for limiting printed events
    v_event_counter NUMBER := 0;

BEGIN
    -- Write header to the output
    DBMS_OUTPUT.PUT_LINE('Campaign and Its Related Events Report:');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

    -- Open the campaign cursor and fetch the specific campaign
    OPEN c_campaign;
    FETCH c_campaign INTO v_campaign_record;
    IF c_campaign%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No campaign found with the given ID.');
        CLOSE c_campaign;
        RETURN;
    END IF;
    
    -- Assign campaign data to variables
    v_campaign_data.CampaignName := v_campaign_record.CampaignName;
    v_campaign_data.StartDate := v_campaign_record.StartDate;
    v_campaign_data.EndDate := v_campaign_record.EndDate;

    -- Write campaign details to the output
    DBMS_OUTPUT.PUT_LINE('Campaign Name: ' || v_campaign_data.CampaignName);
    DBMS_OUTPUT.PUT_LINE('Start Date: ' || v_campaign_data.StartDate);
    DBMS_OUTPUT.PUT_LINE('End Date: ' || v_campaign_data.EndDate);

    -- Open events cursor for the current campaign and loop through each event
    OPEN c_events(p_CampaignID);
    v_event_counter := 0; -- Reset the event counter for each campaign
    LOOP
        FETCH c_events INTO v_events_record;
        EXIT WHEN c_events%NOTFOUND OR v_event_counter >= 10; -- Limit to 10 events
        
        -- Retrieve and calculate event data using previously defined functions
        v_sum_of_donors := SumOfDonorsForEvent(v_events_record.EventID);
        v_sum_of_donors_more_than_one_dollar := SumOfDonorsMoreThanOneHDollar(v_events_record.EventID);
        v_sum_of_total_donations := SumOfTotalDonationsForEvent(v_events_record.EventID);
        
        -- Assign event data to variables
        v_event_data.EventDate := v_events_record.EventDate;
        v_event_data.SumOfDonors := v_sum_of_donors;
        v_event_data.SumOfDonorsMoreThanOneDollar := v_sum_of_donors_more_than_one_dollar;
        v_event_data.SumOfTotalDonations := v_sum_of_total_donations;
      
        -- Write event details to the output
        DBMS_OUTPUT.PUT_LINE('    Event Date: ' || v_event_data.EventDate);
        DBMS_OUTPUT.PUT_LINE('    Sum of Donors: ' || v_event_data.SumOfDonors);
        DBMS_OUTPUT.PUT_LINE('    Sum of Donors (>$1): ' || v_event_data.SumOfDonorsMoreThanOneDollar);
        DBMS_OUTPUT.PUT_LINE('    Sum of Total Donations: ' || v_event_data.SumOfTotalDonations);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

        -- Increment the event counter
        v_event_counter := v_event_counter + 1;
    END LOOP;
    CLOSE c_events;  -- Close events cursor after looping through all events for the campaign
    
    CLOSE c_campaign;  -- Close campaign cursor
EXCEPTION
    -- Exception handling: print error message if any error occurs
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END GenCampaignEventsReport;
/
