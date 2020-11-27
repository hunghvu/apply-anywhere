/* 
********************************
 Project Phase III
 Group 9 (PostgreSQL)
 This SQL Script was tested on
 https://rextester.com/l/postgresql_online_compiler, local server, and
 is deployed to Heroku cloud service. To run, simply load this script file and run.
 Author Hung Vu (Create DB), Cliff (Populate Data)
 ********************************
*/

-- ***************************
-- Part A
-- ***************************
-- TABLE - JOBS: store data about listed job titles (E.g: Software Engineer)

DROP TABLE IF EXISTS JOBS CASCADE;
CREATE TABLE JOBS (
    JOB_TITLE                   VARCHAR(128)                    NOT NULL    PRIMARY KEY,
    REQUIRED_QUALIFICATION      VARCHAR(128)                    NOT NULL,
    EXPECTED_SALARY             INTEGER             DEFAULT 0   NOT NULL,
    CONSTRAINT JOBS_VAL CHECK(REQUIRED_QUALIFICATION IN ('None', 'High School Diploma', 'Bachelor''s Degree', 'Master Degree', 'PhD' )),
    CONSTRAINT EXPECTED_SALARY_VAL CHECK(EXPECTED_SALARY >= 0)
);

-- ***************************
-- ***************************
-- Part B
-- ***************************
-- Sample data for JOBS
-- Summary: store data about JOBS

INSERT INTO JOBS VALUES ('Software Engineer', 'Bachelor''s Degree', 103000);
INSERT INTO JOBS VALUES ('Statistician', 'Master Degree', 87000);
INSERT INTO JOBS VALUES ('Civil Engineer', 'Bachelor''s Degree', 86000);
INSERT INTO JOBS VALUES ('Orthodontist', 'Master Degree', 208000);
INSERT INTO JOBS VALUES ('IT Manager', 'Bachelor''s Degree', 142000);
INSERT INTO JOBS VALUES ('Mathematician', 'Master Degree', 102000);
INSERT INTO JOBS VALUES ('Database Administrator', 'Bachelor''s Degree', 90000);
INSERT INTO JOBS VALUES ('Dentist', 'PhD', 151000);
INSERT INTO JOBS VALUES ('Nurse Practitioner', 'Bachelor''s Degree', 107000);
INSERT INTO JOBS VALUES ('Mechanical Engineer', 'Master Degree', 87000);

-- ***************************
-- Part A
-- ***************************
-- TABLE - CAREERS: store data about listed careers options
-- E.g: A Software Engineer job for who has background in Field Mathematics, 
--  and want to work in a company which focuses on Information and Technology.

DROP TABLE IF EXISTS CAREERS CASCADE;
CREATE TABLE CAREERS(
    FIELD       VARCHAR(128)    DEFAULT 'STEM'      NOT NULL,
    INDUSTRY    VARCHAR(128)                        NOT NULL,
    JOB_TITLE   VARCHAR(128)                        NOT NULL,
    PRIMARY KEY (FIELD, INDUSTRY),
    CONSTRAINT FIELD_VAL CHECK(FIELD IN ('STEM', 'Science', 'Technology', 'Engineering', 'Mathematics')),
    CONSTRAINT CAREERS_FKEY FOREIGN KEY(JOB_TITLE) REFERENCES JOBS(JOB_TITLE) ON DELETE CASCADE    
);

-- ***************************
-- ***************************
-- Part B
-- ***************************
-- Sample data for CAREERS
-- Summary: store data about CAREERS

INSERT INTO CAREERS VALUES ('Technology', 'Artificial Intelligence', 'Software Engineer');
INSERT INTO CAREERS VALUES ('Mathematics', 'Data Scientist', 'Statistician');
INSERT INTO CAREERS VALUES ('Engineering', 'Structural Engineer', 'Civil Engineer');
INSERT INTO CAREERS VALUES ('Science', 'Orthodontic Appliances', 'Orthodontist');
INSERT INTO CAREERS VALUES ('Technology', 'Information and Technology', 'IT Manager');
INSERT INTO CAREERS VALUES ('Mathematics', 'Professor', 'Mathematician');
INSERT INTO CAREERS VALUES ('Technology', 'HealthCare', 'Database Administrator');
INSERT INTO CAREERS VALUES ('Science', 'Dentistry', 'Dentist');
INSERT INTO CAREERS VALUES ('Science', 'Clinical Nurse', 'Nurse Practitioner');
INSERT INTO CAREERS VALUES ('Engineering', 'Engine Design', 'Mechanical Engineer');

-- ***************************
-- Part A
-- ***************************
-- TABLE - EMPLOYERS: store data about employers.

DROP TABLE IF EXISTS EMPLOYERS CASCADE;
CREATE TABLE EMPLOYERS (
    COMPANY     VARCHAR(128)                    NOT NULL        PRIMARY KEY,   
    AVG_SAL     INTEGER                         NOT NULL,
    NUM_EMP     INTEGER         DEFAULT 1       NOT NULL,
    CONSTRAINT AVG_SAL_VAL CHECK(AVG_SAL >= 0),
    CONSTRAINT NUM_EMP_VAL CHECK(NUM_EMP > 0)
);

-- ***************************
-- ***************************
-- Part B
-- ***************************
-- Sample data for EMPLOYERS
-- Summary: store data about EMPLOYERS

INSERT INTO EMPLOYERS VALUES ('Amazon', 100000, 5000);
INSERT INTO EMPLOYERS VALUES ('UWB', 90000, 200);
INSERT INTO EMPLOYERS VALUES ('Harza', 95000, 4000);
INSERT INTO EMPLOYERS VALUES ('Tacoma Hospital', 250000, 3000);
INSERT INTO EMPLOYERS VALUES ('Apple', 180000, 35000);
INSERT INTO EMPLOYERS VALUES ('UWT', 100000, 50);
INSERT INTO EMPLOYERS VALUES ('Pierce County Health Services', 90000, 1500);
INSERT INTO EMPLOYERS VALUES ('Healthy Smile', 150000, 12);
INSERT INTO EMPLOYERS VALUES ('Seattle VA', 110000, 200);
INSERT INTO EMPLOYERS VALUES ('Harley Davidson', 90000, 300);

-- ***************************
-- Part A
-- ***************************
-- TABLE - LISTINGS: store data about listed job applications.

DROP TABLE IF EXISTS LISTINGS CASCADE;
CREATE TABLE LISTINGS (
    JOB_ID          SERIAL                              NOT NULL        PRIMARY KEY,
    JOB_TITLE       VARCHAR(128)                        NOT NULL,
    COMPANY         VARCHAR(128)                        NOT NULL,
    JOB_OPENINGS    INTEGER             DEFAULT 1       NOT NULL,
    PROP_SALARY     INTEGER             DEFAULT 0       NOT NULL,
    JOB_TYPE        VARCHAR(128)                        NOT NULL,
    WORK_CITY       VARCHAR(128)                        NOT NULL,
    WORK_STATE      VARCHAR(128)                        NOT NULL,
    CONSTRAINT JOB_OPENINGS_VAL CHECK(JOB_OPENINGS > 0),
    CONSTRAINT PROP_SALARY_VAL CHECK(PROP_SALARY >= 0),
    CONSTRAINT JOB_TYPE_VAL CHECK(JOB_TYPE IN ('Part-time', 'Full-time')),
    CONSTRAINT LISTINGS_FKEY_1 FOREIGN KEY(JOB_TITLE) REFERENCES JOBS(JOB_TITLE) ON DELETE CASCADE,
    CONSTRAINT LISTINGS_FKEY_2 FOREIGN KEY(COMPANY) REFERENCES EMPLOYERS(COMPANY) ON DELETE CASCADE
);

-- ***************************
-- ***************************
-- Part B
-- ***************************
-- Sample data for LISTINGS
-- Summary: store data about LISTINGS

INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE) 
	    VALUES ('Software Engineer', 'Amazon', 10, 120000, 'Full-time', 'Seattle', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Statistician', 'UWB', 2, 100000, 'Part-time', 'Bothell', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Civil Engineer', 'Harza', 2, 95000, 'Full-time', 'Seattle', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Orthodontist', 'Tacoma Hospital', 1, 240000, 'Full-time', 'Tacoma', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('IT Manager', 'Apple', 1, 182000, 'Full-time', 'Cupertino', 'CA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Mathematician', 'UWT', 3, 102000, 'Full-time', 'Tacoma', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Database Administrator', 'Pierce County Health Services', 1, 88000, 'Full-time', 'Lakewood', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Dentist', 'Healthy Smile', 2, 147000, 'Full-time', 'NYC', 'NY');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Nurse Practitioner', 'Seattle VA', 7, 110000, 'Part-time', 'Seattle', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Mechanical Engineer', 'Harley Davidson', 3, 90000, 'Full-time', 'Milwaukee', 'WI');

-- SELECT  *
-- FROM    JOBS;

-- SELECT  *
-- FROM    CAREERS; 

-- SELECT  *
-- FROM    EMPLOYERS; 

-- SELECT  *
-- FROM    LISTINGS;