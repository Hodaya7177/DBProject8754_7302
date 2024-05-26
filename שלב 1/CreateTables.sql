CREATE TABLE Person
(
  PersonID NUMERIC(9) NOT NULL,
  FirstName VARCHAR(10) NOT NULL,
  Address VARCHAR(30) NOT NULL,
  Email VARCHAR(25) NOT NULL,
  PhoneNumber VARCHAR(15) NOT NULL,
  LastName VARCHAR(10) NOT NULL,
  PRIMARY KEY (PersonID)
);

CREATE TABLE Campaign
(
  CampaignID NUMERIC(5) NOT NULL,
  DonationGoal VARCHAR(25) NOT NULL,
  CampaignName VARCHAR(25) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  PRIMARY KEY (CampaignID)
);

CREATE TABLE Event
(
  EventID NUMERIC(5) NOT NULL,
  EventDate DATE NOT NULL,
  Location VARCHAR(15) NOT NULL,
  CampaignID NUMERIC(5) NOT NULL,
  EventName VARCHAR(25) NOT NULL,
  EmployeeID NUMERIC(9) NOT NULL,
  DonorID_ NUMERIC(9) NOT NULL,
  PRIMARY KEY (EventID),
  FOREIGN KEY (CampaignID) REFERENCES Campaign(CampaignID)
);

CREATE TABLE Donor
(
  RegistrationDate DATE NOT NULL,
  EventID NUMERIC(5) NOT NULL,
  PersonID NUMERIC(9) NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Employee
(
  HourlyWage FLOAT NOT NULL,
  Seniority INT NOT NULL,
  WorkHours INT NOT NULL,
  Position VARCHAR(20) NOT NULL,
  EventID NUMERIC(5) NOT NULL,
  PersonID NUMERIC(9) NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Participates
(
  DonorID NUMERIC(9) NOT NULL,
  EventID NUMERIC(5) NOT NULL,
  PRIMARY KEY (DonorID, EventID),
  FOREIGN KEY (DonorID) REFERENCES Donor(PersonID),
  FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

CREATE TABLE WorksOn
(
  EventID NUMERIC(5) NOT NULL,
  EmployeeID NUMERIC(9) NOT NULL,
  PRIMARY KEY (EventID, EmployeeID),
  FOREIGN KEY (EventID) REFERENCES Event(EventID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(PersonID)
);

CREATE TABLE Donation
(
  DonationID NUMERIC(5) NOT NULL,
  NumOfPayments INT NOT NULL,
  Amount FLOAT NOT NULL,
  DonationDate DATE NOT NULL,
  PaymentMethod VARCHAR(10) NOT NULL,
  CampaignID NUMERIC(5) NOT NULL,
  DonorID NUMERIC(9) NOT NULL,
  PRIMARY KEY (DonationID),
  FOREIGN KEY (DonorID) REFERENCES Donor(PersonID),
  FOREIGN KEY (CampaignID) REFERENCES Campaign(CampaignID)
);

    
