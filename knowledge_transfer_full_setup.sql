show search_path;
create schema if not exists knowledge_transfer;
set search_path to knowledge_transfer;

drop table if exists EducatorLab cascade;
drop table if exists EducatorActivity cascade;
drop table if exists Activity cascade;
drop table if exists Lab cascade;
drop table if exists Goal cascade;
drop table if exists AcademicDegree cascade;
drop table if exists EducatorPublication cascade;
drop table if exists Publication cascade;
drop table if exists ElectronicMaterial cascade;
drop table if exists Educator cascade;

create table Educator
(
    EducatorId int,
    Name varchar(30) not null,
    Surname varchar(30) not null,
    Age int not null check ( Age between 18 and 100),
    Email varchar(100) not null unique check (Email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    PhotoPath varchar(255),
    primary key (EducatorId)
);

create table ElectronicMaterial
(
    ElectronicMaterialId int,
    EducatorId int,
    Title varchar(255) not null,
    URL text not null,
    LinkType varchar(50) not null check (LinkType in('Lesson note', 'Webex')),
    Description text,
    primary key (ElectronicMaterialId),
    foreign key (EducatorId) references Educator(EducatorId) on delete set null
);

create table Publication
(
    PublicationId int,
    Title varchar(255) not null,
    City varchar(50),
    Country varchar(50),
    Category varchar(100) not null,
    Description text,
    SubjectName varchar(100) not null,
    URL varchar(255),
    primary key (PublicationId)
);

create table EducatorPublication
(
    EducatorId int not null,
    PublicationId int not null,
    primary key (EducatorId, PublicationId),
    foreign key (EducatorId) references Educator(EducatorId) on delete cascade,
    foreign key (PublicationId) references Publication(PublicationId) on delete cascade
);

create table AcademicDegree
(
    AcademicDegreeId int,
    EducatorId int not null,
    DegreeName varchar(100) not null,
    FieldOfStudy varchar(100) not null,
    Institution varchar(100) not null,
    YearAwarded smallint not null check (YearAwarded >= 1900),
    DiplomaNumber varchar(30) not null unique,
    primary key (AcademicDegreeId),
    foreign key (EducatorId) references Educator(EducatorId) on delete cascade
);

create table Goal
(
    GoalId int,
    EducatorId int,
    Title varchar(100) not null unique,
    Description text,
    primary key (GoalId),
    foreign key (EducatorId) references Educator (EducatorId) on delete set null
);

create table Lab
(
    LabId int,
    Title varchar(100) not null unique,
    Location varchar(150) not null,
    Description text,
    primary key (LabId)
);

create table Activity
(
    ActivityId int,
    GoalId int not null,
    LabId int,
    Title varchar(100) not null unique,
    Category varchar(100) not null,
    Description text,
    primary key (ActivityId),
    foreign key (GoalId) references Goal (GoalId) on delete cascade,
    foreign key (LabId) references Lab(LabId) on delete set null
);

create table EducatorActivity
(
    EducatorId int not null,
    ActivityId int not null,
    DateOfRealisation date not null,
    ActivityResult text not null,
    primary key (EducatorId, ActivityId),
    foreign key (EducatorId) references Educator(EducatorId) on delete cascade,
    foreign key (ActivityId) references Activity(ActivityId) on delete cascade
);

create table EducatorLab
(
    EducatorId int not null,
    LabId int not null,
    primary key (EducatorId, LabId),
    foreign key (EducatorId) references Educator(EducatorId) on delete cascade,
    foreign key (LabId) references Lab(LabId) on delete cascade
);

insert into Educator (educatorid, name, surname, age, email, photopath)
values
    (1, 'Grace', 'Bennett', 39, 'grace.bennett@university.sk', '/photos/grace_bennett.gif'),
    (2, 'Daniel', 'Rodriguez', 35, 'daniel123rodriguez@gmail.com', '/photos/daniel_rodriguez.jpg'),
    (3, 'Sarah', 'Mitchell', 29, 'sarah.mitchell@university.sk', null),
    (4, 'James', 'Patel', 50, 'Patel@hotmail.com', '/photos/james_patel.png'),
    (5, 'Olivia', 'Nguyen', 38, 'olivia.nguyen@university.sk', null),
    (6, 'Michael', 'Anderson', 25, 'michael.anderson@university.sk', '/photos/michael_anderson.jpg'),
    (7, 'Sophia', 'Russo', 26, 'sophia.russo@university.sk', null),
    (8, 'William', 'Kum', 41, '4kum1@icloud.com', '/photos/william_kum.jpg'),
    (9, 'Isabella', 'Schneider', 36, 'isabella.schneider@university.sk', null),
    (10, 'Alexander', 'Brown', 47, 'alexander.brown@university.sk', '/photos/alexander_brown.png'),
    (11, 'Ethan', 'Garcia', 24, 'ethaNNN@gmail.com', '/photos/ethan_garcia.jpg'),
    (12, 'Benjamin', 'Lee', 44, 'lII1I@icloud.com', '/photos/benjamin_lee.jpg'),
    (13, 'Chloe', 'Martinez', 28, 'chloe.martinez@university.sk', null),
    (14, 'Laura', 'Fischer', 25, 'lauraFischer@hotmail.com', '/photos/laura_fischer.gif'),
    (15, 'Julia', 'Becker', 31, 'Be4@gmail.com', null);


insert into Academicdegree(academicdegreeid, educatorid, degreename, fieldofstudy, institution, yearawarded, diplomanumber)
values
    (1, 1, 'Ing.', 'Educational Technology', 'TUKE', 2007, 'EDU-2007-001'),
    (2, 2, 'Ing.', 'Cybersecurity', 'Comenius University', 2010, 'SEC-2010-019'),
    (3, 3, 'Ing.', 'Artificial Intelligence', 'TUKE', 2018, 'AI-2018-021'),
    (4, 4, 'Ing.', 'Computer Networks', 'TUKE', 1997, 'NET-1997-004'),
    (5, 4, 'PhD', 'Network Security', 'STU Bratislava', 2002, 'SEC-2002-004'),
    (6, 4, 'PhDr.', 'Information Policy', 'Comenius University', 2006, 'IP-2006-004'),
    (7, 5, 'Ing.', 'Virtual Reality', 'TUKE', 2011, 'VR-2011-031'),
    (8, 6, 'Ing.', 'Robotics', 'TUKE', 2021, 'ROB-2021-087'),
    (9, 7, 'Ing.', 'Artificial Intelligence', 'TUKE', 2018, 'AI-2018-022'),
    (10, 8, 'Ing.', 'Information Systems', 'TUKE', 2009, 'IS-2009-101'),
    (11, 9, 'PhD', 'Software Architecture', 'STU Bratislava', 2012, 'SWA-2012-014'),
    (12, 10, 'Ing.', 'Digital Humanities', 'UKF Nitra', 2005, 'DH-2005-092'),
    (13, 11, 'Ing.', 'Data Science', 'TUKE', 2020, 'DS-2022-045'),
    (14, 12, 'Ing.', 'Software Engineering', 'STU Bratislava', 2008, 'SE-2008-067'),
    (15, 13, 'PhD', 'Game Design', 'TUKE', 2017, 'GME-2017-018'),
    (16, 14, 'PhDr.', 'Computer Graphics', 'University of Žilina', 2019, 'CG-2019-034'),
    (17, 15, 'PhD', 'Human-Computer Interaction', 'TUKE', 2020, 'HCI-2020-077'),
    (18, 2, 'PhD', 'Cybersecurity', 'Comenius University', 2015, 'SEC-2015-002'),
    (19, 3, 'PhDr.', 'Artificial Intelligence', 'TUKE', 2020, 'AI-2020-003'),
    (20, 7, 'PhDr.', 'Artificial Intelligence', 'TUKE', 2020, 'AI-2020-007'),
    (21, 8, 'PhD', 'Information Systems', 'TUKE', 2015, 'IS-2015-008'),
    (22, 10, 'PhDr.', 'Digital Humanities', 'UKF Nitra', 2010, 'DH-2010-010'),
    (23, 11, 'PhDr.', 'Data Science', 'TUKE', 2022, 'DS-2024-011'),
    (24, 13, 'PhDr.', 'Game Design', 'TUKE', 2019, 'GME-2019-013'),
    (25, 14, 'PhD', 'Computer Graphics', 'University of Žilina', 2023, 'CG-2023-014'),
    (26, 11, 'PhD', 'Data Science', 'University of Žilina', 2024, 'CG-2023-015');


insert into ElectronicMaterial(electronicMaterialId, educatorId, title, url, linktype, description)
values
       (1,3, 'Formal specifications of systems', 'link1', 'Lesson note', 'Creation of an educational module for the group of subjects of Theoretical Informatics.'),
       (2,2, 'Introduction to programming and networks', 'link2', 'Lesson note','Creation of an educational module for the Introduction to Programming and Networks course.'),
       (3,14, 'Object-oriented programming', 'link3', 'Lesson note', 'Creation of an educational module for the Object Oriented Programming subject.'),
       (4,11, 'Database systems', 'link4', 'Lesson note', 'Creation of an educational module for the subject Database systems.'),
       (5,15, 'Numerical Mathematics, Probability and Mathematical Statistics',  'link5', 'Lesson note', 'Creation of an educational module for the subject Numerical Mathematics, Probability and Mathematical Statistics.'),
       (6,13, 'Algorithms and complexity', 'link6', 'Lesson note', 'Creation of an educational module for the subject Algorithms and their complexity.'),
       (7,12, 'Logic for computer scientists', 'link7', 'Lesson note', 'Provision of modules for implementation of digital systems based on programmable circuits.'),
       (8,8, 'Basics of software engineering','link8', 'Lesson note', 'Creating an educational module for the subject Basics of software engineering.'),
       (9, 6, 'Formal specifications of systems', 'link9', 'Webex', 'Lecture on formal specifications of systems.'),
       (10, 4, 'Introduction to programming and networks', 'link10', 'Webex','Lecture on the basics of programming and computer networks.'),
       (11, 7, 'Object-oriented programming', 'link11', 'Webex', 'Lecture on the fundamentals of object-oriented programming.'),
       (12, 9, 'Database systems', 'link12', 'Webex', 'Lecture on relational database systems and their applications.'),
       (13, 15, 'Numerical Mathematics, Probability and Mathematical Statistics', 'link13', 'Webex', 'Lecture on key concepts in numerical methods, probability, and statistics.'),
       (14, 5, 'Algorithms and complexity', 'link14', 'Webex', 'Lecture on algorithm design and computational complexity.'),
       (15, 1, 'Logic for computer scientists', 'link15', 'Webex', 'Lecture on logic principles for computing and formal reasoning.'),
       (16, 10, 'Basics of software engineering', 'link16', 'Webex', 'Lecture on the fundamentals of software engineering practices.');

insert into Publication(publicationid, title, city, country, category, description, subjectname, url)
values
    (1, 'Innovative AI Techniques in Education', 'Kosice', 'Slovakia', 'Journal', 'Application of AI for personalized learning.', 'Artificial Intelligence', 'link1'),
    (2, 'IoT Security Challenges in Smart Homes', 'Kosice', 'Slovakia', 'Conference', 'Addressing vulnerabilities in smart devices.', 'Cybersecurity', 'link2'),
    (3, 'Augmented Labs for Chemistry Students', 'Bratislava', 'Slovakia', 'Journal', 'Using AR to visualize chemical reactions.', 'Augmented Reality', 'link3'),
    (4, 'Data Literacy for High School Teachers', 'Kosice', 'Slovakia', 'Journal', 'Improving data interpretation in classrooms.', 'Data Science', 'link4'),
    (5, 'Open Source Software in Academia', 'Presov', 'Slovakia', 'Conference', 'Benefits and adoption of OSS in universities.', 'Software Engineering', 'link5'),
    (6, 'AI-Driven Adaptive Testing Systems', 'Kosice', 'Slovakia', 'Journal', 'Smart assessments based on student performance.', 'Education Technology', 'link6'),
    (7, 'Virtual Internships in Engineering Programs', 'Zilina', 'Slovakia', 'Journal', 'Simulated work experiences through virtual platforms.', 'Education Technology', 'link7'),
    (8, 'Blockchain Credentials in Slovak Universities', 'Kosice', 'Slovakia', 'Journal', 'Securing academic records using blockchain.', 'Blockchain Technology', 'link8'),
    (9, 'Student Motivation Through Game Design', 'Kosice', 'Slovakia', 'Conference', 'Enhancing learning via student-made games.', 'Game Design', 'link9'),
    (10, 'Collaborative Tools for Remote Teams', 'Nitra', 'Slovakia', 'Journal', 'Evaluating tools like Miro, Trello, and Teams.', 'Remote Work', 'link10'),
    (11, 'Smart Agriculture in Eastern Slovakia', 'Kosice', 'Slovakia', 'Journal', 'IoT-based monitoring for efficient farming.', 'Smart Agriculture', 'link11'),
    (12, 'Accessibility in Digital Learning Platforms', 'Banska Bystrica', 'Slovakia', 'Journal', 'Improving usability for students with disabilities.', 'Inclusive Education', 'link12'),
    (13, 'Cyberbullying Prevention with AI Filters', 'Kosice', 'Slovakia', 'Conference', 'Real-time content moderation with AI tools.', 'Cybersecurity', 'link13'),
    (14, 'Using VR for Medical Training', 'Kosice', 'Slovakia', 'Journal', 'Immersive training environments for med students.', 'Virtual Reality', 'link14'),
    (15, 'Slovak Language Processing Tools', 'Kosice', 'Slovakia', 'Journal', 'Development of tokenizers and parsers for Slovak.', 'Computational Linguistics', 'link14'),
    (16, 'Physics Simulations for Distance Learners', 'Trnava', 'Slovakia', 'Conference', 'Interactive modules for physics labs online.', 'STEM Education', 'link15'),
    (17, 'Digital Humanities Research Methods', 'Bratislava', 'Slovakia', 'Journal', 'Applying digital tools in historical research.', 'Digital Humanities', 'link16'),
    (18, 'Ethics in Educational Robotics', 'Kosice', 'Slovakia', 'Journal', 'Moral dilemmas in child-robot interaction.', 'Robotics Ethics', 'link17'),
    (19, 'Machine Learning for Student Dropout Prediction', 'Kosice', 'Slovakia', 'Journal', 'Predictive models for academic risk factors.', 'AI in Education', 'link18');


insert into Goal(goalid, educatorid, title, description)
values
    (1, 3, 'Improve AI Teaching Methods', 'Develop and test new teaching strategies using AI tools in the classroom.'),
    (2, 7, 'Integrate AR into Science Labs', 'Introduce augmented reality into chemistry labs for interactive learning.'),
    (3, 9, 'Enhance Student Engagement with Games', 'Design game-based learning modules to increase student participation.'),
    (4, 1, 'Research Ethical AI Use in Education', 'Investigate the ethical challenges of integrating AI systems in learning environments.'),
    (5, 4, 'Organize Cybersecurity Workshop', 'Host a workshop for students on current threats and prevention in cybersecurity.'),
    (6, 6, 'Develop Robotics Curriculum', 'Create hands-on robotics projects for undergraduate students.'),
    (7, 10, 'Support Language Learners with NLP', 'Utilize natural language processing tools to assist foreign students in language acquisition.'),
    (8, 2, 'Promote Open Source in Academia', 'Advocate and teach benefits of using open source software in computer science courses.'),
    (9, 11, 'Research Blockchain in Education', 'Explore the use of blockchain for storing academic records and diplomas.'),
    (10, 12, 'Analyze Online Learning Outcomes', 'Evaluate effectiveness of online learning environments across different student groups.');


insert into Lab(labid, title, location, description)
values
    (1, 'Artificial Intelligence Lab', 'TUKE, Block B, Room 205', 'A research lab focused on developing and testing machine learning and AI models.'),
    (2, 'Cybersecurity Lab', 'TUKE, Block C, Room 101', 'Dedicated to studying system vulnerabilities, ethical hacking, and network security.'),
    (3, 'Robotics and Automation Lab', 'TUKE, Block A, Room 310', 'Equipped for building and programming autonomous robotic systems.'),
    (4, 'Virtual and Augmented Reality Lab', 'TUKE, Block B, Room 214', 'Focused on immersive simulations, VR/AR applications, and user interface research.'),
    (5, 'Data Science and Visualization Lab', 'TUKE, Block A, Room 118', 'Analyzing big data sets and creating visual dashboards for interpretation.'),
    (6, 'Educational Technology Lab', 'TUKE, Block A, Room 202', 'Exploring new teaching tools, platforms, and learning experience design.'),
    (7, 'Blockchain and Distributed Systems Lab', 'TUKE, Block A, Room 303', 'Researching decentralized technologies and their applications in education.');


insert into Activity(activityid, goalid, labid, title, description, category)
values
    (1, 1, 1, 'Design AI-Powered Quiz Generator', 'Create a tool that generates adaptive quizzes using AI algorithms.', 'Prototype'),
    (2, 1, 1, 'Pilot AI Lesson Plans', 'Test AI-enhanced lesson plans with a group of students and evaluate outcomes.', 'Experiment'),
    (3, 2, 4, 'Build AR Chemistry Models', 'Create interactive AR molecular structures for use in science labs.', 'Development'),
    (4, 2, 4, 'Student Testing of AR Modules', 'Conduct student usability testing of augmented reality educational modules.', 'Testing'),
    (5, 3, 6, 'Create Educational Game Prototypes', 'Develop basic versions of games aimed at improving engagement in STEM subjects.', 'Design'),
    (6, 3, 6, 'Run Game-Based Learning Sessions', 'Facilitate workshops where students learn through playing and analyzing games.', 'Workshop'),
    (7, 4, 1, 'Research Ethics Frameworks for AI', 'Compare ethical models for AI in education and adapt them to Slovak context.', 'Research'),
    (8, 4, 1, 'Develop Case Studies on AI Misuse', 'Prepare real-world educational case studies exploring ethical risks of AI.', 'Case Study'),
    (9, 5, 2, 'Simulate Cyber Attacks', 'Use lab environment to demonstrate and defend against simulated attacks.', 'Simulation'),
    (10, 5, 2, 'Create Awareness Materials', 'Design posters and handouts for cybersecurity awareness day.', 'Outreach'),
    (11, 6, 3, 'Assemble Educational Robot Kits', 'Develop custom robot kits for use in university labs.', 'Engineering'),
    (12, 6, 3, 'Test Autonomous Robot Algorithms', 'Evaluate algorithms for navigation and object avoidance.', 'Testing'),
    (13, 7, 5, 'Build NLP-based Translation Tool', 'Create an NLP for non-native Slovak learners.', 'Prototype'),
    (14, 9, 7, 'Prototype Blockchain Credential System', 'Develop a smart contract to verify student certificates.', 'Development'),
    (15, 10, 5, 'Analyze Online Survey Results', 'Use data visualization to analyze student feedback from online courses.', 'Data Analysis');

insert into EducatorPublication(educatorid, publicationid)
values
    (7, 1),
    (2, 2),
    (14, 3),
    (11, 4),
    (12, 5),
    (10, 6),
    (2,7),
    (13, 9),
    (13, 10),
    (7, 11),
    (11, 12),
    (2, 13),
    (5, 14),
    (1, 15),
    (5, 16),
    (10, 17),
    (3, 18),
    (14, 19),
    (15, 8),
    (8, 4),
    (3, 15),
    (12, 17),
    (5, 11),
    (8, 8);

insert into EducatorLab(educatorid, labid)
values
    (1, 1),
    (2, 2),
    (3, 1),
    (4, 2),
    (5, 3),
    (6, 4),
    (7, 1),
    (8, 5),
    (9, 6),
    (10, 7),
    (11, 5),
    (12, 5),
    (13, 6),
    (14, 4),
    (15, 3),
    (2, 5),
    (3, 6),
    (7, 6),
    (11, 2);

insert into EducatorActivity(educatorid, activityid, dateofrealisation, activityresult)
values
    (1, 1, '2024-03-07', 'Needs Improvement'),
    (1, 2, '2023-03-20', 'Needs Improvement'),
    (3, 7, '2024-04-06', 'Needs Improvement'),
    (3, 8, '2023-09-28', 'Needs Improvement'),
    (2, 9, '2023-12-27', 'In Progress'),
    (2, 10, '2024-03-09', 'Needs Improvement'),
    (6, 11, '2024-04-25', 'Successful'),
    (6, 12, '2023-02-19', 'Successful'),
    (7, 5, '2024-07-26', 'Successful'),
    (7, 6, '2023-01-02', 'Successful'),
    (9, 13, '2023-10-21', 'Needs Improvement'),
    (8, 14, '2023-02-13', 'In Progress'),
    (11, 15, '2023-11-10', 'Successful'),
    (5, 3, '2024-01-05', 'Successful'),
    (5, 4, '2023-05-04', 'Successful'),
    (4, 10, '2023-11-26', 'In Progress'),
    (10, 15, '2024-08-20', 'Successful'),
    (13, 6, '2023-11-07', 'Successful'),
    (12, 11, '2024-03-22', 'In Progress'),
    (14, 11, '2023-03-21', 'Successful'),
    (15, 8, '2023-07-21', 'Successful');


-- 2 views with simple non-trivial select over one table

-- view that checks if the mail is filled with the '@university.sk' principle
-- and it shows if it doesn't
create or replace view Educator_Email_Check as
select E.Educatorid,
       E.Name       as EducatorName,
       E.Surname    as EducatorSurname,
       E.Email      as EducatorEmail
from Educator E
WHERE LOWER(email) !~ '[a-z]+.[a-z]@university.sk';

-- view that checks if the photo is in '.jpg' format, and it shows if it doesn't
-- or if photo path doesn't exist at all
create or replace view Educator_Photo_Check as
select
    E.Educatorid,
    E.Name          as EducatorName,
    E.Surname       as EducatorSurname,
    E.PhotoPath
from Educator E
WHERE E.PhotoPath is null or (E.photoPath not like '%.jpg' and E.photoPath not like '%.jpeg');

-- view for 10 educatorsId for the last 15 years
create or replace view Degrees_For_15Years as
    select
        AD.educatorid,
           max(AD.yearawarded) as LatestDegree
from AcademicDegree AD
where YearAwarded between 2010 and 2025
group by AD.educatorid
order by LatestDegree
limit 10;


-- 3 views with joining tables

-- materialized view showing the relationship between activities, goals, and labs
--     (for better clarity 'AI' is replaced by 'AI (Artificial Intelligence)')
create materialized view Complete_Activity_Info as
select
    A.ActivityId,
    A.Title    as ActivityTitle,
    replace(
        replace(A.Description, 'AI', 'AI (Artificial Intelligence)'),
        'NLP', 'NLP (Natural Language Processing)'
    ) as ActivityDescription,
    A.Category as ActivityCategory,
    G.Title    as GoalTitle,
    L.Title    as LabTitle
    from Activity A
inner join Goal G on G.GoalId = A.GoalId
inner join Lab L on L.LabId = A.LabId;

-- view showing information about the goals that need to be improved
create or replace view Goals_Needs_Improvement as
select distinct
    G.GoalId,
    G.Title       as GoalTitle,
    G.Description as GoalDescription,
    E.Name        as EducatorName,
    E.Surname     as EducatorSurname,
    EA.ActivityResult,
    EA.DateOfRealisation
    from EducatorActivity EA
inner join Activity A on ea.ActivityId = A.ActivityId
inner join Goal G on G.GoalId = A.GoalId
inner join Educator E on G.EducatorId = E.EducatorId
where EA.ActivityResult = 'Needs Improvement'
order by EA.DateOfRealisation;

-- view showing information about the educator who are hosts Webex meeting
create materialized view Educator_Webex_Status as
select
    E.EducatorId,
    E.Name        as EducatorName,
    E.Surname     as EducatorSurname,
    EM.Title      as ElectronicMaterialTitle,
    case when EM.EducatorId is not null
            then 'Hosts Webex Meeting'
            else 'Not hosting a Webex Meeting'
    end as WebexStatus
    from Educator E
left join ElectronicMaterial EM on E.EducatorId = EM.EducatorId and EM.LinkType = 'Webex';

-- view showing all educators with publications in Kosice or no publications at all, ordered by EducatorId
create or replace view Publication_Kosice as
select E.EducatorId,
       P.PublicationId,
       E.Name        as EducatorName,
       E.Surname     as EducatorSurname,
       P.Title       as PublicationTitle,
       P.City        as PublicationCity,
       P.Description as PublicationDescription,
       P.URL         as PublicationURL
    from Educator E
full join EducatorPublication EP on E.EducatorId = EP.EducatorId
full join Publication P on EP.PublicationId = P.Publicationid
where City = 'Kosice' or P.City is null or EP.PublicationId is null or E.EducatorId is null
order by EducatorId;


-- 2 views using aggregation functions and/or clustering

-- materialized view showing educators who create lesson modules and yet have more than 1 education background
create materialized view Educators_With_LessonNote_Multiple_Degrees as
select
    E.EducatorId,
    E.Name        as EducatorName,
    E.Surname     as EducatorSurname,
    EM.Title      as ElectronicMaterialTitle,
    EM.LinkType   as ElectronicMateriaLinkType
    from Educator E
join AcademicDegree AD on E.EducatorId = AD.EducatorId
join ElectronicMaterial EM on E.EducatorId = EM.EducatorId
where EM.LinkType = 'Lesson note'
group by e.EducatorId, e.Name, e.Surname,  EM.Title, EM.LinkType
having count(distinct AD.DegreeName) > 1;

-- materialized view showing the age of educators who have received new education in the last 5 years
-- and checking if it has activity
create materialized view Recent_Degree_Educator_Stats as
    select
        E.EducatorId,
        E.Name                    as EducatorName,
        E.Surname                 as EducatorSurname,
        E.Age                     as EducatorAge,
        max(AD.YearAwarded)       as LatestDegreeYear,
        EA.EducatorId is not null as HasActtivity
    from Educator E
join AcademicDegree AD on E.EducatorId = AD.EducatorId
left join EducatorActivity EA on E.EducatorId = EA.EducatorId
where AD.YearAwarded between 2020 and 2025
group by E.EducatorId, E.Name, E.Surname, E.Age, EA.EducatorId;

-- materialized view showing total number of activities and successful activities for each year
-- and how many teachers participated in them
create materialized view Year_Activity_Stats as
    select
        extract(year from EA.DateOfRealisation) as Year,
        count(*) as TotalActivities,
        count(case when ea.ActivityResult = 'Successful' then 1 end) as SuccessfulActivities,
        count(distinct e.EducatorId) as UniqueEducators
    from EducatorActivity EA
join Educator E on E.EducatorId = EA.EducatorId
group by extract(year from EA.DateOfRealisation)
order by Year;


-- 1 view using set operations

-- materialized view showing information about all publications and materials
create materialized view Publications_Materials as
    select
        E.Name            as EducatorName,
        E.Surname         as EducatorSurname,
        P.Title,
        P.Description
    from Publication P
join EducatorPublication EP on P.PublicationId = EP.PublicationId
join Educator E on E.EducatorId = EP.EducatorId
union
    select
        E2.Name as EducatorName,
        E2.Surname         as EducatorSurname,
        EM.Title,
        EM.Description
from ElectronicMaterial EM
join Educator E2 on EM.EducatorId = E2.EducatorId;


-- 2 views using subqueries

-- materialized view showing information on publications by educators
-- whose age is younger than average
create materialized view Young_Educators_Publications as
    select
            e.Name          as EducatorName,
            e.Surname       as EducatorSurname,
            e.Age           as EducatorAge,
            round((select avg(e.Age) from Educator e), 0) as AverageAge,
            p.Title         as PublicationTitle,
            p.Description   as PublicationDescription
    from Educator e
join EducatorPublication ep on e.EducatorId = ep.EducatorId
join Publication p on ep.PublicationId = p.publicationid
where e.Age < (select avg(e.Age) from Educator e)
group by e.Name, e.Surname, e.Age, p.Title, p.Description
order by e.Age;

-- view showing diplomas whose year is less than average
-- and verification of the need for actualization.
create or replace view Need_Diploma_Proof as
select
        case
            when a.YearAwarded < 2010 then 'Actualize'
            else 'Appropriate'
        end as DiplomaStatus,
        a.YearAwarded,
        round((select avg(a.YearAwarded) from AcademicDegree a), 0) as AverageYear,
        a.DiplomaNumber,
        a.FieldOfStudy,
        e.Name          as EducatorName,
        e.Surname       as EducatorSurname
from AcademicDegree a
join Educator e on e.EducatorId = a.EducatorId
where a.YearAwarded < (select avg(a.yearawarded) from AcademicDegree a)
group by a.DiplomaNumber, a.YearAwarded, a.FieldOfStudy, e.Name, e.Surname;


-- script to create trigger(s) that will implement auto-incrementation of artificial keys

-- auto-incrementation for table Educator
create sequence if not exists educator_id_seq
start with 16
increment by 1;

create or replace function set_educator_id()
    returns trigger
    language plpgsql
as $$
begin
    if new.EducatorId is null then
        new.EducatorId := nextval('educator_id_seq');
    end if;
    return new;
end;
$$;

create trigger trg_set_educator_id
before insert on Educator
for each row
execute function set_educator_id();

insert into Educator (Name, Surname, Age, Email, PhotoPath)
 values ( 'Polly', 'Rubilly', 27, 'Rubyy@gmail.com', null);


-- script for at least two meaningful triggers

-- trigger so that the instructor's email is correct,
-- and only updates it if the address is '@university.sk'
create or replace function update_invalid_email()
    returns trigger
    language plpgsql
as $$
begin
    if lower(new.EducatorEmail) !~ '[a-z]+.[a-z]@university.sk' then
        raise exception 'Invalid email format: %', new.EducatorEmail;
    end if;
    update Educator
    set Email = new.EducatorEmail
    where EducatorId = new.EducatorId;
    return new;
end;
$$;

create or replace trigger trigger_update_email
    instead of update on Educator_Email_Check
    for each row
    execute function update_invalid_email();

-- rows for check
-- correct  mail
update Educator_Email_Check
set EducatorEmail = 'daniel.rodriguez@university.sk'
where EducatorId = 2;

-- wrong mail, which will give an error
update Educator_Email_Check
-- set EducatorEmail = 'james.patel@university.sk'
set EducatorEmail = '!!!patel235@university.sk'
where EducatorId = 4;

-- trigger automatically adds .jpg to the photo path when updating through the view
create or replace function update_photo_path()
    returns trigger
    language plpgsql
as $$
begin
    if lower(new.PhotoPath) not like '%.jpg' and lower(new.PhotoPath) not like '%.jpeg' then
        new.PhotoPath := new.PhotoPath || '.jpg';
    end if;
    update Educator
    set PhotoPath = new.PhotoPath
    where EducatorId = new.EducatorId;
    return new;
end;
$$;

create or replace trigger trigger_update_photo
    instead of update on Educator_Photo_Check
    for each row
    execute function update_photo_path();

-- rows for check
update Educator_Photo_Check
set PhotoPath = '/photos/sophia_russo'
where EducatorId = 7;

update Educator_Photo_Check
set PhotoPath = '/photos/julia_becker.jpg'
where EducatorId = 15;


-- script containing at least one stored procedure and one function

-- procedure which will remove old degrees with
-- diplomas that were earned before the year 2005.
create or replace procedure delete_old_degrees()
    language plpgsql
as $$
    begin
        delete from AcademicDegree
        where YearAwarded <= 2005;
end;
$$;

call delete_old_degrees();

-- function that will return the total number of all activities that are “In Progress”
create or replace function count_needs_improvement()
    returns int
    language plpgsql
as $$
    declare
    total_count int;
    begin
        select count(*)
        into total_count
        from EducatorActivity
        where ActivityResult = 'Needs Improvement';

        return total_count;
    end;
$$;

select count_needs_improvement();

-- function that will return the city that is most often seen in publications
create or replace function most_common_city()
    returns varchar
    language plpgsql
as $$
declare
    top_city varchar;
    begin
        select city
        into top_city
        from (
                select city, count(*) as c
                from Publication
                group by city
                order by c desc
                limit 1
             ) as subquery;
        return top_city;
    end;
$$;

select most_common_city();


-- function that will return the date of the late activity in state 'In Progress'
create or replace function max_in_progress_date()
    returns date
    language plpgsql
as $$
declare
    latest_date date;
    begin
        select max(DateOfRealisation)
        into latest_date
        from EducatorActivity
            where ActivityResult = 'In Progress';
    return latest_date;
    end;
$$;

select max_in_progress_date();


-- function will return the result of checking if the teacher has a goal
create or replace function check_goal_for_educator(fEducatorId int)
    returns text
    language plpgsql
as $$
declare
    educatorName varchar(30);
    educatorSurname varchar(30);
    hasGoal boolean;
    begin
        select Name, Surname
        into educatorName, educatorSurname
        from Educator
            where EducatorId = fEducatorId;
        select exists(
            select 1
            from Goal
            where EducatorId = fEducatorId
        )
        into hasGoal;
        if hasGoal then
            return educatorName || ' ' || educatorSurname || ' ' || 'has goal assigned';
        else
            return educatorName || ' ' || educatorSurname || ' ' || 'has no goals assigned';
        end if;
    end;
$$;

select check_goal_for_educator(1);