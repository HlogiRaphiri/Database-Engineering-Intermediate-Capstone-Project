--Database Engineering Intermediate Capstone Project
--1
Create Database zaio_management_db;

--2
\c zaio_management_db

--3
git init C:\Users\MrRap\Documents\QCTO-DS\Practical Modules\Database-Engineering-Intermediate-Capstone-Project


--4
gitignore.txt

--5
SELECT datname, pg_encoding_to_char(encoding)
FROM pg_database
WHERE datname = 'zaio_management_db';

--6
CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    track_name VARCHAR(50) UNIQUE)
    ;

--7
CREATE TABLE zaio_students (
    track_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
	cohort_year int
);

--8
ALTER TABLE zaio_students 
ALTER COLUMN cohort_year SET DEFAULT 2026;

--9
ALTER TABLE zaio_students
ADD FOREIGN KEY (track_id)
REFERENCES tracks(track_id);

--10
    course_code VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100)
);