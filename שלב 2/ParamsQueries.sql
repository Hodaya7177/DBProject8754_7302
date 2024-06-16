---Query1:

SELECT 
    p.PersonID, 
    p.FirstName, 
    p.LastName, 
    SUM(dn.Amount) AS TotalDonation
FROM 
    System.Person p
JOIN 
    System.Donor d ON p.PersonID = d.PersonID
JOIN 
    System.Donation dn ON d.PersonID = dn.DonorID
WHERE 
    dn.DonationDate BETWEEN TO_DATE(&<name="Start Date" hint="Enter the start date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD') 
    AND TO_DATE(&<name="End Date" hint="Enter the end date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
GROUP BY 
    p.PersonID, p.FirstName, p.LastName
HAVING 
    SUM(dn.Amount) > &<name="Minimum Amount" hint="Enter the minimum amount for donations" type="integer">
ORDER BY 
    TotalDonation DESC;
    
    
---Query2:    

SELECT 
    c.CampaignID, 
    c.CampaignName, 
    c.DonationGoal, 
    SUM(dn.Amount) AS TotalDonation
FROM 
     System.Campaign c
JOIN 
     System.Donation dn ON c.CampaignID = dn.CampaignID
GROUP BY 
    c.CampaignID, c.CampaignName, c.DonationGoal
HAVING 
    SUM(dn.Amount) >= &<name="Donation Amount" hint="Enter the minimum total donation amount" type="integer">
ORDER BY 
    TotalDonation DESC;

---Query3:

SELECT 
    p.PersonID, 
    p.FirstName, 
    p.LastName, 
    e.Position, 
    e.Seniority
FROM 
     System.Person p
JOIN 
     System.Employee e ON p.PersonID = e.PersonID
WHERE 
    e.Position = '&<name="Employee Position" list="select DISTINCT Position from System.Employee order by Position">'
    AND e.Seniority >= '&<name="Seniority" type="integer">'
ORDER BY 
    e.Seniority DESC;

---Query4:

SELECT
    p.PersonID,
    p.FirstName || ' ' || p.lastName as DonorName,
    dn.RegistrationDate
FROM
    System.Person p
JOIN
    System.Donor dn ON p.Personid = dn.personid
WHERE
    dn.registrationdate > TO_DATE(&<name="Start Date" hint="Enter the start date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
ORDER BY 
    dn.registrationdate DESC
