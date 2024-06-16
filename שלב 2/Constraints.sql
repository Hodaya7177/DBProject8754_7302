---CONSTRAINT1:

ALTER TABLE System.Donation
ADD CONSTRAINT chk_donation_amount CHECK (Amount > 0)
ADD CONSTRAINT chk_num_of_payments CHECK (NumOfPayments >= 1);



insert into System.DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (3611, 11,0, to_date('27-04-2024', 'dd-mm-yyyy'), 'Credit Card', 2, 792224434);

---CONSTRAINT2:

ALTER TABLE System.Person
ADD CONSTRAINT uniq_email UNIQUE (Email);

select email from System.Person;


insert into System.PERSON (personid, firstname, address, email, phonenumber, lastname)
values (211884325, ' Avi', '12 Harakefet Tel Aviv', 'a.jonze@avr.com', '050-1334567', 'Cohen');

---CONSTRAINT3:
ALTER TABLE System.Donation
MODIFY PaymentMethod DEFAULT 'Cash';

insert into System.DONATION (donationid, numofpayments, amount, donationdate, campaignid, donorid)
values (400, 10,800, to_date('18-01-2022', 'dd-mm-yyyy'), 3, 191553388);

SELECT DonationID, PaymentMethod
FROM System.Donation
WHERE DonationID = 400;
