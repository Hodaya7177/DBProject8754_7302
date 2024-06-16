prompt PL/SQL Developer import file
prompt Created on יום ראשון 16 יוני 2024 by Hodaya
set feedback off
set define off
prompt Creating CAMPAIGN...
create table CAMPAIGN
(
  campaignid   NUMBER(5) not null,
  campaignname VARCHAR2(25) not null,
  startdate    DATE not null,
  enddate      DATE not null,
  donationgoal INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CAMPAIGN
  add primary key (CAMPAIGNID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, update, delete, alter on CAMPAIGN to HODAYA11;

prompt Creating PERSON...
create table PERSON
(
  personid    NUMBER(9) not null,
  firstname   VARCHAR2(10) not null,
  address     VARCHAR2(30) not null,
  email       VARCHAR2(25) not null,
  phonenumber VARCHAR2(15) not null,
  lastname    VARCHAR2(10) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PERSON
  add primary key (PERSONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PERSON
  add constraint UNIQ_EMAIL unique (EMAIL)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, update, delete, alter on PERSON to HODAYA11;

prompt Creating DONOR...
create table DONOR
(
  registrationdate DATE,
  eventid          NUMBER(5) not null,
  personid         NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DONOR
  add primary key (PERSONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DONOR
  add foreign key (PERSONID)
  references PERSON (PERSONID);
alter table DONOR
  add constraint CHK_REGISTRATIONDATE_NOT_NULL
  check (RegistrationDate IS NOT NULL);
grant select, update, delete, alter on DONOR to HODAYA11;

prompt Creating DONATION...
create table DONATION
(
  donationid    NUMBER(5) not null,
  numofpayments INTEGER not null,
  amount        FLOAT not null,
  donationdate  DATE not null,
  paymentmethod VARCHAR2(20) default 'Cash' not null,
  campaignid    NUMBER(5) not null,
  donorid       NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DONATION
  add primary key (DONATIONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DONATION
  add foreign key (DONORID)
  references DONOR (PERSONID);
alter table DONATION
  add foreign key (CAMPAIGNID)
  references CAMPAIGN (CAMPAIGNID);
alter table DONATION
  add constraint CHK_DONATION_AMOUNT
  check (Amount > 0);
alter table DONATION
  add constraint CHK_NUM_OF_PAYMENTS
  check (NumOfPayments >= 1);
grant select, update, delete, alter on DONATION to HODAYA11;

prompt Creating EMPLOYEE...
create table EMPLOYEE
(
  hourlywage FLOAT not null,
  seniority  INTEGER not null,
  workhours  INTEGER not null,
  position   VARCHAR2(20) not null,
  eventid    NUMBER(5) not null,
  personid   NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEE
  add primary key (PERSONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEE
  add foreign key (PERSONID)
  references PERSON (PERSONID);
grant select, update, delete, alter on EMPLOYEE to HODAYA11;

prompt Creating EVENT...
create table EVENT
(
  eventid       NUMBER(5) not null,
  eventdate     DATE,
  eventlocation VARCHAR2(15) not null,
  campaignid    NUMBER(5) not null,
  employeeid    NUMBER(9) not null,
  donorid_      NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EVENT
  add primary key (EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EVENT
  add foreign key (CAMPAIGNID)
  references CAMPAIGN (CAMPAIGNID);
alter table EVENT
  add constraint CHK_EVENT_DATE_NOT_NULL
  check (EventDate IS NOT NULL);
grant select, update, delete, alter on EVENT to HODAYA11;

prompt Creating PARTICIPATES...
create table PARTICIPATES
(
  donorid NUMBER(9) not null,
  eventid NUMBER(5) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATES
  add primary key (DONORID, EVENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATES
  add foreign key (DONORID)
  references DONOR (PERSONID);
alter table PARTICIPATES
  add foreign key (EVENTID)
  references EVENT (EVENTID);
grant select, update, delete, alter on PARTICIPATES to HODAYA11;

prompt Creating WORKSON...
create table WORKSON
(
  eventid    NUMBER(5) not null,
  employeeid NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORKSON
  add primary key (EVENTID, EMPLOYEEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORKSON
  add foreign key (EVENTID)
  references EVENT (EVENTID);
alter table WORKSON
  add foreign key (EMPLOYEEID)
  references EMPLOYEE (PERSONID);
grant select, update, delete, alter on WORKSON to HODAYA11;

prompt Disabling triggers for CAMPAIGN...
alter table CAMPAIGN disable all triggers;
prompt Disabling triggers for PERSON...
alter table PERSON disable all triggers;
prompt Disabling triggers for DONOR...
alter table DONOR disable all triggers;
prompt Disabling triggers for DONATION...
alter table DONATION disable all triggers;
prompt Disabling triggers for EMPLOYEE...
alter table EMPLOYEE disable all triggers;
prompt Disabling triggers for EVENT...
alter table EVENT disable all triggers;
prompt Disabling triggers for PARTICIPATES...
alter table PARTICIPATES disable all triggers;
prompt Disabling triggers for WORKSON...
alter table WORKSON disable all triggers;
prompt Disabling foreign key constraints for DONOR...
alter table DONOR disable constraint SYS_C007412;
prompt Disabling foreign key constraints for DONATION...
alter table DONATION disable constraint SYS_C007421;
alter table DONATION disable constraint SYS_C007422;
prompt Disabling foreign key constraints for EMPLOYEE...
alter table EMPLOYEE disable constraint SYS_C007430;
prompt Disabling foreign key constraints for EVENT...
alter table EVENT disable constraint SYS_C007438;
prompt Disabling foreign key constraints for PARTICIPATES...
alter table PARTICIPATES disable constraint SYS_C007442;
alter table PARTICIPATES disable constraint SYS_C007443;
prompt Disabling foreign key constraints for WORKSON...
alter table WORKSON disable constraint SYS_C007447;
alter table WORKSON disable constraint SYS_C007448;
prompt Deleting WORKSON...
delete from WORKSON;
commit;
prompt Deleting PARTICIPATES...
delete from PARTICIPATES;
commit;
prompt Deleting EVENT...
delete from EVENT;
commit;
prompt Deleting EMPLOYEE...
delete from EMPLOYEE;
commit;
prompt Deleting DONATION...
delete from DONATION;
commit;
prompt Deleting DONOR...
delete from DONOR;
commit;
prompt Deleting PERSON...
delete from PERSON;
commit;
prompt Deleting CAMPAIGN...
delete from CAMPAIGN;
commit;
prompt Loading CAMPAIGN...
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (1, 'Forest Restoration', to_date('28-12-2023', 'dd-mm-yyyy'), to_date('30-04-2024', 'dd-mm-yyyy'), 88463);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (2, ' Water Conservation', to_date('22-07-2023', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 111766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (3, ' Green Tourism', to_date('19-08-2023', 'dd-mm-yyyy'), to_date('10-10-2023', 'dd-mm-yyyy'), 105856);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (4, ' Community Development', to_date('01-09-2023', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 130355);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (5, ' Heritage Preservation', to_date('03-11-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 119235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (6, ' Environmental Education', to_date('14-09-2023', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 129346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (7, ' Land Reclamation', to_date('19-11-2023', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 127836);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (8, ' Afforestation', to_date('05-10-2023', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 142567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (9, ' Renewable Energy', to_date('15-07-2023', 'dd-mm-yyyy'), to_date('09-01-2024', 'dd-mm-yyyy'), 106456);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (10, ' Agricultural Innovation', to_date('12-09-2023', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 113674);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (11, ' Urban Forestry', to_date('18-07-2023', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 123457);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (12, ' Wildlife Protection', to_date('29-08-2023', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 98765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (14, ' Research and Development', to_date('15-08-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 112346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (15, ' Eco-Friendly Projects', to_date('03-10-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 124568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (16, ' River Rehabilitation', to_date('06-11-2023', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (17, ' Forest Fire Prevention', to_date('11-08-2023', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 119875);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (18, ' Desert Agriculture', to_date('20-09-2023', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 122457);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (19, ' Soil Conservation', to_date('25-07-2023', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 111988);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (20, ' Youth Engagement', to_date('07-10-2023', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 101235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (21, ' Eco Tourism', to_date('14-09-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 133456);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (22, ' Public Awareness', to_date('22-08-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 112357);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (23, ' River Cleanup', to_date('28-09-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 123457);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (24, ' Forest Management', to_date('21-10-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (25, ' Bird Conservation', to_date('10-07-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 114568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (26, ' Eco Parks', to_date('03-09-2023', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (27, ' Botanical Gardens', to_date('17-08-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 106789);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (28, ' Desert Rehabilitation', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 110235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (29, ' Forest Pathways', to_date('22-09-2023', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 115679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (30, ' Clean Water Projects', to_date('02-10-2023', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (31, ' Agroforestry', to_date('11-11-2023', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (32, ' Forest Research', to_date('01-12-2023', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (33, ' Eco Initiatives', to_date('23-08-2023', 'dd-mm-yyyy'), to_date('09-12-2023', 'dd-mm-yyyy'), 133456);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (34, ' Park Development', to_date('29-09-2023', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 109877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (35, ' Soil Health', to_date('16-10-2023', 'dd-mm-yyyy'), to_date('23-02-2024', 'dd-mm-yyyy'), 115678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (36, ' Sustainable Agriculture', to_date('30-08-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (37, ' Community Forests', to_date('18-09-2023', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 121235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (39, ' Water Security', to_date('08-09-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (40, ' Forest Biodiversity', to_date('28-10-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 134568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (41, ' Nature Trails', to_date('24-11-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 109876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (42, ' Climate Action', to_date('28-07-2023', 'dd-mm-yyyy'), to_date('10-12-2023', 'dd-mm-yyyy'), 117346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (43, ' Forest Festivals', to_date('24-09-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (45, ' Educational Outreach', to_date('04-11-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 104567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (46, ' Wildflower Conservation', to_date('12-07-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (47, ' Eco Volunteer Programs', to_date('17-10-2023', 'dd-mm-yyyy'), to_date('21-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (48, ' Urban Green Spaces', to_date('25-11-2023', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (49, ' Forest Stewardship', to_date('02-08-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 134567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (50, ' Tree Planting', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 112346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (51, ' Wetland Restoration', to_date('06-12-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (52, ' Green Energy', to_date('20-07-2023', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 133457);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (53, ' Eco Building Projects', to_date('25-10-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 115678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (54, ' Climate Resilience', to_date('16-08-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 109876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (55, ' Sustainable Water Use', to_date('08-11-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 123457);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (56, ' River Health', to_date('27-07-2023', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 112346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (57, ' Environmental Advocacy', to_date('06-10-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 121235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (58, ' Forest Trails', to_date('23-11-2023', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 134567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (59, ' Water Quality', to_date('05-09-2023', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (60, ' Eco Awareness', to_date('31-07-2023', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (61, ' Green Schools', to_date('21-09-2023', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (62, ' Land Protection', to_date('04-10-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (63, ' Forest Fire Recovery', to_date('16-11-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (64, ' Sustainable Living', to_date('24-08-2023', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 109876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (65, ' Wildlife Corridors', to_date('19-10-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 133456);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (66, ' Green Innovations', to_date('06-09-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 115678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (67, ' Community Gardens', to_date('13-11-2023', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (68, ' Clean Energy', to_date('10-08-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 110988);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (69, ' Ecotourism', to_date('11-09-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 123457);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (70, ' River Restoration', to_date('02-12-2023', 'dd-mm-yyyy'), to_date('15-03-2024', 'dd-mm-yyyy'), 121235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (71, ' Forest Rehabilitation', to_date('27-11-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (72, ' Wildlife Habitats', to_date('06-08-2023', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (73, ' Eco Communities', to_date('30-09-2023', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (74, ' Reforestation', to_date('29-07-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (75, ' Sustainable Projects', to_date('12-10-2023', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (76, ' Forest Preservation', to_date('26-07-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 102346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (77, ' Soil Enrichment', to_date('09-09-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (79, ' Heritage Sites', to_date('18-08-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (80, ' Eco Education', to_date('14-10-2023', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (81, ' Community Projects', to_date('13-09-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (82, ' Agroecology', to_date('09-11-2023', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 115678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (83, ' Environmental Protection', to_date('24-07-2023', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 134567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (84, ' Sustainable Ecosystems', to_date('11-08-2023', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (85, ' Green Restoration', to_date('15-09-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (86, ' Tree Conservation', to_date('17-10-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (87, ' Forest Health', to_date('04-11-2023', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 134567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (88, ' Eco Innovations', to_date('20-09-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (89, ' Green Communities', to_date('28-07-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (90, ' Renewable Resources', to_date('13-08-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 109877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (91, ' Forest Conservation', to_date('22-10-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 115679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (92, ' Sustainable Forests', to_date('14-11-2023', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 104567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (93, ' Clean Environment', to_date('26-08-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (94, ' Nature Conservation', to_date('02-09-2023', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 110987);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (95, ' Forest Ecosystems', to_date('07-12-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (96, ' Green Infrastructure', to_date('19-07-2023', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (97, ' Water Sustainability', to_date('21-09-2023', 'dd-mm-yyyy'), to_date('15-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (98, ' Ecological Restoration', to_date('16-08-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (99, ' Green Planning', to_date('24-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 134567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (100, ' Environmental Research', to_date('26-11-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (101, ' Clean Water', to_date('14-07-2023', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'), 104567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (102, ' Eco-Friendly Solutions', to_date('11-09-2023', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (103, ' Natural Resources', to_date('19-08-2023', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (104, ' Conservation Projects', to_date('16-10-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 125678);
commit;
prompt 100 records committed...
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (105, ' Community Forests', to_date('10-11-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (106, ' Green Initiatives', to_date('30-07-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (107, ' Renewable Energy', to_date('15-08-2023', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (108, ' Environmental Solutions', to_date('25-09-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 134567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (109, ' Forest and Wildlife', to_date('27-10-2023', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (110, ' Eco Preservation', to_date('17-11-2023', 'dd-mm-yyyy'), to_date('01-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (111, ' Urban Greening', to_date('25-07-2023', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (112, ' Environmental Management', to_date('22-09-2023', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (113, ' Forest Protection', to_date('05-08-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (114, ' Sustainable Practices', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 110988);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (115, ' Eco Development', to_date('05-11-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (116, ' Green Technologies', to_date('19-09-2023', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (118, ' Biodiversity Projects', to_date('30-10-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (119, ' Sustainable Solutions', to_date('27-07-2023', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (120, ' Green Energy', to_date('14-09-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (121, ' Environmental Awareness', to_date('21-08-2023', 'dd-mm-yyyy'), to_date('13-03-2024', 'dd-mm-yyyy'), 104567);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (122, ' Eco-Friendly Projects', to_date('23-10-2023', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (123, ' Forest Health', to_date('02-11-2023', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (124, ' Wildlife Conservation', to_date('16-07-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (125, ' Eco Tourism', to_date('10-09-2023', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (126, ' Sustainable Development', to_date('20-08-2023', 'dd-mm-yyyy'), to_date('15-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (127, ' Water Management', to_date('18-10-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (128, ' Conservation Efforts', to_date('12-11-2023', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (129, ' Green Initiatives', to_date('03-09-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (130, ' Forest Sustainability', to_date('24-08-2023', 'dd-mm-yyyy'), to_date('21-03-2024', 'dd-mm-yyyy'), 104568);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (131, ' Eco Innovations', to_date('17-09-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (132, ' Biodiversity Efforts', to_date('13-10-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (133, ' Natural Resources', to_date('20-11-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (134, ' Wildlife Protection', to_date('26-07-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (135, ' Forest Conservation', to_date('29-09-2023', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (137, ' Sustainable Agriculture', to_date('26-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (138, ' Green Solutions', to_date('29-11-2023', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (139, ' Community Engagement', to_date('13-07-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (140, ' Clean Energy Projects', to_date('06-09-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (141, ' Eco Conservation', to_date('14-08-2023', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (143, ' Green Technologies', to_date('07-11-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (144, ' Wildlife Initiatives', to_date('23-09-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (145, ' Sustainable Forests', to_date('31-08-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (146, ' Environmental Projects', to_date('04-10-2023', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (147, ' Green Projects', to_date('25-11-2023', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (148, ' Wildlife Projects', to_date('05-09-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (149, ' Eco Projects', to_date('17-07-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (150, ' Community Forests', to_date('20-09-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (151, ' Sustainable Resources', to_date('25-08-2023', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (152, ' Eco Restoration', to_date('03-10-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (153, ' Forest Restoration', to_date('01-11-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (155, ' Green Communities', to_date('27-08-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (156, ' Wildlife Preservation', to_date('18-10-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (157, ' Sustainable Ecosystems', to_date('05-11-2023', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (158, ' Forest Health', to_date('22-09-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (159, ' Environmental Awareness', to_date('11-08-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (160, ' Green Energy', to_date('08-10-2023', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (162, ' Eco-Friendly Solutions', to_date('30-09-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (163, ' Forest Protection', to_date('20-08-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (164, ' Environmental Education', to_date('17-09-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (165, ' Sustainable Living', to_date('02-11-2023', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (166, ' Green Technologies', to_date('31-08-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (167, ' Conservation Efforts', to_date('13-10-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (168, ' Wildlife Habitats', to_date('19-11-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (169, ' Eco Innovations', to_date('04-09-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (170, ' Forest Biodiversity', to_date('24-08-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (172, ' Green Planning', to_date('26-11-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (173, ' Sustainable Projects', to_date('15-09-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (174, ' Forest and Wildlife', to_date('15-08-2023', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (175, ' Eco-Friendly Projects', to_date('12-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (176, ' Community Engagement', to_date('08-11-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (177, ' Green Restoration', to_date('18-09-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (178, ' Wildlife Protection', to_date('30-08-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (180, ' Environmental Projects', to_date('14-11-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (181, ' Sustainable Ecosystems', to_date('25-09-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (182, ' Green Energy', to_date('28-08-2023', 'dd-mm-yyyy'), to_date('13-03-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (183, ' Biodiversity Projects', to_date('05-10-2023', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (184, ' Eco Conservation', to_date('27-11-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (185, ' Forest Sustainability', to_date('07-09-2023', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (186, ' Wildlife Initiatives', to_date('14-08-2023', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (187, ' Green Solutions', to_date('24-10-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (188, ' Community Forests', to_date('06-11-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (189, ' Sustainable Resources', to_date('10-09-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (190, ' Environmental Protection', to_date('16-08-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (191, ' Forest Ecosystems', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (192, ' Green Communities', to_date('13-11-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (193, ' Wildlife Conservation', to_date('29-09-2023', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (194, ' Environmental Awareness', to_date('22-08-2023', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (195, ' Sustainable Living', to_date('17-10-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (196, ' Green Projects', to_date('23-11-2023', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (197, ' Wildlife Preservation', to_date('28-09-2023', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (198, ' Forest Restoration', to_date('23-08-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (199, ' Eco-Friendly Solutions', to_date('14-10-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (200, ' Green Initiatives', to_date('18-11-2023', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (201, ' Sustainable Development', to_date('03-09-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (202, ' Forest Health', to_date('13-08-2023', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (203, ' Environmental Projects', to_date('23-10-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (204, ' Green Solutions', to_date('09-11-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (205, ' Wildlife Protection', to_date('19-09-2023', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (206, ' Eco-Friendly Projects', to_date('26-08-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (207, ' Sustainable Ecosystems', to_date('15-10-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (208, ' Green Planning', to_date('04-11-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (210, ' Forest and Wildlife', to_date('17-08-2023', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (211, ' Wildlife Projects', to_date('06-10-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (212, ' Environmental Awareness', to_date('16-11-2023', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 111234);
commit;
prompt 200 records committed...
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (213, ' Green Technologies', to_date('26-09-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (214, ' Sustainable Resources', to_date('15-08-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (215, ' Community Forests', to_date('10-10-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (216, ' Eco Conservation', to_date('22-11-2023', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (217, ' Wildlife Habitats', to_date('02-09-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (218, ' Environmental Projects', to_date('29-08-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (219, ' Green Solutions', to_date('20-10-2023', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (220, ' Forest Sustainability', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (221, ' Conservation Efforts', to_date('07-09-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (222, ' Wildlife Initiatives', to_date('18-08-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (223, ' Sustainable Ecosystems', to_date('09-10-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (224, ' Green Communities', to_date('29-11-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (226, ' Eco Innovations', to_date('28-09-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (227, ' Green Energy', to_date('19-08-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (228, ' Wildlife Conservation', to_date('01-10-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (229, ' Sustainable Development', to_date('17-11-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (230, ' Environmental Education', to_date('11-09-2023', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (231, ' Green Projects', to_date('27-08-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (232, ' Wildlife Initiatives', to_date('19-10-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (233, ' Forest Restoration', to_date('14-11-2023', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (234, ' Eco-Friendly Solutions', to_date('16-09-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (235, ' Environmental Projects', to_date('22-08-2023', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (236, ' Green Communities', to_date('25-10-2023', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (237, ' Sustainable Resources', to_date('06-11-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (238, ' Wildlife Protection', to_date('26-09-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (239, ' Environmental Awareness', to_date('21-08-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (240, ' Green Planning', to_date('14-10-2023', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (241, ' Conservation Efforts', to_date('16-11-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (242, ' Forest Ecosystems', to_date('14-09-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (243, ' Eco Conservation', to_date('30-08-2023', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (244, ' Sustainable Ecosystems', to_date('23-10-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (245, ' Wildlife Habitats', to_date('05-11-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (247, ' Green Energy', to_date('12-08-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (248, ' Community Forests', to_date('04-10-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (249, ' Eco-Friendly Projects', to_date('11-11-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (250, ' Wildlife Conservation', to_date('27-09-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (251, ' Green Initiatives', to_date('23-08-2023', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (252, ' Sustainable Resources', to_date('06-10-2023', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (253, ' Environmental Projects', to_date('25-11-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (254, ' Forest Health', to_date('09-09-2023', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (255, ' Eco Conservation', to_date('14-08-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (256, ' Green Solutions', to_date('16-10-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (257, ' Wildlife Initiatives', to_date('08-11-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (258, ' Sustainable Development', to_date('30-09-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (259, ' Environmental Awareness', to_date('29-08-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (260, ' Green Energy', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (261, ' Wildlife Protection', to_date('13-11-2023', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (262, ' Eco-Friendly Solutions', to_date('13-09-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (263, ' Forest Restoration', to_date('31-08-2023', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (265, ' Green Technologies', to_date('18-11-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (266, ' Wildlife Conservation', to_date('25-09-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (267, ' Sustainable Ecosystems', to_date('26-08-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (268, ' Eco Conservation', to_date('15-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (269, ' Green Initiatives', to_date('01-11-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (270, ' Wildlife Habitats', to_date('18-09-2023', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (271, ' Environmental Education', to_date('18-08-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (272, ' Forest Sustainability', to_date('28-10-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (273, ' Eco-Friendly Projects', to_date('24-11-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (274, ' Sustainable Resources', to_date('19-09-2023', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (275, ' Green Solutions', to_date('25-08-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (276, ' Environmental Projects', to_date('09-10-2023', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (277, ' Wildlife Conservation', to_date('20-11-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (278, ' Green Planning', to_date('05-09-2023', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (279, ' Sustainable Ecosystems', to_date('17-08-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (280, ' Eco Innovations', to_date('26-10-2023', 'dd-mm-yyyy'), to_date('13-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (281, ' Environmental Protection', to_date('12-11-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (282, ' Forest and Wildlife', to_date('07-09-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 111234);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (283, ' Green Energy', to_date('22-08-2023', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (284, ' Sustainable Development', to_date('18-10-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (285, ' Wildlife Projects', to_date('10-11-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (286, ' Environmental Awareness', to_date('11-09-2023', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (287, ' Green Communities', to_date('21-08-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (288, ' Forest Restoration', to_date('29-10-2023', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (289, ' Eco-Friendly Projects', to_date('28-11-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (290, ' Environmental Projects', to_date('14-09-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (291, ' Green Technologies', to_date('19-08-2023', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (292, ' Wildlife Conservation', to_date('03-10-2023', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (293, ' Sustainable Ecosystems', to_date('22-11-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (294, ' Green Initiatives', to_date('27-09-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (295, ' Forest Health', to_date('24-08-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (296, ' Environmental Protection', to_date('07-10-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 122345);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (297, ' Wildlife Projects', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (298, ' Green Solutions', to_date('29-09-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (299, ' Eco Innovations', to_date('29-08-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (300, ' Sustainable Development', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (301, ' Environmental Awareness', to_date('30-11-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (302, ' Green Communities', to_date('30-09-2023', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (303, ' Forest Restoration', to_date('31-08-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (304, ' Eco-Friendly Solutions', to_date('23-10-2023', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (305, ' Environmental Projects', to_date('17-11-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (306, ' Green Technologies', to_date('16-09-2023', 'dd-mm-yyyy'), to_date('14-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (307, ' Wildlife Conservation', to_date('26-08-2023', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (308, ' Sustainable Ecosystems', to_date('15-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (309, ' Eco Conservation', to_date('18-11-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 119876);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (310, ' Green Initiatives', to_date('08-09-2023', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (311, ' Forest Health', to_date('16-08-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (312, ' Environmental Protection', to_date('10-10-2023', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (313, ' Wildlife Projects', to_date('08-11-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (314, ' Green Solutions', to_date('04-09-2023', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 119877);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (315, ' Eco Innovations', to_date('28-08-2023', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 108766);
commit;
prompt 300 records committed...
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (316, ' Sustainable Development', to_date('22-10-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (317, ' Environmental Awareness', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (318, ' Green Communities', to_date('10-09-2023', 'dd-mm-yyyy'), to_date('09-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (319, ' Forest Restoration', to_date('12-08-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 108765);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (320, ' Eco-Friendly Solutions', to_date('16-10-2023', 'dd-mm-yyyy'), to_date('19-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (321, ' Environmental Projects', to_date('20-11-2023', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (322, ' Green Technologies', to_date('27-09-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (323, ' Wildlife Conservation', to_date('23-08-2023', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (324, ' Sustainable Ecosystems', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (325, ' Eco Conservation', to_date('07-11-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (326, ' Green Initiatives', to_date('03-09-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (327, ' Forest Health', to_date('15-08-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (328, ' Environmental Protection', to_date('27-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (329, ' Wildlife Projects', to_date('24-11-2023', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (330, ' Green Solutions', to_date('20-09-2023', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 125679);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (331, ' Eco Innovations', to_date('26-08-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (332, ' Sustainable Development', to_date('15-10-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (333, ' Environmental Awareness', to_date('08-11-2023', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (334, ' Green Communities', to_date('02-09-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (335, ' Forest Restoration', to_date('11-08-2023', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (336, ' Eco-Friendly Solutions', to_date('14-10-2023', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (337, ' Environmental Projects', to_date('17-11-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (338, ' Green Technologies', to_date('09-09-2023', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (339, ' Wildlife Conservation', to_date('22-08-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (340, ' Sustainable Ecosystems', to_date('30-10-2023', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (341, ' Eco Conservation', to_date('23-11-2023', 'dd-mm-yyyy'), to_date('23-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (342, ' Green Initiatives', to_date('29-09-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (343, ' Forest Health', to_date('24-08-2023', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (344, ' Environmental Protection', to_date('16-10-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (345, ' Wildlife Projects', to_date('12-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (346, ' Green Solutions', to_date('07-09-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (347, ' Eco Innovations', to_date('29-08-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (348, ' Sustainable Development', to_date('20-10-2023', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (349, ' Environmental Awareness', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (350, ' Green Communities', to_date('08-09-2023', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (351, ' Forest Restoration', to_date('13-08-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (352, ' Eco-Friendly Solutions', to_date('17-10-2023', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (353, ' Environmental Projects', to_date('20-11-2023', 'dd-mm-yyyy'), to_date('18-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (354, ' Green Technologies', to_date('02-09-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (355, ' Wildlife Conservation', to_date('25-08-2023', 'dd-mm-yyyy'), to_date('23-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (356, ' Sustainable Ecosystems', to_date('10-10-2023', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (357, ' Eco Conservation', to_date('18-11-2023', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (358, ' Green Initiatives', to_date('11-09-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (359, ' Forest Health', to_date('26-08-2023', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (360, ' Environmental Protection', to_date('21-10-2023', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (361, ' Wildlife Projects', to_date('09-11-2023', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (362, ' Green Solutions', to_date('03-09-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (363, ' Eco Innovations', to_date('30-08-2023', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (364, ' Sustainable Development', to_date('24-10-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (365, ' Environmental Awareness', to_date('17-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (366, ' Green Communities', to_date('04-09-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (367, ' Forest Restoration', to_date('14-08-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (368, ' Eco-Friendly Solutions', to_date('18-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (369, ' Environmental Projects', to_date('21-11-2023', 'dd-mm-yyyy'), to_date('23-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (370, ' Green Technologies', to_date('05-09-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (371, ' Wildlife Conservation', to_date('27-08-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (372, ' Sustainable Ecosystems', to_date('12-10-2023', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (373, ' Eco Conservation', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (374, ' Green Initiatives', to_date('07-09-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (375, ' Forest Health', to_date('20-08-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (376, ' Environmental Protection', to_date('25-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (377, ' Wildlife Projects', to_date('10-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (378, ' Green Solutions', to_date('10-09-2023', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (379, ' Eco Innovations', to_date('31-08-2023', 'dd-mm-yyyy'), to_date('23-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (380, ' Sustainable Development', to_date('28-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (381, ' Environmental Awareness', to_date('19-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (382, ' Green Communities', to_date('11-09-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (383, ' Forest Restoration', to_date('21-08-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (384, ' Eco-Friendly Solutions', to_date('29-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (385, ' Environmental Projects', to_date('22-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (386, ' Green Technologies', to_date('12-09-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (387, ' Wildlife Conservation', to_date('22-08-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (388, ' Sustainable Ecosystems', to_date('15-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (389, ' Eco Conservation', to_date('25-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (390, ' Green Initiatives', to_date('13-09-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (391, ' Forest Health', to_date('23-08-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (392, ' Environmental Protection', to_date('16-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (393, ' Wildlife Projects', to_date('12-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (394, ' Green Solutions', to_date('14-09-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (395, ' Eco Innovations', to_date('24-08-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (396, ' Sustainable Development', to_date('17-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (397, ' Environmental Awareness', to_date('15-11-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 111235);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (398, ' Green Communities', to_date('15-09-2023', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 125678);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (399, ' Forest Restoration', to_date('25-08-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 108766);
insert into CAMPAIGN (campaignid, campaignname, startdate, enddate, donationgoal)
values (400, ' Eco-Friendly Solutions', to_date('18-10-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 122346);
commit;
prompt 385 records loaded
prompt Loading PERSON...
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (211854325, ' David', '12 Herzel Tel Aviv', 'david.cohen@example.com', '050-1234567', 'Cohen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (233358964, 'Sarah', '34 Dizengof Tel Aviv', 'sarah.levy@example.com', '050-2345678', 'Levy');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (311245632, ' Michael', '56 Ben Yehuda Tel Aviv', 'michael.katz@example.com', '050-3456789', 'Katz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (155204698, ' Rachel', '78 Allenby Tel Aviv', 'rachel.green@example.com', '050-4567890', 'Green');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (57056412, 'Jonathan', '90 Rothschild Tel Aviv', 'jonathan.gold@example.com', '050-5678901', 'Gold');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (221854325, 'David', '8 Herzel Jerusalem', 'david88@example.com', '050-1998767', 'Shalom');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (252158964, 'Michal', '34 Rakefet Netanya', ' michal.levy@example.com', '050-2665678', 'Levy');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (322245632, ' Noam', '16 Ben Yehuda Tel Aviv', 'noam56@example.com', '050-9776541', 'Karni');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (155999698, ' Rachel', '8 Allenby Jerusalem', ' rachel99@example.com', '050-777890', 'Harel');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (99056412, 'Jonathan', '90 Rabi Akiva Bnei-Braq', 'jonathan33@example.com', '050-5699901', 'Harush');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (843267238, 'Martin', '34 Gloria RoadPompton Plains', 'martin.m@coridiantechnolo', '056-1436691', 'Marley');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (846699499, 'Jessica', '42nd StreetCampinas', 'jessica.coburn@qssgroup.b', '051-1298942', 'Coburn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (494343266, 'Ian', '33 Van DammeTulsa', 'ian@glmt.com', '052-6855173', 'Brody');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (823217557, 'Meg', '991 Redford RoadSolikamsk', 'meg.rauhofer@infovision.c', '056-4949238', 'Rauhofer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (278483766, 'Sean', '99 Julianna DriveSmyrna', 'seand@ogi.com', '051-6247126', 'Darren');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (444897653, 'Freddie', '71 Scaggs StreetRedwood Shores', 'freddie.statham@portageen', '053-4543742', 'Statham');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (936718518, 'Ruth', '58 Ahmad RoadSuwon', 'r.romijnstamos@visionarys', '058-6419637', 'Romijn-Sta');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (778227355, 'Vertical', '24 Matthau StreetBuffalo', 'vertical.rydell@creditors', '058-4374585', 'Rydell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (331196396, 'Tori', '53 Albright RoadDuluth', 'tori.koyana@dynacqinterna', '053-4348849', 'Koyana');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (459784952, 'Victor', '91 Fehr RoadAustin', 'victor.burke@wci.com', '057-8686382', 'Burke');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (467211543, 'Leonardo', '55 Raleigh RoadBelp', 'leonardo.chesnutt@anheuse', '056-1784722', 'Chesnutt');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (572851524, 'Merrilee', '73 Hackman RoadThalwil', 'merrilee.woodward@caliber', '059-7946672', 'Woodward');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (132478141, 'Clay', '371 Springfield AveSouthend on', 'clay.cotton@microtek.uk', '056-9239274', 'Cotton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (885851983, 'Denzel', '62 Lynne RoadBudapest', 'denzel.bullock@genghisgri', '058-5133781', 'Bullock');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (318142751, 'Kasey', '9 Culkin StreetLancaster', 'k.foster@kimberlyclark.co', '056-6771883', 'Foster');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (468381237, 'Machine', '54 Law StreetSaudarkrokur', 'machine.stiles@csi.is', '053-1423593', 'Stiles');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (496513286, 'Olympia', '790 Jeffery StreetNorthbrook', 'olympia@als.com', '053-4897618', 'Peniston');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (869793359, 'Daniel', '81 Aiken BlvdRavensburg', 'daniel.p@sfgo.de', '053-2341579', 'Paquin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (877145518, 'Ryan', '80 Kate DriveKobe', 'rkane@cowlitzbancorp.jp', '051-1494794', 'Kane');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (675926779, 'Tony', '27 Swoosie RoadBoston', 'tony.tennison@nbs.com', '053-5649994', 'Tennison');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (483533519, 'Liev', '12 Temuera RoadSanta Clarat', 'liev.penn@marathonheater.', '055-3897178', 'Penn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (975498366, 'Ricky', '20 Sara RoadHarsum', 'ricky.carlton@qls.de', '057-9688387', 'Carlton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (141999357, 'Spencer', '72 Holly StreetEbersberg', 'spencer.root@kitba.de', '050-8614392', 'Root');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (981395586, 'Aidan', '4 HaggardHorsham', 'aidan.murray@jlphor.com', '057-3621425', 'Murray');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (124796735, 'Maxine', '88 Gibbons StreetRueil-Malmais', 'maxine.kapanka@calence.fr', '050-9613392', 'Kapanka');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (792224434, 'Sander', '72 San Francisco StreetMaryvil', 'sander.taylor@kingland.co', '055-2499166', 'Taylor');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (211258385, 'Murray', '42nd StreetLyon', 'murraym@sfb.fr', '051-8598188', 'Marin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (779533258, 'Roger', '85 Moriarty RoadTualatin', 'rbean@noodles.com', '051-1564254', 'Bean');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (961795379, 'Willie', '36 Wilkinson DriveTualatin', 'w.foster@y2marketing.com', '057-6473737', 'Foster');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (492487594, 'Judi', '169 Aomori DriveWest Monroe', 'j.lucien@ipsadvisory.com', '058-9682987', 'Lucien');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (518895223, 'Jon', '31st StreetDouala', 'jon.guinness@signature.co', '057-3851972', 'Guinness');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (983574126, 'Hector', '17 Worrell RoadKreuzau', 'hector.h@ivci.de', '052-1732118', 'Hersh');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (818746397, 'Hank', '96 Sissy RoadBarcelona', 'hank@adolph.es', '057-9945997', 'Biehn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (393787716, 'Neil', '49 BenicioMacclesfield', 'neil.d@evinco.uk', '054-9454484', 'Doucette');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (244861741, 'Denny', '62 Dysart StreetPlymouth Meeti', 'denny.d@trafficmanagement', '056-1364557', 'Dreyfuss');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (338839244, 'Whoopi', '86 Crosby StreetCarlsbad', 'whoopib@sis.com', '054-3639849', 'Ball');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (612496723, 'Rachid', '70 Rip StreetRichmond', 'rachid.langella@waltdisne', '050-2892117', 'Langella');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (555738385, 'Desmond', '42 Elisabeth StreetSpringfield', 'desmond@tmt.au', '055-8942497', 'Benet');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (218493661, 'Murray', '60 Radney BlvdStone Mountain', 'murray@httprint.com', '051-5198364', 'Hatchet');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (625149514, 'Chant׳™', '6 Caviezel RoadPrinceton', 'chant.dillon@newmedia.com', '054-3965352', 'Dillon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (152897774, 'Blair', '72 Ruffalo RoadRosemead', 'bmccann@gillani.com', '058-9289855', 'McCann');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (399168515, 'Roddy', '70 Frank StreetPasadena', 'roddy.holliday@bioreferen', '053-9279931', 'Holliday');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (449335211, 'Allison', '21st StreetMaidenhead', 'allison.derringer@wendysi', '054-2499993', 'Derringer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (517931835, 'Mac', '60 Warrington AveAgoncillo', 'mac.clooney@datawarehouse', '053-4214881', 'Clooney');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (312578226, 'Rachid', '88 ArquetteErlangen', 'rachid@qls.de', '053-4381992', 'O''Donnell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (513328693, 'Bradley', '72 Paris RoadMurray', 'bradley.henriksen@hatworl', '058-9241414', 'Henriksen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (485277152, 'Gates', '82 Gray RoadBedford', 'gates.detmer@monarchcasin', '057-7223795', 'Detmer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (569586425, 'Kathleen', '54 Singletary RoadDerwood', 'kmadsen@portosan.com', '059-3839969', 'Madsen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (199635825, 'Geggy', '30 Graz DriveMatsue', 'geggyp@atlanticnet.jp', '058-2736337', 'Pony');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (856431755, 'Rhea', '1 Costa DriveReisterstown', 'r.quatro@execuscribe.com', '058-4631622', 'Quatro');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (698333646, 'Franz', '324 Rowlands RoadTottori', 'franz.berenger@inspiratio', '055-5936731', 'Berenger');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (473536133, 'Debby', '42nd StreetSao jose rio preto', 'debby.harrelson@ksj.br', '054-7879732', 'Harrelson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (612312412, 'Liquid', '89 Parish RoadBlue bell', 'liquid.a@dvdt.com', '053-4476941', 'Aglukark');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (124736796, 'Mykelti', '846 Monterrey DrivePomona', 'm.gyllenhaal@diamondtechn', '058-2598553', 'Gyllenhaal');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (972543625, 'Lloyd', '49 Zagreb RoadRocklin', 'lloyd.matthau@vms.com', '051-2898268', 'Matthau');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (612456769, 'Roddy', '576 Diehl StreetRedwood City', 'r.furtado@spotfireholding', '051-7388549', 'Furtado');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (495275382, 'Emmylou', '89 RapaportFrankfurt', 'emmylou.dempsey@trafficma', '059-5759527', 'Dempsey');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (799461997, 'Charlize', '18 Sisto DriveFlushing', 'charlize.bullock@componen', '057-6618671', 'Bullock');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (224755992, 'Nicole', '42 Joaquim RoadFremont', 'nicole.cromwell@ivci.com', '055-6926469', 'Cromwell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (968441868, 'Tom', '25 Murray DriveEast Peoria', 'tom.osment@nsd.com', '054-1432234', 'Osment');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (342235525, 'Lloyd', '44 Colin Young RoadRuncorn', 'lloyd.flanery@hcoa.uk', '054-2217112', 'Flanery');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (219432622, 'Carl', '280 RioSaint Paul', 'cdickinson@creditorsinter', '057-7351395', 'Dickinson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (792815389, 'Rutger', '87 von Sydow RoadHartford', 'rutger.milsap@providentba', '052-6755611', 'Milsap');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (534861298, 'Jena', '69 Matthau StreetCoslada', 'jena.m@interfacesoftware.', '052-6752962', 'McDonnell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (192177347, 'Lindsey', '43 Fleet DriveGoslar', 'lindsey.snider@accesssyst', '057-3511295', 'Snider');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (734592929, 'Natascha', '10 Green StreetGrand-mere', 'n.rydell@vitacostcom.ca', '051-8395888', 'Rydell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (366752127, 'Machine', '61 JoshuaMeppel', 'machine@globalwireless.nl', '059-6311523', 'Thornton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (343997862, 'Trey', '24 Burmester DriveShelton', 't.sanchez@newtoninteracti', '052-1758254', 'Sanchez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (339789768, 'Isaac', '629 Walsh DriveSutton', 'isaac.archer@sweetproduct', '051-1968835', 'Archer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (543847619, 'Kimberly', '433 Nolte AveLehi', 'kspacey@horizon.com', '057-3631179', 'Spacey');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (821792885, 'Liv', '84 CollieDorval', 'liv.g@clubone.ca', '053-6195165', 'Gellar');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (115754625, 'Nils', '83 Rock StreetAshdod', 'nils.fichtner@pib.il', '058-8418852', 'Fichtner');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (759736188, 'Claire', '86 Wilkinson RoadWest Lafayett', 'claire.huston@bowman.com', '056-7648874', 'Huston');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (595892174, 'Rory', '13 Trevino DriveBrookfield', 'rory.laws@aquascapedesign', '052-8276628', 'Laws');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (899545542, 'Elisabeth', '466 De Almeida BlvdOppenheim', 'e.gilley@inspirationsoftw', '054-9319149', 'Gilley');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (531438979, 'Steven', '284 Paquin DriveExeter', 'stevenr@exinomtechnologie', '058-5345161', 'Rubinek');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (969887624, 'Wallace', '52nd StreetJakarta', 'wallace@glmt.id', '051-7814532', 'Trejo');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (677746773, 'Viggo', '40 Phoenix RoadLeinfelden-Echt', 'viggo.kotto@sysconmedia.d', '052-3848239', 'Kotto');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (811239772, 'Jeffery', '69 Fort Lewis StreetGennevilli', 'jeffery.streep@microsoft.', '055-5824568', 'Streep');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (389672233, 'Diane', '36 Horton RoadBretzfeld-Waldba', 'diane.b@linacsystems.de', '058-2733666', 'Biehn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (853763113, 'Nikki', '65 Helsinki RoadHerndon', 'nikki@capellaeducation.co', '054-3863671', 'Keen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (831646571, 'Barbara', '71st StreetChirignago', 'barbara.saintemarie@scoot', '052-1723735', 'Sainte-Mar');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (414542828, 'Walter', '13 RogerYucca', 'walter.heald@zoneperfectn', '054-2247238', 'Heald');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (224381125, 'Bridgette', '3 Morton DriveWashington', 'b.gere@portosan.com', '054-5485845', 'Gere');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (548163249, 'Melba', '60 Wellington BlvdVista', 'melbaf@sps.com', '054-7584951', 'Forrest');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (463936156, 'Chubby', '982 Kaohsiung StreetMelrose pa', 'chubby.kapanka@solipsys.c', '055-1999962', 'Kapanka');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (955984396, 'Lindsay', '51st StreetCrete', 'lindsay.norton@worldcom.c', '057-8587453', 'Norton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (625377281, 'Emily', '88 Eldard DriveLexington', 'e.weisz@usdairyproducers.', '059-2134873', 'Weisz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (533884378, 'Joely', '702 Norderstedt DriveJuazeiro', 'joely.browne@sysconmedia.', '056-9784462', 'Browne');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (127452677, 'Woody', '20 Emmylou RoadSt. Petersburg', 'woody.rosas@webgroup.com', '051-6974426', 'Rosas');
commit;
prompt 100 records committed...
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (929224953, 'Janice', '64 Tucci RoadWhitehouse Statio', 'janice.avalon@priorityexp', '059-1182573', 'Avalon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (615722688, 'Willem', '69 Loren RoadSuwon-city', 'willem.dorff@timevision.c', '051-2653969', 'Dorff');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (148241745, 'Antonio', '55 TomlinTurku', 'antoniop@sony.fi', '058-5689533', 'Pacino');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (218757672, 'Russell', '51st StreetStony Point', 'russell@gra.com', '056-4647997', 'Aykroyd');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (961972549, 'Clive', '54 Jovovich RoadBern', 'clive.hughes@kroger.ch', '057-7744486', 'Hughes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (691574567, 'Elisabeth', '60 Sizemore RoadMt. Laurel', 'elisabeth@stonebrewing.co', '059-8363746', 'Palin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (484568425, 'Collin', '91st StreetUlsteinvik', 'collin.owen@infovision.no', '056-7295252', 'Owen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (156613236, 'Laura', '67 AnnetteWest Chester', 'laura.valentin@bestbuy.co', '055-5592297', 'Valentin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (626425945, 'Betty', '84 Rome DriveShawnee', 'bwahlberg@aristotle.com', '057-1851548', 'Wahlberg');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (942889771, 'Ossie', '18 Stallone DriveKing of Pruss', 'ossie.orlando@stiknowledg', '050-1443215', 'Orlando');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (393235941, 'Nicole', '52nd StreetPasadena', 'nicole.broadbent@tmaresou', '058-8573742', 'Broadbent');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (937311881, 'Kylie', '2 Michelle RoadLimeira', 'kylie.degraw@formatech.br', '055-8882918', 'DeGraw');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (687955148, 'Andre', '3 Connick BlvdBarcelona', 'andre@scheringplough.es', '059-5454677', 'Sheen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (746597546, 'Lenny', '68 Butler DriveLeinfelden-Echt', 'lenny.mccready@wendysinte', '054-3545824', 'McCready');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (356625526, 'Chad', '38 Nicholas RoadYamaguchi', 'c.duchovny@captechventure', '051-1946415', 'Duchovny');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (615959839, 'Elle', '54 Redhill AveH׳”ssleholm', 'ellef@mavericktechnologie', '050-8136355', 'Field');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (611164944, 'Vincent', '99 Ball RoadYamagata', 'vincent@mattel.jp', '056-5853168', 'Holland');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (214753399, 'Ivan', '241 StormareUden', 'ivanh@topicsentertainment', '055-2537711', 'Hartnett');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (728521699, 'Kevn', '46 ViennaBristol', 'kevn.cockburn@deutschetel', '054-4983629', 'Cockburn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (689494953, 'Olympia', '72 Kelly DriveEschborn', 'olympia@refinery.de', '058-5258756', 'McGinley');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (311734255, 'Spike', '25 Nelson RoadReisterstown', 'spike.b@spectrum.com', '058-2386691', 'Boone');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (232428195, 'Rod', '12nd StreetBoston', 'rod.crouse@ibm.com', '054-6931135', 'Crouse');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (281625423, 'Katie', '42nd StreetFt. Leavenworth', 'katie.gershon@multimedial', '059-5882695', 'Gershon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (227284647, 'Rebecca', '173 Molly RoadHuntsville', 'rebecca.sartain@diamondgr', '050-8582627', 'Sartain');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (835858478, 'Brooke', '36 Trick StreetMiddleburg Heig', 'brooke.peterson@biosite.c', '059-8484124', 'Peterson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (116972777, 'Rita', '135 Lorenz StreetRio Rancho', 'rita.e@ezecastlesoftware.', '051-9887931', 'Eat World');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (815335443, 'Denny', '1 Americana AveNagoya', 'denny.harrelson@alogent.j', '053-8718488', 'Harrelson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (335528793, 'Hank', '61 Dublin DriveBerkshire', 'hank.mcintosh@comglobalsy', '055-6439565', 'McIntosh');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (127459374, 'Micky', '76 McFerrin AveGainesville', 'micky@officedepot.com', '058-4727562', 'Uggams');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (548548833, 'Lloyd', '216 Goodall RoadSursee', 'loakenfold@oss.ch', '050-8737594', 'Oakenfold');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (329948869, 'Yaphet', '28 Cockburn RoadBellerose', 'yaphet.sylvian@creditorsi', '053-8642927', 'Sylvian');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (588246249, 'Emerson', '481 Kathleen RoadWichita', 'emerson.cook@vspan.com', '058-5138624', 'Cook');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (552949541, 'Phoebe', '78 Halfway house RoadRibeirao ', 'phoebe.oconnor@portosan.b', '054-1651959', 'O''Connor');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (385641543, 'Ceili', '3 Barrymore BlvdSao caetano do', 'ceili.v@ntas.br', '052-8662368', 'Van Shelto');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (712736239, 'Allison', '263 Palmer RoadAlmaty', 'allisonm@travizon.com', '059-8281543', 'McIntosh');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (367673877, 'Tobey', '761 Gilley StreetCasselberry', 'tobeyv@dps.com', '059-1464834', 'Van Helden');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (429493272, 'Dorry', '11st StreetShelton', 'dframpton@dearbornbancorp', '057-5946198', 'Frampton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (836178661, 'Joely', '915 Vanessa DriveDaejeon', 'joely@cyberthink.com', '051-8356762', 'Watson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (676761349, 'Adam', '82 Goodman RoadElkins Park', 'adam.pearce@newmedia.com', '056-8376377', 'Pearce');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (535937329, 'Clarence', '491 Cassidy RoadMiddleburg Hei', 'c.visnjic@merck.com', '056-9229419', 'Visnjic');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (317635954, 'Millie', '35 Minnie RoadVisselh׳¦vede', 'millie.margolyes@employer', '051-4235183', 'Margolyes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (367144584, 'Sheena', '58 Valencia RoadPensacola', 's.harry@printingforlessco', '052-4252775', 'Harry');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (717412629, 'Connie', '413 Riverdale DriveCampana', 'connie@mms.ar', '053-7755136', 'Laurie');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (865638685, 'Gwyneth', '2 LetoHanover', 'gwyneth.chappelle@techboo', '054-9388689', 'Chappelle');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (727881971, 'Reese', '1 Adamstown StreetAllen', 'reese.h@genghisgrill.com', '058-8313681', 'Hartnett');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (789132274, 'Marc', '71 Hannover RoadIrving', 'marc@swp.com', '058-3717391', 'Dempsey');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (762385283, 'Vendetta', '80 Lara StreetPhoenix', 'vendetta.raye@gltg.com', '052-7636185', 'Raye');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (253778582, 'Lucy', '571 ChetKopavogur', 'lucy.g@meghasystems.is', '051-6719544', 'Griffin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (111732338, 'Elvis', '39 Gough DriveMadrid', 'elvis.sellers@powerlight.', '057-5311792', 'Sellers');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (168714263, 'Edwin', '989 Connie RoadFramingaham', 'edwin@sysconmedia.com', '055-8666621', 'Spears');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (579494772, 'Nile', '52 Bullock RoadSaitama', 'nile.chandler@ungertechno', '058-8885576', 'Chandler');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (493544467, 'Owen', '18 Bassett StreetLisboa', 'owen@telesynthesis.pt', '054-4647482', 'Moreno');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (352196863, 'Dermot', '40 CaviezelGaithersburg', 'dermot@universalsolutions', '059-3342893', 'Phifer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (248161537, 'Grant', '27 Bend BlvdPlymouth Meeting', 'grant.baez@qssgroup.com', '058-2636585', 'Baez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (913789557, 'Sandra', '15 Hohenfels StreetPort Macqua', 's.marx@sourcegear.au', '051-3345669', 'Marx');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (624266199, 'Bret', '863 Rapaport StreetRimini', 'bret.cozier@fflcbancorp.i', '052-8277319', 'Cozier');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (728944335, 'Tamala', '442 Westerberg RoadYogyakarta', 't.neville@usgovernment.id', '056-2947599', 'Neville');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (356613594, 'Quentin', '66 MacIsaac StreetSantiago', 'quentin.quaid@sci.cl', '054-6349344', 'Quaid');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (215843618, 'Ronnie', '73 Collins RoadUlm', 'ronnie.schwarzenegger@qas', '058-9563476', 'Schwarzene');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (943842588, 'Parker', '438 Fishburne RoadBautzen', 'parker.makowicz@accuship.', '053-7879679', 'Makowicz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (696393696, 'Cornell', '49 Gagnon DriveVeenendaal', 'cornellf@nissanmotor.nl', '050-2263635', 'Foxx');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (449235134, 'Joan', '18 Juliana DriveWilmington', 'joan.campbell@boldtechsys', '053-4139915', 'Campbell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (527231381, 'Ian', '35 Peniston DriveColdmeece', 'ian.evanswood@gci.uk', '050-7496696', 'Evanswood');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (882879218, 'Elle', '331 Shocked RoadChiba', 'epaxton@verizon.jp', '055-8789357', 'Paxton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (452738696, 'Stevie', '46 Allison BlvdCedar Park', 'stevie.pepper@bis.com', '054-5263214', 'Pepper');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (891718617, 'Geoffrey', '44 Remy BlvdHorsham', 'geoffrey.beckinsale@advan', '057-7323768', 'Beckinsale');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (416855553, 'Rosie', '23 Assante RoadNewton-le-willo', 'rosie.ruiz@greenmountain.', '056-6894726', 'Ruiz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (481194597, 'Judi', '278 ThelmaGennevilliers', 'judi.oldman@topicsenterta', '052-6769871', 'Oldman');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (749856571, 'Judd', '61 Emily RoadGeneva', 'judd.savage@north.ch', '053-5373776', 'Savage');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (677984899, 'Gil', '89 Cobbs RoadDresden', 'gil.mahood@harrison.de', '053-5644671', 'Mahood');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (794474241, 'John', '72 Law RoadSpring Valley', 'john.elizabeth@abatix.com', '053-9494281', 'Elizabeth');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (595749885, 'Tilda', '92 Cedar Rapids DriveN. ft. My', 'tjoli@gentrasystems.com', '058-8388394', 'Joli');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (839719359, 'Madeline', '47 Maebashi RoadKoeln', 'madeliner@summitenergy.de', '051-3218684', 'Red');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (946548967, 'Chuck', '88 Monmouth BlvdLimeira', 'chuck.woods@clorox.br', '055-6949121', 'Woods');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (169179476, 'Lisa', '76 Cockburn DriveT׳”by', 'l.shocked@techbooks.se', '051-2319592', 'Shocked');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (864417121, 'Emm', '43 Glenshaw StreetOrange', 'emm.smith@medsource.com', '050-4294542', 'Smith');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (287714685, 'Linda', '21 Nick DriveKoeln', 'linda.c@trafficmanagement', '056-6151472', 'Candy');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (269452927, 'Victor', '55 Vilafranca Penedes RoadRado', 'vrollins@kiamotors.si', '053-6543281', 'Rollins');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (892242272, 'Louise', '77 Crewson StreetLeinfelden-Ec', 'louisem@infopros.de', '051-2121239', 'Moody');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (166129194, 'Tori', '59 Jody StreetUdine', 'tori.close@cendant.it', '052-6345834', 'Close');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (876662372, 'Lloyd', '94 AzariaBeaverton', 'lloyd.c@valleyoaksystems.', '058-1697731', 'Conway');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (329354235, 'Max', '59 McCain AveSundsvall', 'max.ponty@toyotamotor.se', '055-3747723', 'Ponty');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (622383977, 'Bernie', '80 Immenstaad RoadIndianapolis', 'bernie.rowlands@digitalmo', '051-8327132', 'Rowlands');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (725484253, 'Jesse', '2 Stuart AveVictoria', 'jesse.s@sht.ca', '055-4277895', 'Stone');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (899631822, 'Campbell', '885 McElhone StreetBretzfeld-W', 'campbell@mag.de', '053-7278433', 'Cornell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (735234817, 'Bette', '742 Rhymes RoadRozenburg', 'bette.coburn@freedommedic', '057-6444284', 'Coburn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (819324957, 'Ivan', '26 Brno AveDrogenbos', 'ivan.d@fmi.be', '057-6183216', 'Dourif');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (646383622, 'Merrill', '51st StreetManchester', 'merrill.chao@denaliventur', '056-5191176', 'Chao');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (764958648, 'Jeroen', '663 Halfway house StreetPirapo', 'jeroen.s@intraspheretechn', '050-7396864', 'Stigers');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (951419871, 'Dionne', '57 Kane AveFarnham', 'dionne.weir@ams.uk', '052-7373385', 'Weir');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (237728872, 'Jeremy', '5 Delroy StreetO''fallon', 'jeremy@conquest.com', '051-7415352', 'Stampley');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (745155142, 'Andre', '71 Essen StreetMississauga', 'andre.cetera@ssci.ca', '054-1995316', 'Cetera');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (961963235, 'Powers', '68 Angelina RoadAugsburg', 'powers.s@naturescure.de', '058-2111597', 'Springfiel');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (569834712, 'Viggo', '53 Biel DriveFreiburg', 'viggo.h@y2marketing.de', '058-9423469', 'Himmelman');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (973545828, 'Larry', '9 Tucker DriveLivermore', 'larry.lange@escalade.com', '055-5292943', 'Lange');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (949629294, 'Sophie', '7 Bugnon StreetHarrisburg', 'sophie.branagh@ceom.com', '053-2163861', 'Branagh');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (148745747, 'Sissy', '6 Huntington DriveBurlington', 'sissy.zevon@gcd.com', '053-3864556', 'Zevon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (891453141, 'Grace', '54 GibbonsWalnut Creek', 'grace@pra.com', '056-2645519', 'Kier');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (391991443, 'Lennie', '77 Sawa DriveAllen', 'lennie@firstsouthbancorp.', '058-5145699', 'Tankard');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (197719382, 'Gran', '44 Avalon StreetGranada Hills', 'gdeejay@hfg.com', '058-4833871', 'Deejay');
commit;
prompt 200 records committed...
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (753488476, 'Shawn', '78 Aracruz StreetSan Dimas', 'shawn.rapaport@paisley.co', '059-3241664', 'Rapaport');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (186513129, 'Scarlett', '29 Swannanoa AveEbersdorf', 'scarlett.c@axis.de', '055-9448345', 'Crouch');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (318485592, 'Sigourney', '39 Gladys StreetLake worth', 'sgill@boldtechsystems.com', '059-3994477', 'Gill');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (711722189, 'Susan', '69 Turner RoadMorioka', 'susan.cara@interfacesoftw', '057-2436671', 'Cara');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (735621686, 'France', '53 Wayans StreetRorschach', 'ftomlin@pioneermortgage.c', '053-1865665', 'Tomlin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (162442867, 'Hex', '74 Mountain View StreetDaejeon', 'hesposito@at.com', '054-3671696', 'Esposito');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (529682883, 'Angela', '30 Bebe RoadCottbus', 'angela.raitt@jsa.de', '052-8216346', 'Raitt');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (995684566, 'Sona', '29 Athens AveSlough', 'sona.posey@sunstream.uk', '058-9714664', 'Posey');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (353299578, 'Kazem', '838 Guilfoyle StreetWhittier', 'kazem.b@healthscribe.com', '055-3529492', 'Bonham');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (778893846, 'Ralph', '291 Whittier StreetMatsue', 'ralph.garber@jewettcamero', '052-4263964', 'Garber');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (567346599, 'Saffron', '87 Regina RoadYokohama', 'saffron.c@ultimus.jp', '052-7131224', 'Cromwell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (939755567, 'Glen', '799 Nivola RoadHjallerup', 'gnelligan@fpf.dk', '050-3345536', 'Nelligan');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (671793184, 'Nicole', '44 Ifans RoadLancaster', 'nicole.hughes@data.com', '058-8348152', 'Hughes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (956761811, 'Seann', '16 Mitchell RoadBattle Creek', 'seann.bean@gltg.com', '059-5319425', 'Bean');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (385264286, 'Jeffery', '23 TucsonThame', 'jeffery.muellerstahl@nmr.', '052-5592737', 'Mueller-St');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (171887148, 'Carolyn', '70 Pantoliano BlvdOslo', 'carolyn.gore@noodles.no', '053-8182781', 'Gore');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (119231529, 'Benicio', '75 Westerberg DriveNew hartfor', 'benicio.postlethwaite@epa', '051-2222747', 'Postlethwa');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (666419193, 'Jet', '568 Devine RoadNew York City', 'jetg@elitemedical.com', '057-7673812', 'Guilfoyle');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (359738524, 'Gates', '94 Rain StreetNiles', 'g.gallagher@glacierbancor', '055-2889581', 'Gallagher');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (342679537, 'Walter', '10 Llewelyn StreetClaymont', 'walter.a@sht.com', '053-2559959', 'Arkenstone');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (122494375, 'Coley', '55 Liev RoadAberdeen', 'coleyc@gateway.uk', '058-8423595', 'Campbell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (864633429, 'Jodie', '938 Jean DriveAlgermissen', 'jodie.e@air.de', '058-2122559', 'England');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (725648559, 'Amy', '20 Taipei DriveMatsue', 'amy.r@vesta.jp', '053-6381912', 'Rivers');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (846455483, 'Isaac', '40 Noah RoadHalfway house', 'isaac.busey@ecopy.za', '052-9216562', 'Busey');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (326872757, 'Allison', '459 Beverley RoadBarcelona', 'apfeiffer@fns.es', '053-6176356', 'Pfeiffer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (147241172, 'Bernard', '24 MortensenSugar Hill', 'bernard.branch@daimlerchr', '055-6367516', 'Branch');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (536312268, 'Nik', '70 ReidConcordville', 'nikm@gsat.com', '056-3934264', 'Martinez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (485356152, 'Austin', '18 Pollak StreetEncinitas', 'a.jonze@avr.com', '050-5972172', 'Jonze');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (514763855, 'Lara', '52 Amy StreetKloten', 'lara.clooney@diversitech.', '052-9197698', 'Clooney');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (288569752, 'Jonny Lee', '41st StreetSuwon', 'jonnylee.gooding@als.com', '050-8783441', 'Gooding');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (961125361, 'Johnny', '1 Oliver BlvdRedwood Shores', 'jtennison@mosaic.com', '055-7634469', 'Tennison');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (211124975, 'Geoff', '8 Chaplin StreetLimeira', 'g.kweller@logisticare.br', '050-2645379', 'Kweller');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (312589229, 'Hilary', '51 Royston AveHampton', 'hilary.moore@afs.com', '058-9568113', 'Moore');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (455747423, 'Teri', '91 Tyler RoadLongueuil', 'teri@topicsentertainment.', '051-4915613', 'Dayne');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (769174132, 'Harris', '75 McDonnell DriveCaguas', 'h.rock@horizon.com', '051-6278193', 'Rock');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (336999793, 'Sonny', '325 Peniston BlvdPacific Grove', 's.english@solipsys.com', '052-8522372', 'English');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (422367597, 'Carole', '778 Cheech RoadKoblenz', 'carole.crystal@hardwoodwh', '053-4646656', 'Crystal');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (172221481, 'Kimberly', '902 Mili AveSugar Land', 'k.negbaur@ssi.com', '053-1536628', 'Negbaur');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (458918148, 'Goran', '24 Edmunds RoadWinnipeg', 'goran.hynde@tarragonrealt', '055-8826916', 'Hynde');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (372528246, 'Queen', '35 Hunt Valley RoadSt. Louis', 'queen.warburton@viacell.c', '052-1273146', 'Warburton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (888795787, 'Ossie', '69 Church DriveRedmond', 'o.waits@extremepizza.com', '051-3396463', 'Waits');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (678673814, 'Jaime', '18 Burke StreetAbbotsford', 'jaime.stiles@morganresear', '055-3837482', 'Stiles');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (184921118, 'Freda', '964 Stone Mountain StreetSoest', 'freda.lasalle@harrison.nl', '057-1926739', 'LaSalle');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (844742226, 'Liam', '81st StreetErpe-Mere', 'liam.mcanally@pulaskifina', '055-8872497', 'McAnally');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (242242944, 'Meredith', '70 Ringwood DriveNeuquen', 'meredith.balk@royalgold.a', '056-9372224', 'Balk');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (935798395, 'Demi', '398 Dillane DriveTakapuna', 'demi.makowicz@mre.nz', '055-5755364', 'Makowicz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (495235798, 'Denise', '771 Mahoney RoadWaco', 'denisev@ghrsystems.com', '059-8319538', 'Vincent');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (352949287, 'Richard', '83rd StreetPortland', 'r.cummings@trekequipment.', '057-5551131', 'Cummings');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (583491233, 'Armand', '10 McDormand StreetWaterloo', 'armanda@creditorsintercha', '058-8372931', 'Askew');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (972295621, 'Lily', '55 Miles StreetHochwald', 'lilyp@elmco.ch', '051-7866626', 'Pollak');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (139567725, 'Viggo', '51 Fort worth DriveTallahassee', 'v.fender@dillards.com', '057-3329818', 'Fender');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (572551257, 'Rascal', '53rd StreetCromwell', 'rascal.shalhoub@microsoft', '058-8896463', 'Shalhoub');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (245548155, 'Judge', '44 University DriveTucson', 'judge.p@dataprise.com', '051-9858528', 'Phillips');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (556427763, 'George', '770 Courbevoie StreetLake Fore', 'george.klein@limitedbrand', '052-5535153', 'Klein');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (858496861, 'Fairuza', '63rd StreetFort Lewis', 'fairuza.hershey@bluffcity', '052-9314723', 'Hershey');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (683364887, 'Famke', '52nd StreetDreieich', 'famke.r@aristotle.de', '058-6352983', 'Raybon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (336824331, 'Mekhi', '24 Penn DriveVancouver', 'mekhi.cruz@ivorysystems.c', '056-6262966', 'Cruz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (144649477, 'Nastassja', '778 HuntsvilleHelsingborg', 'nthomas@eagleone.se', '052-8136655', 'Thomas');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (185613246, 'Ralph', '114 Ferrer RoadKoeln', 'ralph.berkley@ceo.de', '051-5513689', 'Berkley');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (827722177, 'Gene', '12nd StreetYomgok-dong', 'gene.reno@carteretmortgag', '057-7117793', 'Reno');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (981592776, 'Vivica', '75 Sale DriveOlsztyn', 'vivica.imbruglia@seafoxbo', '050-3491817', 'Imbruglia');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (924391649, 'Phil', '98 Lynne StreetRingwood', 'p.hurt@kmart.au', '059-5946283', 'Hurt');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (596542332, 'Lisa', '62nd StreetTh׳¦rishaus', 'lisa.bacharach@visaintern', '054-5834441', 'Bacharach');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (585424715, 'Judi', '61 Streep StreetDuluth', 'judi@hotmail.com', '051-8916926', 'Sandler');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (522834411, 'Jimmie', '42 Juliana StreetAmsterdam', 'jimmied@scripnet.nl', '054-4543342', 'DeLuise');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (295575691, 'Jean', '68 Ceili StreetPecs', 'jean.pesci@sweetproductio', '059-7411293', 'Pesci');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (951296981, 'Tia', '57 Morioka StreetDietikon', 'tia.paige@aventis.ch', '059-4569887', 'Paige');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (572938411, 'Corey', '52 Strathairn StreetSamrand', 'c.dean@voicelog.za', '050-8732385', 'Dean');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (162137163, 'Larenz', '4 Noumea BlvdBatavia', 'larenz@cascadebancorp.com', '059-7197543', 'Perlman');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (434234621, 'Guy', '43 West Chester AveMelbourne', 'guy.d@cocacola.au', '056-8791354', 'Danger');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (369644687, 'Curtis', '6 WillieTbilisi', 'curtis.furay@seafoxboat.g', '054-8772986', 'Furay');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (467159192, 'Kyra', '124 Winter BlvdGolden', 'kyra@kiamotors.com', '050-4639127', 'Tarantino');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (775561519, 'Darius', '70 Dean BlvdTaoyuan', 'dariusg@msdw.tw', '058-9885437', 'Goodall');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (695937844, 'Junior', '85 Duvall DriveTh׳¦rishaus', 'junior.rhymes@viacell.ch', '052-5783992', 'Rhymes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (754317637, 'Holly', '51 AshleyGeneve', 'holly@midwestmedia.ch', '055-4658574', 'Laurie');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (847364326, 'Aida', '70 Lou RoadSpresiano', 'aida@floorgraphics.it', '059-4417962', 'Gambon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (689985245, 'Selma', '36 Dublin AveChemnitz', 'selmac@keymark.de', '052-4861185', 'Chestnut');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (764279839, 'Terence', '113 Wilder RoadNew York', 'terence.houston@walmartst', '053-6781753', 'Houston');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (715723946, 'Burt', '20 Minnie DriveBismarck', 'bteng@shot.com', '053-1625361', 'Teng');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (531448264, 'Tal', '43rd StreetTokyo', 'tal.harrison@generalelect', '057-5716485', 'Harrison');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (556617211, 'Raymond', '60 Lizzy StreetAdelaide', 'raymond.mcgill@solipsys.a', '053-5964715', 'McGill');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (593715245, 'Alan', '77 Reading StreetPeterborough', 'alan.steenburgen@astute.c', '052-3275797', 'Steenburge');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (666155814, 'Reese', '226 Yankovic StreetSan Jose', 'reese.kapanka@sprint.cr', '052-1635497', 'Kapanka');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (452127625, 'Ving', '51 Batavia AveElche', 'ving.voight@lifelinesyste', '056-7656397', 'Voight');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (562229785, 'Noah', '76 O''Connor RoadMonroe', 'noah.burns@johnkeeler.com', '050-3678485', 'Burns');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (153525296, 'April', '70 Coburn DriveKejae City', 'amitchell@spectrum.com', '057-1324435', 'Mitchell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (546289323, 'Eddie', '13 Garcia StreetWן¢•rzburg', 'eddie.tucci@formatech.de', '056-8223953', 'Tucci');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (123671412, 'Sally', '84 Harahan RoadBellevue', 'sally.ingram@sms.com', '054-6655729', 'Ingram');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (248393884, 'Tyrone', '27 Cardiff AveFukuoka', 'tyronel@greene.jp', '056-7955232', 'Llewelyn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (342299945, 'Bill', '76 Lynn RoadK׳¨benhavn', 'bill.senior@gtp.dk', '056-9362568', 'Senior');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (627995199, 'Geoffrey', '32nd StreetBattle Creek', 'g.hagerty@universalsoluti', '056-7249574', 'Hagerty');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (836952812, 'Goran', '343 Romijn-Stamos DriveBkk', 'goran@pharmacia.th', '058-2828249', 'Richardson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (998751539, 'Javon', '67 ColonMississauga', 'jholmes@tripwire.ca', '055-3824478', 'Holmes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (277347811, 'Jesus', '99 Fleet RoadRuncorn', 'jesusp@scripnet.uk', '051-1375654', 'Perez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (417431712, 'Manu', '58 Stewart BlvdS׳“o paulo', 'manu.griggs@cmi.br', '054-6422165', 'Griggs');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (854941699, 'Kieran', '78 Peterson RoadGersthofen', 'kieran.myles@trusecure.de', '055-7152432', 'Myles');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (443853155, 'CeCe', '13 Trumbull RoadGummersbach', 'cece@mindiq.de', '055-1828633', 'Ponce');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (646215689, 'Whoopi', '95 Fleet BlvdOrleans', 'whoopi@newtoninteractive.', '055-5114944', 'Mueller-St');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (787856135, 'Kenneth', '61st StreetHercules', 'kenneth.mandrell@esteelau', '050-8849433', 'Mandrell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (952478962, 'Hilton', '60 Ossie StreetMaintenon', 'h.dunaway@mwh.fr', '054-6342957', 'Dunaway');
commit;
prompt 300 records committed...
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (722827558, 'Holly', '82nd StreetFuchstal-asch', 'holly.jay@microsoft.de', '059-3666399', 'Jay');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (662591313, 'Lennie', '86 LiuHarahan', 'lennie@ass.com', '056-3993642', 'Weston');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (939775516, 'Chaka', '31st StreetNagoya', 'chaka@dps.jp', '059-6917922', 'Guinness');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (463663775, 'Julia', '47 Waite RoadCleveland', 'julia.winter@balchem.com', '053-5171132', 'Winter');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (247174221, 'Charles', '53 AidaSouthampton', 'c.koteas@yashtechnologies', '055-1724892', 'Koteas');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (829814233, 'Nile', '766 T׳”by StreetMacau', 'nile.cash@telwares.mo', '051-8257219', 'Cash');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (269773762, 'Amy', '68 Donna DriveBerlin-Adlershof', 'amy@capstone.de', '059-8164373', 'Snider');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (258216284, 'Wendy', '430 Norm RoadMiami', 'w.chappelle@summitenergy.', '051-2969928', 'Chappelle');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (873251915, 'Cheryl', '100 Ammons AveWaldorf', 'cheryl.red@dsp.com', '056-9283861', 'Red');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (556719822, 'Hilary', '92 Ontiveros RoadAbbotsford', 'hkotto@summitenergy.au', '054-8633694', 'Kotto');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (236776618, 'Jet', '51 MacNeil AveBarcelona', 'jet.gough@taycorfinancial', '054-6698614', 'Gough');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (987637154, 'Jonatha', '64 Fred StreetIssaquah', 'jonatha.b@dancor.com', '054-4212564', 'Badalucco');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (611517596, 'Jody', '38 Stiller StreetDuluth', 'jody.mcdowell@accessus.co', '050-3519232', 'McDowell');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (749374253, 'Josh', '8 Matt DriveRio de janeiro', 'josh.snipes@kellogg.br', '057-6881677', 'Snipes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (699112677, 'Ming-Na', '568 Cardiff RoadKaiserslautern', 'mingna.craig@mag.de', '058-8691521', 'Craig');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (954722157, 'Jessica', '349 Shannon AveGauteng', 'jessica.spector@daimlerch', '055-8848236', 'Spector');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (986723751, 'Cameron', '27 Market HarboroughAthens', 'cameronk@nsd.gr', '052-2752666', 'Keitel');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (794592687, 'Beth', '45 Collie DriveKwun Tong', 'beth.rhodes@elitemedical.', '051-3453177', 'Rhodes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (366464293, 'Joely', '12 Isaak RoadHouston', 'j.dorff@ceo.com', '052-6639964', 'Dorff');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (464357414, 'Xander', '16 Turku RoadValencia', 'xcruz@asapstaffing.es', '054-8956128', 'Cruz');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (111234399, 'Natacha', '404 Macy StreetDardilly', 'natacha.archer@streetglow', '057-2226643', 'Archer');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (392815234, 'Sandra', '95 Vallauris BlvdBrussel', 'sandra@meritagetechnologi', '052-7978159', 'Costner');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (965515364, 'Julianna', '78 Roger DriveNaestved', 'julianna.galecki@banfepro', '053-6298988', 'Galecki');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (142535423, 'Gates', '36 Adrien BlvdAnn Arbor', 'gates.m@aristotle.com', '054-9491197', 'Matthau');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (772472181, 'Bernard', '34 JordanUdine', 'bernard.p@axis.it', '054-8652699', 'Perez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (275735161, 'Denise', '96 ChubbyFukuoka', 'denise.snow@intraspherete', '056-4234715', 'Snow');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (327234746, 'Rascal', '32 Chilton StreetO''fallon', 'rascal@vspan.com', '058-8795741', 'Winans');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (192555343, 'Fiona', '97 Wilkinson DriveEl Dorado Hi', 'fiona.orlando@americanlan', '050-7754732', 'Orlando');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (112464717, 'Balthazar', '2 BismarckSanta Clarita', 'balthazar.costa@gcd.com', '055-1498772', 'Costa');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (564826418, 'Chris', '53 BellChinnor', 'chris.bush@ssi.uk', '055-4538675', 'Bush');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (259362496, 'Lili', '84 Dawson StreetBarueri', 'lili.paquin@bedfordbancsh', '059-1691654', 'Paquin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (153515476, 'Frank', '532 Stallone AveJacksonville', 'frank.conlee@kingston.com', '058-9513553', 'Conlee');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (657467672, 'Rawlins', '73 Quentin StreetWaldbronn', 'rawlins.barrymore@mwp.de', '052-7249228', 'Barrymore');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (747616616, 'Rene', '6 Henriksen RoadFort gordon', 'r.lynne@fab.com', '059-2117336', 'Lynne');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (166212118, 'Crispin', '35 Cannock BlvdAshland', 'crispin.bugnon@allegiantb', '055-3141649', 'Bugnon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (649216418, 'Shannyn', '706 Park Ridge RoadAachen', 's.rivers@idas.de', '053-3164945', 'Rivers');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (462369231, 'Jimmy', '26 Schreiber RoadNiles', 'jimmy.cervine@typhoon.com', '057-1213997', 'Cervine');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (892961117, 'Jon', '45 DubaiBurlington', 'jmatthau@nobrainerblindsc', '052-9711416', 'Matthau');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (396354422, 'Benjamin', '52 Velizy Villacoublay RoadMou', 'benjamin.w@pacificdatades', '059-4528117', 'Wopat');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (793365692, 'Belinda', '10 Hal StreetChambersburg', 'belinda.burrows@catamount', '057-5566754', 'Burrows');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (689787933, 'Celia', '59 May StreetWetzlar', 'celia.sanchez@techbooks.d', '053-1848535', 'Sanchez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (967965722, 'Nelly', '71st StreetAiken', 'nelly.harrelson@bayer.com', '059-8937328', 'Harrelson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (271483786, 'Kazem', '6 Kirkwood BlvdGaithersburg', 'kazem.w@limitedbrands.com', '053-4519526', 'Warburton');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (381683979, 'Rip', '125 McKean DriveChiba', 'rip@gha.jp', '052-8492822', 'Hersh');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (185287127, 'Keanu', '81 Craig DriveLinz', 'kbanderas@nlx.at', '053-4542415', 'Banderas');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (888793354, 'James', '33 Collins StreetFreising', 'james.roberts@microtek.de', '054-3569213', 'Roberts');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (479647887, 'Elias', '42nd StreetBelmont', 'elias.perez@banfeproducts', '058-7777324', 'Perez');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (383953253, 'Joy', '23 Mapo-gu DriveIrving', 'joy.fishburne@hencie.com', '053-8912891', 'Fishburne');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (374499312, 'Rupert', '42 Smyrna RoadWest Launceston', 'rupert.daniels@shar.au', '051-6842967', 'Daniels');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (493129756, 'Oro', '16 Fishburne DriveAltamonte Sp', 'orow@genextechnologies.co', '055-3856163', 'Whitmore');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (697151836, 'Bernard', '41 New hartford AveAomori', 'bernard.daniels@nbs.jp', '057-8483775', 'Daniels');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (456767367, 'Michelle', '444 Joely RoadJun-nam', 'm.weaver@irissoftware.com', '050-4327999', 'Weaver');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (577742123, 'Larenz', '99 Chambers DriveMatsue', 'larenzc@sfgo.jp', '058-2472393', 'Camp');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (577879396, 'Angie', '98 Tualatin StreetNorth Point', 'angie.english@royalgold.h', '058-7746687', 'English');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (367315441, 'Bebe', '38 Conners DriveSan Dimas', 'bebe.zahn@fns.com', '059-4338548', 'Zahn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (159952542, 'Vanessa', '35 Alan StreetFramingaham', 'vanessa@afs.com', '059-7322327', 'Brock');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (663973294, 'Loretta', '61 Pleasure StreetRichmond', 'loretta@infinity.com', '051-2222161', 'Boone');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (385646575, 'Rawlins', '12 Joli DriveMiddletown', 'rawlins.akins@iss.com', '052-9148416', 'Akins');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (897457852, 'Grace', '38 Kungki StreetDenver', 'grace.candy@sps.com', '057-3117817', 'Candy');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (858462761, 'Pierce', '52 Redhill RoadVancouver', 'pierce.goodall@scripnet.c', '050-7241582', 'Goodall');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (664641138, 'Connie', '94 Stuart StreetStreamwood', 'connie@pioneerdatasystems', '052-4922398', 'Cobbs');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (296482178, 'Liam', '26 Cale DriveDublin', 'l.vicious@safeway.com', '051-6774675', 'Vicious');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (461382856, 'Trey', '927 Evans RoadParis', 'trey.collette@prioritylea', '057-9431196', 'Collette');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (833442792, 'Emma', '47 Chapel hill StreetEdmonton', 'emmar@marketfirst.ca', '054-4482981', 'Rankin');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (927868274, 'Jared', '66 Mogliano VenetoCourbevoie', 'jared.tankard@servicelink', '058-6422341', 'Tankard');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (185255945, 'Mira', '982 Tori RoadCincinnati', 'mira.ontiveros@gagwear.co', '052-9899424', 'Ontiveros');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (868435226, 'Lara', '70 Hornsby RoadAlessandria', 'lara.wilson@sony.it', '050-5584883', 'Wilson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (979922972, 'Dustin', '53 Raymond BlvdPaderborn', 'd.spine@otbd.de', '050-2873759', 'Spine');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (284632359, 'Meg', '36 Michaels RoadPrinceton', 'meg@fetchlogistics.com', '050-2474621', 'Benson');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (378133522, 'Tony', '98 Loretta DriveBoulder', 'tony.jane@berkshirehathaw', '052-4349455', 'Jane');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (491819425, 'Cornell', '88 Omar RoadAiken', 'ccoolidge@kis.com', '054-9653957', 'Coolidge');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (394168749, 'Sammy', '93 Flower mound DriveRoyston', 'sammyd@conagra.uk', '051-3156575', 'Donelly');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (275442394, 'Elias', '55 Janssen DriveBreda', 'epiven@bestbuy.nl', '052-2855739', 'Piven');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (113711537, 'Emilio', '62 Oshawa RoadLeeds', 'emilio.elwes@jewettcamero', '058-1798672', 'Elwes');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (972144782, 'Vince', '231 LaBelle StreetOak park', 'vince@ipsadvisory.com', '054-3273758', 'Winslet');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (789246959, 'Bob', '68 Thessaloniki BlvdWhittier', 'bob.delancie@quakercityba', '050-2494345', 'de Lancie');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (528543642, 'Ahmad', '33rd StreetDerwood', 'a.hiatt@simplycertificate', '056-4171663', 'Hiatt');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (852412535, 'Rueben', '2 Jean-LucAni׳˜res', 'rweston@mqsoftware.ch', '057-4247554', 'Weston');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (287355172, 'Roy', '83rd StreetLos Alamos', 'roy.bening@ivci.com', '050-3183958', 'Bening');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (186987147, 'Adam', '25 Melba DriveMaidstone', 'a.conway@northhighland.uk', '051-1916563', 'Conway');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (649858656, 'Lara', '21 Elias BlvdS. Bernardo do Ca', 'lara.kimball@cowlitzbanco', '051-7636825', 'Kimball');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (516217471, 'Sally', '134 Perry StreetSpring Valley', 'sally.king@dillards.com', '051-4387187', 'King');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (386665637, 'Jim', '26 Lunch AveGifu', 'jim.kidman@elitemedical.j', '057-4455383', 'Kidman');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (655743377, 'Jeanne', '96 Rhys StreetLincoln', 'jeanne.cassidy@pioneermor', '057-4777275', 'Cassidy');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (481424118, 'Ned', '77 Odense StreetHaverhill', 'ned.bacon@hudsonriverbanc', '057-5345433', 'Bacon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (714378859, 'Ricardo', '29 Karen StreetRua eteno', 'ricardo.z@younginnovation', '057-6737614', 'Zane');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (784921161, 'Alfie', '3 Marlboro AveRtp', 'alfie.yorn@hotmail.com', '051-6356583', 'Yorn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (654626772, 'Hilton', '62nd StreetKansas City', 'hiltonb@yumbrands.com', '058-8917976', 'Beals');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (345445514, 'Eugene', '96 April AveSteyr', 'e.torn@caliber.at', '051-6656922', 'Torn');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (839841634, 'Kirk', '58 Maureen DriveIrving', 'kirk.russo@tarragonrealty', '053-7973857', 'Russo');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (292698327, 'Murray', '54 Harrison BlvdFleet', 'murray.todd@bigyanksports', '059-6881743', 'Todd');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (135267658, 'Lisa', '221 LaPaglia AveHarrisburg', 'lisa.stormare@securityche', '057-9598657', 'Stormare');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (364463583, 'Brent', '117 Ermey RoadOulu', 'brent@staffone.fi', '051-8895721', 'Dysart');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (268518746, 'Willie', '26 Freddy AveWest Point', 'willie.w@vitacostcom.com', '051-6792662', 'Wright');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (314777163, 'Liquid', '13 Eldard RoadDurham', 'liquidh@career.com', '054-9365377', 'Hunt');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (231384155, 'Hikaru', '20 Serbedzija RoadCopenhagen', 'hikaru@max.dk', '055-5568357', 'Mazzello');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (191553388, 'Bob', '75 Conners BlvdWilliamstown', 'b.bugnon@solipsys.com', '059-8782142', 'Bugnon');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (179123698, 'Donna', '100 Eindhoven StreetMeerbusch', 'donna.downie@tama.de', '055-1576869', 'Downie');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (284281556, 'Joanna', '85 Nivola StreetLouisville', 'joannag@computersource.co', '055-6483643', 'Gayle');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (515383699, 'Ricky', '93 Emerson StreetMaebashi', 'ricky.hynde@yashtechnolog', '057-3925125', 'Hynde');
commit;
prompt 400 records committed...
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (881611398, 'Lizzy', '48 Cherry StreetKwun Tong', 'lizzy.janssen@gillette.hk', '054-3379993', 'Janssen');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (853315614, 'Phil', '71 Stiller RoadBracknell', 'pisaacs@bis.uk', '056-6991379', 'Isaacs');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (794969549, 'Willie', '72nd StreetHouston', 'willie.janney@authoria.co', '055-8147782', 'Janney');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (819153241, 'Helen', '77 Angers RoadRoyston', 'helen.midler@cardinalcart', '056-8952175', 'Midler');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (364759767, 'Albert', '53 Dafoe BlvdCalcutta', 'albert.okeefe@genextechno', '054-6751822', 'O''Keefe');
insert into PERSON (personid, firstname, address, email, phonenumber, lastname)
values (553254547, 'Kristin', '42nd StreetEiksmarka', 'kristind@atg.no', '052-1594212', 'Domino');
commit;
prompt 406 records loaded
prompt Loading DONOR...
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-07-2010', 'dd-mm-yyyy'), 88935, 493544467);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-05-2017', 'dd-mm-yyyy'), 42344, 865638685);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-02-2016', 'dd-mm-yyyy'), 41245, 153515476);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-06-2022', 'dd-mm-yyyy'), 49716, 567346599);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-09-2021', 'dd-mm-yyyy'), 77617, 585424715);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-08-2019', 'dd-mm-yyyy'), 92231, 955984396);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-08-2022', 'dd-mm-yyyy'), 56555, 715723946);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-04-2011', 'dd-mm-yyyy'), 43775, 159952542);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-10-2018', 'dd-mm-yyyy'), 52829, 444897653);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-03-2013', 'dd-mm-yyyy'), 96583, 913789557);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('03-02-2016', 'dd-mm-yyyy'), 32978, 461382856);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('11-04-2012', 'dd-mm-yyyy'), 92832, 961795379);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-10-2010', 'dd-mm-yyyy'), 73429, 749856571);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('10-12-2018', 'dd-mm-yyyy'), 96373, 753488476);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-05-2018', 'dd-mm-yyyy'), 16992, 414542828);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('30-07-2021', 'dd-mm-yyyy'), 76126, 548163249);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-06-2019', 'dd-mm-yyyy'), 69761, 353299578);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('24-04-2023', 'dd-mm-yyyy'), 63286, 184921118);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('24-07-2013', 'dd-mm-yyyy'), 65433, 664641138);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('04-05-2011', 'dd-mm-yyyy'), 85196, 762385283);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-09-2023', 'dd-mm-yyyy'), 68219, 224381125);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-10-2010', 'dd-mm-yyyy'), 15438, 556427763);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-07-2021', 'dd-mm-yyyy'), 48817, 695937844);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('03-09-2016', 'dd-mm-yyyy'), 58231, 219432622);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-10-2017', 'dd-mm-yyyy'), 91272, 452738696);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('14-04-2021', 'dd-mm-yyyy'), 24987, 595749885);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-07-2010', 'dd-mm-yyyy'), 64362, 646215689);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-08-2015', 'dd-mm-yyyy'), 85391, 318485592);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-02-2021', 'dd-mm-yyyy'), 23849, 339789768);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('17-12-2010', 'dd-mm-yyyy'), 53455, 712736239);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-09-2016', 'dd-mm-yyyy'), 88757, 569834712);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('07-06-2016', 'dd-mm-yyyy'), 76976, 269452927);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-12-2010', 'dd-mm-yyyy'), 17679, 759736188);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-08-2017', 'dd-mm-yyyy'), 86159, 281625423);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('18-03-2015', 'dd-mm-yyyy'), 22983, 792224434);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('07-09-2023', 'dd-mm-yyyy'), 15594, 312578226);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('05-02-2013', 'dd-mm-yyyy'), 58119, 626425945);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('18-10-2021', 'dd-mm-yyyy'), 88799, 514763855);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('04-08-2020', 'dd-mm-yyyy'), 32831, 271483786);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('29-01-2014', 'dd-mm-yyyy'), 75697, 191553388);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('20-04-2018', 'dd-mm-yyyy'), 72851, 528543642);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-01-2010', 'dd-mm-yyyy'), 13215, 612312412);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('18-03-2015', 'dd-mm-yyyy'), 45491, 593715245);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-05-2022', 'dd-mm-yyyy'), 23811, 654626772);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-01-2024', 'dd-mm-yyyy'), 59294, 937311881);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('17-07-2011', 'dd-mm-yyyy'), 73371, 892961117);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('12-07-2023', 'dd-mm-yyyy'), 82966, 847364326);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('25-07-2016', 'dd-mm-yyyy'), 86634, 698333646);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('12-08-2021', 'dd-mm-yyyy'), 58954, 278483766);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-07-2019', 'dd-mm-yyyy'), 39798, 449335211);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-04-2011', 'dd-mm-yyyy'), 33843, 888793354);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-12-2015', 'dd-mm-yyyy'), 57861, 245548155);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('09-02-2011', 'dd-mm-yyyy'), 82269, 277347811);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('03-08-2016', 'dd-mm-yyyy'), 54866, 882879218);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-02-2013', 'dd-mm-yyyy'), 14143, 385646575);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-10-2021', 'dd-mm-yyyy'), 79583, 891453141);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('05-03-2011', 'dd-mm-yyyy'), 14463, 218757672);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-01-2015', 'dd-mm-yyyy'), 32815, 846455483);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('13-12-2019', 'dd-mm-yyyy'), 43688, 646383622);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-05-2014', 'dd-mm-yyyy'), 47879, 998751539);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('07-03-2023', 'dd-mm-yyyy'), 19448, 942889771);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('14-03-2017', 'dd-mm-yyyy'), 37884, 516217471);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('03-09-2022', 'dd-mm-yyyy'), 71292, 386665637);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-03-2023', 'dd-mm-yyyy'), 43598, 572551257);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('24-05-2020', 'dd-mm-yyyy'), 45651, 596542332);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-11-2013', 'dd-mm-yyyy'), 88921, 856431755);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-11-2010', 'dd-mm-yyyy'), 58978, 385641543);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('18-12-2015', 'dd-mm-yyyy'), 43559, 689787933);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('09-11-2017', 'dd-mm-yyyy'), 99379, 569586425);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-07-2015', 'dd-mm-yyyy'), 56186, 687955148);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-08-2012', 'dd-mm-yyyy'), 61458, 844742226);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('24-09-2018', 'dd-mm-yyyy'), 21745, 876662372);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('05-07-2018', 'dd-mm-yyyy'), 75582, 961963235);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('29-03-2019', 'dd-mm-yyyy'), 83286, 649858656);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('20-05-2022', 'dd-mm-yyyy'), 88938, 583491233);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('25-08-2013', 'dd-mm-yyyy'), 64915, 897457852);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('01-06-2011', 'dd-mm-yyyy'), 23931, 389672233);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-10-2013', 'dd-mm-yyyy'), 53755, 829814233);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-09-2013', 'dd-mm-yyyy'), 23691, 935798395);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('12-07-2010', 'dd-mm-yyyy'), 14668, 764279839);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-07-2018', 'dd-mm-yyyy'), 24738, 987637154);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-09-2023', 'dd-mm-yyyy'), 38888, 697151836);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-11-2022', 'dd-mm-yyyy'), 14259, 311245632);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('13-07-2018', 'dd-mm-yyyy'), 15162, 662591313);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('13-07-2022', 'dd-mm-yyyy'), 15798, 671793184);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('29-04-2019', 'dd-mm-yyyy'), 22547, 666155814);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-05-2017', 'dd-mm-yyyy'), 56645, 329354235);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('19-09-2018', 'dd-mm-yyyy'), 54771, 823217557);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-12-2010', 'dd-mm-yyyy'), 98458, 649216418);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('20-12-2022', 'dd-mm-yyyy'), 86274, 725484253);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('06-06-2010', 'dd-mm-yyyy'), 13884, 186513129);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('08-04-2020', 'dd-mm-yyyy'), 48553, 552949541);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('05-09-2011', 'dd-mm-yyyy'), 43919, 381683979);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('09-09-2016', 'dd-mm-yyyy'), 97936, 572938411);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('28-11-2015', 'dd-mm-yyyy'), 68758, 496513286);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-08-2020', 'dd-mm-yyyy'), 71797, 972144782);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('30-11-2013', 'dd-mm-yyyy'), 32413, 852412535);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('17-03-2018', 'dd-mm-yyyy'), 98978, 456767367);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-08-2022', 'dd-mm-yyyy'), 57446, 722827558);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('28-06-2011', 'dd-mm-yyyy'), 12915, 132478141);
commit;
prompt 100 records committed...
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-07-2013', 'dd-mm-yyyy'), 79745, 211124975);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('13-07-2013', 'dd-mm-yyyy'), 44271, 675926779);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-10-2017', 'dd-mm-yyyy'), 16834, 764958648);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('05-10-2016', 'dd-mm-yyyy'), 77718, 927868274);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('08-07-2023', 'dd-mm-yyyy'), 49936, 627995199);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('28-07-2019', 'dd-mm-yyyy'), 82827, 468381237);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('26-03-2018', 'dd-mm-yyyy'), 62275, 657467672);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('06-08-2019', 'dd-mm-yyyy'), 45756, 612456769);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('03-04-2017', 'dd-mm-yyyy'), 76343, 232428195);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('14-08-2023', 'dd-mm-yyyy'), 38674, 745155142);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-05-2017', 'dd-mm-yyyy'), 98193, 595892174);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('18-05-2012', 'dd-mm-yyyy'), 37149, 429493272);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-06-2014', 'dd-mm-yyyy'), 87145, 949629294);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('14-10-2015', 'dd-mm-yyyy'), 98714, 787856135);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('30-01-2015', 'dd-mm-yyyy'), 74658, 57056412);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('17-09-2015', 'dd-mm-yyyy'), 78155, 449235134);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('25-09-2023', 'dd-mm-yyyy'), 91523, 186987147);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('09-10-2014', 'dd-mm-yyyy'), 33736, 396354422);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-07-2010', 'dd-mm-yyyy'), 16161, 275735161);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('09-04-2014', 'dd-mm-yyyy'), 33745, 869793359);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-07-2023', 'dd-mm-yyyy'), 37329, 533884378);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-08-2017', 'dd-mm-yyyy'), 43631, 735234817);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-06-2021', 'dd-mm-yyyy'), 65721, 588246249);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-08-2010', 'dd-mm-yyyy'), 23498, 728944335);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('08-09-2019', 'dd-mm-yyyy'), 95331, 258216284);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-07-2016', 'dd-mm-yyyy'), 91942, 366464293);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('24-05-2023', 'dd-mm-yyyy'), 86329, 481194597);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('10-03-2023', 'dd-mm-yyyy'), 69218, 322245632);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('04-12-2019', 'dd-mm-yyyy'), 82279, 218493661);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-12-2020', 'dd-mm-yyyy'), 46552, 124796735);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-08-2019', 'dd-mm-yyyy'), 26143, 352196863);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('11-09-2022', 'dd-mm-yyyy'), 21448, 747616616);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('07-09-2018', 'dd-mm-yyyy'), 31681, 356625526);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('20-01-2016', 'dd-mm-yyyy'), 77972, 394168749);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-05-2022', 'dd-mm-yyyy'), 48888, 815335443);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('28-11-2014', 'dd-mm-yyyy'), 22237, 885851983);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-08-2023', 'dd-mm-yyyy'), 88311, 295575691);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-05-2014', 'dd-mm-yyyy'), 57845, 338839244);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-07-2015', 'dd-mm-yyyy'), 26125, 577879396);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-06-2013', 'dd-mm-yyyy'), 34372, 556617211);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('04-07-2013', 'dd-mm-yyyy'), 27883, 676761349);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-10-2023', 'dd-mm-yyyy'), 83782, 967965722);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-08-2016', 'dd-mm-yyyy'), 69513, 946548967);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-07-2019', 'dd-mm-yyyy'), 63154, 115754625);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('29-01-2023', 'dd-mm-yyyy'), 81497, 142535423);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('11-01-2023', 'dd-mm-yyyy'), 96184, 728521699);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-05-2014', 'dd-mm-yyyy'), 94575, 211854325);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-04-2024', 'dd-mm-yyyy'), 44442, 727881971);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('27-12-2016', 'dd-mm-yyyy'), 33619, 162442867);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('29-08-2015', 'dd-mm-yyyy'), 24437, 252158964);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('17-06-2010', 'dd-mm-yyyy'), 17873, 835858478);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('11-12-2018', 'dd-mm-yyyy'), 95377, 839719359);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('15-07-2022', 'dd-mm-yyyy'), 95774, 612496723);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-02-2013', 'dd-mm-yyyy'), 23442, 873251915);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('18-03-2010', 'dd-mm-yyyy'), 35958, 112464717);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('25-08-2020', 'dd-mm-yyyy'), 43638, 615722688);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('20-03-2013', 'dd-mm-yyyy'), 84414, 135267658);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('02-10-2010', 'dd-mm-yyyy'), 46353, 843267238);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('14-12-2020', 'dd-mm-yyyy'), 45176, 148241745);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('17-09-2022', 'dd-mm-yyyy'), 53276, 891718617);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('01-04-2015', 'dd-mm-yyyy'), 47279, 367144584);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('14-03-2011', 'dd-mm-yyyy'), 32697, 211258385);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('31-08-2010', 'dd-mm-yyyy'), 32118, 127459374);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('10-12-2015', 'dd-mm-yyyy'), 42565, 463663775);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('12-04-2024', 'dd-mm-yyyy'), 27884, 312589229);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-05-2021', 'dd-mm-yyyy'), 62659, 995684566);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('09-06-2019', 'dd-mm-yyyy'), 39743, 495275382);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-08-2023', 'dd-mm-yyyy'), 42821, 983574126);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('23-07-2015', 'dd-mm-yyyy'), 81169, 481424118);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('06-09-2023', 'dd-mm-yyyy'), 14742, 864633429);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('28-06-2013', 'dd-mm-yyyy'), 81782, 979922972);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('10-05-2020', 'dd-mm-yyyy'), 62541, 924391649);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('05-04-2021', 'dd-mm-yyyy'), 85881, 939775516);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('12-06-2011', 'dd-mm-yyyy'), 15563, 799461997);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('08-10-2012', 'dd-mm-yyyy'), 19194, 892242272);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-06-2014', 'dd-mm-yyyy'), 26153, 359738524);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('16-10-2020', 'dd-mm-yyyy'), 55715, 717412629);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('28-12-2023', 'dd-mm-yyyy'), 92855, 555738385);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('11-06-2011', 'dd-mm-yyyy'), 18562, 383953253);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('07-04-2022', 'dd-mm-yyyy'), 26552, 965515364);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('12-08-2011', 'dd-mm-yyyy'), 36662, 192177347);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('22-11-2017', 'dd-mm-yyyy'), 57618, 185613246);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('06-05-2010', 'dd-mm-yyyy'), 44148, 853763113);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('07-03-2017', 'dd-mm-yyyy'), 57183, 678673814);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('01-01-2014', 'dd-mm-yyyy'), 39326, 336999793);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('06-12-2010', 'dd-mm-yyyy'), 93282, 981395586);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('06-01-2018', 'dd-mm-yyyy'), 67836, 956761811);
insert into DONOR (registrationdate, eventid, personid)
values (to_date('21-07-2013', 'dd-mm-yyyy'), 91795, 111732338);
commit;
prompt 188 records loaded
prompt Loading DONATION...
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (1, 9, 2247.48, to_date('28-10-2023', 'dd-mm-yyyy'), 'Credit Card', 5, 211854325);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (3, 10, 2039.18, to_date('22-07-2023', 'dd-mm-yyyy'), 'Bank Transfer', 6, 311245632);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (5, 5, 2975.31, to_date('07-02-2024', 'dd-mm-yyyy'), 'Credit Card', 2, 57056412);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (7, 10, 2392.92, to_date('19-02-2024', 'dd-mm-yyyy'), 'Bank Transfer', 6, 252158964);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (8, 1, 2339.49, to_date('08-02-2024', 'dd-mm-yyyy'), 'Online Payment', 2, 322245632);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (11, 5, 2681.5, to_date('29-11-2023', 'dd-mm-yyyy'), 'Credit Card', 8, 843267238);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (14, 4, 2072.31, to_date('28-02-2024', 'dd-mm-yyyy'), 'Cash', 2, 823217557);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (15, 5, 2458.25, to_date('07-04-2024', 'dd-mm-yyyy'), 'Bank Transfer', 1, 278483766);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (16, 11, 2786.58, to_date('23-11-2023', 'dd-mm-yyyy'), 'Bank Transfer', 9, 444897653);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (23, 11, 2261.63, to_date('19-11-2023', 'dd-mm-yyyy'), 'Bank Transfer', 6, 132478141);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (24, 2, 2594.82, to_date('19-05-2024', 'dd-mm-yyyy'), 'Bank Transfer', 8, 885851983);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (26, 5, 2749.29, to_date('20-09-2023', 'dd-mm-yyyy'), 'Online Payment', 9, 468381237);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (27, 7, 2242.19, to_date('03-04-2024', 'dd-mm-yyyy'), 'Online Payment', 1, 496513286);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (28, 3, 2792.5, to_date('12-09-2023', 'dd-mm-yyyy'), 'Credit Card', 6, 869793359);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (30, 2, 2673.42, to_date('11-05-2024', 'dd-mm-yyyy'), 'Check', 5, 675926779);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (34, 4, 2609.64, to_date('22-03-2024', 'dd-mm-yyyy'), 'Credit Card', 3, 981395586);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (35, 5, 2125.86, to_date('15-08-2023', 'dd-mm-yyyy'), 'Bank Transfer', 1, 124796735);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (36, 11, 2352.68, to_date('27-04-2024', 'dd-mm-yyyy'), 'Credit Card', 2, 792224434);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (37, 6, 2970.42, to_date('21-02-2024', 'dd-mm-yyyy'), 'Credit Card', 9, 211258385);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (39, 7, 2964.89, to_date('21-01-2024', 'dd-mm-yyyy'), 'Bank Transfer', 5, 961795379);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (42, 3, 2641.24, to_date('24-03-2024', 'dd-mm-yyyy'), 'Cash', 8, 983574126);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (46, 6, 2741.01, to_date('29-03-2024', 'dd-mm-yyyy'), 'Credit Card', 3, 338839244);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (47, 1, 2236.11, to_date('05-04-2024', 'dd-mm-yyyy'), 'Check', 9, 612496723);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (48, 3, 2512.84, to_date('04-03-2024', 'dd-mm-yyyy'), 'Check', 2, 555738385);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (49, 11, 2860.45, to_date('15-12-2023', 'dd-mm-yyyy'), 'Online Payment', 5, 218493661);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (53, 7, 2893.57, to_date('15-05-2024', 'dd-mm-yyyy'), 'Credit Card', 6, 449335211);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (55, 10, 2404.31, to_date('11-01-2024', 'dd-mm-yyyy'), 'Credit Card', 1, 312578226);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (58, 7, 2855.94, to_date('01-04-2024', 'dd-mm-yyyy'), 'Cash', 5, 569586425);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (60, 9, 2417.43, to_date('01-05-2024', 'dd-mm-yyyy'), 'Cash', 9, 856431755);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (61, 6, 2784.35, to_date('08-03-2024', 'dd-mm-yyyy'), 'Cash', 8, 698333646);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (63, 8, 2890.69, to_date('30-10-2023', 'dd-mm-yyyy'), 'Bank Transfer', 6, 612312412);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (66, 6, 2494.59, to_date('13-04-2024', 'dd-mm-yyyy'), 'Online Payment', 9, 612456769);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (67, 3, 2397.85, to_date('27-11-2023', 'dd-mm-yyyy'), 'Check', 1, 495275382);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (68, 9, 2519.28, to_date('31-01-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 799461997);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (72, 5, 2501.67, to_date('18-11-2023', 'dd-mm-yyyy'), 'Bank Transfer', 6, 219432622);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (75, 9, 2262.39, to_date('14-01-2024', 'dd-mm-yyyy'), 'Online Payment', 2, 192177347);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (79, 3, 2179.23, to_date('16-03-2024', 'dd-mm-yyyy'), 'Cash', 8, 339789768);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (82, 9, 2920.19, to_date('09-09-2023', 'dd-mm-yyyy'), 'Credit Card', 6, 115754625);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (83, 3, 2367.1, to_date('09-12-2023', 'dd-mm-yyyy'), 'Bank Transfer', 2, 759736188);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (84, 2, 2719.56, to_date('02-01-2024', 'dd-mm-yyyy'), 'Credit Card', 1, 595892174);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (90, 9, 2581.88, to_date('25-07-2023', 'dd-mm-yyyy'), 'Credit Card', 6, 389672233);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (91, 2, 2562.6, to_date('07-10-2023', 'dd-mm-yyyy'), 'Credit Card', 5, 853763113);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (93, 1, 2386.92, to_date('25-01-2024', 'dd-mm-yyyy'), 'Check', 1, 414542828);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (94, 6, 2963.56, to_date('11-02-2024', 'dd-mm-yyyy'), 'Cash', 2, 224381125);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (95, 3, 2817.29, to_date('13-08-2023', 'dd-mm-yyyy'), 'Check', 8, 548163249);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (97, 4, 2582.84, to_date('23-01-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 955984396);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (99, 5, 2648.73, to_date('27-12-2023', 'dd-mm-yyyy'), 'Check', 3, 533884378);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (102, 2, 2568.28, to_date('02-12-2023', 'dd-mm-yyyy'), 'Bank Transfer', 1, 615722688);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (103, 1, 2305.96, to_date('14-11-2023', 'dd-mm-yyyy'), 'Check', 2, 148241745);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (104, 7, 2751.23, to_date('03-02-2024', 'dd-mm-yyyy'), 'Credit Card', 9, 218757672);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (109, 3, 2269.07, to_date('26-04-2024', 'dd-mm-yyyy'), 'Credit Card', 3, 626425945);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (110, 9, 2842.1, to_date('27-01-2024', 'dd-mm-yyyy'), 'Online Payment', 6, 942889771);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (112, 4, 2965.17, to_date('18-02-2024', 'dd-mm-yyyy'), 'Cash', 1, 937311881);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (113, 8, 2327.29, to_date('12-05-2024', 'dd-mm-yyyy'), 'Check', 2, 687955148);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (115, 6, 2401.25, to_date('12-04-2024', 'dd-mm-yyyy'), 'Credit Card', 8, 356625526);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (119, 6, 2294.67, to_date('13-12-2023', 'dd-mm-yyyy'), 'Bank Transfer', 3, 728521699);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (122, 3, 2219.16, to_date('18-05-2024', 'dd-mm-yyyy'), 'Check', 1, 232428195);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (123, 4, 2399.17, to_date('04-11-2023', 'dd-mm-yyyy'), 'Credit Card', 2, 281625423);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (125, 4, 2583.98, to_date('16-01-2024', 'dd-mm-yyyy'), 'Cash', 8, 835858478);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (127, 3, 2487.72, to_date('20-07-2023', 'dd-mm-yyyy'), 'Check', 5, 815335443);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (129, 10, 2797.89, to_date('29-02-2024', 'dd-mm-yyyy'), 'Cash', 3, 127459374);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (132, 11, 2293.78, to_date('22-11-2023', 'dd-mm-yyyy'), 'Credit Card', 1, 588246249);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (133, 4, 2804.57, to_date('30-09-2023', 'dd-mm-yyyy'), 'Bank Transfer', 2, 552949541);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (134, 7, 2225.43, to_date('07-11-2023', 'dd-mm-yyyy'), 'Bank Transfer', 9, 385641543);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (135, 2, 2743.13, to_date('21-12-2023', 'dd-mm-yyyy'), 'Credit Card', 8, 712736239);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (137, 6, 2817.99, to_date('01-02-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 429493272);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (139, 9, 2466.84, to_date('26-02-2024', 'dd-mm-yyyy'), 'Credit Card', 3, 676761349);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (142, 1, 2401.64, to_date('24-01-2024', 'dd-mm-yyyy'), 'Bank Transfer', 1, 367144584);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (143, 3, 2670.19, to_date('31-07-2023', 'dd-mm-yyyy'), 'Bank Transfer', 2, 717412629);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (144, 3, 2228.48, to_date('06-08-2023', 'dd-mm-yyyy'), 'Online Payment', 9, 865638685);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (145, 8, 2419.53, to_date('11-10-2023', 'dd-mm-yyyy'), 'Cash', 8, 727881971);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (147, 9, 2964.76, to_date('07-12-2023', 'dd-mm-yyyy'), 'Check', 5, 762385283);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (149, 8, 2394.29, to_date('20-02-2024', 'dd-mm-yyyy'), 'Credit Card', 3, 111732338);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (152, 5, 2282.17, to_date('08-05-2024', 'dd-mm-yyyy'), 'Cash', 1, 493544467);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (153, 3, 2419.96, to_date('04-08-2023', 'dd-mm-yyyy'), 'Cash', 2, 352196863);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (155, 3, 2247.56, to_date('07-08-2023', 'dd-mm-yyyy'), 'Bank Transfer', 8, 913789557);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (157, 1, 2382.2, to_date('01-03-2024', 'dd-mm-yyyy'), 'Cash', 5, 728944335);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (162, 1, 2476.78, to_date('04-12-2023', 'dd-mm-yyyy'), 'Bank Transfer', 1, 449235134);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (164, 3, 2126.84, to_date('03-10-2023', 'dd-mm-yyyy'), 'Check', 9, 882879218);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (165, 6, 2248.14, to_date('09-01-2023', 'dd-mm-yyyy'), 'Credit Card', 8, 452738696);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (167, 8, 2409.37, to_date('09-10-2023', 'dd-mm-yyyy'), 'Online Payment', 5, 891718617);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (169, 2, 2775.84, to_date('13-02-2024', 'dd-mm-yyyy'), 'Bank Transfer', 3, 481194597);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (170, 9, 2506.28, to_date('02-10-2023', 'dd-mm-yyyy'), 'Cash', 6, 749856571);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (173, 1, 2184.23, to_date('17-05-2024', 'dd-mm-yyyy'), 'Check', 2, 595749885);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (174, 5, 2982.85, to_date('25-03-2024', 'dd-mm-yyyy'), 'Credit Card', 9, 839719359);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (175, 8, 2603.4, to_date('25-04-2024', 'dd-mm-yyyy'), 'Credit Card', 8, 946548967);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (179, 9, 2321.36, to_date('14-04-2024', 'dd-mm-yyyy'), 'Bank Transfer', 3, 269452927);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (180, 3, 2231.72, to_date('09-01-2024', 'dd-mm-yyyy'), 'Credit Card', 6, 892242272);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (182, 9, 2598.04, to_date('29-04-2024', 'dd-mm-yyyy'), 'Cash', 1, 876662372);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (183, 4, 2617.89, to_date('17-08-2023', 'dd-mm-yyyy'), 'Check', 2, 329354235);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (185, 3, 2138.27, to_date('25-09-2023', 'dd-mm-yyyy'), 'Bank Transfer', 8, 725484253);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (187, 6, 2271.78, to_date('02-03-2024', 'dd-mm-yyyy'), 'Bank Transfer', 5, 735234817);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (189, 7, 2460.98, to_date('25-11-2023', 'dd-mm-yyyy'), 'Cash', 3, 646383622);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (190, 2, 2163.51, to_date('30-01-2024', 'dd-mm-yyyy'), 'Check', 6, 764958648);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (193, 10, 2226.64, to_date('26-03-2024', 'dd-mm-yyyy'), 'Cash', 2, 745155142);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (194, 9, 2380.94, to_date('10-08-2023', 'dd-mm-yyyy'), 'Check', 9, 961963235);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (195, 10, 2729.41, to_date('06-09-2023', 'dd-mm-yyyy'), 'Credit Card', 8, 569834712);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (197, 10, 2173.89, to_date('19-04-2024', 'dd-mm-yyyy'), 'Bank Transfer', 5, 949629294);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (199, 4, 2345.92, to_date('12-02-2024', 'dd-mm-yyyy'), 'Bank Transfer', 3, 891453141);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (202, 10, 2980.74, to_date('11-04-2024', 'dd-mm-yyyy'), 'Online Payment', 1, 753488476);
commit;
prompt 100 records committed...
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (203, 8, 2297.65, to_date('02-02-2024', 'dd-mm-yyyy'), 'Bank Transfer', 2, 186513129);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (204, 9, 2924.5, to_date('14-09-2023', 'dd-mm-yyyy'), 'Cash', 9, 318485592);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (207, 4, 2137.82, to_date('15-02-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 162442867);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (209, 2, 2258.57, to_date('20-05-2024', 'dd-mm-yyyy'), 'Online Payment', 3, 995684566);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (210, 7, 2623.45, to_date('13-01-2024', 'dd-mm-yyyy'), 'Check', 6, 353299578);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (212, 8, 2206.15, to_date('09-07-2023', 'dd-mm-yyyy'), 'Cash', 1, 567346599);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (214, 8, 2981.25, to_date('12-12-2023', 'dd-mm-yyyy'), 'Check', 9, 671793184);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (215, 9, 2751.96, to_date('13-03-2024', 'dd-mm-yyyy'), 'Cash', 8, 956761811);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (220, 3, 2836.2, to_date('15-11-2023', 'dd-mm-yyyy'), 'Credit Card', 6, 359738524);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (223, 1, 2243.97, to_date('05-08-2023', 'dd-mm-yyyy'), 'Bank Transfer', 2, 864633429);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (225, 8, 2240.5, to_date('03-01-2024', 'dd-mm-yyyy'), 'Cash', 8, 846455483);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (230, 7, 2642.59, to_date('23-10-2023', 'dd-mm-yyyy'), 'Check', 6, 514763855);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (233, 7, 2198.2, to_date('02-11-2023', 'dd-mm-yyyy'), 'Credit Card', 2, 211124975);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (234, 10, 2613.98, to_date('04-01-2024', 'dd-mm-yyyy'), 'Check', 9, 312589229);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (237, 11, 2682.39, to_date('19-09-2023', 'dd-mm-yyyy'), 'Credit Card', 5, 336999793);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (243, 1, 2721.59, to_date('17-12-2023', 'dd-mm-yyyy'), 'Check', 2, 678673814);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (244, 6, 2902.46, to_date('12-03-2024', 'dd-mm-yyyy'), 'Cash', 9, 184921118);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (245, 1, 2891.73, to_date('18-01-2024', 'dd-mm-yyyy'), 'Check', 8, 844742226);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (247, 10, 2451.96, to_date('19-01-2024', 'dd-mm-yyyy'), 'Online Payment', 5, 935798395);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (250, 10, 2192.28, to_date('07-09-2023', 'dd-mm-yyyy'), 'Check', 6, 583491233);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (253, 5, 2178.45, to_date('18-11-2023', 'dd-mm-yyyy'), 'Bank Transfer', 2, 572551257);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (254, 2, 2734.91, to_date('15-01-2024', 'dd-mm-yyyy'), 'Credit Card', 9, 245548155);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (255, 10, 2437.38, to_date('05-10-2023', 'dd-mm-yyyy'), 'Bank Transfer', 8, 556427763);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (260, 8, 2601.49, to_date('01-12-2023', 'dd-mm-yyyy'), 'Check', 6, 185613246);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (263, 9, 2453.29, to_date('28-02-2024', 'dd-mm-yyyy'), 'Check', 2, 924391649);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (264, 8, 2802.76, to_date('04-03-2024', 'dd-mm-yyyy'), 'Check', 9, 596542332);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (265, 1, 2168.45, to_date('08-10-2023', 'dd-mm-yyyy'), 'Bank Transfer', 8, 585424715);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (267, 9, 2342.61, to_date('24-08-2023', 'dd-mm-yyyy'), 'Credit Card', 5, 295575691);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (269, 6, 2367.49, to_date('03-03-2024', 'dd-mm-yyyy'), 'Online Payment', 3, 572938411);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (275, 2, 2163.94, to_date('26-05-2024', 'dd-mm-yyyy'), 'Online Payment', 8, 695937844);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (277, 10, 2915.2, to_date('24-05-2024', 'dd-mm-yyyy'), 'Check', 5, 847364326);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (279, 1, 2268.37, to_date('30-10-2023', 'dd-mm-yyyy'), 'Check', 3, 764279839);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (280, 5, 2184.29, to_date('24-03-2024', 'dd-mm-yyyy'), 'Online Payment', 6, 715723946);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (282, 8, 2735.18, to_date('09-11-2023', 'dd-mm-yyyy'), 'Credit Card', 1, 556617211);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (283, 7, 2465.28, to_date('11-03-2024', 'dd-mm-yyyy'), 'Credit Card', 2, 593715245);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (284, 6, 2129.34, to_date('12-01-2024', 'dd-mm-yyyy'), 'Bank Transfer', 9, 666155814);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (292, 3, 2216.18, to_date('07-02-2024', 'dd-mm-yyyy'), 'Online Payment', 1, 627995199);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (294, 5, 2567.81, to_date('11-08-2023', 'dd-mm-yyyy'), 'Cash', 9, 998751539);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (295, 3, 2927.34, to_date('07-11-2023', 'dd-mm-yyyy'), 'Online Payment', 8, 277347811);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (299, 5, 2504.63, to_date('25-02-2024', 'dd-mm-yyyy'), 'Check', 3, 646215689);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (300, 6, 2671.93, to_date('19-05-2024', 'dd-mm-yyyy'), 'Bank Transfer', 6, 787856135);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (302, 1, 2458.16, to_date('01-10-2023', 'dd-mm-yyyy'), 'Online Payment', 1, 722827558);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (303, 7, 2453.18, to_date('01-03-2024', 'dd-mm-yyyy'), 'Credit Card', 2, 662591313);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (304, 10, 2379.51, to_date('03-01-2024', 'dd-mm-yyyy'), 'Bank Transfer', 9, 939775516);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (305, 9, 2328.91, to_date('19-01-2024', 'dd-mm-yyyy'), 'Cash', 8, 463663775);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (307, 1, 2519.2, to_date('08-02-2024', 'dd-mm-yyyy'), 'Bank Transfer', 5, 829814233);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (309, 3, 2209.5, to_date('30-05-2024', 'dd-mm-yyyy'), 'Credit Card', 3, 258216284);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (310, 2, 2381.25, to_date('21-09-2023', 'dd-mm-yyyy'), 'Check', 6, 873251915);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (313, 9, 2409.58, to_date('29-01-2024', 'dd-mm-yyyy'), 'Online Payment', 2, 987637154);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (320, 5, 2618.57, to_date('03-12-2023', 'dd-mm-yyyy'), 'Online Payment', 6, 366464293);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (324, 6, 2516.93, to_date('29-08-2023', 'dd-mm-yyyy'), 'Credit Card', 9, 965515364);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (325, 4, 2178.4, to_date('11-04-2024', 'dd-mm-yyyy'), 'Credit Card', 8, 142535423);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (327, 5, 2761.2, to_date('10-02-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 275735161);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (330, 7, 2528.27, to_date('26-08-2023', 'dd-mm-yyyy'), 'Bank Transfer', 6, 112464717);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (333, 6, 2298.7, to_date('11-09-2023', 'dd-mm-yyyy'), 'Online Payment', 2, 153515476);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (334, 7, 2469.38, to_date('19-02-2024', 'dd-mm-yyyy'), 'Credit Card', 9, 657467672);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (335, 1, 2801.45, to_date('27-01-2024', 'dd-mm-yyyy'), 'Cash', 8, 747616616);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (337, 2, 2684.32, to_date('06-02-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 649216418);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (339, 7, 2243.87, to_date('25-04-2024', 'dd-mm-yyyy'), 'Check', 3, 892961117);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (340, 9, 2918.75, to_date('26-02-2024', 'dd-mm-yyyy'), 'Online Payment', 6, 396354422);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (342, 10, 2392.14, to_date('18-04-2024', 'dd-mm-yyyy'), 'Cash', 1, 689787933);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (343, 5, 2405.81, to_date('29-03-2024', 'dd-mm-yyyy'), 'Bank Transfer', 2, 967965722);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (344, 7, 2513.29, to_date('01-09-2023', 'dd-mm-yyyy'), 'Credit Card', 9, 271483786);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (345, 3, 2574.32, to_date('01-10-2023', 'dd-mm-yyyy'), 'Credit Card', 8, 381683979);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (347, 6, 2805.13, to_date('23-01-2024', 'dd-mm-yyyy'), 'Cash', 5, 888793354);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (349, 6, 2401.2, to_date('28-07-2023', 'dd-mm-yyyy'), 'Bank Transfer', 3, 383953253);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (352, 9, 2871.16, to_date('20-10-2023', 'dd-mm-yyyy'), 'Check', 1, 697151836);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (353, 11, 2501.93, to_date('23-01-2024', 'dd-mm-yyyy'), 'Check', 2, 456767367);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (355, 3, 2674.19, to_date('27-02-2024', 'dd-mm-yyyy'), 'Check', 8, 577879396);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (357, 8, 2238.41, to_date('08-09-2023', 'dd-mm-yyyy'), 'Check', 5, 159952542);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (359, 1, 2489.75, to_date('11-01-2024', 'dd-mm-yyyy'), 'Check', 3, 385646575);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (360, 5, 2705.62, to_date('29-10-2023', 'dd-mm-yyyy'), 'Online Payment', 6, 897457852);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (363, 10, 2832.71, to_date('29-08-2023', 'dd-mm-yyyy'), 'Credit Card', 2, 664641138);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (365, 8, 2285.14, to_date('05-09-2023', 'dd-mm-yyyy'), 'Online Payment', 8, 461382856);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (367, 9, 2971.54, to_date('30-08-2023', 'dd-mm-yyyy'), 'Bank Transfer', 5, 927868274);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (370, 10, 2473.2, to_date('12-04-2024', 'dd-mm-yyyy'), 'Credit Card', 6, 979922972);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (374, 8, 2520.13, to_date('05-04-2024', 'dd-mm-yyyy'), 'Check', 9, 394168749);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (377, 9, 2671.47, to_date('03-10-2023', 'dd-mm-yyyy'), 'Bank Transfer', 5, 972144782);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (379, 10, 2387.2, to_date('21-08-2023', 'dd-mm-yyyy'), 'Cash', 3, 528543642);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (380, 2, 2641.89, to_date('24-04-2024', 'dd-mm-yyyy'), 'Check', 6, 852412535);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (382, 7, 2572.9, to_date('17-01-2024', 'dd-mm-yyyy'), 'Cash', 1, 186987147);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (383, 1, 2503.92, to_date('11-12-2023', 'dd-mm-yyyy'), 'Check', 2, 649858656);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (384, 9, 2893.14, to_date('22-01-2024', 'dd-mm-yyyy'), 'Cash', 9, 516217471);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (385, 3, 2572.19, to_date('21-03-2024', 'dd-mm-yyyy'), 'Online Payment', 8, 386665637);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (387, 6, 2843.74, to_date('13-02-2024', 'dd-mm-yyyy'), 'Credit Card', 5, 481424118);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (390, 11, 2501.12, to_date('19-03-2024', 'dd-mm-yyyy'), 'Check', 6, 654626772);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (394, 2, 2735.24, to_date('09-02-2024', 'dd-mm-yyyy'), 'Bank Transfer', 9, 135267658);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (399, 10, 2671.21, to_date('18-01-2024', 'dd-mm-yyyy'), 'Check', 3, 191553388);
insert into DONATION (donationid, numofpayments, amount, donationdate, paymentmethod, campaignid, donorid)
values (400, 10, 800, to_date('18-01-2022', 'dd-mm-yyyy'), 'Cash', 3, 191553388);
commit;
prompt 189 records loaded
prompt Loading EMPLOYEE...
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (67, 5, 6, 'Event Organizer', 39298, 186987147);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 5, 5, 'Telephonist', 29324, 853763113);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 4, 7, 'Project Manager', 96255, 359738524);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (73, 8, 7, 'Project Manager', 68445, 972543625);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (33, 9, 5, 'Volunteer', 35598, 899631822);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (66, 9, 10, 'Project Manager', 47292, 414542828);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 10, 9, 'Fund Raiser', 35692, 946548967);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (61, 6, 8, 'Event Organizer', 68962, 135267658);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (43, 3, 8, 'Project Manager', 74821, 754317637);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 8, 6, 'Fund Raiser', 35869, 535937329);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (95, 1, 10, 'Secretary', 88673, 278483766);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (40, 6, 7, 'Volunteer', 71519, 836952812);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (98, 4, 5, 'Volunteers Manager', 46541, 939755567);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 3, 10, 'Campaign Manager', 17373, 218757672);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (90, 1, 9, 'Event Organizer', 44377, 793365692);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (97, 4, 7, 'Secretary', 67114, 491819425);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (99, 10, 7, 'Project Manager', 66548, 481424118);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (63, 7, 8, 'Project Manager', 26944, 611164944);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 8, 8, 'Fund Raiser', 27114, 913789557);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 2, 10, 'Finance Manager', 21693, 939775516);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 7, 6, 'Secretary', 28467, 253778582);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 7, 10, 'Fund Raiser', 26687, 595749885);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 9, 7, 'Volunteers Manager', 69122, 352949287);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 8, 5, 'Campaign Manager', 62366, 749374253);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (61, 9, 5, 'Volunteer', 55281, 615959839);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 7, 7, 'Event Organizer', 64238, 972144782);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 4, 10, 'Fund Raiser', 14956, 242242944);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (83, 4, 7, 'Project Manager', 69426, 162442867);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (53, 6, 5, 'Secretary', 73396, 236776618);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (63, 8, 7, 'Volunteers Manager', 82673, 396354422);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (86, 9, 8, 'Event Manager', 74846, 115754625);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (73, 7, 7, 'Fund Raiser', 53354, 819324957);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (88, 3, 10, 'Event Organizer', 84719, 186513129);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (70, 5, 7, 'Event Organizer', 55521, 386665637);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (89, 10, 6, 'Volunteers Manager', 73655, 434234621);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (56, 10, 5, 'Project Manager', 35275, 458918148);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (90, 8, 10, 'Fund Raiser', 23622, 778893846);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (90, 2, 5, 'Volunteer', 36619, 147241172);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (77, 10, 10, 'Project Manager', 81158, 495235798);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (72, 2, 5, 'Campaign Manager', 61861, 675926779);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (52, 2, 9, 'Telephonist', 15581, 787856135);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (69, 3, 7, 'Volunteers Manager', 41247, 124796735);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 3, 7, 'Finance Manager', 93382, 485356152);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 9, 5, 'Campaign Manager', 73886, 284632359);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (35, 9, 5, 'Fund Raiser', 91249, 269773762);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (85, 2, 8, 'Event Organizer', 56583, 789246959);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (48, 5, 10, 'Telephonist', 11123, 935798395);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (53, 7, 7, 'Volunteer', 22292, 615722688);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (100, 2, 9, 'Volunteer', 93158, 975498366);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 9, 6, 'Volunteer', 97897, 572851524);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (69, 3, 5, 'Event Manager', 39126, 155999698);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 7, 9, 'Fund Raiser', 26218, 865638685);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (52, 7, 6, 'Campaign Manager', 47175, 367673877);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 4, 5, 'Volunteer', 88354, 852412535);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 5, 6, 'Volunteers Manager', 93266, 252158964);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (75, 7, 5, 'Finance Manager', 58164, 284281556);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 7, 7, 'Fund Raiser', 43666, 888795787);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 3, 9, 'Event Organizer', 78373, 336999793);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (87, 7, 10, 'Fund Raiser', 54636, 876662372);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 4, 8, 'Campaign Manager', 23342, 467159192);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (48, 4, 10, 'Finance Manager', 26992, 516217471);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (58, 5, 6, 'Volunteer', 88888, 666419193);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (80, 1, 8, 'Campaign Manager', 18428, 579494772);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (89, 10, 8, 'Campaign Manager', 65227, 484568425);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (74, 10, 6, 'Volunteer', 51339, 711722189);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (33, 7, 7, 'Volunteer', 96862, 342235525);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (33, 9, 6, 'Volunteer', 47378, 326872757);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (64, 3, 5, 'Volunteers Manager', 95447, 367315441);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 4, 10, 'Fund Raiser', 27246, 951419871);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (51, 10, 10, 'Telephonist', 56861, 152897774);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (94, 6, 8, 'Telephonist', 16868, 312589229);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (32, 8, 7, 'Campaign Manager', 61992, 625377281);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (97, 5, 10, 'Telephonist', 66945, 784921161);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 9, 5, 'Volunteer', 12581, 954722157);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (76, 3, 6, 'Telephonist', 62745, 689787933);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (33, 4, 5, 'Volunteers Manager', 91125, 973545828);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (80, 3, 10, 'Telephonist', 25487, 464357414);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (102, 6, 8, 'Volunteers Manager', 14115, 245548155);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 7, 7, 'Event Manager', 95986, 463936156);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (56, 6, 10, 'Finance Manager', 43126, 759736188);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (45, 2, 10, 'Volunteer', 22367, 556719822);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (54, 10, 5, 'Fund Raiser', 95891, 318142751);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (40, 6, 7, 'Event Manager', 81333, 218493661);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 6, 6, 'Finance Manager', 11753, 336824331);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 4, 6, 'Volunteers Manager', 98219, 595892174);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (40, 8, 5, 'Event Organizer', 57666, 627995199);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (103, 8, 9, 'Campaign Manager', 52496, 119231529);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 9, 5, 'Volunteer', 48836, 891718617);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (96, 2, 7, 'Secretary', 56356, 956761811);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 9, 9, 'Campaign Manager', 83237, 697151836);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (48, 2, 7, 'Secretary', 98397, 311245632);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (82, 3, 10, 'Fund Raiser', 54531, 459784952);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 8, 6, 'Volunteer', 55679, 533884378);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (51, 4, 6, 'Secretary', 82119, 869793359);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (43, 3, 8, 'Event Manager', 53199, 179123698);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (72, 10, 6, 'Volunteer', 37566, 821792885);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 5, 5, 'Project Manager', 79989, 456767367);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 8, 6, 'Campaign Manager', 84739, 734592929);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (101, 8, 8, 'Volunteers Manager', 49686, 942889771);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (35, 9, 9, 'Campaign Manager', 29196, 969887624);
commit;
prompt 100 records committed...
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (58, 10, 8, 'Fund Raiser', 86839, 792815389);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (99, 6, 5, 'Telephonist', 58479, 312578226);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (81, 7, 8, 'Fund Raiser', 35743, 722827558);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (72, 4, 8, 'Campaign Manager', 29361, 626425945);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (93, 2, 10, 'Event Manager', 75184, 583491233);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 8, 10, 'Fund Raiser', 73165, 366752127);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (68, 10, 6, 'Telephonist', 58393, 369644687);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (86, 8, 8, 'Fund Raiser', 21844, 156613236);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (90, 3, 8, 'Event Manager', 47145, 567346599);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (98, 10, 6, 'Telephonist', 91981, 322245632);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (45, 10, 8, 'Project Manager', 34495, 695937844);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (46, 5, 5, 'Volunteer', 97447, 572938411);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (90, 4, 5, 'Project Manager', 47681, 663973294);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (83, 7, 6, 'Secretary', 91623, 314777163);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (92, 3, 7, 'Volunteer', 74934, 612456769);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (86, 6, 9, 'Volunteer', 84254, 847364326);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (87, 8, 9, 'Event Organizer', 82678, 416855553);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (104, 10, 6, 'Project Manager', 83821, 528543642);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 10, 5, 'Volunteers Manager', 93391, 159952542);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (103, 10, 5, 'Campaign Manager', 19261, 924391649);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (75, 4, 7, 'Finance Manager', 14655, 353299578);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (64, 8, 9, 'Secretary', 11958, 224755992);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (56, 5, 7, 'Event Organizer', 35146, 496513286);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 4, 6, 'Event Manager', 48441, 715723946);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (80, 6, 7, 'Fund Raiser', 73743, 258216284);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (98, 9, 9, 'Volunteer', 38415, 885851983);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (100, 5, 10, 'Campaign Manager', 14321, 625149514);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (69, 1, 5, 'Telephonist', 34481, 899545542);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (68, 7, 5, 'Campaign Manager', 53595, 677746773);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (62, 10, 5, 'Secretary', 18374, 327234746);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (95, 10, 6, 'Telephonist', 95896, 717412629);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (40, 5, 5, 'Secretary', 99866, 381683979);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 4, 8, 'Event Organizer', 71318, 385646575);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (52, 4, 10, 'Project Manager', 66238, 689494953);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (96, 2, 7, 'Volunteer', 86479, 244861741);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (96, 8, 8, 'Project Manager', 36489, 515383699);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (87, 8, 8, 'Campaign Manager', 95952, 572551257);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (45, 5, 5, 'Secretary', 75837, 391991443);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 2, 9, 'Secretary', 58186, 596542332);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (67, 6, 7, 'Event Organizer', 53513, 699112677);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (96, 4, 6, 'Fund Raiser', 99961, 224381125);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (60, 3, 10, 'Fund Raiser', 49916, 749856571);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (67, 3, 8, 'Secretary', 29253, 211854325);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (53, 3, 10, 'Campaign Manager', 99791, 835858478);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 4, 9, 'Event Manager', 25756, 281625423);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 9, 10, 'Finance Manager', 99347, 483533519);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (34, 5, 6, 'Secretary', 77812, 811239772);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 4, 6, 'Volunteer', 95864, 113711537);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 4, 7, 'Fund Raiser', 88589, 268518746);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (77, 6, 5, 'Project Manager', 11851, 292698327);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (82, 6, 7, 'Volunteer', 18548, 929224953);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (32, 1, 6, 'Telephonist', 71444, 485277152);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (90, 7, 10, 'Volunteer', 82888, 649216418);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (84, 6, 5, 'Volunteers Manager', 21991, 728944335);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (60, 3, 10, 'Event Organizer', 37332, 237728872);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (92, 9, 6, 'Telephonist', 68499, 232428195);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (76, 9, 6, 'Secretary', 66318, 275735161);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (69, 3, 7, 'Volunteers Manager', 71715, 221854325);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (51, 4, 8, 'Volunteer', 35159, 248161537);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (87, 6, 7, 'Event Manager', 85761, 248393884);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (89, 6, 6, 'Project Manager', 45364, 259362496);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (94, 2, 8, 'Finance Manager', 82789, 383953253);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (69, 10, 5, 'Campaign Manager', 17198, 864633429);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (53, 5, 6, 'Campaign Manager', 19324, 882879218);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (55, 6, 10, 'Volunteer', 86133, 622383977);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (76, 2, 7, 'Event Manager', 85225, 343997862);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 5, 6, 'Volunteers Manager', 83286, 577742123);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (76, 8, 9, 'Campaign Manager', 66347, 479647887);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (54, 10, 8, 'Event Organizer', 51623, 394168749);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (101, 10, 9, 'Finance Manager', 99255, 769174132);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 8, 5, 'Volunteer', 82566, 473536133);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (97, 8, 6, 'Campaign Manager', 15794, 352196863);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (34, 1, 8, 'Secretary', 18413, 986723751);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (47, 7, 5, 'Campaign Manager', 67832, 142535423);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (86, 10, 5, 'Event Manager', 65747, 231384155);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (96, 10, 6, 'Secretary', 55995, 556617211);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (32, 4, 8, 'Event Manager', 86327, 127452677);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (68, 5, 5, 'Event Organizer', 68174, 185287127);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (67, 6, 10, 'Event Organizer', 76148, 735621686);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (46, 4, 8, 'Volunteers Manager', 91592, 366464293);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (81, 6, 8, 'Event Manager', 39454, 794969549);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 3, 9, 'Event Organizer', 96786, 691574567);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (43, 8, 5, 'Telephonist', 55875, 122494375);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 5, 10, 'Volunteers Manager', 91327, 185255945);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (79, 1, 5, 'Volunteer', 18896, 317635954);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (72, 7, 8, 'Fund Raiser', 99679, 514763855);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (65, 7, 9, 'Volunteers Manager', 97386, 794474241);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 6, 5, 'Volunteers Manager', 11537, 378133522);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (67, 5, 10, 'Event Manager', 93781, 356625526);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 10, 8, 'Volunteer', 87614, 819153241);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (63, 6, 8, 'Secretary', 58628, 981395586);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (54, 7, 7, 'Volunteer', 79585, 197719382);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (43, 4, 8, 'Event Organizer', 48549, 666155814);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (66, 2, 5, 'Project Manager', 86767, 385264286);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 1, 8, 'Fund Raiser', 71111, 712736239);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (55, 9, 8, 'Fund Raiser', 95528, 892961117);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 6, 6, 'Finance Manager', 62496, 269452927);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (62, 6, 9, 'Secretary', 12345, 714378859);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (46, 1, 7, 'Event Organizer', 38148, 961972549);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (77, 3, 9, 'Project Manager', 37153, 676761349);
commit;
prompt 200 records committed...
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (98, 5, 7, 'Project Manager', 74785, 671793184);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (79, 10, 7, 'Campaign Manager', 25378, 662591313);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 8, 5, 'Project Manager', 78846, 356613594);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (86, 8, 5, 'Event Organizer', 94242, 846699499);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (56, 8, 9, 'Campaign Manager', 51161, 372528246);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (97, 7, 8, 'Volunteer', 78556, 492487594);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (49, 2, 10, 'Volunteer', 26163, 728521699);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 5, 5, 'Volunteers Manager', 14939, 339789768);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (74, 5, 6, 'Volunteers Manager', 96536, 57056412);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (94, 2, 10, 'Campaign Manager', 99189, 99056412);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (99, 6, 7, 'Secretary', 92942, 897457852);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (77, 1, 10, 'Campaign Manager', 94155, 987637154);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (62, 9, 9, 'Event Organizer', 52628, 612496723);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 8, 10, 'Volunteers Manager', 76548, 687955148);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (76, 2, 8, 'Telephonist', 76472, 762385283);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 3, 8, 'Secretary', 35661, 698333646);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 4, 9, 'Secretary', 46846, 818746397);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (42, 3, 9, 'Telephonist', 43686, 646383622);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (92, 8, 10, 'Campaign Manager', 97286, 858462761);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 8, 8, 'Telephonist', 66817, 494343266);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (63, 6, 8, 'Event Organizer', 84792, 677984899);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (31, 8, 5, 'Fund Raiser', 91497, 393787716);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 10, 10, 'Volunteer', 46156, 839841634);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (82, 2, 5, 'Finance Manager', 91696, 888793354);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (99, 6, 7, 'Campaign Manager', 88169, 965515364);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (85, 8, 9, 'Fund Raiser', 14664, 311734255);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (73, 8, 6, 'Event Organizer', 65917, 364759767);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (103, 3, 7, 'Event Organizer', 48197, 951296981);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (49, 3, 6, 'Campaign Manager', 39946, 764279839);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (45, 4, 10, 'Event Organizer', 84371, 172221481);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 7, 10, 'Event Manager', 58276, 753488476);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (61, 9, 7, 'Volunteers Manager', 29693, 778227355);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 9, 10, 'Telephonist', 83241, 452738696);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (80, 1, 5, 'Volunteers Manager', 98493, 211124975);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (31, 1, 7, 'Event Manager', 24197, 775561519);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 2, 6, 'Finance Manager', 99199, 831646571);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (60, 9, 6, 'Event Organizer', 73599, 624266199);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (94, 3, 7, 'Volunteers Manager', 81452, 449335211);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (70, 4, 8, 'Volunteers Manager', 17612, 829814233);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (35, 5, 7, 'Telephonist', 22986, 192177347);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (92, 3, 7, 'Volunteer', 39877, 468381237);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (60, 5, 10, 'Project Manager', 84372, 493544467);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (75, 8, 6, 'Campaign Manager', 49396, 338839244);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (95, 2, 6, 'Telephonist', 13477, 536312268);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (44, 1, 5, 'Event Manager', 75242, 689985245);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (92, 8, 10, 'Campaign Manager', 51332, 873251915);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (73, 4, 10, 'Volunteer', 24982, 972295621);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (42, 5, 8, 'Event Organizer', 71311, 577879396);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (46, 3, 6, 'Campaign Manager', 86361, 461382856);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (42, 2, 5, 'Event Manager', 68548, 546289323);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (42, 4, 7, 'Volunteer', 63374, 657467672);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 5, 5, 'Event Manager', 29392, 389672233);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (55, 6, 10, 'Finance Manager', 65862, 864417121);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (62, 10, 7, 'Event Organizer', 58126, 275442394);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (64, 4, 9, 'Finance Manager', 46576, 564826418);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (89, 1, 6, 'Secretary', 22848, 215843618);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (83, 10, 7, 'Campaign Manager', 95899, 233358964);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (94, 4, 6, 'Campaign Manager', 92557, 392815234);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 9, 8, 'Event Manager', 11589, 393235941);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 2, 7, 'Event Manager', 63718, 678673814);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (61, 5, 8, 'Event Manager', 43138, 385641543);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 10, 10, 'Finance Manager', 26446, 683364887);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 3, 5, 'Event Manager', 62898, 529682883);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (83, 7, 9, 'Event Manager', 73717, 111234399);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (75, 4, 9, 'Volunteer', 87859, 444897653);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (69, 9, 7, 'Secretary', 59816, 522834411);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (103, 5, 5, 'Fund Raiser', 61285, 569834712);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (101, 5, 9, 'Event Manager', 62649, 891453141);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 8, 8, 'Event Organizer', 92127, 968441868);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (82, 8, 6, 'Finance Manager', 83888, 827722177);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (61, 10, 8, 'Telephonist', 55212, 513328693);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (85, 9, 8, 'Event Manager', 97587, 833442792);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (73, 1, 9, 'Fund Raiser', 67512, 961963235);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (76, 8, 10, 'Telephonist', 75345, 342679537);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (36, 10, 7, 'Telephonist', 62265, 429493272);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (40, 4, 8, 'Event Organizer', 43831, 846455483);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (52, 6, 7, 'Finance Manager', 89411, 399168515);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (65, 10, 5, 'Volunteer', 98554, 949629294);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (53, 8, 9, 'Telephonist', 75978, 199635825);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (50, 7, 6, 'Project Manager', 49389, 531448264);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (78, 5, 5, 'Telephonist', 87312, 979922972);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (77, 10, 6, 'Secretary', 66255, 462369231);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (86, 3, 6, 'Volunteers Manager', 45415, 696393696);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (97, 5, 7, 'Fund Raiser', 66614, 374499312);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 6, 8, 'Volunteer', 39532, 329948869);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (42, 1, 8, 'Campaign Manager', 34128, 664641138);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (39, 10, 10, 'Project Manager', 93825, 169179476);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 5, 7, 'Secretary', 34737, 153525296);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (61, 10, 7, 'Campaign Manager', 77498, 166129194);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (70, 1, 5, 'Event Organizer', 93423, 211258385);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (65, 5, 6, 'Event Organizer', 17243, 593715245);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (104, 7, 7, 'Campaign Manager', 95312, 318485592);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (57, 2, 7, 'Volunteer', 51718, 548163249);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (83, 5, 6, 'Volunteers Manager', 29226, 171887148);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (35, 6, 7, 'Event Manager', 44375, 585424715);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (79, 9, 8, 'Fund Raiser', 87856, 725648559);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 2, 5, 'Secretary', 85111, 288569752);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (52, 6, 9, 'Event Organizer', 98628, 531438979);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (35, 6, 7, 'Volunteer', 82128, 961125361);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (65, 8, 5, 'Volunteers Manager', 92356, 112464717);
commit;
prompt 300 records committed...
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (71, 10, 8, 'Secretary', 76412, 422367597);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (38, 2, 7, 'Event Manager', 32394, 654626772);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (65, 9, 7, 'Volunteer', 52582, 493129756);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (30, 5, 7, 'Event Manager', 73769, 166212118);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (58, 6, 9, 'Fund Raiser', 36253, 123671412);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (41, 10, 10, 'Volunteer', 89938, 655743377);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (75, 10, 5, 'Secretary', 88617, 727881971);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (75, 3, 9, 'Fund Raiser', 93343, 569586425);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (30, 1, 5, 'Project Manager', 69958, 168714263);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (58, 1, 8, 'Event Organizer', 37294, 452127625);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (59, 1, 7, 'Event Manager', 29133, 162137163);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (43, 8, 10, 'Volunteer', 87825, 943842588);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (40, 7, 10, 'Event Manager', 35578, 892242272);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (42, 10, 6, 'Event Manager', 32926, 856431755);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (43, 3, 10, 'Event Organizer', 59744, 548548833);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (94, 9, 5, 'Event Manager', 66641, 467211543);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (91, 7, 9, 'Fund Raiser', 15714, 443853155);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (58, 1, 7, 'Campaign Manager', 73361, 562229785);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (99, 10, 5, 'Telephonist', 46821, 995684566);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (85, 6, 6, 'Finance Manager', 79613, 794592687);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (67, 5, 6, 'Secretary', 21832, 967965722);
insert into EMPLOYEE (hourlywage, seniority, workhours, position, eventid, personid)
values (60, 4, 9, 'Campaign Manager', 72445, 789132274);
commit;
prompt 322 records loaded
prompt Loading EVENT...
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (89751, to_date('04-12-2021', 'dd-mm-yyyy'), 'Elad', 180, 967045685, 250191439);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (43300, to_date('03-10-2023', 'dd-mm-yyyy'), 'Haifa', 156, 402266922, 658085317);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (59452, to_date('10-08-2020', 'dd-mm-yyyy'), 'Tel-Aviv', 326, 156996771, 305044532);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (65574, to_date('22-01-2024', 'dd-mm-yyyy'), 'Ofakim', 16, 163122111, 310957227);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17332, to_date('01-10-2020', 'dd-mm-yyyy'), 'Elad', 21, 280907001, 255003607);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (52229, to_date('03-11-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 77, 722387215, 774506577);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (24497, to_date('17-03-2022', 'dd-mm-yyyy'), 'Jerusalem', 81, 331270487, 265784215);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (95518, to_date('30-05-2020', 'dd-mm-yyyy'), 'Ofakim', 169, 696264887, 744066353);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77821, to_date('16-08-2020', 'dd-mm-yyyy'), 'Tel-Aviv', 276, 959427946, 424829539);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (28270, to_date('05-03-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 200, 772239243, 692663580);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72159, to_date('14-04-2024', 'dd-mm-yyyy'), 'Netanya', 149, 404601573, 762703551);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16045, to_date('09-02-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 199, 476950972, 520994712);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (51087, to_date('18-08-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 125, 194030777, 294021950);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (43666, to_date('26-08-2020', 'dd-mm-yyyy'), 'Elad', 230, 179519832, 598388399);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (99575, to_date('11-03-2024', 'dd-mm-yyyy'), 'Beer-Sheva', 259, 615210757, 930296660);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47016, to_date('08-12-2022', 'dd-mm-yyyy'), 'Netanya', 168, 142632294, 396548079);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72419, to_date('29-06-2021', 'dd-mm-yyyy'), 'Netanya', 336, 492265472, 144982030);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41390, to_date('15-01-2024', 'dd-mm-yyyy'), 'Eilat', 371, 918113238, 596513164);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17861, to_date('23-05-2024', 'dd-mm-yyyy'), 'Jerusalem', 215, 174594959, 183648265);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (25530, to_date('15-08-2021', 'dd-mm-yyyy'), 'Haifa', 247, 580121126, 754255708);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33385, to_date('06-03-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 75, 754680918, 750741524);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (95869, to_date('16-02-2024', 'dd-mm-yyyy'), 'Haifa', 224, 335085790, 737985884);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (81977, to_date('19-04-2022', 'dd-mm-yyyy'), 'Modiin', 330, 660331401, 637351104);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (38870, to_date('07-07-2020', 'dd-mm-yyyy'), 'Ofakim', 275, 986861504, 942333691);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (91687, to_date('26-03-2024', 'dd-mm-yyyy'), 'Ofakim', 182, 931240734, 636429282);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (68266, to_date('06-05-2023', 'dd-mm-yyyy'), 'Jerusalem', 174, 588130165, 801290517);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (57451, to_date('17-01-2023', 'dd-mm-yyyy'), 'Modiin', 172, 599714565, 660522197);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41292, to_date('14-05-2024', 'dd-mm-yyyy'), 'Modiin', 183, 296701420, 288746533);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (18570, to_date('12-08-2020', 'dd-mm-yyyy'), 'Modiin', 218, 450316996, 680426414);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16845, to_date('13-08-2023', 'dd-mm-yyyy'), 'Beer-Sheva', 76, 837128025, 929606599);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72865, to_date('05-05-2021', 'dd-mm-yyyy'), 'Jerusalem', 208, 267732710, 878520462);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (86444, to_date('30-06-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 101, 171926423, 598288552);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (56539, to_date('07-07-2023', 'dd-mm-yyyy'), 'Beer-Sheva', 170, 906886399, 163316027);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (20695, to_date('19-03-2021', 'dd-mm-yyyy'), 'Givat-Shmuel', 6, 901967708, 670004227);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (55915, to_date('11-12-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 305, 897545844, 409132501);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47817, to_date('03-11-2023', 'dd-mm-yyyy'), 'Netanya', 218, 651932749, 493149616);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (78878, to_date('22-06-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 168, 111905890, 915120264);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (52150, to_date('23-09-2021', 'dd-mm-yyyy'), 'Beer-Sheva', 187, 467833075, 407038020);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (86500, to_date('03-07-2021', 'dd-mm-yyyy'), 'Givat-Shmuel', 348, 863254336, 981522911);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (46231, to_date('31-01-2021', 'dd-mm-yyyy'), 'Ofakim', 389, 862448278, 558912213);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (18240, to_date('23-05-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 284, 775502266, 572947696);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (31002, to_date('06-09-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 93, 357361140, 211608659);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33027, to_date('11-09-2022', 'dd-mm-yyyy'), 'Elad', 366, 391183717, 750838551);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77686, to_date('08-04-2022', 'dd-mm-yyyy'), 'Ashdod', 182, 680052272, 526087277);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (12816, to_date('24-05-2024', 'dd-mm-yyyy'), 'Beer-Sheva', 346, 521644179, 704145805);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (56527, to_date('28-03-2022', 'dd-mm-yyyy'), 'Jerusalem', 3, 850721377, 256071801);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (89544, to_date('16-08-2022', 'dd-mm-yyyy'), 'Elad', 36, 616146063, 923083619);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (69789, to_date('07-02-2022', 'dd-mm-yyyy'), 'Modiin', 291, 608798752, 996597984);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (28664, to_date('22-05-2021', 'dd-mm-yyyy'), 'Netanya', 149, 119086007, 853357776);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (15697, to_date('12-01-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 291, 775874518, 180419773);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (52047, to_date('14-06-2021', 'dd-mm-yyyy'), 'Ofakim', 43, 384109522, 920957501);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (78571, to_date('24-06-2021', 'dd-mm-yyyy'), 'Ofakim', 328, 201145472, 233778004);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (91908, to_date('10-11-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 360, 521718337, 989012710);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (35074, to_date('23-02-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 118, 400941265, 875278415);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (21892, to_date('01-02-2023', 'dd-mm-yyyy'), 'Holon', 285, 997089891, 489866083);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40195, to_date('25-04-2023', 'dd-mm-yyyy'), 'Netanya', 112, 490080922, 919188367);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (69247, to_date('04-03-2023', 'dd-mm-yyyy'), 'Modiin', 297, 265117239, 482480208);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (45372, to_date('17-07-2022', 'dd-mm-yyyy'), 'Elad', 176, 712572185, 504109388);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (56689, to_date('22-08-2021', 'dd-mm-yyyy'), 'Eilat', 103, 252166185, 957908575);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94631, to_date('10-04-2022', 'dd-mm-yyyy'), 'Beit-Shemesh', 73, 857747346, 263424009);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (96130, to_date('07-07-2022', 'dd-mm-yyyy'), 'Tel-Aviv', 382, 545514857, 456534421);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (14633, to_date('26-08-2023', 'dd-mm-yyyy'), 'Givat-Shmuel', 340, 447918618, 806676524);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (52833, to_date('24-07-2023', 'dd-mm-yyyy'), 'Givataim', 54, 437334122, 930998956);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (58130, to_date('16-10-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 210, 517463393, 782843319);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (66182, to_date('20-02-2024', 'dd-mm-yyyy'), 'Ashdod', 351, 756033836, 363286108);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (71601, to_date('07-06-2023', 'dd-mm-yyyy'), 'Jerusalem', 144, 263910725, 116898816);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77965, to_date('13-10-2022', 'dd-mm-yyyy'), 'Ashdod', 46, 505375742, 147046688);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (27612, to_date('10-07-2023', 'dd-mm-yyyy'), 'Ofakim', 160, 947286140, 585070584);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (85994, to_date('03-10-2022', 'dd-mm-yyyy'), 'Givataim', 52, 361367000, 240130604);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (70428, to_date('28-10-2022', 'dd-mm-yyyy'), 'Netanya', 289, 362756599, 397036820);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82162, to_date('14-08-2020', 'dd-mm-yyyy'), 'Elad', 331, 823700381, 506851037);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (97256, to_date('13-04-2023', 'dd-mm-yyyy'), 'Eilat', 115, 206130561, 505997396);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (98500, to_date('09-07-2021', 'dd-mm-yyyy'), 'Jerusalem', 395, 651649959, 760281063);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (20230, to_date('10-08-2022', 'dd-mm-yyyy'), 'Elad', 237, 672038929, 565951410);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (62370, to_date('26-08-2022', 'dd-mm-yyyy'), 'Beit-Shemesh', 375, 512983275, 471096652);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (98088, to_date('29-05-2023', 'dd-mm-yyyy'), 'Haifa', 66, 292681633, 541241286);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (98133, to_date('25-12-2022', 'dd-mm-yyyy'), 'Holon', 321, 850180930, 374850757);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (61903, to_date('11-04-2022', 'dd-mm-yyyy'), 'Givat-Shmuel', 292, 178746180, 904171273);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (91656, to_date('28-04-2024', 'dd-mm-yyyy'), 'Givataim', 7, 423231009, 932405899);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37906, to_date('22-03-2023', 'dd-mm-yyyy'), 'Jerusalem', 297, 888690113, 505653440);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (30527, to_date('19-11-2021', 'dd-mm-yyyy'), 'Netanya', 357, 524316899, 348206375);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (81703, to_date('29-08-2020', 'dd-mm-yyyy'), 'Modiin', 95, 248025888, 705595327);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48678, to_date('12-02-2021', 'dd-mm-yyyy'), 'Beit-Shemesh', 324, 758078831, 351830457);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (35339, to_date('20-05-2021', 'dd-mm-yyyy'), 'Ofakim', 313, 714190300, 555385696);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (30325, to_date('11-10-2020', 'dd-mm-yyyy'), 'Modiin', 138, 500451912, 363371742);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (50418, to_date('11-10-2020', 'dd-mm-yyyy'), 'Modiin', 249, 657574200, 401171217);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (88423, to_date('07-08-2021', 'dd-mm-yyyy'), 'Jerusalem', 346, 477459023, 146931645);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (76286, to_date('17-01-2023', 'dd-mm-yyyy'), 'Netanya', 48, 711501978, 566718520);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (42888, to_date('16-03-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 259, 359652888, 113425821);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (58316, to_date('22-06-2020', 'dd-mm-yyyy'), 'Ashdod', 308, 722562795, 403469798);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (57863, to_date('22-08-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 26, 701436529, 474353836);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (12176, to_date('11-03-2021', 'dd-mm-yyyy'), 'Haifa', 255, 410078054, 343351298);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (27399, to_date('05-05-2024', 'dd-mm-yyyy'), 'Eilat', 88, 808011578, 979723180);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47984, to_date('25-04-2021', 'dd-mm-yyyy'), 'Jerusalem', 40, 374638763, 376431788);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (68002, to_date('10-11-2023', 'dd-mm-yyyy'), 'Givataim', 338, 197525202, 141925251);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (39985, to_date('29-09-2021', 'dd-mm-yyyy'), 'Modiin', 4, 625155187, 796567126);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (56487, to_date('24-06-2022', 'dd-mm-yyyy'), 'Holon', 320, 904567308, 822215992);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48072, to_date('08-10-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 340, 337497578, 845155041);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (93625, to_date('11-12-2021', 'dd-mm-yyyy'), 'Netanya', 289, 386051507, 990410311);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (42198, to_date('21-02-2023', 'dd-mm-yyyy'), 'Givat-Shmuel', 292, 856988103, 562527520);
commit;
prompt 100 records committed...
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48926, to_date('20-07-2020', 'dd-mm-yyyy'), 'Givat-Shmuel', 89, 851869537, 852057645);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (39885, to_date('17-12-2023', 'dd-mm-yyyy'), 'Holon', 322, 163305896, 597212209);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94653, to_date('11-12-2021', 'dd-mm-yyyy'), 'Ofakim', 344, 583556535, 330109445);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (50462, to_date('03-03-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 42, 188807583, 672947877);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (84494, to_date('31-10-2020', 'dd-mm-yyyy'), 'Beit-Shemesh', 300, 533849263, 895707987);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40156, to_date('19-09-2021', 'dd-mm-yyyy'), 'Bnei-Braq', 372, 746390846, 116977868);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (19644, to_date('08-07-2021', 'dd-mm-yyyy'), 'Beit-Shemesh', 94, 778102020, 521184527);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94559, to_date('27-02-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 294, 632079493, 962503703);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (15898, to_date('18-02-2022', 'dd-mm-yyyy'), 'Eilat', 299, 757005661, 190090784);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33410, to_date('08-06-2022', 'dd-mm-yyyy'), 'Eilat', 24, 631533640, 200112753);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (78979, to_date('13-11-2021', 'dd-mm-yyyy'), 'Netanya', 33, 493363651, 576449765);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40092, to_date('06-06-2023', 'dd-mm-yyyy'), 'Elad', 307, 803229707, 479537804);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (97647, to_date('09-08-2023', 'dd-mm-yyyy'), 'Modiin', 323, 921688256, 485547181);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (61931, to_date('31-03-2021', 'dd-mm-yyyy'), 'Ofakim', 286, 305436048, 170657484);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (73494, to_date('30-08-2022', 'dd-mm-yyyy'), 'Givat-Shmuel', 241, 229914562, 613508820);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72339, to_date('09-01-2023', 'dd-mm-yyyy'), 'Givataim', 140, 668494513, 596592169);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (32000, to_date('18-04-2022', 'dd-mm-yyyy'), 'Ofakim', 110, 601123197, 824016092);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (39251, to_date('15-06-2021', 'dd-mm-yyyy'), 'Eilat', 159, 586318523, 472017700);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94296, to_date('15-11-2020', 'dd-mm-yyyy'), 'Haifa', 6, 543290625, 171230394);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (62323, to_date('13-11-2020', 'dd-mm-yyyy'), 'Givataim', 2, 197745845, 660740787);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (54830, to_date('26-05-2023', 'dd-mm-yyyy'), 'Ofakim', 105, 291712196, 149375817);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (84224, to_date('03-06-2023', 'dd-mm-yyyy'), 'Haifa', 397, 270912560, 731201547);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (11560, to_date('13-07-2022', 'dd-mm-yyyy'), 'Tel-Aviv', 381, 124592742, 733777949);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (96543, to_date('06-12-2022', 'dd-mm-yyyy'), 'Jerusalem', 243, 598408998, 490784953);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (81808, to_date('28-04-2022', 'dd-mm-yyyy'), 'Eilat', 242, 703654251, 535465667);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (98694, to_date('23-07-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 221, 454941720, 196044591);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (44760, to_date('03-01-2023', 'dd-mm-yyyy'), 'Eilat', 19, 541738107, 410675376);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82308, to_date('15-02-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 393, 290793810, 711244129);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (31833, to_date('16-11-2023', 'dd-mm-yyyy'), 'Netanya', 331, 388736593, 636703565);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (21118, to_date('26-01-2024', 'dd-mm-yyyy'), 'Givat-Shmuel', 125, 500976745, 460018565);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (44830, to_date('13-04-2024', 'dd-mm-yyyy'), 'Holon', 328, 923860953, 144468945);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (67153, to_date('07-10-2021', 'dd-mm-yyyy'), 'Holon', 164, 885762632, 629801942);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (85164, to_date('11-10-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 278, 172055523, 376900347);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (30056, to_date('09-11-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 229, 318206521, 272855047);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (15280, to_date('26-04-2023', 'dd-mm-yyyy'), 'Givat-Shmuel', 361, 346549521, 743253448);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (69539, to_date('12-11-2021', 'dd-mm-yyyy'), 'Eilat', 72, 885316132, 581882304);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (92962, to_date('05-04-2023', 'dd-mm-yyyy'), 'Holon', 349, 956669792, 223543108);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (90251, to_date('16-09-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 19, 540672512, 859957599);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77424, to_date('22-11-2020', 'dd-mm-yyyy'), 'Jerusalem', 329, 974480352, 112259726);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (36361, to_date('25-05-2022', 'dd-mm-yyyy'), 'Netanya', 37, 220498479, 196608159);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (98492, to_date('01-04-2024', 'dd-mm-yyyy'), 'Haifa', 170, 453671064, 480671024);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (67091, to_date('10-12-2021', 'dd-mm-yyyy'), 'Elad', 221, 744565789, 855154914);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (25152, to_date('03-12-2022', 'dd-mm-yyyy'), 'Haifa', 321, 675225059, 286236122);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (55999, to_date('01-11-2021', 'dd-mm-yyyy'), 'Beer-Sheva', 361, 145005339, 645151846);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (53683, to_date('26-03-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 375, 783554521, 362326707);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (27718, to_date('05-09-2022', 'dd-mm-yyyy'), 'Haifa', 174, 180113595, 998006144);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (76010, to_date('29-08-2020', 'dd-mm-yyyy'), 'Eilat', 247, 338376526, 968959822);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (78770, to_date('26-12-2021', 'dd-mm-yyyy'), 'Ashdod', 290, 816431067, 248063233);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (51364, to_date('20-10-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 326, 681051337, 735633171);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17786, to_date('10-04-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 98, 360223693, 697234693);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (64102, to_date('17-10-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 101, 873844045, 178696202);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (50584, to_date('09-07-2023', 'dd-mm-yyyy'), 'Elad', 231, 694681477, 958361730);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (30922, to_date('10-01-2023', 'dd-mm-yyyy'), 'Givat-Shmuel', 30, 412005137, 180623555);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (62494, to_date('28-11-2021', 'dd-mm-yyyy'), 'Elad', 82, 331564303, 671881883);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (34535, to_date('04-06-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 120, 385643294, 723034207);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (57565, to_date('13-03-2024', 'dd-mm-yyyy'), 'Givataim', 355, 596427116, 758895732);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (27262, to_date('25-11-2021', 'dd-mm-yyyy'), 'Beit-Shemesh', 127, 436244271, 965321416);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77202, to_date('22-11-2021', 'dd-mm-yyyy'), 'Beit-Shemesh', 399, 573751984, 582985718);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82686, to_date('15-08-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 88, 838169247, 864007145);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (88334, to_date('31-10-2021', 'dd-mm-yyyy'), 'Givataim', 234, 831220961, 652181227);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (93073, to_date('09-09-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 127, 818413718, 308563321);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (76273, to_date('08-04-2024', 'dd-mm-yyyy'), 'Eilat', 8, 535510885, 320852368);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41165, to_date('28-04-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 170, 421412532, 564006980);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (59740, to_date('07-09-2020', 'dd-mm-yyyy'), 'Jerusalem', 127, 250679022, 991156306);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (44566, to_date('18-03-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 328, 429295660, 590994301);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94616, to_date('10-11-2023', 'dd-mm-yyyy'), 'Ashdod', 32, 457055013, 566696986);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (28243, to_date('05-02-2022', 'dd-mm-yyyy'), 'Modiin', 90, 425945916, 363416111);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (11578, to_date('19-10-2021', 'dd-mm-yyyy'), 'Ofakim', 388, 588230123, 335230902);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82485, to_date('03-09-2023', 'dd-mm-yyyy'), 'Eilat', 235, 487008235, 114242191);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (29921, to_date('27-09-2020', 'dd-mm-yyyy'), 'Givat-Shmuel', 15, 662061977, 191564668);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (28205, to_date('08-11-2020', 'dd-mm-yyyy'), 'Modiin', 396, 418365842, 623375391);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17602, to_date('19-11-2022', 'dd-mm-yyyy'), 'Givataim', 229, 516375188, 841739267);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77596, to_date('08-03-2022', 'dd-mm-yyyy'), 'Ofakim', 319, 660439310, 354784649);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (23911, to_date('29-12-2021', 'dd-mm-yyyy'), 'Modiin', 236, 493828540, 813484473);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16261, to_date('25-10-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 389, 642850460, 318823803);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (29232, to_date('25-09-2021', 'dd-mm-yyyy'), 'Ofakim', 333, 496920027, 477126298);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (97588, to_date('24-01-2022', 'dd-mm-yyyy'), 'Jerusalem', 23, 932208156, 292245037);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (90740, to_date('01-04-2024', 'dd-mm-yyyy'), 'Givataim', 157, 760251076, 994878732);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (92009, to_date('16-12-2021', 'dd-mm-yyyy'), 'Ashdod', 150, 263731009, 680925665);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41248, to_date('04-06-2022', 'dd-mm-yyyy'), 'Modiin', 320, 918288234, 845293512);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (95971, to_date('16-07-2020', 'dd-mm-yyyy'), 'Jerusalem', 77, 495064140, 161928121);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (51910, to_date('14-08-2020', 'dd-mm-yyyy'), 'Beit-Shemesh', 322, 281815597, 513373835);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (18682, to_date('11-05-2024', 'dd-mm-yyyy'), 'Netanya', 398, 536860943, 291163065);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (12609, to_date('04-11-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 372, 970561092, 786151732);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (90010, to_date('13-08-2021', 'dd-mm-yyyy'), 'Ofakim', 268, 935076771, 988259228);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (24501, to_date('09-01-2022', 'dd-mm-yyyy'), 'Tel-Aviv', 77, 574336052, 755071283);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (95426, to_date('17-02-2021', 'dd-mm-yyyy'), 'Eilat', 311, 411568270, 136448187);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17415, to_date('13-06-2021', 'dd-mm-yyyy'), 'Ofakim', 158, 585944126, 747998301);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94409, to_date('19-06-2021', 'dd-mm-yyyy'), 'Eilat', 394, 785159486, 743798073);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (24519, to_date('24-10-2023', 'dd-mm-yyyy'), 'Modiin', 309, 172214548, 262905581);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (79843, to_date('06-02-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 327, 359643802, 962387994);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40671, to_date('11-03-2021', 'dd-mm-yyyy'), 'Netanya', 195, 311877931, 889343584);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (64660, to_date('02-11-2023', 'dd-mm-yyyy'), 'Holon', 124, 152269762, 749466647);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82301, to_date('24-05-2024', 'dd-mm-yyyy'), 'Beer-Sheva', 245, 800677694, 946581893);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (93053, to_date('08-10-2020', 'dd-mm-yyyy'), 'Beer-Sheva', 399, 592112062, 766357521);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (49744, to_date('21-03-2022', 'dd-mm-yyyy'), 'Haifa', 352, 480102882, 553573066);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (20835, to_date('24-10-2023', 'dd-mm-yyyy'), 'Haifa', 280, 389465146, 813093495);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40091, to_date('01-06-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 288, 263611080, 552581002);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (29203, to_date('25-08-2020', 'dd-mm-yyyy'), 'Jerusalem', 112, 778558356, 329930537);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (91087, to_date('12-06-2020', 'dd-mm-yyyy'), 'Ofakim', 248, 406333419, 386251512);
commit;
prompt 200 records committed...
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (18150, to_date('15-12-2022', 'dd-mm-yyyy'), 'Beit-Shemesh', 338, 297339934, 868217932);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (66885, to_date('17-02-2022', 'dd-mm-yyyy'), 'Netanya', 358, 320758954, 917552853);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (35075, to_date('24-01-2024', 'dd-mm-yyyy'), 'Netanya', 279, 932644567, 232606447);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (62115, to_date('13-03-2021', 'dd-mm-yyyy'), 'Eilat', 222, 870595003, 958726614);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (19355, to_date('02-11-2023', 'dd-mm-yyyy'), 'Elad', 158, 982746213, 991097864);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (29645, to_date('01-10-2020', 'dd-mm-yyyy'), 'Netanya', 68, 632304835, 239908928);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (27731, to_date('10-09-2022', 'dd-mm-yyyy'), 'Netanya', 27, 625283980, 609907708);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (80446, to_date('03-12-2020', 'dd-mm-yyyy'), 'Jerusalem', 309, 175322929, 221925843);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (69300, to_date('06-02-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 315, 482231269, 655747291);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37277, to_date('10-05-2024', 'dd-mm-yyyy'), 'Jerusalem', 175, 182697921, 878862418);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (13118, to_date('14-07-2022', 'dd-mm-yyyy'), 'Holon', 208, 236509046, 290256956);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (24524, to_date('23-07-2020', 'dd-mm-yyyy'), 'Ofakim', 135, 878706889, 454910750);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (62856, to_date('18-06-2023', 'dd-mm-yyyy'), 'Netanya', 218, 439733672, 703887006);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (58090, to_date('21-07-2022', 'dd-mm-yyyy'), 'Givat-Shmuel', 26, 229332275, 711789835);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (85224, to_date('02-07-2020', 'dd-mm-yyyy'), 'Jerusalem', 61, 674549409, 610531677);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (20609, to_date('20-11-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 94, 704982824, 558305177);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47992, to_date('29-12-2020', 'dd-mm-yyyy'), 'Holon', 364, 356835839, 770433338);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (45704, to_date('20-11-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 321, 501115280, 818722052);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16356, to_date('27-10-2023', 'dd-mm-yyyy'), 'Ofakim', 20, 829129077, 907294433);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16608, to_date('11-09-2021', 'dd-mm-yyyy'), 'Holon', 218, 701317293, 490033153);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (81281, to_date('11-05-2021', 'dd-mm-yyyy'), 'Givat-Shmuel', 285, 327681464, 866216965);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (25757, to_date('04-04-2024', 'dd-mm-yyyy'), 'Bnei-Braq', 323, 350680971, 502535809);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (78761, to_date('21-01-2023', 'dd-mm-yyyy'), 'Elad', 353, 583582369, 887153484);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (13715, to_date('18-09-2020', 'dd-mm-yyyy'), 'Modiin', 382, 892288830, 525891957);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (46849, to_date('20-10-2023', 'dd-mm-yyyy'), 'Modiin', 77, 136830277, 398026821);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (58370, to_date('07-01-2023', 'dd-mm-yyyy'), 'Beer-Sheva', 148, 153504319, 421934417);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (61545, to_date('14-09-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 23, 362767895, 811979682);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (87742, to_date('17-08-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 398, 398559029, 497595985);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17460, to_date('12-09-2020', 'dd-mm-yyyy'), 'Elad', 325, 202633754, 440283934);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (67082, to_date('12-03-2022', 'dd-mm-yyyy'), 'Givataim', 218, 314288285, 184359738);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (39367, to_date('26-07-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 108, 251293070, 179771897);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (73768, to_date('17-01-2021', 'dd-mm-yyyy'), 'Ashdod', 202, 670130265, 929243201);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77527, to_date('07-09-2023', 'dd-mm-yyyy'), 'Holon', 29, 503019968, 610791480);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (89687, to_date('03-03-2024', 'dd-mm-yyyy'), 'Ashdod', 99, 559581714, 740353079);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (31189, to_date('01-02-2024', 'dd-mm-yyyy'), 'Netanya', 182, 416824151, 500969866);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (23040, to_date('28-12-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 16, 544697141, 179784222);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (35324, to_date('12-01-2024', 'dd-mm-yyyy'), 'Holon', 169, 355769573, 839333701);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (93426, to_date('15-05-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 320, 644754471, 702634238);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (66781, to_date('25-12-2020', 'dd-mm-yyyy'), 'Ofakim', 163, 247184684, 575562675);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (55730, to_date('11-01-2022', 'dd-mm-yyyy'), 'Eilat', 148, 932000558, 194836573);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (60659, to_date('23-10-2021', 'dd-mm-yyyy'), 'Netanya', 58, 679018338, 825996992);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (98791, to_date('10-03-2021', 'dd-mm-yyyy'), 'Netanya', 341, 372295580, 209893434);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (79821, to_date('05-11-2021', 'dd-mm-yyyy'), 'Eilat', 386, 979995412, 758652168);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (90059, to_date('29-06-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 220, 776818770, 985965938);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (61324, to_date('11-08-2022', 'dd-mm-yyyy'), 'Givat-Shmuel', 175, 412763771, 787909633);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (93212, to_date('08-05-2022', 'dd-mm-yyyy'), 'Netanya', 94, 450047663, 765319732);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (44026, to_date('19-06-2022', 'dd-mm-yyyy'), 'Beit-Shemesh', 36, 166184517, 294839797);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (32707, to_date('13-06-2022', 'dd-mm-yyyy'), 'Eilat', 289, 418801363, 761794783);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (19827, to_date('05-05-2021', 'dd-mm-yyyy'), 'Ashdod', 273, 235446752, 833975541);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48022, to_date('21-12-2023', 'dd-mm-yyyy'), 'Givataim', 174, 782817562, 715361909);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (65087, to_date('17-10-2023', 'dd-mm-yyyy'), 'Holon', 17, 985518267, 740924516);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (80060, to_date('26-04-2022', 'dd-mm-yyyy'), 'Givataim', 301, 545526282, 200334839);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (21422, to_date('13-04-2021', 'dd-mm-yyyy'), 'Ofakim', 134, 642998777, 999173189);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (54458, to_date('21-02-2022', 'dd-mm-yyyy'), 'Elad', 335, 268389643, 518813235);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37931, to_date('26-11-2021', 'dd-mm-yyyy'), 'Givataim', 147, 459946996, 564844448);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (65349, to_date('10-09-2020', 'dd-mm-yyyy'), 'Holon', 272, 939430005, 294208775);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (73364, to_date('28-04-2022', 'dd-mm-yyyy'), 'Jerusalem', 47, 339598015, 581651209);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40586, to_date('11-12-2022', 'dd-mm-yyyy'), 'Jerusalem', 362, 893532342, 169386978);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (49481, to_date('10-06-2023', 'dd-mm-yyyy'), 'Modiin', 332, 497030242, 279806834);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47131, to_date('19-01-2023', 'dd-mm-yyyy'), 'Ofakim', 279, 555826240, 527875564);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33649, to_date('29-12-2022', 'dd-mm-yyyy'), 'Netanya', 134, 232456549, 536400058);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72250, to_date('21-09-2023', 'dd-mm-yyyy'), 'Ashdod', 56, 227619553, 169205187);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (67131, to_date('09-03-2021', 'dd-mm-yyyy'), 'Jerusalem', 176, 248883281, 243467901);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (55713, to_date('24-01-2022', 'dd-mm-yyyy'), 'Tel-Aviv', 50, 663307146, 691631205);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (88867, to_date('29-08-2021', 'dd-mm-yyyy'), 'Ashdod', 322, 934478849, 386864884);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (55094, to_date('06-02-2023', 'dd-mm-yyyy'), 'Beer-Sheva', 79, 924426198, 815055489);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40615, to_date('21-01-2022', 'dd-mm-yyyy'), 'Givataim', 29, 301363847, 944598414);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (45208, to_date('23-12-2022', 'dd-mm-yyyy'), 'Modiin', 368, 220238971, 181585958);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (91403, to_date('13-04-2021', 'dd-mm-yyyy'), 'Eilat', 307, 416430726, 298366726);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (23591, to_date('01-09-2020', 'dd-mm-yyyy'), 'Tel-Aviv', 101, 493977181, 433014760);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (36360, to_date('31-05-2020', 'dd-mm-yyyy'), 'Bnei-Braq', 28, 607264759, 550311137);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82305, to_date('16-02-2021', 'dd-mm-yyyy'), 'Givataim', 390, 498478240, 691739494);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33824, to_date('27-03-2021', 'dd-mm-yyyy'), 'Beit-Shemesh', 182, 673050017, 430941224);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (18317, to_date('28-03-2024', 'dd-mm-yyyy'), 'Modiin', 59, 918631658, 317307277);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (79574, to_date('23-08-2020', 'dd-mm-yyyy'), 'Haifa', 260, 139133065, 291029060);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77567, to_date('26-05-2020', 'dd-mm-yyyy'), 'Tel-Aviv', 163, 328390300, 386648983);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (99594, to_date('30-11-2020', 'dd-mm-yyyy'), 'Beit-Shemesh', 323, 372287619, 471854392);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17635, to_date('10-07-2020', 'dd-mm-yyyy'), 'Modiin', 275, 164880895, 713163663);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17237, to_date('20-12-2021', 'dd-mm-yyyy'), 'Haifa', 285, 194160132, 143975955);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (89342, to_date('07-10-2022', 'dd-mm-yyyy'), 'Ofakim', 350, 401562928, 143122259);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (22271, to_date('09-10-2020', 'dd-mm-yyyy'), 'Beer-Sheva', 97, 830418895, 445450467);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (44556, to_date('28-11-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 139, 698891559, 399859902);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72795, to_date('07-07-2023', 'dd-mm-yyyy'), 'Beer-Sheva', 248, 997067183, 620303931);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48831, to_date('01-07-2023', 'dd-mm-yyyy'), 'Jerusalem', 309, 607641540, 984331869);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (12540, to_date('30-12-2022', 'dd-mm-yyyy'), 'Bnei-Braq', 11, 268333473, 794070538);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (63433, to_date('15-05-2024', 'dd-mm-yyyy'), 'Tel-Aviv', 257, 530454859, 489449706);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41663, to_date('25-11-2021', 'dd-mm-yyyy'), 'Ashdod', 243, 799436960, 772254329);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (45546, to_date('06-06-2023', 'dd-mm-yyyy'), 'Ashdod', 328, 555267922, 369363969);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (40485, to_date('05-01-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 200, 558091326, 964433809);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (49957, to_date('18-11-2020', 'dd-mm-yyyy'), 'Givat-Shmuel', 394, 550571369, 702752816);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (53051, to_date('06-05-2024', 'dd-mm-yyyy'), 'Netanya', 355, 797084895, 174810354);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (71669, to_date('22-10-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 6, 767935042, 703065519);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (67368, to_date('14-12-2023', 'dd-mm-yyyy'), 'Givataim', 270, 847418578, 737203637);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (77117, to_date('24-10-2021', 'dd-mm-yyyy'), 'Ofakim', 26, 776998200, 342335843);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (23079, to_date('30-04-2022', 'dd-mm-yyyy'), 'Beit-Shemesh', 280, 176259028, 179055083);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (46442, to_date('19-11-2022', 'dd-mm-yyyy'), 'Eilat', 74, 794148271, 856844470);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (11656, to_date('06-07-2020', 'dd-mm-yyyy'), 'Jerusalem', 291, 917095165, 991067461);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (87602, to_date('14-07-2020', 'dd-mm-yyyy'), 'Haifa', 208, 489762861, 206739292);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (85348, to_date('25-06-2023', 'dd-mm-yyyy'), 'Netanya', 7, 610726295, 441660269);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (85419, to_date('01-12-2022', 'dd-mm-yyyy'), 'Eilat', 394, 772157790, 808805007);
commit;
prompt 300 records committed...
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48528, to_date('17-05-2021', 'dd-mm-yyyy'), 'Eilat', 255, 639202059, 260128393);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (12238, to_date('27-09-2023', 'dd-mm-yyyy'), 'Jerusalem', 341, 123315211, 669866578);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41499, to_date('10-10-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 66, 966247973, 750047314);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (61637, to_date('23-02-2021', 'dd-mm-yyyy'), 'Modiin', 109, 149801667, 782563907);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37168, to_date('31-05-2021', 'dd-mm-yyyy'), 'Elad', 385, 263166624, 718685553);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47034, to_date('26-08-2023', 'dd-mm-yyyy'), 'Netanya', 28, 364486330, 636492065);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (95115, to_date('18-09-2020', 'dd-mm-yyyy'), 'Haifa', 296, 500434196, 648551904);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (53554, to_date('12-03-2021', 'dd-mm-yyyy'), 'Netanya', 315, 922055303, 635458049);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (24263, to_date('18-08-2022', 'dd-mm-yyyy'), 'Holon', 352, 362761104, 653033311);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (22349, to_date('28-12-2021', 'dd-mm-yyyy'), 'Ashdod', 212, 822428825, 967027318);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37207, to_date('16-01-2024', 'dd-mm-yyyy'), 'Haifa', 64, 335628842, 397473527);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (64348, to_date('20-06-2022', 'dd-mm-yyyy'), 'Elad', 310, 129821970, 678834158);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (90005, to_date('26-10-2021', 'dd-mm-yyyy'), 'Jerusalem', 162, 672097720, 574057489);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (97484, to_date('08-04-2021', 'dd-mm-yyyy'), 'Modiin', 214, 536944404, 422766506);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48512, to_date('24-12-2023', 'dd-mm-yyyy'), 'Holon', 71, 440490462, 487051444);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (48510, to_date('19-07-2021', 'dd-mm-yyyy'), 'Ofakim', 107, 466309914, 585043746);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (32334, to_date('30-08-2021', 'dd-mm-yyyy'), 'Netanya', 51, 529293424, 555531592);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (21023, to_date('09-04-2022', 'dd-mm-yyyy'), 'Modiin', 327, 723878078, 333974409);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (80342, to_date('04-04-2024', 'dd-mm-yyyy'), 'Ashdod', 207, 333061971, 832826365);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (81410, to_date('02-01-2023', 'dd-mm-yyyy'), 'Elad', 12, 851788082, 372580691);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (22012, to_date('21-07-2023', 'dd-mm-yyyy'), 'Tel-Aviv', 323, 837130199, 231920268);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (56339, to_date('03-07-2022', 'dd-mm-yyyy'), 'Haifa', 387, 469506474, 764058793);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (43536, to_date('25-02-2021', 'dd-mm-yyyy'), 'Elad', 267, 186077837, 904351304);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (20151, to_date('01-02-2023', 'dd-mm-yyyy'), 'Ashdod', 220, 957808543, 449134221);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47717, to_date('08-07-2021', 'dd-mm-yyyy'), 'Ashdod', 65, 657120806, 523996630);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (22364, to_date('14-06-2020', 'dd-mm-yyyy'), 'Modiin', 96, 964715668, 769107437);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (95482, to_date('24-08-2020', 'dd-mm-yyyy'), 'Netanya', 132, 986025393, 835901043);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (80442, to_date('24-06-2023', 'dd-mm-yyyy'), 'Ashdod', 53, 752748760, 667932730);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (88504, to_date('04-02-2021', 'dd-mm-yyyy'), 'Beit-Shemesh', 189, 689191916, 135603224);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (80429, to_date('16-08-2020', 'dd-mm-yyyy'), 'Beer-Sheva', 358, 483825121, 639690293);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (84751, to_date('09-06-2021', 'dd-mm-yyyy'), 'Ofakim', 6, 195312729, 922193692);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (73428, to_date('01-03-2021', 'dd-mm-yyyy'), 'Holon', 165, 732738858, 175173939);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (39453, to_date('07-01-2024', 'dd-mm-yyyy'), 'Ashdod', 275, 886014592, 495028447);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (45626, to_date('02-12-2020', 'dd-mm-yyyy'), 'Bnei-Braq', 244, 586379641, 492955749);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (36007, to_date('26-08-2021', 'dd-mm-yyyy'), 'Modiin', 10, 861983589, 387086481);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72188, to_date('13-11-2022', 'dd-mm-yyyy'), 'Eilat', 311, 638613429, 310434999);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (82300, to_date('27-05-2020', 'dd-mm-yyyy'), 'Holon', 158, 704204559, 631232211);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (41436, to_date('11-10-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 348, 514034095, 219699561);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (18334, to_date('01-12-2020', 'dd-mm-yyyy'), 'Modiin', 350, 698380515, 554485879);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (81296, to_date('21-01-2021', 'dd-mm-yyyy'), 'Netanya', 96, 261777794, 749645938);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33547, to_date('30-12-2020', 'dd-mm-yyyy'), 'Beit-Shemesh', 355, 750649605, 625436732);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (88346, to_date('15-11-2022', 'dd-mm-yyyy'), 'Givataim', 167, 648252908, 323381776);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (91615, to_date('09-02-2023', 'dd-mm-yyyy'), 'Beit-Shemesh', 4, 678030312, 724986759);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (76171, to_date('26-08-2023', 'dd-mm-yyyy'), 'Eilat', 54, 825092910, 144457546);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (25439, to_date('10-04-2024', 'dd-mm-yyyy'), 'Ashdod', 191, 541438517, 445349636);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (90917, to_date('17-01-2021', 'dd-mm-yyyy'), 'Holon', 58, 676059812, 306836293);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (66243, to_date('11-01-2021', 'dd-mm-yyyy'), 'Bnei-Braq', 317, 566273394, 673754139);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37253, to_date('26-11-2022', 'dd-mm-yyyy'), 'Elad', 281, 303723676, 270118417);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (94508, to_date('17-12-2020', 'dd-mm-yyyy'), 'Modiin', 198, 976725556, 766851930);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (25897, to_date('14-10-2023', 'dd-mm-yyyy'), 'Ashdod', 184, 480619529, 741124094);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16798, to_date('07-08-2023', 'dd-mm-yyyy'), 'Eilat', 111, 478290312, 289980188);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (56877, to_date('11-08-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 127, 887580910, 830246269);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (97759, to_date('08-04-2024', 'dd-mm-yyyy'), 'Elad', 146, 637542055, 689687837);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (75995, to_date('18-04-2024', 'dd-mm-yyyy'), 'Givat-Shmuel', 237, 496956884, 491193345);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (49242, to_date('10-09-2022', 'dd-mm-yyyy'), 'Ofakim', 355, 387377314, 921391738);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72873, to_date('19-05-2022', 'dd-mm-yyyy'), 'Beit-Shemesh', 387, 127105748, 422783262);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (25603, to_date('20-08-2023', 'dd-mm-yyyy'), 'Bnei-Braq', 157, 204404291, 435278501);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (37533, to_date('18-09-2022', 'dd-mm-yyyy'), 'Givat-Shmuel', 195, 467397344, 399761169);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (97139, to_date('18-01-2023', 'dd-mm-yyyy'), 'Jerusalem', 189, 757934375, 810667711);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (89950, to_date('18-05-2021', 'dd-mm-yyyy'), 'Eilat', 290, 590697897, 134293740);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (72557, to_date('22-08-2020', 'dd-mm-yyyy'), 'Tel-Aviv', 357, 422058918, 289418883);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (13099, to_date('13-12-2022', 'dd-mm-yyyy'), 'Givataim', 357, 256250900, 890153213);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (99156, to_date('01-02-2024', 'dd-mm-yyyy'), 'Eilat', 49, 115704715, 236433103);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (13981, to_date('14-11-2023', 'dd-mm-yyyy'), 'Givat-Shmuel', 87, 617982663, 388018179);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (87836, to_date('09-12-2020', 'dd-mm-yyyy'), 'Haifa', 303, 949070950, 931550442);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (28158, to_date('06-04-2024', 'dd-mm-yyyy'), 'Eilat', 329, 500269804, 596514601);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47982, to_date('05-03-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 212, 944787395, 239931106);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (88993, to_date('06-12-2020', 'dd-mm-yyyy'), 'Haifa', 257, 908897493, 627796999);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (79682, to_date('09-03-2022', 'dd-mm-yyyy'), 'Eilat', 237, 842708860, 911598495);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (79893, to_date('18-10-2023', 'dd-mm-yyyy'), 'Ashdod', 113, 811875953, 812405293);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (87442, to_date('02-04-2021', 'dd-mm-yyyy'), 'Ashdod', 303, 429835151, 198413769);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47257, to_date('14-05-2021', 'dd-mm-yyyy'), 'Haifa', 166, 885466017, 996564530);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (16402, to_date('22-10-2020', 'dd-mm-yyyy'), 'Netanya', 124, 128014017, 693055856);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (57476, to_date('23-10-2023', 'dd-mm-yyyy'), 'Givataim', 213, 506797051, 699177100);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (70951, to_date('08-09-2021', 'dd-mm-yyyy'), 'Haifa', 91, 372622627, 698823995);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (22805, to_date('28-09-2021', 'dd-mm-yyyy'), 'Tel-Aviv', 74, 936499954, 845963512);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (19766, to_date('02-04-2023', 'dd-mm-yyyy'), 'Ofakim', 316, 726762968, 271345145);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (39375, to_date('06-08-2021', 'dd-mm-yyyy'), 'Beer-Sheva', 218, 584542921, 403134743);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (73003, to_date('10-12-2023', 'dd-mm-yyyy'), 'Haifa', 239, 166851893, 777175645);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (51902, to_date('19-11-2022', 'dd-mm-yyyy'), 'Beer-Sheva', 120, 559479998, 867604314);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (44944, to_date('24-03-2023', 'dd-mm-yyyy'), 'Givataim', 359, 177040870, 623111163);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (58464, to_date('14-02-2021', 'dd-mm-yyyy'), 'Bnei-Braq', 232, 648859674, 541567663);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (45885, to_date('16-07-2021', 'dd-mm-yyyy'), 'Givat-Shmuel', 285, 945065250, 475229002);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (47618, to_date('07-05-2024', 'dd-mm-yyyy'), 'Eilat', 263, 179021805, 198909729);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (28310, to_date('01-03-2021', 'dd-mm-yyyy'), 'Givataim', 47, 909293137, 524704761);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (33782, to_date('07-06-2021', 'dd-mm-yyyy'), 'Eilat', 61, 292478132, 267125443);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (13014, to_date('03-10-2022', 'dd-mm-yyyy'), 'Haifa', 318, 523096153, 574063809);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (17620, to_date('27-03-2022', 'dd-mm-yyyy'), 'Modiin', 371, 137749514, 402785244);
insert into EVENT (eventid, eventdate, eventlocation, campaignid, employeeid, donorid_)
values (15422, to_date('14-02-2023', 'dd-mm-yyyy'), 'Netanya', 89, 449182098, 123417473);
commit;
prompt 389 records loaded
prompt Loading PARTICIPATES...
insert into PARTICIPATES (donorid, eventid)
values (111732338, 35074);
insert into PARTICIPATES (donorid, eventid)
values (111732338, 61324);
insert into PARTICIPATES (donorid, eventid)
values (111732338, 79682);
insert into PARTICIPATES (donorid, eventid)
values (112464717, 29232);
insert into PARTICIPATES (donorid, eventid)
values (115754625, 82308);
insert into PARTICIPATES (donorid, eventid)
values (124796735, 60659);
insert into PARTICIPATES (donorid, eventid)
values (124796735, 67131);
insert into PARTICIPATES (donorid, eventid)
values (132478141, 27612);
insert into PARTICIPATES (donorid, eventid)
values (132478141, 90251);
insert into PARTICIPATES (donorid, eventid)
values (135267658, 28158);
insert into PARTICIPATES (donorid, eventid)
values (135267658, 95971);
insert into PARTICIPATES (donorid, eventid)
values (142535423, 73428);
insert into PARTICIPATES (donorid, eventid)
values (142535423, 99156);
insert into PARTICIPATES (donorid, eventid)
values (148241745, 20695);
insert into PARTICIPATES (donorid, eventid)
values (148241745, 36360);
insert into PARTICIPATES (donorid, eventid)
values (153515476, 66781);
insert into PARTICIPATES (donorid, eventid)
values (159952542, 40586);
insert into PARTICIPATES (donorid, eventid)
values (162442867, 41436);
insert into PARTICIPATES (donorid, eventid)
values (162442867, 82301);
insert into PARTICIPATES (donorid, eventid)
values (184921118, 15280);
insert into PARTICIPATES (donorid, eventid)
values (184921118, 52229);
insert into PARTICIPATES (donorid, eventid)
values (184921118, 69300);
insert into PARTICIPATES (donorid, eventid)
values (186513129, 27399);
insert into PARTICIPATES (donorid, eventid)
values (186513129, 30922);
insert into PARTICIPATES (donorid, eventid)
values (186513129, 94508);
insert into PARTICIPATES (donorid, eventid)
values (191553388, 48678);
insert into PARTICIPATES (donorid, eventid)
values (191553388, 62323);
insert into PARTICIPATES (donorid, eventid)
values (192177347, 45372);
insert into PARTICIPATES (donorid, eventid)
values (192177347, 73364);
insert into PARTICIPATES (donorid, eventid)
values (211124975, 20835);
insert into PARTICIPATES (donorid, eventid)
values (211124975, 57565);
insert into PARTICIPATES (donorid, eventid)
values (211124975, 58090);
insert into PARTICIPATES (donorid, eventid)
values (211258385, 53051);
insert into PARTICIPATES (donorid, eventid)
values (211258385, 90059);
insert into PARTICIPATES (donorid, eventid)
values (211258385, 97759);
insert into PARTICIPATES (donorid, eventid)
values (219432622, 88867);
insert into PARTICIPATES (donorid, eventid)
values (224381125, 40195);
insert into PARTICIPATES (donorid, eventid)
values (224381125, 47982);
insert into PARTICIPATES (donorid, eventid)
values (232428195, 25897);
insert into PARTICIPATES (donorid, eventid)
values (232428195, 97647);
insert into PARTICIPATES (donorid, eventid)
values (252158964, 40195);
insert into PARTICIPATES (donorid, eventid)
values (258216284, 97484);
insert into PARTICIPATES (donorid, eventid)
values (269452927, 40671);
insert into PARTICIPATES (donorid, eventid)
values (275735161, 25603);
insert into PARTICIPATES (donorid, eventid)
values (275735161, 91403);
insert into PARTICIPATES (donorid, eventid)
values (277347811, 98088);
insert into PARTICIPATES (donorid, eventid)
values (278483766, 36007);
insert into PARTICIPATES (donorid, eventid)
values (278483766, 71601);
insert into PARTICIPATES (donorid, eventid)
values (278483766, 89342);
insert into PARTICIPATES (donorid, eventid)
values (281625423, 12176);
insert into PARTICIPATES (donorid, eventid)
values (281625423, 78761);
insert into PARTICIPATES (donorid, eventid)
values (295575691, 89687);
insert into PARTICIPATES (donorid, eventid)
values (311245632, 90251);
insert into PARTICIPATES (donorid, eventid)
values (329354235, 84224);
insert into PARTICIPATES (donorid, eventid)
values (336999793, 29203);
insert into PARTICIPATES (donorid, eventid)
values (338839244, 94559);
insert into PARTICIPATES (donorid, eventid)
values (339789768, 27262);
insert into PARTICIPATES (donorid, eventid)
values (366464293, 15422);
insert into PARTICIPATES (donorid, eventid)
values (367144584, 40092);
insert into PARTICIPATES (donorid, eventid)
values (367144584, 41499);
insert into PARTICIPATES (donorid, eventid)
values (381683979, 12816);
insert into PARTICIPATES (donorid, eventid)
values (381683979, 24519);
insert into PARTICIPATES (donorid, eventid)
values (381683979, 33027);
insert into PARTICIPATES (donorid, eventid)
values (383953253, 42198);
insert into PARTICIPATES (donorid, eventid)
values (383953253, 58370);
insert into PARTICIPATES (donorid, eventid)
values (385641543, 19644);
insert into PARTICIPATES (donorid, eventid)
values (385646575, 13118);
insert into PARTICIPATES (donorid, eventid)
values (385646575, 13715);
insert into PARTICIPATES (donorid, eventid)
values (385646575, 51364);
insert into PARTICIPATES (donorid, eventid)
values (385646575, 51902);
insert into PARTICIPATES (donorid, eventid)
values (385646575, 66243);
insert into PARTICIPATES (donorid, eventid)
values (385646575, 97256);
insert into PARTICIPATES (donorid, eventid)
values (386665637, 82308);
insert into PARTICIPATES (donorid, eventid)
values (389672233, 49481);
insert into PARTICIPATES (donorid, eventid)
values (389672233, 65087);
insert into PARTICIPATES (donorid, eventid)
values (389672233, 87742);
insert into PARTICIPATES (donorid, eventid)
values (394168749, 82485);
insert into PARTICIPATES (donorid, eventid)
values (394168749, 91687);
insert into PARTICIPATES (donorid, eventid)
values (414542828, 52833);
insert into PARTICIPATES (donorid, eventid)
values (429493272, 54830);
insert into PARTICIPATES (donorid, eventid)
values (429493272, 61931);
insert into PARTICIPATES (donorid, eventid)
values (444897653, 75995);
insert into PARTICIPATES (donorid, eventid)
values (449235134, 37931);
insert into PARTICIPATES (donorid, eventid)
values (449235134, 45208);
insert into PARTICIPATES (donorid, eventid)
values (452738696, 41499);
insert into PARTICIPATES (donorid, eventid)
values (452738696, 59452);
insert into PARTICIPATES (donorid, eventid)
values (456767367, 33385);
insert into PARTICIPATES (donorid, eventid)
values (456767367, 94631);
insert into PARTICIPATES (donorid, eventid)
values (463663775, 56539);
insert into PARTICIPATES (donorid, eventid)
values (468381237, 35075);
insert into PARTICIPATES (donorid, eventid)
values (481194597, 50462);
insert into PARTICIPATES (donorid, eventid)
values (481424118, 40615);
insert into PARTICIPATES (donorid, eventid)
values (481424118, 87836);
insert into PARTICIPATES (donorid, eventid)
values (493544467, 21118);
insert into PARTICIPATES (donorid, eventid)
values (493544467, 87742);
insert into PARTICIPATES (donorid, eventid)
values (495275382, 27399);
insert into PARTICIPATES (donorid, eventid)
values (495275382, 62323);
insert into PARTICIPATES (donorid, eventid)
values (496513286, 16608);
insert into PARTICIPATES (donorid, eventid)
values (496513286, 56539);
insert into PARTICIPATES (donorid, eventid)
values (514763855, 43300);
commit;
prompt 100 records committed...
insert into PARTICIPATES (donorid, eventid)
values (514763855, 80446);
insert into PARTICIPATES (donorid, eventid)
values (514763855, 87836);
insert into PARTICIPATES (donorid, eventid)
values (514763855, 98088);
insert into PARTICIPATES (donorid, eventid)
values (528543642, 20151);
insert into PARTICIPATES (donorid, eventid)
values (528543642, 67131);
insert into PARTICIPATES (donorid, eventid)
values (548163249, 13715);
insert into PARTICIPATES (donorid, eventid)
values (548163249, 47016);
insert into PARTICIPATES (donorid, eventid)
values (548163249, 80442);
insert into PARTICIPATES (donorid, eventid)
values (552949541, 61903);
insert into PARTICIPATES (donorid, eventid)
values (555738385, 47131);
insert into PARTICIPATES (donorid, eventid)
values (555738385, 64348);
insert into PARTICIPATES (donorid, eventid)
values (556427763, 29921);
insert into PARTICIPATES (donorid, eventid)
values (556617211, 73428);
insert into PARTICIPATES (donorid, eventid)
values (569586425, 90740);
insert into PARTICIPATES (donorid, eventid)
values (569834712, 47992);
insert into PARTICIPATES (donorid, eventid)
values (569834712, 88423);
insert into PARTICIPATES (donorid, eventid)
values (569834712, 91403);
insert into PARTICIPATES (donorid, eventid)
values (572938411, 30922);
insert into PARTICIPATES (donorid, eventid)
values (572938411, 72250);
insert into PARTICIPATES (donorid, eventid)
values (577879396, 61545);
insert into PARTICIPATES (donorid, eventid)
values (583491233, 18334);
insert into PARTICIPATES (donorid, eventid)
values (583491233, 47618);
insert into PARTICIPATES (donorid, eventid)
values (583491233, 61931);
insert into PARTICIPATES (donorid, eventid)
values (585424715, 17415);
insert into PARTICIPATES (donorid, eventid)
values (585424715, 35074);
insert into PARTICIPATES (donorid, eventid)
values (585424715, 47982);
insert into PARTICIPATES (donorid, eventid)
values (588246249, 52047);
insert into PARTICIPATES (donorid, eventid)
values (588246249, 80429);
insert into PARTICIPATES (donorid, eventid)
values (593715245, 41436);
insert into PARTICIPATES (donorid, eventid)
values (595749885, 81296);
insert into PARTICIPATES (donorid, eventid)
values (595749885, 87602);
insert into PARTICIPATES (donorid, eventid)
values (595892174, 57863);
insert into PARTICIPATES (donorid, eventid)
values (612312412, 17415);
insert into PARTICIPATES (donorid, eventid)
values (612312412, 18150);
insert into PARTICIPATES (donorid, eventid)
values (612312412, 25152);
insert into PARTICIPATES (donorid, eventid)
values (612456769, 15280);
insert into PARTICIPATES (donorid, eventid)
values (612456769, 17460);
insert into PARTICIPATES (donorid, eventid)
values (612456769, 93426);
insert into PARTICIPATES (donorid, eventid)
values (612496723, 81977);
insert into PARTICIPATES (donorid, eventid)
values (615722688, 21892);
insert into PARTICIPATES (donorid, eventid)
values (615722688, 28664);
insert into PARTICIPATES (donorid, eventid)
values (627995199, 46231);
insert into PARTICIPATES (donorid, eventid)
values (627995199, 78979);
insert into PARTICIPATES (donorid, eventid)
values (646215689, 45372);
insert into PARTICIPATES (donorid, eventid)
values (649216418, 51364);
insert into PARTICIPATES (donorid, eventid)
values (649216418, 90917);
insert into PARTICIPATES (donorid, eventid)
values (654626772, 16608);
insert into PARTICIPATES (donorid, eventid)
values (654626772, 95971);
insert into PARTICIPATES (donorid, eventid)
values (662591313, 81808);
insert into PARTICIPATES (donorid, eventid)
values (666155814, 13099);
insert into PARTICIPATES (donorid, eventid)
values (666155814, 24524);
insert into PARTICIPATES (donorid, eventid)
values (671793184, 17460);
insert into PARTICIPATES (donorid, eventid)
values (675926779, 11656);
insert into PARTICIPATES (donorid, eventid)
values (676761349, 15280);
insert into PARTICIPATES (donorid, eventid)
values (676761349, 44026);
insert into PARTICIPATES (donorid, eventid)
values (676761349, 70951);
insert into PARTICIPATES (donorid, eventid)
values (678673814, 20230);
insert into PARTICIPATES (donorid, eventid)
values (678673814, 62115);
insert into PARTICIPATES (donorid, eventid)
values (687955148, 82300);
insert into PARTICIPATES (donorid, eventid)
values (689787933, 13099);
insert into PARTICIPATES (donorid, eventid)
values (695937844, 80429);
insert into PARTICIPATES (donorid, eventid)
values (695937844, 84751);
insert into PARTICIPATES (donorid, eventid)
values (697151836, 15280);
insert into PARTICIPATES (donorid, eventid)
values (697151836, 44026);
insert into PARTICIPATES (donorid, eventid)
values (697151836, 49242);
insert into PARTICIPATES (donorid, eventid)
values (697151836, 53051);
insert into PARTICIPATES (donorid, eventid)
values (697151836, 69247);
insert into PARTICIPATES (donorid, eventid)
values (697151836, 69789);
insert into PARTICIPATES (donorid, eventid)
values (698333646, 65087);
insert into PARTICIPATES (donorid, eventid)
values (715723946, 17415);
insert into PARTICIPATES (donorid, eventid)
values (715723946, 21118);
insert into PARTICIPATES (donorid, eventid)
values (717412629, 17415);
insert into PARTICIPATES (donorid, eventid)
values (717412629, 44556);
insert into PARTICIPATES (donorid, eventid)
values (722827558, 47618);
insert into PARTICIPATES (donorid, eventid)
values (722827558, 86444);
insert into PARTICIPATES (donorid, eventid)
values (727881971, 56339);
insert into PARTICIPATES (donorid, eventid)
values (727881971, 84751);
insert into PARTICIPATES (donorid, eventid)
values (728521699, 13118);
insert into PARTICIPATES (donorid, eventid)
values (728521699, 21118);
insert into PARTICIPATES (donorid, eventid)
values (728521699, 44944);
insert into PARTICIPATES (donorid, eventid)
values (728944335, 20835);
insert into PARTICIPATES (donorid, eventid)
values (728944335, 47984);
insert into PARTICIPATES (donorid, eventid)
values (728944335, 88334);
insert into PARTICIPATES (donorid, eventid)
values (735234817, 47717);
insert into PARTICIPATES (donorid, eventid)
values (745155142, 24263);
insert into PARTICIPATES (donorid, eventid)
values (745155142, 32707);
insert into PARTICIPATES (donorid, eventid)
values (745155142, 34535);
insert into PARTICIPATES (donorid, eventid)
values (745155142, 37906);
insert into PARTICIPATES (donorid, eventid)
values (745155142, 39375);
insert into PARTICIPATES (donorid, eventid)
values (747616616, 81296);
insert into PARTICIPATES (donorid, eventid)
values (749856571, 25439);
insert into PARTICIPATES (donorid, eventid)
values (749856571, 45208);
insert into PARTICIPATES (donorid, eventid)
values (749856571, 90005);
insert into PARTICIPATES (donorid, eventid)
values (753488476, 16261);
insert into PARTICIPATES (donorid, eventid)
values (753488476, 29232);
insert into PARTICIPATES (donorid, eventid)
values (753488476, 36360);
insert into PARTICIPATES (donorid, eventid)
values (759736188, 18240);
insert into PARTICIPATES (donorid, eventid)
values (759736188, 37168);
insert into PARTICIPATES (donorid, eventid)
values (759736188, 43536);
insert into PARTICIPATES (donorid, eventid)
values (759736188, 69300);
commit;
prompt 200 records committed...
insert into PARTICIPATES (donorid, eventid)
values (762385283, 25530);
insert into PARTICIPATES (donorid, eventid)
values (762385283, 98088);
insert into PARTICIPATES (donorid, eventid)
values (764958648, 24263);
insert into PARTICIPATES (donorid, eventid)
values (764958648, 44760);
insert into PARTICIPATES (donorid, eventid)
values (787856135, 30325);
insert into PARTICIPATES (donorid, eventid)
values (792224434, 37906);
insert into PARTICIPATES (donorid, eventid)
values (792224434, 40615);
insert into PARTICIPATES (donorid, eventid)
values (799461997, 28310);
insert into PARTICIPATES (donorid, eventid)
values (799461997, 29921);
insert into PARTICIPATES (donorid, eventid)
values (799461997, 77686);
insert into PARTICIPATES (donorid, eventid)
values (799461997, 81703);
insert into PARTICIPATES (donorid, eventid)
values (815335443, 18682);
insert into PARTICIPATES (donorid, eventid)
values (815335443, 24263);
insert into PARTICIPATES (donorid, eventid)
values (815335443, 30056);
insert into PARTICIPATES (donorid, eventid)
values (815335443, 60659);
insert into PARTICIPATES (donorid, eventid)
values (815335443, 73768);
insert into PARTICIPATES (donorid, eventid)
values (815335443, 81281);
insert into PARTICIPATES (donorid, eventid)
values (829814233, 33649);
insert into PARTICIPATES (donorid, eventid)
values (829814233, 51902);
insert into PARTICIPATES (donorid, eventid)
values (829814233, 88346);
insert into PARTICIPATES (donorid, eventid)
values (835858478, 51910);
insert into PARTICIPATES (donorid, eventid)
values (835858478, 84751);
insert into PARTICIPATES (donorid, eventid)
values (839719359, 13099);
insert into PARTICIPATES (donorid, eventid)
values (839719359, 66182);
insert into PARTICIPATES (donorid, eventid)
values (839719359, 77527);
insert into PARTICIPATES (donorid, eventid)
values (843267238, 21118);
insert into PARTICIPATES (donorid, eventid)
values (843267238, 22349);
insert into PARTICIPATES (donorid, eventid)
values (843267238, 78761);
insert into PARTICIPATES (donorid, eventid)
values (843267238, 88346);
insert into PARTICIPATES (donorid, eventid)
values (844742226, 28243);
insert into PARTICIPATES (donorid, eventid)
values (844742226, 50418);
insert into PARTICIPATES (donorid, eventid)
values (844742226, 50584);
insert into PARTICIPATES (donorid, eventid)
values (844742226, 78571);
insert into PARTICIPATES (donorid, eventid)
values (844742226, 82301);
insert into PARTICIPATES (donorid, eventid)
values (846455483, 12816);
insert into PARTICIPATES (donorid, eventid)
values (846455483, 25603);
insert into PARTICIPATES (donorid, eventid)
values (846455483, 40156);
insert into PARTICIPATES (donorid, eventid)
values (846455483, 44566);
insert into PARTICIPATES (donorid, eventid)
values (846455483, 48926);
insert into PARTICIPATES (donorid, eventid)
values (853763113, 47257);
insert into PARTICIPATES (donorid, eventid)
values (853763113, 66243);
insert into PARTICIPATES (donorid, eventid)
values (856431755, 69789);
insert into PARTICIPATES (donorid, eventid)
values (856431755, 94508);
insert into PARTICIPATES (donorid, eventid)
values (865638685, 33385);
insert into PARTICIPATES (donorid, eventid)
values (865638685, 84494);
insert into PARTICIPATES (donorid, eventid)
values (869793359, 16608);
insert into PARTICIPATES (donorid, eventid)
values (869793359, 49744);
insert into PARTICIPATES (donorid, eventid)
values (869793359, 84224);
insert into PARTICIPATES (donorid, eventid)
values (873251915, 18150);
insert into PARTICIPATES (donorid, eventid)
values (873251915, 20835);
insert into PARTICIPATES (donorid, eventid)
values (876662372, 61637);
insert into PARTICIPATES (donorid, eventid)
values (882879218, 23040);
insert into PARTICIPATES (donorid, eventid)
values (882879218, 25152);
insert into PARTICIPATES (donorid, eventid)
values (885851983, 39985);
insert into PARTICIPATES (donorid, eventid)
values (885851983, 50462);
insert into PARTICIPATES (donorid, eventid)
values (891453141, 51902);
insert into PARTICIPATES (donorid, eventid)
values (891718617, 29203);
insert into PARTICIPATES (donorid, eventid)
values (892961117, 17786);
insert into PARTICIPATES (donorid, eventid)
values (892961117, 21422);
insert into PARTICIPATES (donorid, eventid)
values (892961117, 36361);
insert into PARTICIPATES (donorid, eventid)
values (897457852, 13014);
insert into PARTICIPATES (donorid, eventid)
values (897457852, 15697);
insert into PARTICIPATES (donorid, eventid)
values (897457852, 16261);
insert into PARTICIPATES (donorid, eventid)
values (897457852, 42888);
insert into PARTICIPATES (donorid, eventid)
values (924391649, 24497);
insert into PARTICIPATES (donorid, eventid)
values (924391649, 48831);
insert into PARTICIPATES (donorid, eventid)
values (924391649, 81296);
insert into PARTICIPATES (donorid, eventid)
values (927868274, 56539);
insert into PARTICIPATES (donorid, eventid)
values (935798395, 40485);
insert into PARTICIPATES (donorid, eventid)
values (937311881, 94631);
insert into PARTICIPATES (donorid, eventid)
values (946548967, 81281);
insert into PARTICIPATES (donorid, eventid)
values (946548967, 94559);
insert into PARTICIPATES (donorid, eventid)
values (949629294, 97647);
insert into PARTICIPATES (donorid, eventid)
values (955984396, 16798);
insert into PARTICIPATES (donorid, eventid)
values (955984396, 27718);
insert into PARTICIPATES (donorid, eventid)
values (955984396, 37168);
insert into PARTICIPATES (donorid, eventid)
values (956761811, 30325);
insert into PARTICIPATES (donorid, eventid)
values (956761811, 33782);
insert into PARTICIPATES (donorid, eventid)
values (956761811, 56527);
insert into PARTICIPATES (donorid, eventid)
values (961795379, 88346);
insert into PARTICIPATES (donorid, eventid)
values (961963235, 29921);
insert into PARTICIPATES (donorid, eventid)
values (961963235, 32707);
insert into PARTICIPATES (donorid, eventid)
values (961963235, 97588);
insert into PARTICIPATES (donorid, eventid)
values (961963235, 98088);
insert into PARTICIPATES (donorid, eventid)
values (972144782, 47982);
insert into PARTICIPATES (donorid, eventid)
values (981395586, 82485);
insert into PARTICIPATES (donorid, eventid)
values (983574126, 20609);
insert into PARTICIPATES (donorid, eventid)
values (987637154, 24497);
insert into PARTICIPATES (donorid, eventid)
values (987637154, 47984);
insert into PARTICIPATES (donorid, eventid)
values (995684566, 78571);
insert into PARTICIPATES (donorid, eventid)
values (995684566, 89950);
insert into PARTICIPATES (donorid, eventid)
values (998751539, 94616);
commit;
prompt 292 records loaded
prompt Loading WORKSON...
insert into WORKSON (eventid, employeeid)
values (11560, 124796735);
insert into WORKSON (eventid, employeeid)
values (11560, 556719822);
insert into WORKSON (eventid, employeeid)
values (11560, 676761349);
insert into WORKSON (eventid, employeeid)
values (11578, 443853155);
insert into WORKSON (eventid, employeeid)
values (11656, 162137163);
insert into WORKSON (eventid, employeeid)
values (11656, 899631822);
insert into WORKSON (eventid, employeeid)
values (11656, 951419871);
insert into WORKSON (eventid, employeeid)
values (12176, 385646575);
insert into WORKSON (eventid, employeeid)
values (12609, 949629294);
insert into WORKSON (eventid, employeeid)
values (12816, 119231529);
insert into WORKSON (eventid, employeeid)
values (12816, 753488476);
insert into WORKSON (eventid, employeeid)
values (13118, 548548833);
insert into WORKSON (eventid, employeeid)
values (13715, 386665637);
insert into WORKSON (eventid, employeeid)
values (13715, 789246959);
insert into WORKSON (eventid, employeeid)
values (15280, 864417121);
insert into WORKSON (eventid, employeeid)
values (16045, 172221481);
insert into WORKSON (eventid, employeeid)
values (16045, 735621686);
insert into WORKSON (eventid, employeeid)
values (16045, 935798395);
insert into WORKSON (eventid, employeeid)
values (16045, 939775516);
insert into WORKSON (eventid, employeeid)
values (16356, 722827558);
insert into WORKSON (eventid, employeeid)
values (16845, 339789768);
insert into WORKSON (eventid, employeeid)
values (16845, 569834712);
insert into WORKSON (eventid, employeeid)
values (16845, 853763113);
insert into WORKSON (eventid, employeeid)
values (17332, 429493272);
insert into WORKSON (eventid, employeeid)
values (17332, 975498366);
insert into WORKSON (eventid, employeeid)
values (17415, 338839244);
insert into WORKSON (eventid, employeeid)
values (17415, 356625526);
insert into WORKSON (eventid, employeeid)
values (17460, 224755992);
insert into WORKSON (eventid, employeeid)
values (17602, 979922972);
insert into WORKSON (eventid, employeeid)
values (17620, 248393884);
insert into WORKSON (eventid, employeeid)
values (17620, 493129756);
insert into WORKSON (eventid, employeeid)
values (17786, 312589229);
insert into WORKSON (eventid, employeeid)
values (17861, 683364887);
insert into WORKSON (eventid, employeeid)
values (18150, 416855553);
insert into WORKSON (eventid, employeeid)
values (18240, 831646571);
insert into WORKSON (eventid, employeeid)
values (18317, 242242944);
insert into WORKSON (eventid, employeeid)
values (18317, 392815234);
insert into WORKSON (eventid, employeeid)
values (18334, 987637154);
insert into WORKSON (eventid, employeeid)
values (18570, 577742123);
insert into WORKSON (eventid, employeeid)
values (18682, 336824331);
insert into WORKSON (eventid, employeeid)
values (19644, 759736188);
insert into WORKSON (eventid, employeeid)
values (19766, 676761349);
insert into WORKSON (eventid, employeeid)
values (19766, 728944335);
insert into WORKSON (eventid, employeeid)
values (19766, 882879218);
insert into WORKSON (eventid, employeeid)
values (19827, 115754625);
insert into WORKSON (eventid, employeeid)
values (19827, 142535423);
insert into WORKSON (eventid, employeeid)
values (19827, 835858478);
insert into WORKSON (eventid, employeeid)
values (20151, 268518746);
insert into WORKSON (eventid, employeeid)
values (20230, 612496723);
insert into WORKSON (eventid, employeeid)
values (20695, 123671412);
insert into WORKSON (eventid, employeeid)
values (20695, 556617211);
insert into WORKSON (eventid, employeeid)
values (20835, 946548967);
insert into WORKSON (eventid, employeeid)
values (21023, 961972549);
insert into WORKSON (eventid, employeeid)
values (21118, 215843618);
insert into WORKSON (eventid, employeeid)
values (21118, 625377281);
insert into WORKSON (eventid, employeeid)
values (21422, 444897653);
insert into WORKSON (eventid, employeeid)
values (22012, 624266199);
insert into WORKSON (eventid, employeeid)
values (22271, 956761811);
insert into WORKSON (eventid, employeeid)
values (22805, 972295621);
insert into WORKSON (eventid, employeeid)
values (23079, 484568425);
insert into WORKSON (eventid, employeeid)
values (23591, 312578226);
insert into WORKSON (eventid, employeeid)
values (23911, 689985245);
insert into WORKSON (eventid, employeeid)
values (24497, 326872757);
insert into WORKSON (eventid, employeeid)
values (24497, 572551257);
insert into WORKSON (eventid, employeeid)
values (24497, 689494953);
insert into WORKSON (eventid, employeeid)
values (24501, 485356152);
insert into WORKSON (eventid, employeeid)
values (24519, 939775516);
insert into WORKSON (eventid, employeeid)
values (25152, 383953253);
insert into WORKSON (eventid, employeeid)
values (25152, 722827558);
insert into WORKSON (eventid, employeeid)
values (25603, 456767367);
insert into WORKSON (eventid, employeeid)
values (25603, 556617211);
insert into WORKSON (eventid, employeeid)
values (25757, 352949287);
insert into WORKSON (eventid, employeeid)
values (25897, 393787716);
insert into WORKSON (eventid, employeeid)
values (27399, 57056412);
insert into WORKSON (eventid, employeeid)
values (27399, 284632359);
insert into WORKSON (eventid, employeeid)
values (27731, 372528246);
insert into WORKSON (eventid, employeeid)
values (28158, 495235798);
insert into WORKSON (eventid, employeeid)
values (28158, 683364887);
insert into WORKSON (eventid, employeeid)
values (28158, 789132274);
insert into WORKSON (eventid, employeeid)
values (28205, 891718617);
insert into WORKSON (eventid, employeeid)
values (28270, 57056412);
insert into WORKSON (eventid, employeeid)
values (28270, 888795787);
insert into WORKSON (eventid, employeeid)
values (28310, 322245632);
insert into WORKSON (eventid, employeeid)
values (29203, 343997862);
insert into WORKSON (eventid, employeeid)
values (29645, 483533519);
insert into WORKSON (eventid, employeeid)
values (30056, 711722189);
insert into WORKSON (eventid, employeeid)
values (30527, 452738696);
insert into WORKSON (eventid, employeeid)
values (30922, 452127625);
insert into WORKSON (eventid, employeeid)
values (30922, 924391649);
insert into WORKSON (eventid, employeeid)
values (31833, 836952812);
insert into WORKSON (eventid, employeeid)
values (32000, 281625423);
insert into WORKSON (eventid, employeeid)
values (32000, 595892174);
insert into WORKSON (eventid, employeeid)
values (32000, 775561519);
insert into WORKSON (eventid, employeeid)
values (32334, 899545542);
insert into WORKSON (eventid, employeeid)
values (33027, 142535423);
insert into WORKSON (eventid, employeeid)
values (33027, 562229785);
insert into WORKSON (eventid, employeeid)
values (33027, 654626772);
insert into WORKSON (eventid, employeeid)
values (33547, 367673877);
insert into WORKSON (eventid, employeeid)
values (33782, 152897774);
insert into WORKSON (eventid, employeeid)
values (33782, 625377281);
commit;
prompt 100 records committed...
insert into WORKSON (eventid, employeeid)
values (33782, 789246959);
insert into WORKSON (eventid, employeeid)
values (33782, 892961117);
insert into WORKSON (eventid, employeeid)
values (34535, 99056412);
insert into WORKSON (eventid, employeeid)
values (34535, 846455483);
insert into WORKSON (eventid, employeeid)
values (34535, 961963235);
insert into WORKSON (eventid, employeeid)
values (35075, 356625526);
insert into WORKSON (eventid, employeeid)
values (35324, 314777163);
insert into WORKSON (eventid, employeeid)
values (36360, 671793184);
insert into WORKSON (eventid, employeeid)
values (37168, 467211543);
insert into WORKSON (eventid, employeeid)
values (37207, 99056412);
insert into WORKSON (eventid, employeeid)
values (37207, 366464293);
insert into WORKSON (eventid, employeeid)
values (37207, 794474241);
insert into WORKSON (eventid, employeeid)
values (37253, 961972549);
insert into WORKSON (eventid, employeeid)
values (37277, 211854325);
insert into WORKSON (eventid, employeeid)
values (37277, 329948869);
insert into WORKSON (eventid, employeeid)
values (38870, 342679537);
insert into WORKSON (eventid, employeeid)
values (38870, 572938411);
insert into WORKSON (eventid, employeeid)
values (38870, 683364887);
insert into WORKSON (eventid, employeeid)
values (38870, 833442792);
insert into WORKSON (eventid, employeeid)
values (39251, 899631822);
insert into WORKSON (eventid, employeeid)
values (39251, 924391649);
insert into WORKSON (eventid, employeeid)
values (39251, 968441868);
insert into WORKSON (eventid, employeeid)
values (39367, 856431755);
insert into WORKSON (eventid, employeeid)
values (39375, 152897774);
insert into WORKSON (eventid, employeeid)
values (39885, 548163249);
insert into WORKSON (eventid, employeeid)
values (39985, 394168749);
insert into WORKSON (eventid, employeeid)
values (40091, 112464717);
insert into WORKSON (eventid, employeeid)
values (40091, 762385283);
insert into WORKSON (eventid, employeeid)
values (40092, 422367597);
insert into WORKSON (eventid, employeeid)
values (40092, 865638685);
insert into WORKSON (eventid, employeeid)
values (40195, 459784952);
insert into WORKSON (eventid, employeeid)
values (40586, 221854325);
insert into WORKSON (eventid, employeeid)
values (40586, 338839244);
insert into WORKSON (eventid, employeeid)
values (40615, 381683979);
insert into WORKSON (eventid, employeeid)
values (40671, 353299578);
insert into WORKSON (eventid, employeeid)
values (41292, 536312268);
insert into WORKSON (eventid, employeeid)
values (41663, 675926779);
insert into WORKSON (eventid, employeeid)
values (41663, 888795787);
insert into WORKSON (eventid, employeeid)
values (42198, 253778582);
insert into WORKSON (eventid, employeeid)
values (42888, 986723751);
insert into WORKSON (eventid, employeeid)
values (43300, 562229785);
insert into WORKSON (eventid, employeeid)
values (43536, 691574567);
insert into WORKSON (eventid, employeeid)
values (43666, 386665637);
insert into WORKSON (eventid, employeeid)
values (44026, 452127625);
insert into WORKSON (eventid, employeeid)
values (44556, 278483766);
insert into WORKSON (eventid, employeeid)
values (44566, 269452927);
insert into WORKSON (eventid, employeeid)
values (44566, 467211543);
insert into WORKSON (eventid, employeeid)
values (44566, 646383622);
insert into WORKSON (eventid, employeeid)
values (44944, 284632359);
insert into WORKSON (eventid, employeeid)
values (45208, 119231529);
insert into WORKSON (eventid, employeeid)
values (45546, 221854325);
insert into WORKSON (eventid, employeeid)
values (45546, 697151836);
insert into WORKSON (eventid, employeeid)
values (45626, 232428195);
insert into WORKSON (eventid, employeeid)
values (45704, 156613236);
insert into WORKSON (eventid, employeeid)
values (45704, 342235525);
insert into WORKSON (eventid, employeeid)
values (45704, 449335211);
insert into WORKSON (eventid, employeeid)
values (45704, 676761349);
insert into WORKSON (eventid, employeeid)
values (45885, 396354422);
insert into WORKSON (eventid, employeeid)
values (46231, 211258385);
insert into WORKSON (eventid, employeeid)
values (46442, 829814233);
insert into WORKSON (eventid, employeeid)
values (46849, 536312268);
insert into WORKSON (eventid, employeeid)
values (47034, 569586425);
insert into WORKSON (eventid, employeeid)
values (47257, 626425945);
insert into WORKSON (eventid, employeeid)
values (47257, 671793184);
insert into WORKSON (eventid, employeeid)
values (47618, 153525296);
insert into WORKSON (eventid, employeeid)
values (47982, 856431755);
insert into WORKSON (eventid, employeeid)
values (47992, 259362496);
insert into WORKSON (eventid, employeeid)
values (48022, 514763855);
insert into WORKSON (eventid, employeeid)
values (48022, 666155814);
insert into WORKSON (eventid, employeeid)
values (48022, 676761349);
insert into WORKSON (eventid, employeeid)
values (48022, 794969549);
insert into WORKSON (eventid, employeeid)
values (48510, 596542332);
insert into WORKSON (eventid, employeeid)
values (48510, 664641138);
insert into WORKSON (eventid, employeeid)
values (48512, 728521699);
insert into WORKSON (eventid, employeeid)
values (48512, 847364326);
insert into WORKSON (eventid, employeeid)
values (48528, 342679537);
insert into WORKSON (eventid, employeeid)
values (48678, 152897774);
insert into WORKSON (eventid, employeeid)
values (49481, 973545828);
insert into WORKSON (eventid, employeeid)
values (49744, 115754625);
insert into WORKSON (eventid, employeeid)
values (49744, 514763855);
insert into WORKSON (eventid, employeeid)
values (49957, 171887148);
insert into WORKSON (eventid, employeeid)
values (49957, 678673814);
insert into WORKSON (eventid, employeeid)
values (49957, 754317637);
insert into WORKSON (eventid, employeeid)
values (50462, 393235941);
insert into WORKSON (eventid, employeeid)
values (50462, 897457852);
insert into WORKSON (eventid, employeeid)
values (50584, 99056412);
insert into WORKSON (eventid, employeeid)
values (50584, 494343266);
insert into WORKSON (eventid, employeeid)
values (50584, 522834411);
insert into WORKSON (eventid, employeeid)
values (50584, 794592687);
insert into WORKSON (eventid, employeeid)
values (50584, 892961117);
insert into WORKSON (eventid, employeeid)
values (51087, 699112677);
insert into WORKSON (eventid, employeeid)
values (51364, 343997862);
insert into WORKSON (eventid, employeeid)
values (51364, 352949287);
insert into WORKSON (eventid, employeeid)
values (51902, 491819425);
insert into WORKSON (eventid, employeeid)
values (51902, 696393696);
insert into WORKSON (eventid, employeeid)
values (51910, 122494375);
insert into WORKSON (eventid, employeeid)
values (51910, 269452927);
insert into WORKSON (eventid, employeeid)
values (51910, 393235941);
insert into WORKSON (eventid, employeeid)
values (52047, 416855553);
insert into WORKSON (eventid, employeeid)
values (52150, 329948869);
commit;
prompt 200 records committed...
insert into WORKSON (eventid, employeeid)
values (52150, 367315441);
insert into WORKSON (eventid, employeeid)
values (52150, 671793184);
insert into WORKSON (eventid, employeeid)
values (52150, 691574567);
insert into WORKSON (eventid, employeeid)
values (52833, 462369231);
insert into WORKSON (eventid, employeeid)
values (52833, 836952812);
insert into WORKSON (eventid, employeeid)
values (53051, 856431755);
insert into WORKSON (eventid, employeeid)
values (53051, 973545828);
insert into WORKSON (eventid, employeeid)
values (54458, 972295621);
insert into WORKSON (eventid, employeeid)
values (54830, 127452677);
insert into WORKSON (eventid, employeeid)
values (55094, 434234621);
insert into WORKSON (eventid, employeeid)
values (55094, 579494772);
insert into WORKSON (eventid, employeeid)
values (55713, 892961117);
insert into WORKSON (eventid, employeeid)
values (55730, 671793184);
insert into WORKSON (eventid, employeeid)
values (55915, 244861741);
insert into WORKSON (eventid, employeeid)
values (55999, 987637154);
insert into WORKSON (eventid, employeeid)
values (56487, 153525296);
insert into WORKSON (eventid, employeeid)
values (56527, 312578226);
insert into WORKSON (eventid, employeeid)
values (56527, 522834411);
insert into WORKSON (eventid, employeeid)
values (56539, 946548967);
insert into WORKSON (eventid, employeeid)
values (56877, 556719822);
insert into WORKSON (eventid, employeeid)
values (57863, 697151836);
insert into WORKSON (eventid, employeeid)
values (58090, 122494375);
insert into WORKSON (eventid, employeeid)
values (58370, 111234399);
insert into WORKSON (eventid, employeeid)
values (58370, 979922972);
insert into WORKSON (eventid, employeeid)
values (60659, 221854325);
insert into WORKSON (eventid, employeeid)
values (61324, 695937844);
insert into WORKSON (eventid, employeeid)
values (61324, 972295621);
insert into WORKSON (eventid, employeeid)
values (61545, 119231529);
insert into WORKSON (eventid, employeeid)
values (61637, 197719382);
insert into WORKSON (eventid, employeeid)
values (61637, 318142751);
insert into WORKSON (eventid, employeeid)
values (61637, 583491233);
insert into WORKSON (eventid, employeeid)
values (61903, 819153241);
insert into WORKSON (eventid, employeeid)
values (62115, 232428195);
insert into WORKSON (eventid, employeeid)
values (62323, 464357414);
insert into WORKSON (eventid, employeeid)
values (62856, 625377281);
insert into WORKSON (eventid, employeeid)
values (62856, 793365692);
insert into WORKSON (eventid, employeeid)
values (62856, 899545542);
insert into WORKSON (eventid, employeeid)
values (64348, 394168749);
insert into WORKSON (eventid, employeeid)
values (64348, 485356152);
insert into WORKSON (eventid, employeeid)
values (64348, 939755567);
insert into WORKSON (eventid, employeeid)
values (65574, 284281556);
insert into WORKSON (eventid, employeeid)
values (65574, 385641543);
insert into WORKSON (eventid, employeeid)
values (65574, 393235941);
insert into WORKSON (eventid, employeeid)
values (65574, 434234621);
insert into WORKSON (eventid, employeeid)
values (66243, 156613236);
insert into WORKSON (eventid, employeeid)
values (66243, 965515364);
insert into WORKSON (eventid, employeeid)
values (66781, 939755567);
insert into WORKSON (eventid, employeeid)
values (67082, 986723751);
insert into WORKSON (eventid, employeeid)
values (67153, 326872757);
insert into WORKSON (eventid, employeeid)
values (67368, 831646571);
insert into WORKSON (eventid, employeeid)
values (67368, 995684566);
insert into WORKSON (eventid, employeeid)
values (68002, 531438979);
insert into WORKSON (eventid, employeeid)
values (69247, 876662372);
insert into WORKSON (eventid, employeeid)
values (69247, 969887624);
insert into WORKSON (eventid, employeeid)
values (69300, 546289323);
insert into WORKSON (eventid, employeeid)
values (69300, 622383977);
insert into WORKSON (eventid, employeeid)
values (70428, 352196863);
insert into WORKSON (eventid, employeeid)
values (70428, 646383622);
insert into WORKSON (eventid, employeeid)
values (70951, 484568425);
insert into WORKSON (eventid, employeeid)
values (70951, 615959839);
insert into WORKSON (eventid, employeeid)
values (70951, 961125361);
insert into WORKSON (eventid, employeeid)
values (71601, 356625526);
insert into WORKSON (eventid, employeeid)
values (71601, 753488476);
insert into WORKSON (eventid, employeeid)
values (71669, 452127625);
insert into WORKSON (eventid, employeeid)
values (72159, 577742123);
insert into WORKSON (eventid, employeeid)
values (72159, 671793184);
insert into WORKSON (eventid, employeeid)
values (72339, 253778582);
insert into WORKSON (eventid, employeeid)
values (72339, 515383699);
insert into WORKSON (eventid, employeeid)
values (72419, 342235525);
insert into WORKSON (eventid, employeeid)
values (72419, 459784952);
insert into WORKSON (eventid, employeeid)
values (72557, 186987147);
insert into WORKSON (eventid, employeeid)
values (72557, 792815389);
insert into WORKSON (eventid, employeeid)
values (72865, 385264286);
insert into WORKSON (eventid, employeeid)
values (72865, 483533519);
insert into WORKSON (eventid, employeeid)
values (72865, 696393696);
insert into WORKSON (eventid, employeeid)
values (72873, 434234621);
insert into WORKSON (eventid, employeeid)
values (73003, 317635954);
insert into WORKSON (eventid, employeeid)
values (73003, 353299578);
insert into WORKSON (eventid, employeeid)
values (73003, 787856135);
insert into WORKSON (eventid, employeeid)
values (73364, 968441868);
insert into WORKSON (eventid, employeeid)
values (73428, 218493661);
insert into WORKSON (eventid, employeeid)
values (73494, 312578226);
insert into WORKSON (eventid, employeeid)
values (73494, 876662372);
insert into WORKSON (eventid, employeeid)
values (73768, 218493661);
insert into WORKSON (eventid, employeeid)
values (73768, 359738524);
insert into WORKSON (eventid, employeeid)
values (75995, 218757672);
insert into WORKSON (eventid, employeeid)
values (75995, 556719822);
insert into WORKSON (eventid, employeeid)
values (76010, 444897653);
insert into WORKSON (eventid, employeeid)
values (77117, 275735161);
insert into WORKSON (eventid, employeeid)
values (77117, 374499312);
insert into WORKSON (eventid, employeeid)
values (77527, 611164944);
insert into WORKSON (eventid, employeeid)
values (77686, 99056412);
insert into WORKSON (eventid, employeeid)
values (78571, 829814233);
insert into WORKSON (eventid, employeeid)
values (78761, 595892174);
insert into WORKSON (eventid, employeeid)
values (79682, 583491233);
insert into WORKSON (eventid, employeeid)
values (79821, 467159192);
insert into WORKSON (eventid, employeeid)
values (80060, 353299578);
insert into WORKSON (eventid, employeeid)
values (80060, 434234621);
insert into WORKSON (eventid, employeeid)
values (80342, 385264286);
insert into WORKSON (eventid, employeeid)
values (80342, 492487594);
commit;
prompt 300 records committed...
insert into WORKSON (eventid, employeeid)
values (80342, 946548967);
insert into WORKSON (eventid, employeeid)
values (80442, 317635954);
insert into WORKSON (eventid, employeeid)
values (80446, 211124975);
insert into WORKSON (eventid, employeeid)
values (81281, 252158964);
insert into WORKSON (eventid, employeeid)
values (81296, 577879396);
insert into WORKSON (eventid, employeeid)
values (81410, 111234399);
insert into WORKSON (eventid, employeeid)
values (81410, 342679537);
insert into WORKSON (eventid, employeeid)
values (81703, 727881971);
insert into WORKSON (eventid, employeeid)
values (81808, 169179476);
insert into WORKSON (eventid, employeeid)
values (81977, 699112677);
insert into WORKSON (eventid, employeeid)
values (82162, 399168515);
insert into WORKSON (eventid, employeeid)
values (82162, 416855553);
insert into WORKSON (eventid, employeeid)
values (82300, 869793359);
insert into WORKSON (eventid, employeeid)
values (82308, 311245632);
insert into WORKSON (eventid, employeeid)
values (82485, 329948869);
insert into WORKSON (eventid, employeeid)
values (82485, 422367597);
insert into WORKSON (eventid, employeeid)
values (84224, 218493661);
insert into WORKSON (eventid, employeeid)
values (84494, 869793359);
insert into WORKSON (eventid, employeeid)
values (84751, 155999698);
insert into WORKSON (eventid, employeeid)
values (84751, 253778582);
insert into WORKSON (eventid, employeeid)
values (85164, 819324957);
insert into WORKSON (eventid, employeeid)
values (85224, 689787933);
insert into WORKSON (eventid, employeeid)
values (85348, 572938411);
insert into WORKSON (eventid, employeeid)
values (85994, 492487594);
insert into WORKSON (eventid, employeeid)
values (86444, 892242272);
insert into WORKSON (eventid, employeeid)
values (86500, 546289323);
insert into WORKSON (eventid, employeeid)
values (86500, 654626772);
insert into WORKSON (eventid, employeeid)
values (87836, 546289323);
insert into WORKSON (eventid, employeeid)
values (87836, 615722688);
insert into WORKSON (eventid, employeeid)
values (87836, 951296981);
insert into WORKSON (eventid, employeeid)
values (88346, 342679537);
insert into WORKSON (eventid, employeeid)
values (88346, 735621686);
insert into WORKSON (eventid, employeeid)
values (88423, 596542332);
insert into WORKSON (eventid, employeeid)
values (88504, 775561519);
insert into WORKSON (eventid, employeeid)
values (88993, 493544467);
insert into WORKSON (eventid, employeeid)
values (88993, 531448264);
insert into WORKSON (eventid, employeeid)
values (88993, 891718617);
insert into WORKSON (eventid, employeeid)
values (89342, 951296981);
insert into WORKSON (eventid, employeeid)
values (89544, 473536133);
insert into WORKSON (eventid, employeeid)
values (89687, 676761349);
insert into WORKSON (eventid, employeeid)
values (89687, 939775516);
insert into WORKSON (eventid, employeeid)
values (89751, 113711537);
insert into WORKSON (eventid, employeeid)
values (89751, 284632359);
insert into WORKSON (eventid, employeeid)
values (89751, 456767367);
insert into WORKSON (eventid, employeeid)
values (89751, 548548833);
insert into WORKSON (eventid, employeeid)
values (89751, 612496723);
insert into WORKSON (eventid, employeeid)
values (90005, 452127625);
insert into WORKSON (eventid, employeeid)
values (90005, 626425945);
insert into WORKSON (eventid, employeeid)
values (90005, 847364326);
insert into WORKSON (eventid, employeeid)
values (90010, 366752127);
insert into WORKSON (eventid, employeeid)
values (90059, 111234399);
insert into WORKSON (eventid, employeeid)
values (90251, 372528246);
insert into WORKSON (eventid, employeeid)
values (90251, 422367597);
insert into WORKSON (eventid, employeeid)
values (90251, 548163249);
insert into WORKSON (eventid, employeeid)
values (90251, 676761349);
insert into WORKSON (eventid, employeeid)
values (90740, 485277152);
insert into WORKSON (eventid, employeeid)
values (90917, 147241172);
insert into WORKSON (eventid, employeeid)
values (91087, 336824331);
insert into WORKSON (eventid, employeeid)
values (91087, 943842588);
insert into WORKSON (eventid, employeeid)
values (91403, 556617211);
insert into WORKSON (eventid, employeeid)
values (91656, 821792885);
insert into WORKSON (eventid, employeeid)
values (91687, 811239772);
insert into WORKSON (eventid, employeeid)
values (91908, 452127625);
insert into WORKSON (eventid, employeeid)
values (92962, 311734255);
insert into WORKSON (eventid, employeeid)
values (94296, 221854325);
insert into WORKSON (eventid, employeeid)
values (94296, 359738524);
insert into WORKSON (eventid, employeeid)
values (94296, 596542332);
insert into WORKSON (eventid, employeeid)
values (94508, 359738524);
insert into WORKSON (eventid, employeeid)
values (94616, 885851983);
insert into WORKSON (eventid, employeeid)
values (94616, 888793354);
insert into WORKSON (eventid, employeeid)
values (94631, 452127625);
insert into WORKSON (eventid, employeeid)
values (95115, 531448264);
insert into WORKSON (eventid, employeeid)
values (95482, 434234621);
insert into WORKSON (eventid, employeeid)
values (95482, 939755567);
insert into WORKSON (eventid, employeeid)
values (95482, 972543625);
insert into WORKSON (eventid, employeeid)
values (95482, 995684566);
insert into WORKSON (eventid, employeeid)
values (95518, 764279839);
insert into WORKSON (eventid, employeeid)
values (95869, 168714263);
insert into WORKSON (eventid, employeeid)
values (95869, 288569752);
insert into WORKSON (eventid, employeeid)
values (96130, 336999793);
insert into WORKSON (eventid, employeeid)
values (96130, 342235525);
insert into WORKSON (eventid, employeeid)
values (96130, 367673877);
insert into WORKSON (eventid, employeeid)
values (96543, 99056412);
insert into WORKSON (eventid, employeeid)
values (97139, 536312268);
insert into WORKSON (eventid, employeeid)
values (97139, 846699499);
insert into WORKSON (eventid, employeeid)
values (97484, 211258385);
insert into WORKSON (eventid, employeeid)
values (97484, 683364887);
insert into WORKSON (eventid, employeeid)
values (97647, 339789768);
insert into WORKSON (eventid, employeeid)
values (98088, 649216418);
insert into WORKSON (eventid, employeeid)
values (98088, 683364887);
insert into WORKSON (eventid, employeeid)
values (98133, 818746397);
insert into WORKSON (eventid, employeeid)
values (98492, 572938411);
insert into WORKSON (eventid, employeeid)
values (98500, 317635954);
insert into WORKSON (eventid, employeeid)
values (99156, 979922972);
insert into WORKSON (eventid, employeeid)
values (99575, 626425945);
insert into WORKSON (eventid, employeeid)
values (99575, 712736239);
insert into WORKSON (eventid, employeeid)
values (99575, 956761811);
commit;
prompt 397 records loaded
prompt Enabling foreign key constraints for DONOR...
alter table DONOR enable constraint SYS_C007412;
prompt Enabling foreign key constraints for DONATION...
alter table DONATION enable constraint SYS_C007421;
alter table DONATION enable constraint SYS_C007422;
prompt Enabling foreign key constraints for EMPLOYEE...
alter table EMPLOYEE enable constraint SYS_C007430;
prompt Enabling foreign key constraints for EVENT...
alter table EVENT enable constraint SYS_C007438;
prompt Enabling foreign key constraints for PARTICIPATES...
alter table PARTICIPATES enable constraint SYS_C007442;
alter table PARTICIPATES enable constraint SYS_C007443;
prompt Enabling foreign key constraints for WORKSON...
alter table WORKSON enable constraint SYS_C007447;
alter table WORKSON enable constraint SYS_C007448;
prompt Enabling triggers for CAMPAIGN...
alter table CAMPAIGN enable all triggers;
prompt Enabling triggers for PERSON...
alter table PERSON enable all triggers;
prompt Enabling triggers for DONOR...
alter table DONOR enable all triggers;
prompt Enabling triggers for DONATION...
alter table DONATION enable all triggers;
prompt Enabling triggers for EMPLOYEE...
alter table EMPLOYEE enable all triggers;
prompt Enabling triggers for EVENT...
alter table EVENT enable all triggers;
prompt Enabling triggers for PARTICIPATES...
alter table PARTICIPATES enable all triggers;
prompt Enabling triggers for WORKSON...
alter table WORKSON enable all triggers;
set feedback on
set define on
prompt Done.
