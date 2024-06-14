WITH campaign_donations AS (
    SELECT 
        c.campaignid,
        c.campaignname,
        d.donorid,
        SUM(d.amount) AS total_donations
    FROM CAMPAIGN c
    JOIN DONATION d ON c.campaignid = d.campaignid
    GROUP BY c.campaignid, c.campaignname, d.donorid
),
top_donors AS (
    SELECT 
        cd.campaignid,
        cd.campaignname,
        cd.donorid,
        cd.total_donations,
        ROW_NUMBER() OVER (PARTITION BY cd.campaignid ORDER BY cd.total_donations DESC) AS rn
    FROM campaign_donations cd
)
SELECT 
    t.campaignname,
    SUM(t.total_donations) AS total_donations,
    (SELECT p.firstname || ' ' || p.lastname
     FROM top_donors td
     JOIN DONOR dn ON td.donorid = dn.personid
     JOIN PERSON p ON dn.personid = p.personid
     WHERE td.campaignid = t.campaignid AND td.rn = 1
    ) AS top_donor
FROM top_donors t
GROUP BY t.campaignname, t.campaignid
ORDER BY total_donations DESC;
