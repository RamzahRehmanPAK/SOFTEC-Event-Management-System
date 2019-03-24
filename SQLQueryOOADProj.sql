create schema OOADProject
go

create table OOADProject.Person(
	name varchar(50) not null,
	phoneNo varchar(50) not null,
	CNIC varchar(13) primary key,
	email varchar(50) not null,
	typeOfPerson varchar (30) not null check(typeOfPerson='Head'OR typeOfPerson='Volunteer'OR typeOfPerson='President'
	OR typeOfPerson='Treasurer'OR typeOfPerson='VP Competition'
	OR typeOfPerson='VP Exhibition' OR typeOfPerson='Speaker'OR typeOfPerson='VP Seminar/Event'
	OR typeOfPerson='Participant'OR typeOfPerson='Marketing Personnel')
);
go
--ALTER TABLE OOADProject.Person
--add constraint 	ck_typeOfPerson check(typeOfPerson='Head'OR typeOfPerson='Volunteer'OR typeOfPerson='President'
--	OR typeOfPerson='Treasurer'OR typeOfPerson='VP Competition'
--	OR typeOfPerson='VP Exhibition' OR typeOfPerson='Speaker'OR typeOfPerson='VP Seminar/Event'
--	OR typeOfPerson='Participant'OR typeOfPerson='Marketing Personnel')

	-- sp_helpconstraint 'OOADProject.Person'
	

create table OOADProject.PersonFurtherRequirement(
	id int identity(1,1),
	CNIC  varchar(13)  foreign key references OOADProject.Person(CNIC), 
	attribute varchar (30) check(attribute='Username' OR attribute='Password' OR attribute='ActivityID' OR attribute='RemainingFund') not null,
	value varchar(50)  not null,
	primary key(id)
);
go
create table OOADProject.Location(

	 location varchar(50) primary key
);
go

create table  OOADProject.Meeting(
id int primary key identity(1,1),
meetingtime varchar(30) not null,
location varchar(50) foreign key references OOADProject.Location(location) not null,
purpose varchar (50) not null
);
go

create table  OOADProject.Activity(
	id int  primary key  identity(1,1),
	name varchar (50) not null unique,
	noOfDays int,
	activityDescription varchar(300),
	typeOfActivity varchar (50) check(typeOfActivity='Competition' OR typeOfActivity='Seminar' OR typeOfActivity='Event' OR typeOfActivity='Exhibition') not null
	);
go

create table  OOADProject.dayWiseSpecification(
	id int primary key identity(1,1),
	activityID int foreign key references OOADProject.Activity(id) not null,
	dayNo int not null,
	location varchar (50) foreign key references OOADProject.Location(location) not null,
	SDDate date not null,
	SDTime time not null,
	duration int not null
	);
go
create table OOADProject.Competition(
activityID int foreign key references OOADProject.Activity(id),
firstPrize float not null ,
secondPrize float not null,
thirdPrize float not null,
participation varchar(30) check ( participation='Team' OR participation='Individual') not null, 
primary key (activityID) 
);
go

create table OOADProject.Exhibition(
activityID int foreign key references OOADProject.Activity(id),
participation varchar(30) check ( participation='Team' OR participation='Individual') not null, 
primary key (activityID) 
);
go
	
	create table  OOADProject.FundRequest(
	status int check(status=0 or status=1 or status=2 or status=3 ) not null,
	amount float not null,
	CNIC  varchar(13)  foreign key references OOADProject.Person(CNIC),
	reason varchar(300),
	fundRequestTime datetime not null,
	primary key(CNIC)
	);
go

	create table  OOADProject.Sponsor(
	id int primary key identity(1,1),
	CompanyName varchar(50) not null,
	details varchar(300),
	email varchar(50) not null,
	);
go

	create table  OOADProject.collectedFund(
		sponsorID int  foreign key references  OOADProject.Sponsor(id),
		amount float not null,
		dateOfCollection datetime not null,
		primary key(sponsorID)
	);
go

	create table  OOADProject.Speaker(
	id int primary key identity(1,1),
	activityID int foreign key references OOADProject.Activity(id) not null,
	details varchar (100),
	);
go

	create table  OOADProject.IndividualParticipant(
	id int primary key identity(1,1),
	teamID int foreign key references OOADProject.Team(teamID) null,
	institute varchar(50) not null,
	grade varchar (50) not null,
	CNIC  varchar(13)  foreign key references OOADProject.Person(CNIC) not null,
	participationID int foreign key references OOADProject.Participation(id) null

	);
go




	create table  OOADProject.Team(
	teamID int primary key identity(1,1),
	teamName varchar (50) not null,
	participationID int foreign key references OOADProject.Participation(id) 
	);
go

	create table OOADProject.Participation(
	id int identity(1,1) ,
	score float,
	judgeName varchar(50)  null,
	description varchar(300) null,
	activityID int foreign key references OOADProject.Activity(id),
	primary key (id)
	);
go


insert into OOADProject.Location values('CS 4'),('CS 5'), ('CS 6')

insert into OOADProject.Person values ('ramzah','03078710122','1222222222222','ramzah@gmail.com','President');


insert into OOADProject.PersonFurtherRequirement values('1222222222222','Username','1'),
('1222222222222','Password','1')



insert into  OOADProject.Activity values('Gaming Competition',null,'People play game and win prizes','Competition');
insert into  OOADProject.Activity values('Bilal Hashmi Programming Competition',null,'People code and win prizes','Competition');
insert into  OOADProject.Activity values('Robo Rumble',null,'People make robot and win prizes','Competition');
insert into  OOADProject.Activity values('Speed Programming',null,'Code speedily and win prizes','Competition');
insert into  OOADProject.Activity values('Concert',null,'Atif Aslam coming ','Event');
insert into  OOADProject.Activity values('Engineering project Exhibition',null,'Exhibit your projects','Exhibition');

insert into OOADProject.Competition values(1,1000,5000,2000,'Team')
insert into OOADProject.Competition values(2,1000,5000,2000,'Team')
insert into OOADProject.Competition values(3,1000,5000,2000,'Team')
insert into OOADProject.Competition values(4,1000,5000,2000,'Team')
insert into OOADProject.Exhibition values(6,'Individual');


insert into  OOADProject.dayWiseSpecification values(1,2,'CS 4','31-AUG-06','10:15:00 AM',60)
insert into  OOADProject.dayWiseSpecification values(1,3,'CS 5','1-SEP-06','10:15:00 AM',60)	


insert into  OOADProject.Person values('Arshad','03322212345','1111111111111','arshad@gmail.com','Volunteer')

insert into  OOADProject.PersonFurtherRequirement values('1111111111111','ActivityID',1)

--insert into OOADProject.Participation values(null,null,null,3);
--SELECT SCOPE_IDENTITY()

Create procedure OOADProject.addParticipation
@activityId int,
@description varchar(300),
@id int out
as
begin
	if @description=''
	insert into OOADProject.Participation values(null,null,null,@activityId)
	else
	insert into OOADProject.Participation values(null,null,@description,@activityId)

	select @id= SCOPE_IDENTITY();
end
go


Create procedure OOADProject.addTeam
@teamName varchar(50),
@participationId int,
@id int out
as
begin
	
	insert into OOADProject.Team values(@teamName,@participationId)
	select @id= SCOPE_IDENTITY();
end
go

Create procedure OOADProject.addIndividualParticipant
@teamId int,
@institute varchar(50),
@grade varchar (50),
@CNIC varchar (13),
@partiID int,
@id int out
as
begin
	
	insert into OOADProject.IndividualParticipant values(@teamid,@institute,@grade,@CNIC,@partiID)
	 select @id= SCOPE_IDENTITY();
end
go