
[General]
Version=1

[Preferences]
Username=
Password=2966
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=PARTICIPATES
Count=400

[Record]
Name=DONORID
Type=NUMBER
Size=9
Data=List(select PersonID from Donor)
Master=

[Record]
Name=EVENTID
Type=NUMBER
Size=5
Data=List(select EventID from Event)
Master=

