
[General]
Version=1

[Preferences]
Username=
Password=2716
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=WORKSON
Count=400

[Record]
Name=EVENTID
Type=NUMBER
Size=5
Data=List(select EventID from Event)
Master=

[Record]
Name=EMPLOYEEID
Type=NUMBER
Size=9
Data=List(select PersonID from Employee)
Master=

