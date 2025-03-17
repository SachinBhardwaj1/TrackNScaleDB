/*
** Author: Sachin Bhardwaj
** Project Name: TrackNScaleDB (Submitted to Arizona State University, under guidance of Prof. Ashish Gulati)
** SQL Server Version: Microsoft SQL Server 2022
** History
** Date Created Comments
** 12/06/2024
** NOTE: The query below is a sample for database creation. It can be used to create and store any number of records and populate them as needed.
*/
--------------------------------------------------------------------------------------------

-- Creating the Database
CREATE DATABASE trackNscale;

-- Using the newly created Database - trackNscale
USE trackNscale;

--------------------------------------------------------------------------------------------

-- Creating Tables

-- Table 1: Applicant Information Table
CREATE TABLE Applicant_Information (
    ApplicantID INT NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    EmailID VARCHAR(100) NOT NULL UNIQUE,
    GraduationDate DATE NOT NULL,
    Major VARCHAR(100) NOT NULL,
    University VARCHAR(150) NOT NULL,
    AdditionalDocumentLink NVARCHAR(200)
);

-- Table 2: Company Information Table
CREATE TABLE Company_Information (
    CompanyID VARCHAR(50) NOT NULL PRIMARY KEY,
    CompanyName VARCHAR(50) NOT NULL,
    Industry VARCHAR(100) NOT NULL,
    Location VARCHAR(200) NOT NULL,
    WebsiteLink NVARCHAR(200) NOT NULL
);

-- Table 3: Job Positions Table
CREATE TABLE Job_Positions (
    JobID VARCHAR(50) NOT NULL PRIMARY KEY,
    CompanyID VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(150) NOT NULL,
    JobType VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    PayRange VARCHAR(50) NOT NULL,
    ApplicationLink NVARCHAR(500) NOT NULL,
    StatusOfJobPosition VARCHAR(50),
    StatusDate DATE,
    FOREIGN KEY (CompanyID) REFERENCES Company_Information(CompanyID)
);

-- Table 4: Applications (Fact Table)
CREATE TABLE Applications (
    ApplicationID VARCHAR(50) NOT NULL PRIMARY KEY,
    ApplicantID INT NOT NULL,
    JobID VARCHAR(50) NOT NULL,
    ApplicationDate DATE NOT NULL,
    Status VARCHAR(100) NOT NULL,
    Message VARCHAR(1000),
    FOREIGN KEY (ApplicantID) REFERENCES Applicant_Information(ApplicantID),
    FOREIGN KEY (JobID) REFERENCES Job_Positions(JobID)
);

-- Table 5: Interviews (Fact Table)
CREATE TABLE Interviews (
    InterviewID INT NOT NULL PRIMARY KEY,
    ApplicationID VARCHAR(50) NOT NULL,
    InterviewDate DATE NOT NULL,
    InterviewType VARCHAR(50) NOT NULL,
    Outcome VARCHAR(50),
    Feedback VARCHAR(500),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

-- Table 6: Job Offers
CREATE TABLE Job_Offers (
    OfferID INT NOT NULL PRIMARY KEY,
    InterviewID INT NOT NULL,
    OfferDate DATE NOT NULL,
    PositionTitle VARCHAR(100) NOT NULL,
    SalaryOffered VARCHAR(50),
    OfferStatus VARCHAR(50) NOT NULL,
    FOREIGN KEY (InterviewID) REFERENCES Interviews(InterviewID)
);

-- Table 7: Audit Log for Applicant_Information Table
CREATE TABLE AuditLog_Applicant_Information (
    LogID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ActionType VARCHAR(20) NOT NULL,
    Timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    ApplicantID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    EmailID VARCHAR(100) NOT NULL,
    GraduationDate DATE NOT NULL,
    Major VARCHAR(100) NOT NULL,
    University VARCHAR(150) NOT NULL,
    AdditionalDocumentLink NVARCHAR(200)
);


--------------------------------------------------------------------------------------------

-- Populating Tables

-- Table 1: Applicant Information Table

INSERT INTO Applicant_Information (ApplicantID, FirstName, LastName, EmailID, GraduationDate, Major, University, AdditionalDocumentLink)
VALUES 
(1, 'Ravi', 'Kumar', 'ravi.kumar@gmail.com', '2025-05-15', 'Computer Science', 'Arizona State University', 'https://drive.google.com/file/d/1RaviKumarResume'),
(2, 'Anjali', 'Sharma', 'anjali.sharma@yahoo.com', '2024-12-10', 'Data Science', 'Stanford University', 'https://portfolio.anjalisharma.me/resume'),
(3, 'Vikram', 'Patel', 'vikram.patel@hotmail.com', '2025-05-20', 'Information Technology', 'MIT', 'https://vikrampatel.github.io/resume'),
(4, 'Priya', 'Singh', 'priya.singh@outlook.com', '2024-08-10', 'Cybersecurity', 'Harvard University', 'https://cyberdocs.priyasingh.com/documents/resume.pdf'),
(5, 'Rahul', 'Mehta', 'rahul.mehta@gmail.com', '2024-11-30', 'Artificial Intelligence', 'UC Berkeley', 'https://ai-resume-links.com/rahul_mehta.pdf'),
(6, 'Pooja', 'Reddy', 'pooja.reddy@ut.edu', '2025-06-01', 'Software Engineering', 'University of Texas', 'https://reddysoftware.dev/files/pooja_reddy_cv'),
(7, 'Amit', 'Chopra', 'amit.chopra@yahoo.com', '2025-05-10', 'Machine Learning', 'Carnegie Mellon University', 'https://amitchopra-ml.com/documents/Resume2025.pdf'),
(8, 'Neha', 'Desai', 'neha.desai@gmail.com', '2024-09-15', 'Data Analytics', 'Cornell University', 'https://datadesai.com/resume/neha_desai'),
(9, 'Siddharth', 'Jain', 'siddharth.jain@hotmail.com', '2025-01-20', 'Human-Computer Interaction', 'Georgia Tech', 'https://hcijain.tech/docs/siddharth_jain_portfolio'),
(10, 'Kavita', 'Verma', 'kavita.verma@um.edu', '2025-07-01', 'Business Analytics', 'University of Michigan', 'https://businessanalytics.kavitaverma.org/cv.pdf'),
(16, 'Uday', 'Kumar', 'uday.kumar@asu.edu', '2021-06-01', 'Mechanical Engineering', 'Illinois Tech, Chicago', 'https://kumarsoftware.dev/resumefiles/uday_kumar_cv'),
(17, 'Amit Kumar', 'Chopra', 'amit.chopra@rediffmail.com', '2021-05-10', 'Data Science', 'Illinois Tech, Chicago', 'https://amitkumar27.com/documents/Resume2021.pdf'),
(19, 'Pooja', 'kumari', 'pooja.kumari@ut.edu', '2022-06-01', 'Metallurgy', 'University of Texas', 'https://poojasoftware.dev/files/pooja_kumari_cv'),
(28, 'Wasim', 'Ahmed', 'wasim.ahmed@gmail.com', '2023-05-10', 'Hotel Management', 'UC Berkeley', 'https://wasim_231.com/documents/Resume2023.pdf');

-- SELECT Query
select * from Applicant_Information;


-- Table 2: Company Information Table

INSERT INTO Company_Information (CompanyID, CompanyName, Industry, Location, WebsiteLink)
VALUES
('C001', 'TCS', 'IT Services', 'California, USA', 'https://www.tcs.com'),
('C002', 'Infosys', 'IT Consulting', 'Virginia, USA', 'https://www.infosys.com'),
('C003', 'Wipro', 'Software Development', 'Atlanta, USA', 'https://careers.wipro.com'),
('C004', 'HCL Technologies', 'IT Infrastructure', 'Ohio, USA', 'https://www.hcltech.com'),
('C005', 'Tech Mahindra', 'Telecom Solutions', 'Dallas, USA', 'https://careers.techmahindra.com'),
('C006', 'Google', 'Technology', 'Mountain View, USA', 'https://careers.google.com'),
('C007', 'Microsoft', 'Software Development', 'Redmond, USA', 'https://careers.microsoft.com'),
('C008', 'Amazon', 'E-commerce', 'Seattle, USA', 'https://www.amazon.jobs'),
('C009', 'Tesla', 'Automotive', 'Palo Alto, USA', 'https://www.tesla.com/careers'),
('C010', 'Meta', 'Social Media', 'Menlo Park, USA', 'https://www.metacareers.com'),
('C011', 'Apple', 'Consumer Electronics', 'Cupertino, USA', 'https://www.apple.com/careers'),
('C012', 'IBM', 'Cloud Computing', 'Armonk, USA', 'https://www.ibm.com/careers'),
('C013', 'Netflix', 'Entertainment', 'Los Gatos, USA', 'https://jobs.netflix.com'),
('C014', 'Adobe', 'Creative Software', 'San Jose, USA', 'https://adobe.wd5.myworkdayjobs.com/en-US/careers'),
('C015', 'Oracle', 'Enterprise Software', 'Austin, USA', 'https://www.oracle.com/careers'),
('C016', 'SAP', 'Enterprise Software', 'Walldorf, Germany', 'https://jobs.sap.com'),
('C017', 'Spotify', 'Music Streaming', 'Stockholm, Sweden', 'https://www.spotifyjobs.com'),
('C018', 'Uber', 'Transportation', 'San Francisco, USA', 'https://www.uber.com/us/en/careers'),
('C019', 'Zoom', 'Video Conferencing', 'San Jose, USA', 'https://careers.zoom.us'),
('C020', 'Salesforce', 'CRM Software', 'San Francisco, USA', 'https://www.salesforce.com/company/careers');


-- SELECT Query
select * from Company_Information;


-- Table 3: Job Positions Table

INSERT INTO Job_Positions (JobID, CompanyID, JobTitle, JobType, Location, PayRange, ApplicationLink, StatusOfJobPosition, StatusDate)
VALUES 
('J001', 'C001', 'Software Engineer', 'Full-time', 'California, USA', '$80,000-$100,000', 'https://tcs.com/apply/software_engineer', 'Open', '2024-12-01'),
('J002', 'C002', 'Data Scientist', 'Full-time', 'Virginia, USA', '$90,000-$120,000', 'https://infosys.com/jobs/datascientist', 'Open', '2024-12-05'),
('J003', 'C003', 'Cybersecurity Analyst', 'Internship', 'Atlanta, USA', '$40,000-$50,000', 'https://wipro.com/internships/cybersecurity', 'Closed', '2024-11-30'),
('J004', 'C004', 'AI Researcher', 'Full-time', 'Ohio, USA', '$120,000-$140,000', 'https://hcltech.com/jobs/ai_researcher', 'Open', '2024-12-02'),
('J005', 'C005', 'DevOps Engineer', 'Part-time', 'Dallas, USA', '$50,000-$70,000', 'https://techmahindra.com/jobs/devops', 'Open', '2024-12-03'),
('J006', 'C006', 'Frontend Developer', 'Full-time', 'Mountain View, USA', '$120,000-$140,000', 'https://careers.google.com/frontend_dev', 'Closed', '2024-11-28'),
('J007', 'C007', 'Machine Learning Engineer', 'Full-time', 'Redmond, USA', '$135,000-$155,000', 'https://careers.microsoft.com/ml_engineer', 'Open', '2024-12-04'),
('J008', 'C008', 'Data Engineer', 'Full-time', 'Seattle, USA', '$110,000-$130,000', 'https://www.amazon.jobs/data_engineer', 'Open', '2024-12-06'),
('J009', 'C009', 'Battery Researcher', 'Internship', 'Palo Alto, USA', '$60,000-$80,000', 'https://www.tesla.com/internships/battery_research', 'Closed', '2024-11-25'),
('J010', 'C010', 'Product Manager', 'Full-time', 'Menlo Park, USA', '$140,000-$170,000', 'https://www.metacareers.com/product_manager', 'Open', '2024-12-07'),
('J011', 'C001', 'Data Analyst', 'Full-time', 'California, USA', '$70,000-$90,000', 'https://tcs.com/apply/data_analyst', 'Open', '2024-12-10'),
('J012', 'C002', 'AI Engineer', 'Full-time', 'Virginia, USA', '$110,000-$130,000', 'https://infosys.com/jobs/ai_engineer', 'Open', '2024-12-12'),
('J013', 'C003', 'IT Support Specialist', 'Part-time', 'Atlanta, USA', '$40,000-$60,000', 'https://wipro.com/jobs/it_support', 'Closed', '2024-12-08'),
('J014', 'C004', 'Cloud Architect', 'Full-time', 'Ohio, USA', '$130,000-$160,000', 'https://hcltech.com/jobs/cloud_architect', 'Open', '2024-12-09'),
('J015', 'C005', 'Network Engineer', 'Internship', 'Dallas, USA', '$50,000-$65,000', 'https://techmahindra.com/jobs/network_engineer', 'Open', '2024-12-11'),
('J016', 'C006', 'Backend Developer', 'Full-time', 'Mountain View, USA', '$130,000-$150,000', 'https://careers.google.com/backend_dev', 'Open', '2024-12-15'),
('J017', 'C007', 'Software Tester', 'Part-time', 'Redmond, USA', '$50,000-$70,000', 'https://careers.microsoft.com/software_tester', 'Closed', '2024-12-14'),
('J018', 'C008', 'DevOps Specialist', 'Full-time', 'Seattle, USA', '$110,000-$135,000', 'https://www.amazon.jobs/devops_specialist', 'Open', '2024-12-16'),
('J019', 'C009', 'Embedded Systems Engineer', 'Full-time', 'Palo Alto, USA', '$85,000-$105,000', 'https://www.tesla.com/jobs/embedded_systems', 'Open', '2024-12-18'),
('J020', 'C010', 'Marketing Manager', 'Full-time', 'Menlo Park, USA', '$120,000-$150,000', 'https://www.metacareers.com/marketing_manager', 'Open', '2024-12-19'),
('J021', 'C001', 'Technical Consultant', 'Full-time', 'California, USA', '$90,000-$110,000', 'https://tcs.com/apply/technical_consultant', 'Open', '2024-12-20'),
('J022', 'C002', 'Business Analyst', 'Full-time', 'Virginia, USA', '$80,000-$100,000', 'https://infosys.com/jobs/business_analyst', 'Closed', '2024-12-21'),
('J023', 'C003', 'Data Security Specialist', 'Internship', 'Atlanta, USA', '$40,000-$60,000', 'https://wipro.com/jobs/data_security', 'Open', '2024-12-22'),
('J024', 'C004', 'Machine Learning Scientist', 'Full-time', 'Ohio, USA', '$140,000-$170,000', 'https://hcltech.com/jobs/ml_scientist', 'Open', '2024-12-23'),
('J025', 'C005', 'System Administrator', 'Part-time', 'Dallas, USA', '$50,000-$70,000', 'https://techmahindra.com/jobs/sys_admin', 'Closed', '2024-12-24'),
('J026', 'C006', 'Mobile Developer', 'Full-time', 'Mountain View, USA', '$115,000-$135,000', 'https://careers.google.com/mobile_dev', 'Open', '2024-12-25'),
('J027', 'C007', 'Cloud Security Engineer', 'Full-time', 'Redmond, USA', '$140,000-$160,000', 'https://careers.microsoft.com/cloud_security', 'Open', '2024-12-26'),
('J028', 'C008', 'Database Administrator', 'Full-time', 'Seattle, USA', '$100,000-$120,000', 'https://www.amazon.jobs/db_admin', 'Closed', '2024-12-27'),
('J029', 'C009', 'Electric Vehicle Technician', 'Internship', 'Palo Alto, USA', '$50,000-$70,000', 'https://www.tesla.com/jobs/ev_technician', 'Open', '2024-12-28'),
('J030', 'C010', 'Human Resources Specialist', 'Full-time', 'Menlo Park, USA', '$90,000-$110,000', 'https://www.metacareers.com/hr_specialist', 'Open', '2024-12-29');


-- SELECT Query
select * from Job_Positions;


-- Table 4: Applications (Fact Table)

INSERT INTO Applications (ApplicationID, ApplicantID, JobID, ApplicationDate, Status, Message)
VALUES
('A001', 7, 'J001', '2024-11-01', 'Submitted', 'Excited to join TCS and grow my career.'),
('A002', 5, 'J002', '2024-11-15', 'In Progress', 'Looking forward to contributing to Infosys projects.'),
('A003', 3, 'J003', '2024-11-20', 'Rejected', 'Thank you for considering my application.'),
('A004', 19, 'J004', '2024-10-22', 'Submitted', 'Eager to explore AI opportunities at HCL.'),
('A005', 6, 'J005', '2024-11-23', 'In Progress', 'Happy to apply for this exciting role.'),
('A006', 1, 'J006', '2024-10-24', 'Rejected', 'Appreciate the opportunity to interview at Google.'),
('A007', 16, 'J007', '2024-11-25', 'Submitted', 'Passionate about ML and excited for Microsoft.'),
('A008', 9, 'J008', '2024-10-26', 'In Progress', 'Looking forward to working with Amazon’s data team.'),
('A009', 4, 'J009', '2024-11-27', 'Rejected', 'Thank you for the opportunity at Tesla.'),
('A010', 10, 'J010', '2024-11-28', 'Submitted', 'Excited to contribute as a Product Manager at Meta.'),
('A011', 7, 'J002', '2024-11-29', 'In Progress', 'Exploring Data Scientist opportunities at Infosys.'),
('A012', 5, 'J004', '2024-08-30', 'Submitted', 'Excited to apply for AI Researcher at HCL.'),
('A013', 1, 'J005', '2024-10-01', 'Submitted', 'Interested in DevOps Engineer role at Tech Mahindra.'),
('A014', 2, 'J001', '2024-12-02', 'Rejected', 'Thank you for considering my application.'),
('A015', 16, 'J007', '2024-12-03', 'In Progress', 'Looking forward to working on ML projects at Microsoft.'),
('A016', 6, 'J003', '2024-12-04', 'Rejected', 'Appreciate the opportunity to interview for Cybersecurity Analyst.'),
('A017', 4, 'J006', '2024-12-05', 'Submitted', 'Keen to explore Frontend Developer role at Google.'),
('A018', 8, 'J009', '2024-12-06', 'Rejected', 'Thank you for the opportunity to apply at Tesla.'),
('A019', 10, 'J008', '2024-10-07', 'In Progress', 'Excited to join Amazon as a Data Engineer.'),
('A020', 28, 'J001', '2024-12-08', 'Submitted', 'Looking forward to growing with TCS.'),
('A021', 3, 'J008', '2024-09-09', 'Submitted', 'Interested in Data Engineer opportunities at Amazon.'),
('A022', 1, 'J009', '2024-12-10', 'Rejected', 'Thank you for considering my Tesla application.'),
('A023', 6, 'J010', '2024-09-11', 'In Progress', 'Passionate about Product Management at Meta.'),
('A024', 17, 'J004', '2024-12-12', 'Submitted', 'Excited to explore AI Researcher opportunities at HCL.'),
('A025', 8, 'J005', '2024-11-13', 'Submitted', 'Keen to contribute to DevOps projects at Tech Mahindra.');


-- SELECT Query
select * from Applications;


-- Table 5: Interviews (Fact Table)

INSERT INTO Interviews (InterviewID, ApplicationID, InterviewDate, InterviewType, Outcome, Feedback)
VALUES 
(101, 'A001', '2024-12-05', 'Technical', 'Passed', 'Strong coding skills.'),
(102, 'A002', '2024-11-25', 'HR', 'Failed', 'Work on communication.'),
(103, 'A004', '2024-11-15', 'Technical', 'Passed', 'Excellent AI knowledge.'),
(104, 'A007', '2024-11-18', 'HR', 'Awaiting Feedback', NULL),
(105, 'A010', '2024-12-01', 'Technical', 'Passed', 'Impressive leadership skills.'),
(106, 'A003', '2024-11-05', 'Behavioral', 'Rejected', 'Focus on storytelling skills.'),
(107, 'A005', '2024-12-07', 'Technical', 'Awaiting Feedback', NULL),
(108, 'A006', '2023-10-14', 'HR', 'Failed', 'Need to improve teamwork communication.'),
(109, 'A008', '2023-12-10', 'Technical', 'Passed', 'Excellent data analysis skills.'),
(110, 'A009', '2024-11-02', 'Technical', 'Awaiting Feedback', NULL),
(111, 'A012', '2024-11-10', 'Behavioral', 'Passed', 'Great interpersonal skills.'),
(112, 'A013', '2023-11-17', 'HR', 'Passed', 'Good leadership qualities.'),
(113, 'A015', '2024-12-14', 'Technical', 'Rejected', 'Improve problem-solving approach.'),
(114, 'A016', '2023-09-16', 'Behavioral', 'Failed', 'Focus on critical thinking.'),
(115, 'A018', '2024-01-19', 'HR', 'Awaiting Feedback', NULL),
(116, 'A019', '2024-02-18', 'Technical', 'Passed', 'Impressive knowledge in cloud computing.'),
(117, 'A020', '2024-03-20', 'Behavioral', 'Passed', 'Strong cultural fit.'),
(118, 'A021', '2024-04-21', 'Technical', 'Failed', 'Lack of confidence in coding skills.'),
(119, 'A023', '2023-08-22', 'HR', 'Passed', 'Good presentation skills.'),
(120, 'A024', '2024-12-12', 'Behavioral', 'Awaiting Feedback', NULL),
(121, 'A025', '2024-10-24', 'Technical', 'Passed', 'Excellent understanding of system design.');


-- SELECT Query
select * from Interviews;


-- Table 6: Job Offers

INSERT INTO Job_Offers (OfferID, InterviewID, OfferDate, PositionTitle, SalaryOffered, OfferStatus)
VALUES
(1, 101, '2024-11-15', 'Software Engineer', '$120k', 'Accepted'),
(2, 103, '2024-09-20', 'AI Researcher', '$125k', 'Accepted'),
(3, 105, '2024-04-25', 'Product Manager', '$85k', 'Pending Paperwork'),
(4, 109, '2024-12-10', 'Data Engineer', '$117k', 'Accepted'),
(5, 111, '2024-07-12', 'Data Scientist', '$100k', 'Rejected'),
(6, 113, '2024-03-05', 'Machine Learning Engineer', '$120k', 'Accepted'),
(7, 116, '2024-01-15', 'Cloud Architect', '$52k', 'Declined'),
(8, 118, '2023-11-20', 'Backend Developer', '$96k', 'Accepted'),
(9, 121, '2024-06-22', 'System Administrator', '$88k', 'Pending Review');


-- SELECT Query
select * from Job_Offers;

--------------------------------------------------------------------------------------------

-- Creating 3 VIEWS

-- View 1: For Active Job Applications with Applicant Details

CREATE VIEW Active_Applications_View AS
SELECT 
    A.ApplicationID,
    AP.FirstName,
    AP.LastName,
    JP.JobTitle,
    JP.Location AS JobLocation,
    A.ApplicationDate,
    A.Status
FROM Applications A
JOIN Applicant_Information AP ON A.ApplicantID = AP.ApplicantID
JOIN Job_Positions JP ON A.JobID = JP.JobID
WHERE A.Status = 'In Progress' OR A.Status = 'Submitted';

-- Select query to view
SELECT * FROM Active_Applications_View;


-- View 2: For Job Offers along with Company Details

CREATE VIEW Job_Offers_View AS
SELECT 
    JO.OfferID,
    AP.FirstName,
    AP.LastName,
    JP.JobTitle,
    C.CompanyName,
    JO.OfferDate,
    JO.SalaryOffered,
    JO.OfferStatus
FROM Job_Offers JO
JOIN Interviews I ON JO.InterviewID = I.InterviewID
JOIN Applications A ON I.ApplicationID = A.ApplicationID
JOIN Applicant_Information AP ON A.ApplicantID = AP.ApplicantID
JOIN Job_Positions JP ON A.JobID = JP.JobID
JOIN Company_Information C ON JP.CompanyID = C.CompanyID
WHERE JO.OfferStatus = 'Accepted';

-- Select query to view
SELECT * FROM Job_Offers_View;


-- View 3: For Applicants Upcoming Interviews

CREATE VIEW Upcoming_Interviews_View AS
SELECT 
    I.InterviewID,
    AP.FirstName,
    AP.LastName,
    JP.JobTitle,
    JP.Location AS JobLocation,
    I.InterviewDate,
    I.InterviewType,
    I.Outcome
FROM Interviews I
JOIN Applications A ON I.ApplicationID = A.ApplicationID
JOIN Applicant_Information AP ON A.ApplicantID = AP.ApplicantID
JOIN Job_Positions JP ON A.JobID = JP.JobID
WHERE I.InterviewDate > GETDATE() OR I.Outcome IS NULL;

-- Select query to view
SELECT * FROM Upcoming_Interviews_View;

-- Testing Query for View 2
SELECT * 
FROM Job_Offers_View
WHERE OfferStatus = 'Accepted';


--------------------------------------------------------------------------------------------

-- Creating TRIGGERS - Audit Log Table for Applicant_Information Table


-- Trigger for Auditing Changes in Applicant_Information Table

CREATE TRIGGER trg_Audit_Applicant_Information
ON Applicant_Information
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert Audit Log for "INSERT" Operation

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AuditLog_Applicant_Information (ActionType, Timestamp, ApplicantID, FirstName, LastName, EmailID, GraduationDate, Major, University, AdditionalDocumentLink)
        SELECT 
            'INSERT' AS ActionType,
            GETDATE() AS Timestamp,
            ApplicantID,
            FirstName,
            LastName,
            EmailID,
            GraduationDate,
            Major,
            University,
            AdditionalDocumentLink
        FROM inserted;
    END;

    -- Insert Audit Log for "UPDATE" Operation
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AuditLog_Applicant_Information (ActionType, Timestamp, ApplicantID, FirstName, LastName, EmailID, GraduationDate, Major, University, AdditionalDocumentLink)
        SELECT 
            'UPDATE' AS ActionType,
            GETDATE() AS Timestamp,
            ApplicantID,
            FirstName,
            LastName,
            EmailID,
            GraduationDate,
            Major,
            University,
            AdditionalDocumentLink
        FROM inserted;
    END;

    -- Insert Audit Log for "DELETE" Operation

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AuditLog_Applicant_Information (ActionType, Timestamp, ApplicantID, FirstName, LastName, EmailID, GraduationDate, Major, University, AdditionalDocumentLink)
        SELECT 
            'DELETE' AS ActionType,
            GETDATE() AS Timestamp,
            ApplicantID,
            FirstName,
            LastName,
            EmailID,
            GraduationDate,
            Major,
            University,
            AdditionalDocumentLink
        FROM deleted;
    END;
END;

-- TESTING

-- Testing the Trigger with INSERT Operation

INSERT INTO Applicant_Information (ApplicantID, FirstName, LastName, EmailID, GraduationDate, Major, University, AdditionalDocumentLink)
VALUES (26, 'Manisha', 'Koirala', 'manisha.koirala@gmail.com', '2023-06-15', 'Business Analytics', 'University of Washington', 'https://manisha-resume.com/analytics');

-- Testing the Trigger with UPDATE Operation

UPDATE Applicant_Information
SET EmailID = 'manisha.koirala.k@yahoo.com'
WHERE ApplicantID = 26;

-- Testing the Trigger with DELETE Operation

DELETE FROM Applicant_Information
WHERE ApplicantID = 26;

-- After testing all trigger operation, Select Query for Applicant_Information

select * from Applicant_Information;

-- After testing all trigger operation, Select Query for AuditLog_Applicant_Information

SELECT * FROM AuditLog_Applicant_Information;


--------------------------------------------------------------------------------------------

-- STORED PROCEDURE

-- Purpose is to retrieve all applications for a specific applicant, including job and company details.

-- Creating Stored Procedure

CREATE PROCEDURE GetApplicationsForApplicant
    @ApplicantID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        A.ApplicationID,
        AP.FirstName,
        AP.LastName,
        JP.JobTitle,
        JP.Location AS JobLocation,
        C.CompanyName,
        A.ApplicationDate,
        A.Status,
        A.Message
    FROM Applications A
    JOIN Applicant_Information AP ON A.ApplicantID = AP.ApplicantID
    JOIN Job_Positions JP ON A.JobID = JP.JobID
    JOIN Company_Information C ON JP.CompanyID = C.CompanyID
    WHERE A.ApplicantID = @ApplicantID;
END;


-- Executing the Stored Procedure

EXEC GetApplicationsForApplicant @ApplicantID = 3;


-- Dropping the Stored Procedure

DROP PROCEDURE GetApplicationsForApplicant;


--------------------------------------------------------------------------------------------

-- User Defined Function (UDF)

-- Purpose is to calculate the total number of applications submitted by a specific applicant.

-- Creating User Defined Function

CREATE FUNCTION GetApplicationCount(@ApplicantID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) 
    FROM Applications 
    WHERE ApplicantID = @ApplicantID;
    RETURN @Count;
END;

-- Using the User Defined Function
-- Purpose is to use the function and retrieve the application count for an applicant

SELECT 
    A.ApplicantID,
    AP.FirstName,
    AP.LastName,
    AP.EmailID,
    dbo.GetApplicationCount(A.ApplicantID) AS TotalApplications
FROM 
    Applications A
JOIN 
    Applicant_Information AP 
ON 
    A.ApplicantID = AP.ApplicantID
GROUP BY 
    A.ApplicantID, AP.FirstName, AP.LastName, AP.EmailID;

-- Dropping the User Defined Function
DROP FUNCTION GetApplicationCount;

--------------------------------------------------------------------------------------------

-- CURSOR


-- This cursor will iterates over the Applications table to check for applications with "In Progress" status and updates the Status field to "Rejected" if they are older than 25 days.

DECLARE @ApplicationID VARCHAR(50), @ApplicationDate DATE, @Status VARCHAR(100);

-- Declare Cursor to Fetch Applications with "In Progress" Status

DECLARE ApplicationsCursor CURSOR FOR
SELECT ApplicationID, ApplicationDate, Status
FROM Applications
WHERE Status = 'In Progress';

-- Open Cursor

OPEN ApplicationsCursor;

-- Fetch the First Row

FETCH NEXT FROM ApplicationsCursor INTO @ApplicationID, @ApplicationDate, @Status;

-- Looping through the Cursor

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Checking if Application is Older than 25 Days
    IF DATEDIFF(DAY, @ApplicationDate, GETDATE()) > 25
    BEGIN
        -- Updating the Status to "Rejected"

        UPDATE Applications
        SET Status = 'Rejected'
        WHERE ApplicationID = @ApplicationID;

        PRINT 'Updated ApplicationID: ' + @ApplicationID + ' to Rejected.';
    END;

    -- Fetch the Next Row
    FETCH NEXT FROM ApplicationsCursor INTO @ApplicationID, @ApplicationDate, @Status;
END;


-- Select Queries
SELECT * FROM Applications;

SELECT * FROM Applications WHERE Status = 'Rejected';


-- Dropping the Cursor Script

-- First checking if the cursor exists and then drop it
IF CURSOR_STATUS('global', 'ApplicationsCursor') >= 0
BEGIN
    -- Closing the cursor
    CLOSE ApplicationsCursor;
    -- Deallocating the cursor
    DEALLOCATE ApplicationsCursor;
    PRINT 'ApplicationsCursor has been successfully dropped.';
END
ELSE
BEGIN
    PRINT 'ApplicationsCursor does not exist or has already been dropped.';
END