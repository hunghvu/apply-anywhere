/* ********************************
 Project Phase II
 Group 9 (PostgreSQL)
 This SQL Script was tested on
 https://rextester.com/l/postgresql_online_compiler, local server, and
 is deployed on Heroku cloud service. 
 --To run, simply
 --load this script file and run.
 ********************************
*/

-- ***************************
-- Part A
-- ***************************
-- TABLE - JOBS: store data about listed job titles (E.g: Software Engineer)

DROP TABLE IF EXISTS JOBS CASCADE;
CREATE TABLE JOBS (
    JOB_TITLE                   VARCHAR(128)                    NOT NULL            PRIMARY KEY,
    REQ_QUAL                    VARCHAR(128)                    NOT NULL,
    EXP_SAL                     INTEGER             DEFAULT 0   NOT NULL,
    CONSTRAINT JOBS_VAL CHECK(REQ_QUAL IN ('None', 'High School Diploma', 'Bachelor''s Degree', 'Master Degree', 'PhD' )),
    CONSTRAINT EXP_SAL_VAL CHECK(EXP_SAL >= 0)
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
-- Test duplicated data.
INSERT INTO CAREERS VALUES ('Mathematics', 'Researcher', 'Mathematician');

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
INSERT INTO EMPLOYERS VALUES ('Boeing', 114000, 5000);
INSERT INTO EMPLOYERS VALUES ('UWS', 120000, 110);

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
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Mechanical Engineer', 'Boeing', 2, 100000, 'Full-time', 'Seatac', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Mathematician', 'UWB', 4, 95000, 'Full-time', 'Bothell', 'WA');
INSERT INTO LISTINGS(JOB_TITLE, COMPANY, JOB_OPENINGS, PROP_SALARY, JOB_TYPE, WORK_CITY, WORK_STATE)
            VALUES ('Mathematician', 'UWS', 1, 107000, 'Full-time', 'Seattle', 'WA');

-- SELECT  *
-- FROM    JOBS;

-- SELECT  *
-- FROM    CAREERS; 

-- SELECT  *
-- FROM    EMPLOYERS; 

-- SELECT  *
-- FROM    LISTINGS;

-- ***************************
-- ***************************
-- Part C
-- **************************

-- *NOTE* This query does not meet requirements from phase 2(JOIN on three tables), however we chose
-- to use the existing query for phase 3 because we don't have any specific requirements other than
-- the queries must be non-trivial.

-- 1st query
-- Purpose: We want to find related information about a listed job which includes the expected salary,
--  its industry, and the company that offers the job.
-- Expected: A table includes Job title, expected salary for that job, its respective industry
--  and name of company who offers the job.
-- *************
 SELECT JOBS.JOB_TITLE AS "Job", JOBS.EXP_SAL AS "Expected Salary (USD)", 
            CAREERS.INDUSTRY AS "Industry", LISTINGS.COMPANY AS "Company Name"
 FROM   JOBS 
 JOIN   CAREERS
 ON     JOBS.JOB_TITLE = CAREERS.JOB_TITLE
 JOIN   LISTINGS
 ON     JOBS.JOB_TITLE = LISTINGS.JOB_TITLE;


-- 2nd query
-- Purpose: We want names of companies and their respective average salary 
--  where the average salary is greater than the actual average salary 
--  of the current job market, where the chosen companies have a 
--  number of employment bigger than the market's average amount of employees.
-- Expected: A table with a company name with its average salary.
-- *************
 SELECT DISTINCT    E.COMPANY AS "Company", E.AVG_SAL AS "Average Salary"
 FROM   EMPLOYERS E, LISTINGS J
 WHERE  E.AVG_SAL > ALL (   SELECT AVG(PROP_SALARY)
                            FROM LISTINGS, EMPLOYERS
                            WHERE E.NUM_EMP > ALL ( SELECT AVG(NUM_EMP)
                                                    FROM EMPLOYERS));


-- 3rd query
-- Purpose: We want to find all job titles, number of openings, and their respective industry.
-- The row will be ordered in descending order based on job openings.
-- Expected: A table includes listed job title, number of openings, and the industry it's in.
-- *************
 SELECT     DERIVED_TABLE.sum AS "Openings", DERIVED_TABLE.JOB_TITLE AS "Jobs", CAREERS.INDUSTRY AS "Industry"
 FROM       CAREERS
 FULL JOIN (    SELECT SUM(LISTINGS.JOB_OPENINGS), LISTINGS.JOB_TITLE
                FROM LISTINGS
                GROUP BY LISTINGS.JOB_TITLE) AS DERIVED_TABLE
        
 ON         DERIVED_TABLE.JOB_TITLE = CAREERS.JOB_TITLE
 ORDER BY   DERIVED_TABLE.SUM DESC;


-- 4th query
-- Purpose: We want to find all jobs outside of Seattle in all STEM fields 
-- that pay more than the average expected salary of listed job titles.
-- Expected: A table contains name of jobs that satisfies the purpose.
-- *************
 SELECT     J.JOB_TITLE AS "Jobs"
 FROM       JOBS J
 WHERE      J.EXP_SAL > (   SELECT AVG(EXP_SAL)
                            FROM JOBS)
 EXCEPT
 SELECT     L.JOB_TITLE 
 FROM       LISTINGS L
 WHERE      L.WORK_CITY = 'Seattle';


-- 5th query
-- Purpose: We want to compare the average actual salary against the average expected salary for a respective
-- city. The data should be ordered by the average actual salary in descending order. 
-- Expected: A table includes name of city, with average salary of job listed in that city, 
--  and average of expected salary of all respective job titles.
-- *************
 SELECT     LISTINGS.WORK_CITY AS "City", ROUND(AVG(LISTINGS.PROP_SALARY)) AS "Average-actual salary", 
                ROUND(AVG(J.EXP_SAL)) AS "Average-expected salary"
 FROM       JOBS J
 JOIN       LISTINGS
 ON         LISTINGS.JOB_TITLE = J.JOB_TITLE
 GROUP BY   LISTINGS.WORK_CITY
 ORDER BY   ROUND(AVG(LISTINGS.PROP_SALARY)) DESC;


-- 6th query
-- Purpose: We want to list the Location including City and State plus the job id for every large company, 
--  where a large company qualifies as a company with a higher number employed than the average of 
--  number employed at all companies.
-- Expected: A table includes city name and state name, along with job ID at that location.
-- *************
 SELECT     L.WORK_CITY AS "City", L.WORK_STATE AS "State", L.JOB_ID AS "Job ID"
 FROM       LISTINGS L, EMPLOYERS E
 WHERE      L.COMPANY = E.COMPANY
            AND E.NUM_EMP > ALL (   SELECT  AVG(NUM_EMP)
                                    FROM    EMPLOYERS);


-- 7th query
-- Purpose: We want to show the difference of average salary of employers versus the average salary of the 
--  actual job market, order from the company with highest (positive) salary difference to the lowest one.
-- Expected: A table contains company name, and the differences between company's average salary
--  and average salary of the whole job market.
-- *************
 SELECT     E.COMPANY AS "Company", 
                ROUND(E.AVG_SAL - ( SELECT AVG(PROP_SALARY) 
                                    FROM LISTINGS)) AS "Company AVG - Job market''s AVG"
 FROM       EMPLOYERS E, LISTINGS L
 WHERE      E.COMPANY = L.COMPANY
 GROUP BY   E.COMPANY
 ORDER BY   ROUND(E.AVG_SAL - (     SELECT AVG(PROP_SALARY) 
                                    FROM LISTINGS)) DESC;


-- 8th query
-- Purpose: The purpose of this query is to list information about a job including its title, position, job
-- type whether it is full time, and work state while checking all listings available outside of the state of WA.
-- Expected: A table contains information of jobs satisfy the requirement, which includes
-- job title, job type, industry, work state, and expected salary.
-- *************
 SELECT     L.JOB_TITLE AS "Job title", L.JOB_TYPE AS "Job type", 
            C.INDUSTRY AS "Industry", J.EXP_SAL AS "Expected salary", L.WORK_STATE AS "STATE"
 FROM       LISTINGS L, EMPLOYERS E, JOBS J, CAREERS C
 WHERE      L.JOB_TITLE = J.JOB_TITLE
            AND L.COMPANY = E.COMPANY
            AND L.JOB_TYPE = 'Full-time'
            AND L.WORK_STATE <> 'WA'
            AND L.JOB_TITLE = C.JOB_TITLE;


-- 9th query
-- Purpose: A client may want to find information about jobs, which includes its job_title, offered salary,
--  compared to the general expected salary for that title, the company name and size of that company.
-- Expected: A table includes job title, the actual salary on job market, its expected salary,
--  the company who offers it and company size (number of employees).
-- *************
 SELECT     L.JOB_TITLE AS "Job", L.PROP_SALARY AS "Salary", J.EXP_SAL AS "Expected salary", 
                      L.COMPANY AS "Company", E.NUM_EMP AS "No. Employed"
 FROM       LISTINGS L, EMPLOYERS E, JOBS J
 WHERE      L.COMPANY = E.COMPANY
            AND L.JOB_TITLE = J.JOB_TITLE;

-- 10th query
-- Purpose: We want to show the total jobs available for someone who might be open to working
-- within their STEM Field instead of a particular specified industry.
-- Expected: A table that includes the STEM title as well as the total number of jobs available
-- for each unique field.
-- ******************************************************************
 SELECT     CAREERS.FIELD AS "STEM Field", SUM(LISTINGS.JOB_OPENINGS) AS "Total Jobs/STEM Field"
 FROM       CAREERS, LISTINGS
 WHERE      CAREERS.JOB_TITLE = LISTINGS.JOB_TITLE 
 GROUP BY   CAREERS.FIELD
 ORDER BY   SUM(LISTINGS.JOB_OPENINGS) DESC
-- End of Script (Nov 28, 2020)