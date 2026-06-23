--Database Engineering Intermediate Capstone Project
--1
Create Database zaio_management_db;

--2
\c zaio_management_db

--3
git init C:\Users\MrRap\Documents\QCTO-DS\Practical Modules\Database-Engineering-Intermediate-Capstone-Project


--4
.gitignore
.env
*.env
*.log
logs/


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
CREATE TABLE courses (
    course_code VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    description TEXT
);

--11
CREATE TABLE enrollments (
    student_id INTEGER REFERENCES zaio_students(student_id),
    course_code VARCHAR(10) REFERENCES courses(course_code),
    final_grade NUMERIC
);

--12
ALTER TABLE enrollments
ADD CONSTRAINT pk_enrollments
PRIMARY KEY (student_id, course_code);

--13
ALTER TABLE enrollments
ADD CONSTRAINT chk_final_grade
CHECK (final_grade BETWEEN 0 AND 100);

--14
ALTER TABLE zaio_students
ADD COLUMN email VARCHAR(255) NOT NULL UNIQUE;

--15
ALTER TABLE courses
DROP COLUMN description;

--16
INSERT INTO tracks (track_name)
VALUES
('Data Science'),
('AI Engineering'),
('Full Stack Web Dev');

--17
\copy zaio_students (full_name, cohort_year, track_id, email)
FROM 'zaio_student_data.txt'
WITH (FORMAT csv, HEADER true);

--18
UPDATE zaio_students
SET cohort_year = 2026
WHERE track_id = 1;

--19
INSERT INTO tracks (track_id, track_name)
VALUES (1, 'Data Science')
ON CONFLICT (track_id) DO NOTHING;

--20
DELETE FROM enrollments
WHERE final_grade < 10;

--21
SELECT s.full_name
FROM zaio_students s
JOIN tracks t ON s.track_id = t.track_id
WHERE t.track_name = 'Data Science';

--22
SELECT *
FROM zaio_students
WHERE full_name LIKE 'A%';

--23
SELECT c.course_code
FROM courses c
LEFT JOIN enrollments e
ON c.course_code = e.course_code
WHERE e.course_code IS NULL;

--24
SELECT *
FROM zaio_students
ORDER BY full_name DESC;

--25
SELECT *
FROM assignments
WHERE deadline > CURRENT_TIMESTAMP;

--26
SELECT
    t.track_name,
    COUNT(s.student_id) AS total_students
FROM tracks t
LEFT JOIN zaio_students s
ON t.track_id = s.track_id
GROUP BY t.track_name
ORDER BY t.track_name;

--27
SELECT
    AVG(final_grade) AS average_grade
FROM enrollments
WHERE course_code = 'CS101';

---28
SELECT
    s.full_name,
    c.course_code
FROM zaio_students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_code = c.course_code;

--29
SELECT t.track_name, COUNT(s.student_id) AS enrollment_count
FROM tracks t
LEFT JOIN zaio_students s ON t.track_id = s.track_id
GROUP BY t.track_name
HAVING COUNT(s.student_id) = 0;

--30
git add zaio_setup.sql
git commit -m "Add complete SQL capstone assessment - zaio_setup.sql"
git push origin main