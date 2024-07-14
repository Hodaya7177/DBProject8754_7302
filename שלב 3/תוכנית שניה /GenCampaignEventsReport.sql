CREATE OR REPLACE PROCEDURE GenCampaignEventsReport IS
    -- Cursor to fetch all campaigns
    CURSOR c_campaigns IS
        SELECT CampaignID, CampaignName, StartDate, EndDate
        FROM Campaign;
        
    -- Cursor to fetch events for a specific campaign
    CURSOR c_events(p_CampaignID NUMBER) IS
        SELECT EventID, EventDate
        FROM Event
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
    v_campaigns_record c_campaigns%ROWTYPE;
    v_events_record c_events%ROWTYPE;

    v_event_data t_event_record;
    v_campaign_data t_campaign_record;

    v_sum_of_donors NUMBER;
    DonorsMoreThanOneHDollar NUMBER;
    v_sum_of_total_donations NUMBER;
    
    -- Variables for file handling
    v_file UTL_FILE.FILE_TYPE;
    v_dir VARCHAR2(30) := 'REPORT_DIR'; -- Directory object name
    v_filename VARCHAR2(50) := 'campaign_events_report.txt';

BEGIN
    -- Open the file for writing
    v_file := UTL_FILE.FOPEN(v_dir, v_filename, 'w');

    -- Write header to the file
    UTL_FILE.PUT_LINE(v_file, 'Campaigns and Their Related Events Report:');
    UTL_FILE.PUT_LINE(v_file, '-------------------------------------------');

    -- Open the campaigns cursor and loop through each campaign
    OPEN c_campaigns;
    LOOP
        FETCH c_campaigns INTO v_campaigns_record;
        EXIT WHEN c_campaigns%NOTFOUND;
        
        -- Assign campaign data to variables
        v_campaign_data.CampaignName := v_campaigns_record.CampaignName;
        v_campaign_data.StartDate := v_campaigns_record.StartDate;
        v_campaign_data.EndDate := v_campaigns_record.EndDate;

        -- Write campaign details to the file
        UTL_FILE.PUT_LINE(v_file, 'Campaign Name: ' || v_campaign_data.CampaignName);
        UTL_FILE.PUT_LINE(v_file, 'Start Date: ' || v_campaign_data.StartDate);
        UTL_FILE.PUT_LINE(v_file, 'End Date: ' || v_campaign_data.EndDate);

        -- Open events cursor for the current campaign and loop through each event
        OPEN c_events(v_campaigns_record.CampaignID);
        LOOP
            FETCH c_events INTO v_events_record;
            EXIT WHEN c_events%NOTFOUND;
            
            -- Retrieve and calculate event data using previously defined functions
            v_sum_of_donors := SumOfDonorsForEvent(v_events_record.EventID);
            DonorsMoreThanOneHDollar := SumOfDonorsMoreThanOneHDollar(v_events_record.EventID);
            v_sum_of_total_donations := SumOfTotalDonationsForEvent(v_events_record.EventID);
            
            -- Assign event data to variables
            v_event_data.EventDate := v_events_record.EventDate;
            v_event_data.SumOfDonors := v_sum_of_donors;
            v_event_data.SumOfDonorsMoreThanOneDollar := DonorsMoreThanOneHDollar;
            v_event_data.SumOfTotalDonations := v_sum_of_total_donations;
          
            -- Write event details to the file
            UTL_FILE.PUT_LINE(v_file, '    Event Date: ' || v_event_data.EventDate);
            UTL_FILE.PUT_LINE(v_file, '    Sum of Donors: ' || v_event_data.SumOfDonors);
            UTL_FILE.PUT_LINE(v_file, '    Sum of Donors (>$1): ' || v_event_data.SumOfDonorsMoreThanOneDollar);
            UTL_FILE.PUT_LINE(v_file, '    Sum of Total Donations: ' || v_event_data.SumOfTotalDonations);
            UTL_FILE.PUT_LINE(v_file, '-------------------------------------------');
        END LOOP;
        CLOSE c_events;  -- Close events cursor after looping through all events for the campaign
    END LOOP;
    CLOSE c_campaigns;  -- Close campaigns cursor after looping through all campaigns

    -- Close the file
    UTL_FILE.FCLOSE(v_file);
EXCEPTION
    -- Exception handling: print error message if any error occurs
    WHEN OTHERS THEN
        -- If an error occurs, close the file if it is open
        IF UTL_FILE.IS_OPEN(v_file) THEN
            UTL_FILE.FCLOSE(v_file);
        END IF;
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END GenCampaignEventsReport;
