
[General]
Version=1

[Preferences]
Username=
Password=2306
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=EMPLOYEE
Count=400

[Record]
Name=HOURLYWAGE
Type=FLOAT
Size=22
Data=Random(30, 100)
Master=

[Record]
Name=SENIORITY
Type=NUMBER
Size=
Data=Random(1, 10)
Master=

[Record]
Name=WORKHOURS
Type=NUMBER
Size=
Data=Random(5, 10)
Master=

[Record]
Name=POSITION
Type=VARCHAR2
Size=20
Data=List('Project Manager', 'Campaign Manager','Finance Manager', 'Volunteer', 'Volunteers Manager', 'Event Manager', 'Fund Raiser', 'Event Organizer', 'Telephonist', 'Secretary')
Master=

[Record]
Name=EVENTID
Type=NUMBER
Size=5
Data=[11111]
Master=

[Record]
Name=PERSONID
Type=NUMBER
Size=9
Data=List(select PersonID from Person)
Master=

