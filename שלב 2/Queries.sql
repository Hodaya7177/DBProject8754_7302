---SELECT1:

WITH campaign_donations AS (
    SELECT 
        c.campaignid,
        c.campaignname,
        d.donorid,
        SUM(d.amount) AS total_donations
    FROM System.CAMPAIGN c
    JOIN System.DONATION d ON c.campaignid = d.campaignid
    GROUP BY c.campaignid, c.campaignname, d.donorid
),
top_donors AS (
    SELECT 
        cd.campaignid,
        cd.campaignname,
        cd.donorid,
        cd.total_donations,
        ROW_NUMBER() OVER (PARTITION BY cd.campaignid ORDER BY cd.total_donations DESC) AS rn
    FROM System.campaign_donations cd
)
SELECT 
    t.campaignname,
    SUM(t.total_donations) AS total_donations,
    (SELECT p.firstname || ' ' || p.lastname
     FROM top_donors td
     JOIN System.DONOR dn ON td.donorid = dn.personid
     JOIN System.PERSON p ON dn.personid = p.personid
     WHERE td.campaignid = t.campaignid AND td.rn = 1
    ) AS top_donor
FROM top_donors t
GROUP BY t.campaignname, t.campaignid
ORDER BY total_donations DESC;

---SELECT2:

WITH employee_events AS (
    SELECT 
        emp.personid,
        COUNT(w.eventid) AS events_worked_on
    FROM System.Employee emp
    JOIN System.WorksOn w ON emp.personid = w.employeeid
    GROUP BY emp.personid
),
employee_details AS (
    SELECT 
        ee.personid,
        ee.events_worked_on,
        p.firstname || ' ' || p.lastname AS employee_name
    FROM employee_events ee
    JOIN System.Person p ON ee.personid = p.personid
)
SELECT 
    employee_name,
    events_worked_on
FROM employee_details
ORDER BY events_worked_on DESC;

---SELECT3:

WITH employee_donations AS (
    SELECT 
        e.PersonID,
        e.FirstName || ' ' || e.LastName AS EmployeeName,
        SUM(d.Amount) AS TotalDonations
    FROM 
        System.Person e
    JOIN 
        System.Employee emp ON e.PersonID = emp.PersonID
    JOIN 
        System.WorksOn w ON emp.PersonID = w.EmployeeID
    JOIN 
        System.Event ev ON w.EventID = ev.EventID
    JOIN 
        System.Donation d ON ev.CampaignID = d.CampaignID
    GROUP BY 
        e.PersonID, e.FirstName, e.LastName
)
SELECT 
    EmployeeName,
    TotalDonations
FROM 
    employee_donations
ORDER BY 
    TotalDonations DESC;

---SELECT4:

SELECT 
    p.FirstName || ' ' || p.LastName AS EmployeeName,
    ed.Month,
    ed.EventsWorkedOn,
    ed.LastEventDate
FROM 
    System.Person p
JOIN (
    SELECT 
        e.PersonID,
        TO_CHAR(ev.EventDate, 'YYYY-MM') AS Month,
        COUNT(w.EventID) AS EventsWorkedOn,
        MAX(ev.EventDate) AS LastEventDate
    FROM 
        System.Employee e
    JOIN 
        System.WorksOn w ON e.PersonID = w.EmployeeID
    JOIN 
        System.Event ev ON w.EventID = ev.EventID
    WHERE 
        ev.EventDate BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD')
    GROUP BY 
        e.PersonID, TO_CHAR(ev.EventDate, 'YYYY-MM')
) ed ON p.PersonID = ed.PersonID
ORDER BY 
    ed.Month ASC, ed.EventsWorkedOn DESC;



---UPDATE1:

UPDATE System.Campaign
SET DonationGoal = DonationGoal + 4000
WHERE CampaignID IN (
    SELECT CampaignID
    FROM System.Donation
    WHERE (EXTRACT(YEAR FROM DonationDate)) = 2023
    GROUP BY CampaignID
    HAVING SUM(Amount) > 10000
);


---UPDATE2:

UPDATE System.Employee
SET HourlyWage = HourlyWage + 5 
WHERE PersonID IN (
    SELECT e.PersonID
    FROM System.Employee e
    JOIN System.Donation d ON e.PersonID = d.DonorID
    WHERE e.Seniority > 2
    GROUP BY e.PersonID
    HAVING SUM(d.Amount) > 1000
);

---DELETE1:

DELETE FROM System.Participates
WHERE DonorID IN (
    SELECT dn.PersonID
    FROM System.Donor dn
    LEFT JOIN System.Donation d ON dn.PersonID = d.DonorID
    GROUP BY dn.PersonID
    HAVING MAX(d.DonationDate) < ADD_MONTHS(SYSDATE, -24)
    OR MAX(d.DonationDate) IS NULL
);


DELETE FROM System.Donation
WHERE DonorID IN (
    SELECT dn.PersonID
    FROM System.Donor dn
    LEFT JOIN System.Donation d ON dn.PersonID = d.DonorID
    GROUP BY dn.PersonID
    HAVING MAX(d.DonationDate) < ADD_MONTHS(SYSDATE, -24)
    OR MAX(d.DonationDate) IS NULL
);

DELETE FROM System.Donor
WHERE PersonID IN (
    SELECT dn.PersonID
    FROM System.Donor dn
    LEFT JOIN System.Donation d ON dn.PersonID = d.DonorID
    GROUP BY dn.PersonID
    HAVING MAX(d.DonationDate) < ADD_MONTHS(SYSDATE, -24)
    OR MAX(d.DonationDate) IS NULL
);

---DELETE2:

DELETE FROM System.Employee
WHERE PersonID IN (
    SELECT e.PersonID
    FROM System.Employee e
    LEFT JOIN System.WorksOn w ON e.PersonID = w.EmployeeID
    WHERE e.seniority < 3
    GROUP BY e.PersonID
    HAVING COUNT(w.EventID) = 0
);



