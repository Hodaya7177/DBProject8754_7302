CREATE VIEW DonorCampaignView AS
SELECT p.PersonID, p.FirstName, p.LastName, d.RegistrationDate, c.CampaignID, c.CampaignName, c.DonationGoal
FROM Donor d
JOIN Person p ON d.PersonID = p.PersonID
JOIN Donation dn ON d.PersonID = dn.DonorID
JOIN Campaign c ON dn.CampaignID = c.CampaignID;



--שאילתא1
SELECT
    dc.PersonID,
    dc.FirstName,
    dc.LastName,
    dc.RegistrationDate,
    dc.CampaignID,
    dc.CampaignName,
    dc.DonationGoal,
    SUM(dn.Amount) AS TotalDonationAmount
FROM
    DonorCampaignView dc
JOIN
    Donation dn ON dc.PersonID = dn.DonorID AND dc.CampaignID = dn.CampaignID
GROUP BY
    dc.PersonID,
    dc.FirstName,
    dc.LastName,
    dc.RegistrationDate,
    dc.CampaignID,
    dc.CampaignName,
    dc.DonationGoal
ORDER BY
    TotalDonationAmount DESC;


--שאילתא2
SELECT
    dc.PersonID,
    dc.FirstName,
    dc.LastName,
    dc.RegistrationDate,
    dc.CampaignID,
    dc.CampaignName,
    dc.DonationGoal,
    SUM(dn.Amount) AS TotalDonationAmount
FROM
    DonorCampaignView dc
JOIN
    Donation dn ON dc.PersonID = dn.DonorID AND dc.CampaignID = dn.CampaignID
GROUP BY
    dc.PersonID,
    dc.FirstName,
    dc.LastName,
    dc.RegistrationDate,
    dc.CampaignID,
    dc.CampaignName,
    dc.DonationGoal
ORDER BY
    TotalDonationAmount DESC;

--view2
CREATE VIEW TreePlantingView AS
SELECT tp.Planting_ID, tp.Start_Date, tp.End_Date, tp.Forest_ID, tp.Amount_Of_Trees, f.Forest_Name, f.Location, f.Area
FROM TreePlantingProjects tp
JOIN Forests f ON tp.Forest_ID = f.Forest_ID;


--שאילתא3
SELECT
    tp.Planting_ID,
    tp.Start_Date,
    tp.End_Date,
    tp.Forest_ID,
    f.Forest_Name,
    SUM(tp.Amount_Of_Trees) AS TotalTreesPlanted
FROM
    TreePlantingView tp
JOIN
    Forests f ON tp.Forest_ID = f.Forest_ID
GROUP BY
    tp.Planting_ID,
    tp.Start_Date,
    tp.End_Date,
    tp.Forest_ID,
    f.Forest_Name
ORDER BY
    Tot

--שאילתא4
SELECT
    tp.Planting_ID,
    f.Forest_Name,
    AVG(tp.Amount_Of_Trees) AS AverageTreesPlanted,
    SUM(f.Area) AS TotalForestArea
FROM
    TreePlantingView tp
JOIN
    Forests f ON tp.Forest_ID = f.Forest_ID
GROUP BY
    tp.Planting_ID,
    f.Forest_Name
HAVING
    AVG(tp.Amount_Of_Trees) > 100 -- Projects with an average of more than 100 trees planted
ORDER BY
    AverageTreesPlanted DESC;
