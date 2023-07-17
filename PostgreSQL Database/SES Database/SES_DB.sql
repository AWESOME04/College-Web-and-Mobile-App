-- DATABASE PROJECT FOR THE SCHOOL OF ENGINEERNG SCIENCES, UG

-- To develop a database for the Engineering School, the necessary information will be obtained from the Dean's office.

-- The various entities that can be identified for the Engineering School database
-- After gathering all the necessary information, we can start by identifying the entities (objects) that will be stored in the database.
-- Based on the requirements mentioned, some possible entities are:

--     Students
--     Courses
--     Examinations
--     Results
--     Timetables

--     The relationships between these entities can be described as follows:

--     Students can register for multiple courses, examinations, and view their results.
--     Courses are offered by lecturers, and students can register for multiple courses.
--     Examinations are held for courses, and students can register for examinations.
--     Results are generated from examinations.
--     Timetables are created by administrators, and contain details of courses and examination schedules.
--     Lecturers can be assigned to teach multiple courses.


--     Attributes for students can include:

--     Student ID
--     Name
--     Date of birth
--     Address
--     Email
--     Phone number
--     Year of study


--     The correct data types for the attributes identified can be:

--     Student ID: integer
--     Name: varchar
--     Date of birth: date
--     Address: varchar
--     Email: varchar
--     Phone number: varchar
--     Year of study: integer


-- CREATING THE VARIOUS TABLES FOR THE SES DATABASE:

-- Create the Students table
CREATE TABLE Students (
  StudentID BIGINT PRIMARY KEY,
  firstname VARCHAR(200) NOT NULL,
  middlename VARCHAR(200),
  lastname VARCHAR(200) NOT NULL,
  email VARCHAR(50) NOT NULL,
  date_of_birth DATE ,
  phone VARCHAR(30),
  levels INTEGER NOT NULL
);


-- Create the Users table
CREATE TABLE Users (
  UserID SERIAL PRIMARY KEY,
  Username VARCHAR(50) NOT NULL,
  Passwords VARCHAR(50) NOT NULL,
  UserType VARCHAR(20) NOT NULL
);


-- Create the Lecturers table
CREATE TABLE Lecturers (
  LecturerID SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50) ,
  last_name VARCHAR(50) NOT NULL ,
  email VARCHAR(50) ,
  phone VARCHAR(15),
  course_code VARCHAR(30) ,
  Department_ID INTEGER REFERENCES DEPARTMENTS(DepartmentID)
);


-- Create the Courses table
CREATE TABLE Courses (
  CourseCode VARCHAR(20) PRIMARY KEY,
  levels TEXT NOT NULL,
  Title VARCHAR(50) NOT NULL,
  Semester TEXT NOT NULL,
  CreditHours INTEGER ,
  Department VARCHAR(50) NOT NULL ,
  Department_ID INTEGER REFERENCES DEPARTMENTS(DepartmentID)
);


CREATE TABLE LOGIN (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type VARCHAR(20) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES STUDENT(id) ON DELETE CASCADE
        REFERENCES LECTURER(id) ON DELETE CASCADE
        REFERENCES ADMIN(id) ON DELETE CASCADE,
    last_login TIMESTAMP,
    failed_login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMP,
    password_reset_token VARCHAR(255),
    password_reset_token_expiry TIMESTAMP,
    CONSTRAINT valid_user_type CHECK (user_type IN ('student', 'lecturer', 'admin'))
);


-- Create the Registrations table
CREATE TABLE Registrations (
  RegistrationID SERIAL PRIMARY KEY,
  StudentID INTEGER NOT NULL,
  CourseCode VARCHAR(20) NOT NULL,
  Semester VARCHAR(10) NOT NULL,
  Grade VARCHAR(2),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);



-- Create the Departments table
CREATE TABLE Departments (
  DepartmentID SERIAL PRIMARY KEY,
  DepartmentName VARCHAR(50) NOT NULL
);



-- Create the Admin table
CREATE TABLE ADMINS (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telephone_number VARCHAR(20)
);



-- Create the Enrollments table
CREATE TABLE Enrollments (
  EnrollmentID SERIAL PRIMARY KEY,
  StudentID INTEGER NOT NULL,
  AcademicYear VARCHAR(9) NOT NULL,
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);



-- Create the CourseOfferings table
CREATE TABLE CourseOfferings (
  CourseOfferingID SERIAL PRIMARY KEY,
  CourseCode VARCHAR(20) NOT NULL,
  Semester VARCHAR(10) NOT NULL,
  Year INTEGER NOT NULL,
  LecturerID INTEGER NOT NULL,
  FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode),
  FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID)
);



-- Create the Exams table
CREATE TABLE Exams (
  ExamID SERIAL PRIMARY KEY,
  course_code VARCHAR(30),
  semester INTEGER NOT NULL,
  years BIGINT ,
  ExamDate DATE NOT NULL,
  locations TEXT,
  start_time VARCHAR(50) ,
  end_time VARCHAR(50)
);


-- Create the TimeTable table
CREATE TABLE TIMETABLE (
    timetable_id SERIAL PRIMARY KEY,
	Department_ID INTEGER REFERENCES DEPARTMENTS(DepartmentID),
    semester VARCHAR(20),
    years INTEGER,
    start_date DATE,
    end_date DATE
);


-- Create the levels table
CREATE TABLE levels (
	levelID SERIAL PRIMARY KEY,
	NUM TEXT NOT NULL
);



-- Creating the necessary LOCKS for the respective tables

-- Lock the Students table in shared mode
-- Note that these are only used in TRANSACTION BLOCKS!
LOCK TABLE Students IN SHARE MODE;

-- Lock the Users table in exclusive mode
LOCK TABLE Users IN EXCLUSIVE MODE;

-- Lock the Lecturers table in shared mode
LOCK TABLE Lecturers IN SHARE MODE;

-- Lock the Courses table in exclusive mode
LOCK TABLE Courses IN EXCLUSIVE MODE;

-- Lock the Registrations table in shared mode
LOCK TABLE Registrations IN SHARE MODE;

-- Lock the Departments table in exclusive mode
LOCK TABLE Departments IN EXCLUSIVE MODE;

-- Lock the Enrollments table in shared mode
LOCK TABLE Enrollments IN SHARE MODE;

-- Lock the CourseOfferings table in exclusive mode
LOCK TABLE CourseOfferings IN EXCLUSIVE MODE;

-- Lock the Exams table in shared mode
LOCK TABLE Exams IN SHARE MODE;

-- Lock the TimeTable table in exclusive mode
LOCK TABLE TIMETABLE IN EXCLUSIVE MODE;


-- Note that you can adjust the locking mode (i.e., shared, exclusive) depending on your needs.
-- Shared mode allows multiple transactions to read from the table at the same time,
-- while exclusive mode ensures that no other transactions can read


-- Creating AUDITS for the respective Tables


-- Create the audit table for Students
CREATE TABLE Students_audit (
  AuditID SERIAL PRIMARY KEY,
  StudentID BIGINT NOT NULL,
  firstname VARCHAR(200) NOT NULL,
  middlename VARCHAR(200),
  lastname VARCHAR(200) NOT NULL,
  email VARCHAR(50) NOT NULL,
  date_of_birth DATE,
  phone VARCHAR(30),
  levels INTEGER NOT NULL,
  action_type CHAR(1) NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  user_name VARCHAR(50) NOT NULL
);


CREATE TABLE DEPARTMENT_AUDIT (
    id SERIAL PRIMARY KEY,
    department_id INTEGER NOT NULL REFERENCES DEPARTMENTS(id),
    action VARCHAR(20) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    user_id INTEGER REFERENCES ADMIN(id),
    old_name VARCHAR(255),
    new_name VARCHAR(255)
);


-- Create the audit table for Admin
CREATE TABLE admin_audit (
    audit_id SERIAL PRIMARY KEY,
    audit_action CHAR(1) NOT NULL,
    audit_timestamp TIMESTAMP NOT NULL,
    id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telephone_number VARCHAR(20)
);


-- Create the audit table for Level
CREATE TABLE LEVEL_audit (
    operation CHAR(1) NOT NULL,
    ts TIMESTAMP NOT NULL,
    user_name VARCHAR(30) NOT NULL,
    id INTEGER,
    name VARCHAR(20)
);

-- Create the audit table for Courses
CREATE TABLE Courses_Audit (
  AuditID INTEGER PRIMARY KEY,
  CourseCode VARCHAR(20) NOT NULL,
  levels TEXT NOT NULL,
  Title VARCHAR(50) NOT NULL,
  Semester TEXT NOT NULL,
  CreditHours INTEGER ,
  Department VARCHAR(50) NOT NULL ,
  Department_ID INTEGER,
  ActionType VARCHAR(10) NOT NULL,
  ActionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UserID VARCHAR(50) NOT NULL
);


-- Create the audit table for Enrollments
CREATE TABLE Enrollments_Audit (
  AuditID SERIAL PRIMARY KEY,
  EnrollmentID INTEGER NOT NULL,
  StudentID INTEGER NOT NULL,
  AcademicYear VARCHAR(9) NOT NULL,
  Action TEXT NOT NULL,
  DateChanged TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE LOGIN_audit (
    audittime TIMESTAMP,
    username VARCHAR(255),
    password VARCHAR(255),
    user_type VARCHAR(20),
    user_id INTEGER,
    last_login TIMESTAMP,
    failed_login_attempts INTEGER,
    locked_until TIMESTAMP,
    password_reset_token VARCHAR(255),
    password_reset_token_expiry TIMESTAMP,
    audit_action VARCHAR(20)
);


-- Create the audit table for CourseOfferings
CREATE TABLE CourseOfferings_Audit (
  AuditID SERIAL PRIMARY KEY,
  CourseOfferingID INTEGER NOT NULL,
  CourseCode VARCHAR(20) NOT NULL,
  Semester VARCHAR(10) NOT NULL,
  Year INTEGER NOT NULL,
  LecturerID INTEGER NOT NULL,
  Action TEXT NOT NULL,
  DateChanged TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create the audit table for Exams
CREATE TABLE Exams_Audit (
  AuditID SERIAL PRIMARY KEY,
  ExamID INTEGER NOT NULL,
  course_code VARCHAR(30) NOT NULL,
  semester INTEGER NOT NULL,
  years BIGINT ,
  ExamDate DATE NOT NULL,
  locations TEXT,
  start_time VARCHAR(50),
  end_time VARCHAR(50),
  Action TEXT NOT NULL,
  DateChanged TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create the audit table for Timetable
CREATE TABLE TIMETABLE_Audit (
  AuditID SERIAL PRIMARY KEY,
  timetable_id INTEGER NOT NULL,
  Department_ID INTEGER REFERENCES DEPARTMENTS(DepartmentID),
  semester VARCHAR(20),
  years INTEGER,
  start_date DATE,
  end_date DATE,
  Action TEXT NOT NULL,
  DateChanged TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create the TRIGGERS and TRIGGER FUNCTIONS

-- For the 	Students table:
CREATE OR REPLACE FUNCTION students_audit() RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'INSERT') THEN
    INSERT INTO Students_audit(StudentID, firstname, middlename, lastname, email, date_of_birth, phone, levels, action_type, timestamp, user_name)
    VALUES (NEW.StudentID, NEW.firstname, NEW.middlename, NEW.lastname, NEW.email, NEW.date_of_birth, NEW.phone, NEW.levels, 'I', NOW(), current_user);
    RETURN NEW;
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO Students_audit(StudentID, firstname, middlename, lastname, email, date_of_birth, phone, levels, action_type, timestamp, user_name)
    VALUES (OLD.StudentID, OLD.firstname, OLD.middlename, OLD.lastname, OLD.email, OLD.date_of_birth, OLD.phone, OLD.levels, 'U', NOW(), current_user);
    RETURN NEW;
  ELSIF (TG_OP = 'DELETE') THEN
    INSERT INTO Students_audit(StudentID, firstname, middlename, lastname, email, date_of_birth, phone, levels, action_type, timestamp, user_name)
    VALUES (OLD.StudentID, OLD.firstname, OLD.middlename, OLD.lastname, OLD.email, OLD.date_of_birth, OLD.phone, OLD.levels, 'D', NOW(), current_user);
    RETURN OLD;
  END IF;
END;
$$ LANGUAGE plpgsql;


-- Create the trigger on the Students table
CREATE TRIGGER students_audit_trigger
AFTER INSERT OR UPDATE OR DELETE ON Students
FOR EACH ROW
EXECUTE FUNCTION students_audit();



-- For the Admin table
CREATE OR REPLACE FUNCTION admin_audit_function() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO admin_audit (audit_action, audit_timestamp, id, name, email, telephone_number)
        VALUES ('D', NOW(), OLD.id, OLD.name, OLD.email, OLD.telephone_number);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO admin_audit (audit_action, audit_timestamp, id, name, email, telephone_number)
        VALUES ('U', NOW(), NEW.id, NEW.name, NEW.email, NEW.telephone_number);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO admin_audit (audit_action, audit_timestamp, id, name, email, telephone_number)
        VALUES ('I', NOW(), NEW.id, NEW.name, NEW.email, NEW.telephone_number);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER admin_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON ADMINS
FOR EACH ROW
EXECUTE PROCEDURE admin_audit_function();



-- For the Courses table:

CREATE OR REPLACE FUNCTION audit_courses() RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO Courses_Audit (CourseCode, Department, level, Title, Semester, CreditHours, Action) 
    VALUES (OLD.CourseCode, OLD.Department, OLD.level, OLD.Title, OLD.Semester, OLD.CreditHours, 'DELETE');
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO Courses_Audit (CourseCode, Department, level, Title, Semester, CreditHours, Action) 
    VALUES (NEW.CourseCode, NEW.Department, NEW.level, NEW.Title, NEW.Semester, NEW.CreditHours, 'UPDATE');
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO Courses_Audit (CourseCode, Department, level, Title, Semester, CreditHours, Action) 
    VALUES (NEW.CourseCode, NEW.Department, NEW.level, NEW.Title, NEW.Semester, NEW.CreditHours, 'INSERT');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER courses_audit_trigger
AFTER INSERT OR UPDATE OR DELETE ON Courses
FOR EACH ROW
EXECUTE FUNCTION audit_courses();


-- For the Enrollments table:

CREATE OR REPLACE FUNCTION audit_enrollments() RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO Enrollments_Audit (EnrollmentID, StudentID, AcademicYear, Action) 
    VALUES (OLD.EnrollmentID, OLD.StudentID, OLD.AcademicYear, 'DELETE');
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO Enrollments_Audit (EnrollmentID, StudentID, AcademicYear, Action) 
    VALUES (NEW.EnrollmentID, NEW.StudentID, NEW.AcademicYear, 'UPDATE');
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO Enrollments_Audit (EnrollmentID, StudentID, AcademicYear, Action) 
    VALUES (NEW.EnrollmentID, NEW.StudentID, NEW.AcademicYear, 'INSERT');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enrollments_audit_trigger
AFTER INSERT OR UPDATE OR DELETE ON Enrollments
FOR EACH ROW
EXECUTE FUNCTION audit_enrollments();


-- For the levels table:
CREATE OR REPLACE FUNCTION level_audit_func() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO LEVEL_audit (operation, ts, user_name, id, name)
        VALUES ('D', now(), USER, OLD.id, OLD.name);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO LEVEL_audit (operation, ts, user_name, id, name)
        VALUES ('U', now(), USER, NEW.id, NEW.name);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO LEVEL_audit (operation, ts, user_name, id, name)
        VALUES ('I', now(), USER, NEW.id, NEW.name);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER level_audit_trigger
AFTER INSERT OR UPDATE OR DELETE ON LEVELS
FOR EACH ROW EXECUTE PROCEDURE level_audit_func();


-- For the Departments table:
CREATE OR REPLACE FUNCTION department_audit() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO DEPARTMENT_AUDIT (department_id, action, timestamp, user_id, new_name)
        VALUES (NEW.id, 'INSERT', NOW(), NULL, NEW.name);
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO DEPARTMENT_AUDIT (department_id, action, timestamp, user_id, old_name, new_name)
        VALUES (OLD.id, 'UPDATE', NOW(), NULL, OLD.name, NEW.name);
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO DEPARTMENT_AUDIT (department_id, action, timestamp, user_id, old_name)
        VALUES (OLD.id, 'DELETE', NOW(), NULL, OLD.name);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER department_audit_insert
AFTER INSERT OR UPDATE OR DELETE ON DEPARTMENTS
FOR EACH ROW
EXECUTE PROCEDURE department_audit();


-- INSERTING VALUES INTO THE RESPECTIVE TABLES ABOVE 

-- For the levels Table:

INSERT INTO levels(NUM) 
VALUES 

	('100'),
    ('200'),
	('300'),
	('400');

SELECT * FROM levels;

-- For the Courses Table:
SELECT * FROM COURSES;

INSERT INTO COURSES(department,levels,CourseCode,Title,Semester,CreditHours)
VALUES

-- Databse For MTEN Courses:

	  ('MTEN',100,'SENG 101','CALCULUS I','first',4),
      ('MTEN',100,'SENG 103','Mechanics1 Statics','first',3),
      ('MTEN',100,'SENG 105','Engineering Graphics','first',3),
      ('MTEN',100,'SENG 107','Introduction to Engineering','first',2),
	  ('MTEN',100,'SENG 109','General Chemistry','first',3),
	  ('MTEN',100,'SENG 111','General Physics','first',3),
	  ('MTEN',100,'UGRC 110','Academic Writing I','first',3),
	  ('MTEN',100,'SENG 102','CalculusII:Multivarable','second',4),
	  ('MTEN',100,'SENG 114','MechanicsII:Dynamics','second',3),
	  ('MTEN',100,'SENG 106','Applied Electricity','second',3),
	  ('MTEN',100,'SENG 108','Basic Electronics','second',3),
	  ('MTEN',100,'SENG 112','Engineering Computational Tools','second',3),
	  ('MTEN',100,'MTEN 104','Computer Aided Design and Manufacturing(CAD/CAM)','second',3),
	  ('MTEN',100,'UGRC 150','Critical thinkg & pratical reasoning','second',3),
	  ('MTEN',200,'SENG 201','Linear Algebra','first',4),
      ('MTEN',200,'SENG 203','Strength of Materinals I','first',3),
      ('MTEN',200,'SENG 205','Fundamentals of Thermodynamics','first',3),
      ('MTEN',200,'SENG 207','Programming for Engineers','first',3),
	  ('MTEN',200,'SENG 219','Fundamentals of Materials Science& Engineering','first',3),
	  ('MTEN',200,'SENG 209','Materials in our World','first',3),
	  ('MTEN',200,'UGRC 221','Introduction to African Studies','first',3),
	  ('MTEN',200,'SENG 202','Differential Equations','second',4),
	  ('MTEN',200,'SENG 104','Fluid MechanicsI','second',3),
	  ('MTEN',200,'MTEN 202','Kinectics Processes and Surface Phenomenon','second',2),
	  ('MTEN',200,'MTEN 204','Thermodynamics of Materials','second',3),
	  ('MTEN',200,'MTEN 208','Electrical, Magnetic& Optical Properties','second',3),
	  ('MTEN',200,'MTEN 212','Materials Properties Laboratory','second',3),
	  ('MTEN',200,'CHAS 210','Academic Writing II','second',3),
	  ('MTEN',300,'SENG 301','Numerical Methods','first',3),
      ('MTEN',300,'MTEN 301','Materials Processing Laboratory','first',2),
      ('MTEN',300,'MTEN 303','Introducting to Materials Processing','first',3),
      ('MTEN',300,'MTEN 305','Mechanical Behaviour of Materials','first',3),
	  ('MTEN',300,'MTEN 307','Phase Equilibrium of Materials','first',3),
	  ('MTEN',300,'MTEN 309','Materials Analyses Techniques','first',3),
	  ('MTEN',300,'MTEN 311','Solid State Technology','first',2),
	  ('MTEN',300,'MTEN 315','Nanomaterials and Nanotechnology','first',2),
	  ('MTEN',300,'SENG 302','Statistics for Engineers','second',3),
	  ('MTEN',300,'SENG 304','Engineering Economics','second',2),
	  ('MTEN',300,'MTEN 302','Internship','second',1),
	  ('MTEN',300,'MTEN 304','Computational Materials Science','second',2),
	  ('MTEN',100,'MTEN 306','Materials Characterization Laboratory','second',3),
	  ('MTEN',300,'SENG 308','Heat and Mass Transfer','second',3),
	  ('MTEN',300,'MTEN 312','Crystal Chemistry of Ceramics','second',2),
	  ('MTEN',300,'MTEN 314','Ceramic Processing Principle','second',3),
	  ('MTEN',300,'MTEN 316','Enginnering Ceramics I','second',2),
	  ('MTEN',300,'MTEN 318','Principles of Extractive Metallurgy','second',2),
	  ('MTEN',300,'MTEN 322','Physical Metallurgy','second',2),
	  ('MTEN',300,'SENG 324','Metal Joining Technology(Welding)','second',3),
	  ('MTEN',300,'MTEN 326','Organic Chemistryof Polymers','second',3),
	  ('MTEN',300,'MTEN 328','Polymer Processing Tech I','second',2),
	  ('MTEN',400,'SENG 401','laws for Enginners','first',3),
	  ('MTEN',400,'MTEN 400','Project Work','first',3),
	  ('MTEN',400,'MTEN 401','Composite Design and Fabrication','first',3),
	  ('MTEN',400,'MTEN 403','Refractories','first',3),
	  ('MTEN',400,'MTEN 405','Process & Quality Control','first',3),
	  ('MTEN',400,'MTEN 407','Engineering Ceramics II','first',3),
	  ('MTEN',400,'SENG 409','Glasses,Cements and Concretes','first',3),
	  ('MTEN',400,'MTEN 411','Physical Metallurgy II','first',3),
	  ('MTEN',400,'MTEN 413','Foundry Technology','first',3),
	  ('MTEN',400,'MTEN 415','Biodegradable Polymer & Fibrous Materials','first',3),
	  ('MTEN',400,'MTEN 417','Polymer Processing & Technology','first',3),
	  ('MTEN',400,'SENG 402','Principles of Management and Entrepreneurship','second',3),
	  ('MTEN',400,'MTEN 40','Project Work','second',3),
	  ('MTEN',400,'MTEN 402','Non Destructive Evaluation and Failure','second',3),
	  ('MTEN',400,'MTEN 404','Project Management','second',2),
	  ('MTEN',400,'MTEN 408','Professional Development- Seminar','second',1),
	  ('MTEN',400,'MTEN 412','Materials Selection & Design','second',3),
	  ('MTEN',400,'MTEN 414','Environmental Engineering &Waste Management','second',3),
	  ('MTEN',400,'MTEN 416','Corrosion & Corrosion control','second',3);
	  
	  
-- 	  Databse for FPEN Courses:
	  ('FPEN',100,'SENG 101','CALCULUS I','first',4),
      ('FPEN',100,'SENG 103','Mechanics1 Statics','first',3),
      ('FPEN',100,'SENG 105','Engineering Graphics','first',3),
      ('FPEN',100,'SENG 107','Introduction to Engineering','first',2),
	  ('FPEN',100,'SENG 109','General Chemistry','first',3),
	  ('FPEN',100,'SENG 111','General Physics','first',3),
	  ('FPEN',100,'UGRC 110','Academic Writing I','first',3),
	  ('FPEN',100,'SENG 102','CalculusII:Multivarable','second',4),
	  ('FPEN',100,'SENG 104','MechanicsII:Dynamics','second',3),
	  ('FPEN',100,'SENG 106','Applied Electricity','second',3),
	  ('FPEN',100,'SENG 108','Basic Electronics','second',3),
	  ('FPEN',100,'SENG 112','Engineering Computational Tools','second',3),
	  ('FPEN',100,'UGRC 150','Critical thinkg & pratical reasoning','second',3),
	  ('FPEN',200,'SENG 201','Linear Algebra','first',4),
      ('FPEN',200,'SENG 203','Strength of Materinals I','first',3),
      ('FPEN',200,'SENG 205','Fundamentals of Thermodynamics','first',3),
      ('FPEN',200,'SENG 207','Programming for Engineers','first',3),
	  ('FPEN',200,'FPEN 209','Basic Food Process Engineering CalculationsI','first',3),
	  ('FPEN',200,'UGRC 221','Introduction to African Studies','first',3),
	  ('FPEN',200,'SENG 202','Differential Equations','second',4),
	  ('FPEN',200,'FPEN 202','Basic Food Process Engineering Calculations II','second',3),
	  ('FPEN',200,'FPEN 204','Physical and Chemical Properties of Food','second',3),
	  ('FPEN',200,'FPEN 206','Chemical Equilibrium Thermodynamics','second',3),
	  ('FPEN',200,'FPEN 208','Transport Phenomena I(Momentum Transfer','second',3),
	  ('FPEN',200,'CHAS 210','Academic Writing II','second',3),
	  ('FPEN',300,'SENG 301','Numerical Methods','first',3),
      ('FPEN',300,'FPEN 301','Transport Phenomena II(Heat Transfer)','first',3),
      ('FPEN',300,'FPEN 303','Engineering & Design of Food Process I','first',3),
      ('FPEN',300,'FPEN 305','Introduction to Food Microbiology','first',3),
	  ('FPEN',300,'FPEN 307','Process/Product Development in Food Processing','first',3),
	  ('FPEN',300,'FPEN 309','Introduction to Biotechnolgy ','first',3),
	  ('FPEN',300,'FOSC 307','Beverages and Sugar Processing Technology','first',2),
	  ('FPEN',300,'FPEN 311','Introduction to Food Biochemistry','first',3),
	  ('FPEN',300,'SENG 302','Statistics for Engineers','second',3),
	  ('FPEN',300,'SENG 304','Engineering Economics','second',2),
	  ('FPEN',300,'FPEN 302','Separation Process','second',3),
	  ('FPEN',300,'FPEN 304','Enginerring & Design of Food Process II','second',2),
	  ('FPEN',100,'FPEN 308','Environmental Engineering in Food Processing','second',3),
	  ('FPEN',300,'FPEN 312','Transport Phenomena III(was Mass Transfer)','second',3),
	  ('FPEN',300,'FPEN 322','Internship','second',1),
	  ('FPEN',300,'FPEN 314','Rheological and Sensory Properties of Food','second',2), 
	  ('FPEN',400,'SENG 401','laws for Enginners','first',3),
	  ('FPEN',400,'FPEN 401','Food Plant Design and Economics','first',3),
	  ('FPEN',400,'FPEN 403','Chemical and Biochemical Reaction Engineering ','first',3),
	  ('FPEN',400,'FPEN 405','Engineering and Design of Food Process III(Plant Production)','first',3),
	  ('FPEN',400,'FPEN 407','Satistical Quality Control in Food Processing','first',3),
	  ('FPEN',400,'FPEN 409','Safety in Food Plants','first',3),
	  ('FPEN',400,'FPEN 411','Professional Development Seminar','first',1),
	  ('FPEN',400,'FPEN 413','Engineering Design','first',2),
	  ('FPEN',400,'SENG 402','Principles of Management and Entrepreneurship','second',3),
	  ('FPEN',400,'FPEN 400','Independent Enginnering Study(Capstone Engineering Design)','second',6),
	  ('FPEN',400,'FPEN 402','Engineering and Design of Food Process IV(Animal Products)','second',3),
	  ('FPEN',400,'FOSC 402','Food Processing Plant Operations and Sanitation','second',2),
	  ('FPEN',400,'FPEN 404','Process Control','second',2),
	  ('FPEN',400,'FPEN 406','Food Packaging','second',2),
	  ('FPEN',400,'FPEN 416','Microbiological Applications in Food Processing','second',3)

-- Databse For AREN Courses:

	  ('AREN', 100,'SENG 101', 'Calculus I(Pre Maths): Single Variable', 4),
      ('AREN', 100,'SENG 103', 'Mechanics I: Statics', 3),
      ('AREN', 100,'SENG 105', 'Engineering Graphics', 3),
      ('AREN', 100,'SENG 107', 'Introduction to Engineering', 2),
      ('AREN', 100,'SENG 109', 'General Chemistry', 3),
      ('AREN', 100,'SENG 111', 'General Physics', 3),
      ('AREN', 100,'UGRC 110', 'Academic Writing I', 3),
      ('AREN', 100, 'SENG 102', 'CalculusII: Multivarable', 4),
      ('AREN', 100, 'SENG 104', 'MechanicsII:Dynamics', 3),
      ('AREN', 100, 'SENG 106', 'Applied Electricity', 3),
      ('AREN', 100, 'SENG 108', 'Basic Electronics', 3),
      ('AREN', 100, 'SENG 112', 'Engineering Computational Tools', 3),
      ('AREN', 100, 'AREN 114', 'Introduction to Biosystems Engineering', 3),
      ('AREN', 100, 'UGRC 150', 'Critical Thinking and Pratical Reasoning', 3),

      ('AREN', 200, 'SENG 201', 'Linear Algebra', 4),
      ('AREN', 200, 'SENG 203', 'Strength of Materials I', 3),
      ('AREN', 200, 'SENG 205', 'Fundamentals of Thermodynamics', 3),
      ('AREN', 200, 'SENG 207',' Programming for Engineers', 3),
      ('AREN', 200, 'AREN 211', 'Animal Production', 3),
      ('AREN', 200, 'AREN 213', 'Engineering Surveying', 3),
      ('AREN', 200, 'UGRC 221', 'Introduction to African Studies', 3),
      ('AREN', 200, 'SENG 202', 'Differential Equations', 4),
      ('AREN', 200, 'SENG 204', 'Fluid Mechanics I', 3),
      ('AREN', 200, 'AREN 212', 'Introduction to Crop Production', 3),
      ('AREN', 200, 'AREN 214', 'Heat Transfer', 3),
      ('AREN', 200, 'AREN 216', 'Soil Mechanics I', 3),
      ('AREN', 200, 'AREN 232', 'Energy and Power in Biosystems Engineering', 2),
      ('AREN', 200, 'CBAS 210', 'Academic Writing II', 3),
	  
      ('AREN', 300, 'SENG 301', 'Numerical Methods', 3),
      ('AREN', 300, 'AREN 321', 'Engineering Hydrology', 3),
      ('AREN', 300, 'AREN 325', 'Surface Irrigation', 3),
      ('AREN', 300, 'AREN 331', 'Soil & Crop Mechanics Application to Mechanization', 3),
      ('AREN', 300, 'AREN 341', 'Agricultural Produce Processing Systems I: Durables', 3),
      ('AREN', 300, 'AREN 343','Farm Structures I', 3),
      ('AREN', 300, 'AREN 323','Soil Mechanics II', 3),
      ('AREN', 300, 'SENG 302', 'Statistics for Engineers', 3),
      ('AREN', 300, 'SENG 304', 'Engineering Economics', 2),
      ('AREN', 300, 'AREN 306', 'Mechanical Engineering Design I', 3),
      ('AREN', 300, 'AREN 312', 'Rural Engineering', 3),
      ('AREN', 300, 'AREN 314', 'Internship(Industrial Practice)', 3),
      ('AREN', 300, 'AREN 322', 'Fluid Mechanics', 3),
      ('AREN', 300, 'AREN 332', 'Mechanics of Tillage and Traction', 3),
      ('AREN', 300, 'AREN 342', 'Agricultural Produce Processing Systems II (Persihables)', 3),
	  
      ('AREN', 400, 'SENG 401', 'Law for Enginners', 3),
      ('AREN', 400, 'AREN 421', 'Soil and Water Conservation Engineering', 3),
      ('AREN', 400, 'AREN 433', 'Technology of Tractor and Implement', 3),
      ('AREN', 400, 'AREN 441', 'Farm Structures II', 3),
      ('AREN', 400, 'AREN 423', 'Engineering Hydraulics', 3),
      ('AREN', 400, 'AREN 425', 'Drainage Engineering', 3),
      ('AREN', 400, 'AREN 427', 'Groundwater Hydrology', 3),
      ('AREN', 400, 'AREN 431', 'Renewable Energy Technology', 3),
      ('AREN', 400, 'AREN 435', 'Maintenance if Agricultural Machines', 3),
      ('AREN', 400, 'AREN 437', 'Climate Smart Mechanization', 3),
      ('AREN', 400, 'AREN 443', 'Green Supply Chain Management', 3),
      ('AREN', 400, 'AREN 445', 'Storage Systems', 3),
      ('AREN', 400, 'AREN 447', 'Cold Chain Management', 3),
      ('AREN', 400, 'SENG 402', 'Principles of Management and Entrepreneurship',  3),
      ('AREN', 400, 'AREN 400','Project Work', 6),
      ('AREN', 400, 'AREN 426', 'Agrometeoroly and Climatology', 3),
      ('AREN', 400, 'AREN 436', 'Farm Machine Design', 3),
      ('AREN', 400, 'AREN 422', 'Hydraulic Structures', 3),
      ('AREN', 400, 'AREN 424', 'Water Resources Management', 3),
      ('AREN', 400, 'AREN 428', 'Micro Irrigation', 3),
      ('AREN', 400, 'AREN 432', 'Agricultural Machinery Management', 3),
      ('AREN', 400, 'AREN 434', 'Precision Agriculture', 3),
      ('AREN', 400, 'AREN 438', 'Livestock Mechanization', 3),
      ('AREN', 400, 'AREN 442', 'Green Engineering', 3),
      ('AREN', 400, 'AREN 444', 'Agricultural Materials Handling', 3),
      ('AREN', 400, 'AREN 448', 'Introduction to Mechatronics', 3);
	  
	    
-- 	  Databse for BMEN Courses:

	  (100,'SENG 101','CALCULUS I',4)
      (100,'SENG 103','Mechanics1 Statics',3)
      (100,'SENG 105','Engineering Graphics',3)
      (100,'SENG 107','Introduction to Engineering',2)
	  (100,'SENG 109','General Chemistry',3)
	  (100,'SENG 111','General Physics',3)
	  (100,'UGRC 110','Academic Writing I',3)
	  
	  (100,'SENG 102','CalculusII:Multivarable',4)
	  (100,'SENG 104','MechanicsII:Dynamics',3)
	  (100,'SENG 106','Applied Electricity',3)
	  (100,'SENG 108','Basic Electronics',3)
	  (100,'SENG 112','Engineering Computational Tools',3)
	  (100,'BMEN 102','General Biology',2)
	  (100,'UGRC 150','Critical thinkg& pratical reasoning',3)
	  
	  (200,'SENG 201','Linear Algebra',4)
      (200,'SENG 203','Strength of Materinals I',3)
      (200,'SENG 205','Fundamentals of Thermodynamics',3)
      (200,'SENG 207','Programming for Engineers',3)
	  (200,'BMEN 201','Anatomy and Physiology',3)
	  (200,'BMEN 203','Introduction to Structure and Properties of Materials',2)
	  (200,'UGRC 220-238','Intro to African Studies',3)
	  
	  (200,'SENG 202','Differential Equations',4)
	  (200,'SENG 104','Fluid Mechanics I',3)
	  (200,'BMEN 202','Introduction to Biomedical Engineering',3)
	  (200,'BMEN 204','Eng. Principles of Human Physiology And Anatomy',3)
	  (200,'BMEN 208','Transport Process in Liing Systems',2)
	  (200,'BMEN 208','Medical Imaging',3)
	  (200,'CBAS 210','Academic Writing II',3)
	  
	  (300,'SENG 301','Numerical Methods',3)
      (300,'BMEN 303','Bioinstrumentation',3)
      (300,'BMEN 305','Biomaterials',3)
      (300,'BMEN 307','Biomechanics',3)
	  (300,'BMEN 309','Cell, Molecular Biology and Biotechnology',3)
	  (300,'BMEN 315','Research Methodology',3)
	 
	  (300,'SENG 302','Statistics for Engineers',3)
	  (300,'SENG 304','Engineering Economics',2)
	  (300,'BMEN 302','Tissue Engineering',3)
	  (300,'BMEN 304','Local Issues in Biomedical Engineering ',3)
	  (100,'BMEN 306','Design & Selection of Biomaterials',3)
	  (300,'SENG 308','Design of Mechanical Systems',3)
	  (300,'BMEN 314','Biomedical Engineering Systems',3)
	  (300,'BMEN 316','BMEN 316 Internship (Industrial Practice)',3)
	  
	  
	  (400,'SENG 401','laws for Enginners',3)
	  (400,'BMEN 405','Cardiovascular and Respiratory Systems Mechanics',3)
	  (400,'BMEN 407','Medical Signal and Image Processing',3)
	  
	  (400,'BMEN 403','Hiophysics',3)
	  (400,'BMEN 411','Medical Physics',3)
	  (400,'BMEN 413','Bioelectronics',3)
	  (400,'SENG 417','Nanotechnology',3)
	  (400,'BMEN 419','Health Technology Assessment',3)
	  (400,'BMEN 421','Bioinformatics',3)
	  
	  (400,'BMEN 400','Project',6)
	  (400,'SENG 402','Principles of Management and Entrepreneurship',3)
	 
	 (400,'BMEN 404','Telemetry and Telemedicine',3)
	  (400,'BMEN 406','Rehabilitation Engineering',3)
	  (400,'BMEN 408','Orthotics and Prosthesis',3)
	  (400,'BMEN 412','Healthcare Facility Planning & Design ',3)
	  (400,'BMEN 414','Biophotonics',3)
	  
	  
-- 	  Databse for CPEN Courses:

	  (100,'SENG 101','CALCULUS I',4)
      (100,'SENG 103','Mechanics1 Statics',3)
      (100,'SENG 105','Engineering Graphics',3)
      (100,'SENG 107','Introduction to Engineering',2)
	  ('CPEN 103','Computer Engineering Innovations',3)
	  (100,'SENG 111','General Physics',3)
	  (100,'UGRC 110','Academic Writing I',3)
	  (100,'SENG 102','CalculusII:Multivarable',4)
	  (100,'SENG 104','MechanicsII:Dynamics',3)
	  (100,'SENG 106','Applied Electricity',3)
	  (100,'SENG 108','Basic Electronics',3)
	  (100,'SENG 112','Engineering Computational Tools',3)
	  (100,'CPEN 104','Engineering Design',2)
	  (100,'UGRC 150','Critical thinkg& pratical reasoning',3)
	  
	  (200,'SENG 201','Linear Algebra',4)
      (200,'CPEN 203','Digital Circuits',3)
      (200,'CPEN 213','Discrete MathemaCPEN',3)
      (200,'SENG 207','Programming for Engineers',3)
	  (200,'SENG 209','Database System Design',3)
	  (200,'CPEN 201','C++ Programming',3)
	  (200,'UGRC 220 - 238','Introduction to African Studies',3)
	  
	  (200,'SENG 202','Differential Equations',4)
	  (200,'CPEN 204','Data Structure and Algorithms',3)
	  (200,'CPEN 206','Linear Circuits',3)
	  (200,'CPEN 208','Software EngineeCPEN',3)
	  (200,'CPEN 212','Data Communcations',3)
	  (200,'CPEN 214','Digital System Design',3)
	  (200,'CBAS 210','Academic Writing II',3)
	  
	  (300,'SENG 301','Numerical Methods',3)
      (300,'CPEN 301','Signals and Sytems',3)
      (300,'CPEN 307','Operating Systems',3)
      (300,'CPEN 305','Computer Networks',3)
	  (300,'CPEN 311','Object-Oriented Programming',3)
	  (300,'CPEN 313','Microelectronics Circuit Analysis and Design',3)
	  (300,'CPEN 315','Computer Organization and Architecture',3)
	  
	  (300,'SENG 302','Statistics for Engineers',3)
	  (300,'SENG 304','Engineering Economics',2)
	  (300,'CPEN 304','Digital Signal Processing',3)
	  (300,'CPEN 314','Industrial Practice',3)
	  (300,'CPEN 316','Artificial Intelligence and Applications',3)
	  (300,'SENG 318','Software for Distributed Systems',3)
	  (300,'CPEN 322','Microprocessor Programming and Interfacing',3)
	  (300,'SENG 324','Research Methods',3)
	 
	  (400,'SENG 401','Law for Enginners',3)
	  (400,'CPEN 400','Independent Project I',3)
	  (400,'CPEN 401','Control Systems Analysis and Design',3)
	  (400,'CPEN 403','Embedded Systems',3)
	  (400,'CPEN 419','Computer Vision',3)
	  (400,'CPEN 429','Engineering Trends in Computer Engineering',3)
	  
	  (400,'SENG 409','Computer Graphics',3)
	  (400,'CPEN 411','VLSI Systems Design',3)
	  (400,'CPEN 415','Distributed Computing',3)
	  (400,'CPEN 421','Mobile and Web Software Design and Architecture',3)
	  (400,'CPEN 423','Digital Forensics',3)
	  (400,'CPEN 425','Real-Time Systems',3)
	  (400,'CPEN 427','Cryptography',3)
	  
	  (400,'SENG 402','Principles of Management and Entrepreneurship',3)
	  (400,'CPEN 400','Independent Project II',3)
	  (400,'CPEN 406','Wireless Communication Systems',3)
	  (400,'CPEN 424','Robotics',3)
	  (400,'CPEN 426','Computer and Network Security',3)
	  (400,'CPEN 444','Professional Development',3)
	  
	  (400,'CPEN 408','Human-Computer Interface',3)
	  (400,'CPEN 422','Multimedia Systems',3)
	  (400,'CPEN 434','Digital Image Processing',3)
	  (400,'CPEN 432','Wireless Sensor Networks',3)
	  (400,'CPEN 438','Advanced Computer Architecture Systems and Design',3)
	  (400,'CPEN 442','Introduction to Machine Learning',3)
	  



-- Lecturers and their respective courses:

INSERT INTO Lecturers (first_name, middle_name, last_name, email, phone, course_code)
VALUES

	('Kenneth', '', 'Broni', 'kbroni123@gmail.com', '0244895256', 'SENG 207'),
	('John', '', 'Assiamah', '@ug.edu.gh', '', 'CPEN 211'),
	('Margaret', 'Ansah', 'Richardson', 'marichardson@ug.edu.gh', '', 'CPEN 201'),
	('Percy', '', 'Okae', '@ug.edu.gh', '', 'CPEN'),
	('Agyare', '', 'Debra', '@ug.edu.gh', '', 'CPEN 203'),
	('Emmanuel', '', 'Djabang', 'edjabang@ug.edu.gh', '', 'SENG 201'),
	('Eric', 'Oppong', 'Danso', '@ug.edu.gh', '', ''),
	('P', 'K', 'Amoatey', '@ug.edu.gh','', ''),
	('E', '', 'Essien', '@ug.edu.gh', '', ''),
	('Emmmanuel', '', 'Nyankson', 'enyankson@ug.edu.gh', '', 'SENG 205'),
	('Elvis', 'K', 'Tiburu', '@ug.edu.gh', '', 'BMEN 201'),
	('Bernard', 'Owusu', 'Asimeng', '@ug.edu.gh', '', 'BMEN 203');

SELECT * FROM LECTURERS;


-- Various Timetables for the various semesters


INSERT INTO TIMETABLE (timetable_id, semester, years, start_date, end_date)
VALUES 
       (1, '1', 2023, '2023-01-09', '2023-04-27'),
       (2, '2', 2023, '2023-05-15', '2023-08-23'),
       (3, '1', 2023, '2023-09-01', '2023-12-15'),
       (4, '2', 2024, '2024-01-10', '2024-04-28'),
       (5, '1', 2024, '2024-05-16', '2024-08-24'),
       (21, '2', 2024, '2024-09-01', '2024-12-15'),
       (6, '1', 2025, '2025-01-09', '2025-04-27'),
       (7, '2', 2025, '2025-05-15', '2025-08-23'),
       (8, '1', 2025, '2025-09-01', '2025-12-15'),
       (9, '2', 2026, '2026-01-10', '2026-04-28'),
       (10, '1', 2026, '2026-05-16', '2026-08-24'),
       (11, '2', 2026, '2026-09-01', '2026-12-15'),
       (12, '1', 2027, '2027-01-09', '2027-04-27'),
       (13, '2', 2027, '2027-05-15', '2027-08-23'),
       (14, '1', 2027, '2027-09-01', '2027-12-15'),
       (15, '2', 2028, '2028-01-10', '2028-04-28'),
       (16, '1', 2028, '2028-05-16', '2028-08-24'),
       (17, '2', 2028, '2028-09-01', '2028-12-15'),
       (18, '1', 2029, '2029-01-09', '2029-04-27'),
       (19, '2', 2029, '2029-05-15', '2029-08-23'),
       (20, '1', 2029, '2029-09-01', '2029-12-15');
       

SELECT * FROM TIMETABLE;

INSERT INTO exams (course_code, semester, years, ExamDate, locations, start_time, end_time)
VALUES 

       ('UGRC 110', 1, 2023, '2023-01-09', 'CC', '07:30:00', '08:30:00'),
       ('SENG 101', 1, 2023, '2023-05-15', 'SES', '07:30:00', '10:30:00'),
       ('SENG 103', 1, 2023, '2023-09-01', 'SES', '11:30:00', '13:30:00'),
       ('SENG 105', 1, 2023, '2023-01-10', 'SES', '09:30:00', '11:30:00'),
       ('SENG 107', 1, 2023, '2023-05-10', 'SES', '07:30:00', '09:30:00'),
       ('SENG 109', 1, 2023, '2023-09-01', 'SES', '17:30:00', '19:30:00'),
       ('SENG 111', 1, 2023, '2023-01-09', 'SES', '07:30:00', '11:30:00'),
       ('CPEN 103', 1, 2023, '2023-05-15', 'SES', '07:30:00', '11:30:00'),
	   
       ('UGRC 220-238', 1, 2023, '2023-09-01', 'UGCS', '07:30:00', '08:30:00'),
       ('SENG 201', 1, 2023, '2023-09-01', 'SES', '09:30:00', '11:30:00'),
       ('SENG 203', 1, 2023, '2023-01-10', 'SES', '07:30:00', '10:30:00'),
       ('SENG 205', 1, 2023, '2023-05-16', 'SES', '07:30:00', '09:30:00'),
       ('SENG 207', 1, 2023, '2023-09-01', 'SES', '11:30:00', '13:30:00'),
       ('AREN 211', 1, 2023, '2023-01-09', 'SES', '07:30:00', '10:00:00'),
       ('AREN 213', 1, 2023, '2023-05-15', 'SES', '08:30:00', '10:30:00'),
       ('BMEN 201', 1, 2023, '2023-09-01', 'SES', '09:30:00', '11:30:00'),
       ('BMEN 203', 1, 2023, '2023-01-10', 'SES', '11:30:00', '13:30:00'),
       ('CPEN 201', 1, 2023, '2023-05-16', 'SES', '10:30:00', '12:30:00'),
       ('CPEN 203', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('CPEN 213', 1, 2023, '2023-01-09', 'SES', '09:30:00', '11:30:00'),
       ('FPEN 209 ',1, 2023, '2023-05-15', 'SES', '09:30:00', '11:30:00'),
	   
       ('SENG 301', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('AREN 325', 1, 2023, '2023-09-01', 'SES', '15:30:00', '17:30:00'),
       ('AREN 321', 1, 2023, '2023-01-10', 'SES', '09:30:00', '11:30:00'),
       ('AREN 331', 1, 2023, '2023-05-16', 'SES', '13:30:00', '15:30:00'),
       ('AREN 341', 1, 2023, '2023-09-01', 'SES', '07:30:00', '11:30:00'),
       ('AREN 343', 1, 2023, '2023-01-09', 'SES', '09:30:00', '11:30:00'),
       ('AREN 323', 1, 2023, '2023-05-15', 'SES', '09:30:00', '11:30:00'),
       ('BMEN 303', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('BMEN 305', 1, 2023, '2023-09-01', 'SES', '11:30:00', '13:30:00'),
       ('BMEN 307', 1, 2023, '2023-01-10', 'SES', '13:30:00', '15:30:00'),
       ('BMEN 309', 1, 2023, '2023-05-16', 'SES', '16:30:00', '18:30:00'),
       ('BMEN 315', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('FPEN 301', 1, 2023, '2023-01-09', 'SES', '08:30:00', '11:30:00'),
       ('FPEN 303', 1, 2023, '2023-05-15', 'SES', '11:30:00', '13:30:00'),
       ('FPEN 305', 1, 2023, '2023-09-01', 'SES', '09:30:00', '11:30:00'),
       ('FPEN 307', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('FPEN 309', 1, 2023, '2023-01-10', 'SES', '07:30:00', '09:30:00'),
       ('FPEN 311', 1, 2023, '2023-05-16', 'SES', '09:30:00', '11:30:00'),
       ('FOSC 307', 1, 2023, '2023-09-01', 'SES', '10:30:00', '12:30:00'),
       ('MTEN 301', 1, 2023, '2023-01-09', 'SES', '13:30:00', '15:30:00'),
       ('MTEN 303', 1, 2023, '2023-05-15', 'SES', '07:30:00', '10:30:00'),
       ('MTEN 305', 1, 2023, '2023-09-01', 'SES', '17:30:00', '19:30:00'),
       ('MTEN 307', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('MTEN 309', 1, 2023, '2023-01-10', 'SES', '07:30:00', '09:30:00'),
       ('MTEN 311', 1, 2023, '2023-05-13', 'SES', '11:30:00', '13:30:00'),
       ('MTEN 315', 1, 2023, '2023-09-01', 'SES', '13:30:00', '15:30:00'),
       ('CPEN 301', 1, 2023, '2023-01-09', 'SES', '13:30:00', '15:30:00'),
       ('CPEN 305', 1, 2023, '2023-05-15', 'SES', '15:30:00', '17:30:00'),
       ('CPEN 307', 1, 2023, '2023-09-01', 'SES', '07:30:00', '09:30:00'),
       ('CPEN 311', 1, 2023, '2023-09-01', 'SES', '17:30:00', '19:30:00'),
       ('CPEN 313', 1, 2023, '2023-01-10', 'SES', '11:30:00', '13:30:00'),
       ('CPEN 315', 1, 2023, '2023-05-16', 'SES', '07:30:00', '10:30:00'),

       ('SENG 401', 1, 2023, '2023-04-10', 'SES', '07:30:00', '10:30:00'),
       ('AREN 421', 1, 2023, '2023-04-14', 'SES', '08:30:00', '11:00:00'),
       ('AREN 433', 1, 2023, '2023-04-15', 'SES', '09:30:00', '11:30:00'),
       ('AREN 441', 1, 2023, '2023-04-18', 'SES', '13:30:00', '16:00:00'),
       ('AREN 423', 1, 2023, '2023-04-22', 'SES', '11:30:00', '13:30:00'),
       ('AREN 425', 1, 2023, '2023-04-24', 'SES', '07:30:00', '11:30:00'),
       ('AREN 427', 1, 2023, '2023-04-26', 'SES', '17:30:00', '19:30:00'),

       ('BMEN 405', 1, 2023, '2023-04-12', 'SES', '07:30:00', '10:30:00'),
       ('BMEN 407', 1, 2023, '2023-04-14', 'SES', '12:30:00', '14:30:00'),
       ('BMEN 403', 1, 2023, '2023-04-18', 'SES', '09:30:00', '11:30:00'),
       ('BMEN 411', 1, 2023, '2023-04-21', 'SES', '07:30:00', '10:30:00'),
       ('BMEN 413', 1, 2023, '2023-04-22', 'SES', '08:30:00', '11:00:00'),
       ('SENG 417', 1, 2023, '2023-04-24', 'SES', '11:30:00', '13:30:00' ),
       ('BMEN 419', 1, 2023, '2023-04-26', 'SES', '15:30:00', '17:30:00'),
       ('SENG 421', 1, 2023, '2023-04-27', 'SES', '07:30:00', '09:30:00'),

       ('FPEN 401', 1, 2023, '2023-04-11', 'SES', '11:30:00', '14:30:00'),
       ('FPEN 403', 1, 2023, '2023-04-15', 'SES', '09:30:00', '12:30:00'),
       ('FPEN 405', 1, 2023, '2023-04-18', 'SES', '10:30:00', '12:30:00'),
       ('FPEN 407', 1, 2023, '2023-04-12', 'SES', '07:30:00', '10:30:00'),
       ('FPEN 409', 1, 2023, '2023-04-22', 'SES', '09:30:00', '12:30:00'),
       ('FPEN 411', 1, 2023, '2023-04-23', 'SES', '11:30:00', '14:30:00'),
       ('FPEN 413', 1, 2023, '2023-04-25', 'SES', '15:30:00', '17:30:00'),

       ('CPEN 400', 1, 2023, '2023-04-10', 'SES', '12:30:00', '14:30:00'),
       ('CPEN 401', 1, 2023, '2023-04-12', 'SES', '10:30:00', '12:30:00'),
       ('CPEN 403', 1, 2023, '2023-04-15', 'SES', '11:30:00', '14:30:00'),
       ('CPEN 419', 1, 2023, '2023-04-17', 'SES', '09:30:00', '12:30:00'),
       ('CPEN 429', 1, 2023, '2023-04-19', 'SES', '09:30:00', '11:30:00'),
       ('CPEN 409', 1, 2023, '2023-04-21', 'SES', '09:30:00', '11:30:00'),
       ('CPEN 411', 1, 2023, '2023-04-23', 'SES', '07:30:00', '11:00:00'),
       ('CPEN 415', 1, 2023, '2023-04-17', 'SES', '11:30:00', '14:30:00'),
       ('CPEN 421', 1, 2023, '2023-04-15', 'SES', '11:30:00', '13:30:00'),
       ('CPEN 423', 1, 2023, '2023-04-24', 'SES', '09:30:00', '13:30:00'),
       ('CPEN 425', 1, 2023, '2023-04-25', 'SES', '07:30:00', '09:30:00'),
       ('CPEN 427', 1, 2023, '2023-04-27', 'SES', '07:30:00', '10:30:00');
	   

SELECT * FROM TIMETABLE;


INSERT INTO students (StudentID, firstname, middlename, lastname, date_of_birth, email, phone, levels)
VALUES

  (11046578, 'Kwame', 'Boadi', 'Adom', '2003-02-16', 'kwameadom@gmail.com', '+233548567890', 100),
  (11097568, 'Abena', 'Serwaa', 'Owusu', '2002-06-21', 'abenaowusu@gmail.com', '+233545678901', 100),
  (11057467, 'Yawo', 'Kwadwo', 'Adu', '2004-01-15', 'yawoadu@gmail.com', '+233548789012', 100),
  (11045699, 'Akua', 'Abigail', 'Mensah', '2001-08-09', 'akuamensah@gmail.com', '+233542345678', 100),
  (11045689, 'Kofi', 'Yayra', 'Asante', '2003-12-04', 'kofiasante@gmail.com', '+233548901234', 100),
  (11098674, 'Ama', 'Agnes', 'Kwakye', '2002-04-19', 'amakwakye@gmail.com', '+233542345678', 100),
  (11046887, 'Yaw', 'Kelvin', 'Ofori', '2004-09-27', 'yawofori@gmail.com', '+233548901234', 100),
  (11024787, 'Adwoa', 'John', 'Darko', '2001-03-13', 'adwoadarko@gmail.com', '+233545678901', 100),
  (11097865, 'Kwesi', 'King', 'Osei', '2003-07-18', 'kwesiosei@gmail.com', '+233548789012', 100),
  (11095674, 'Akosua', 'Gabby', 'Addo', '2002-11-23', 'akosuaaddo@gmail.com', '+233542345678', 100),
  (11007554, 'Kwabena', 'Lincoln', 'Boateng', '2004-05-08', 'kwabenaboateng@gmail.com', '+233548901234', 100),
  (11068957, 'Ama', 'Ofosu', 'Nkrumah', '2001-09-02', 'amankrumah@gmail.com', '+233545678901', 100),
  (11000884, 'Kofi', 'Wick', 'Tetteh', '2003-11-12', 'kofitetteh@gmail.com', '+233548789012', 100),

  
  (10957499, 'Emma', 'Rose', 'Smith', '2001-01-01', 'emma.smith@gmail.com', '+233241234567', 200),
  (10986982, 'Sophia', 'Elizabeth', 'Jones', '2002-02-02', 'sophia.jones@gmail.com', '+233242345678', 200),
  (10966713, 'Olivia', 'Marie', 'Davis', '2003-03-03', 'olivia.davis@gmail.com', '+233243456789',200),
  (10955078, 'Ava', 'Grace', 'Taylor', '2004-04-04', 'ava.taylor@gmail.com', '+233244567890', 200),
  (10956332, 'Isabella', 'Faith', 'Anderson', '2005-05-05', 'isabella.anderson@gmail.com', '+233245678901', 200),
  (10947466, 'Mia', 'Hope', 'Wilson', '2006-06-06', 'mia.wilson@gmail.com', '+233246789012', 200),
  (10980830, 'Charlotte', 'Joy', 'Johnson', '2007-07-07', 'charlotte.johnson@gmail.com', '+233247890123', 200),
  (10957340, 'Amelia', 'May', 'Brown', '2008-08-08', 'amelia.brown@gmail.com', '+233248901234', 200),
  (10967291, 'Harper', 'Ella', 'Miller', '2009-09-09', 'harper.miller@gmail.com', '+233249012345', 200),
  (10968794, 'Evelyn', 'Rose', 'Garcia', '2010-10-10', 'evelyn.garcia@gmail.com', '+233240123456', 200),
  (10967345, 'Abigail', 'Marie', 'Lopez', '2011-11-11', 'abigail.lopez@gmail.com', '+233241234567', 200),
  (10962390, 'Emily', 'Hope', 'Hernandez', '2012-12-12', 'emily.hernandez@gmail.com', '+233242345678', 200),
  (10857499, 'Elizabeth', 'Faith', 'Martinez', '2013-01-13', 'elizabeth.martinez@gmail.com', '+233243456789', 200),
   
   
  (10857469, 'Kofi', 'John', 'Asamoah', '1998-05-28', 'kofiasamoah@gmail.com', '+233546789012', 300),
  (10857897, 'Kwesi', 'Brown', 'Osei', '1998-06-11', 'kwesiosei@gmail.com', '+233546789012', 300),
  (10865473, 'Akua', 'Manso', 'Addo', '1999-11-06', 'akuaaddo@gmail.com', '+233541234567', 300),
  (10865723, 'Amma', 'Baidoo', 'Owusu', '2001-01-05', 'ammaowusu@gmail.com', '+233548765432', 300),
  (10899090, 'Kwadwo', 'Lesley', 'Mensah', '1999-04-21', 'kwadwomensah@gmail.com', '+233548678910', 300),
  (10871290, 'Afia', 'Wurapa', 'Appiah', '2000-11-30', 'afiaappiah@gmail.com', '+233542345678', 300),
  (10811239, 'Kofi', 'Baffour', 'Agyapong', '1998-06-14', 'kofiagyapong@gmail.com', '+233545678901', 300),
  (10876540, 'Ama', 'Arhin', 'Nti', '1999-08-22', 'amanti@gmail.com', '+233542345678', 300),
  (10811200, 'Yaw', 'Acquah', 'Boamah', '2000-02-13', 'yawboamah@gmail.com', '+233548678910', 300),
  (10894057, 'Kwabena', 'Ofori', 'Agyeman', '1998-09-17', 'kwabenaagyeman@gmail.com', '+233545678901', 300),
  (10875325, 'Akosua', 'OSei', 'Asiedu', '1999-07-25', 'akosuaasiedu@gmail.com', '+233542345678', 300),
  (10844366, 'Kwame', 'Nancy', 'Owusu', '2000-04-08', 'kwameowusu@gmail.com', '+233548678910', 300),
  (10847769, 'Ama', 'Adofo', 'Boakye', '1998-10-09', 'amaboakye@gmail.com', '+233545678901', 300),

   
   
  (10755902, 'Kwaku', 'Kivlin', 'Owusu', '1999-03-11', 'kwakuowusu@gmail.com', '+233540733379', 400),
  (10735089, 'Ama', 'Aggie', 'Osei', '1998-06-02', 'amaosei@gmail.com', '+233541234567', 400),
  (10764668, 'Yaw', 'Quaidoo', 'Asamoah', '2000-07-15', 'yawasamoah@gmail.com', '+233543210987', 400),
  (10755909, 'Kwame', 'Gideon', 'Osei', '1998-12-16', 'kwameosei@gmail.com', '+233546789576', 400),
  (10745996, 'Yaw', 'Gad', 'Gyamfi', '1999-07-01', 'yawgyamfi@gmail.com', '+233541234567', 400),
  (10762878, 'Akua', 'Mary', 'Kwakye', '2000-09-13', 'akuakwakye@gmail.com', '+233543210987', 400),
  (10724468, 'Kwame', 'Johnson', 'Addo', '1998-02-15', 'kwameaddo@gmail.com', '+233546789012', 400),
  (10722780, 'Akosua', 'Quainoo', 'Asante', '1998-09-23', 'akosuaasante@gmail.com', '+233546789012', 400),
  (10705957, 'Ama', 'Doe', 'Asante', '1999-03-29', 'amaasante@gmail.com', '+233541234567', 400),
  (10725579, 'Yaw', 'Black', 'Osei', '2000-05-02', 'yawosei@gmail.com', '+233543210987', 400),
  (10736689, 'Kwesi', 'Nimoh', 'Boateng', '1998-08-06', 'kwesiboateng@gmail.com', '+233546789012', 400),
  (10748088, 'Akosua', 'Offei', 'Asamoah', '1999-12-09', 'akosuaasamoah@gmail.com', '+233541234567', 400),
  (10735579, 'Kofi', 'Manso', 'Yeboah', '2000-06-26', 'kofiyeboah@gmail.com', '+233543210987', 400);


SELECT * FROM STUDENTS;

INSERT INTO Departments(DepartmentName)
VALUES

      ('Biomedical Engineering'),
      ('Computer Engineering'),
	  ('Agricultural Engineering'),
      ('Food Process Engineering'),
      ('Materials Science Engineering');

SELECT * FROM DEPARTMENTS;

