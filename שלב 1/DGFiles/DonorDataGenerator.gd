
[General]
Version=1

[Preferences]
Username=
Password=2987
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DONOR
Count=400

[Record]
Name=REGISTRATIONDATE
Type=DATE
Size=
Data=Random(01/01/2010, 01/05/2024)
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

