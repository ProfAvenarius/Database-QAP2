-- Description: 
-- Author:
-- Date:
CREATE USER university_admin WITH PASSWORD '123!Temp';
CREATE DATABASE enrollment_system WITH OWNER university_admin;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT,
    school_enrollment_date DATE
);

CREATE TABLE professors (
    prof_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    department TEXT
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT NOT NULL,
    course_description TEXT,
    prof_id INT REFERENCES professors(prof_id)
);

CREATE TABLE enrollments (
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE,
    PRIMARY KEY (student_id,course_id)
);

INSERT INTO students(first_name, last_name, email, school_enrollment_date) VALUES
    ('Jeff', 'Winger', 'j.winger@greendale.com', '2009-09-07'),
    ('Britta', 'Perry', 'b.perry@greendale.com', '2007-09-01'),
    ('Annie', 'Edison', 'a.edison@greendale.com', '2008-09-01'),
    ('Troy', 'Barnes', 't.barnes@greendale.com', '2008-09-01'),
    ('Abid', 'Nadir', 'a.nadir@greendale.com', '2008-01-07'),
    ('Shirley', 'Bennett', 's.bennett@greendale.com', '2007-09-07'),
    ('Pierce', 'Hawthorne', 'p.hawthorn@greendale.com', '2005-09-07');

INSERT INTO professors(first_name, last_name, department) VALUES
    ('Ben', 'Chang', 'Spanish'),
    ('Ian', 'Duncan', 'Psychology'),
    ('Eustace', 'Whitman', 'Film Studies'),
    ('Michelle', 'Slater', 'Mathematics'),
    ('Craig', 'Pelton', 'Administration');


INSERT INTO courses(course_name, course_description, prof_id) VALUES
    ('Spanish 101', 'Introduction to the Spanish language.', (SELECT prof_id FROM professors WHERE department = 'Spanish')),
    ('Psychology 101', 'Introduction to human psychology.', (SELECT prof_id FROM professors WHERE department = 'Psychology')),
    ('Mathematics 101', 'Introduction to statistics.',  (SELECT prof_id FROM professors WHERE department = 'Mathematics')),
    ('Film Studies 105', 'Introduction to the Sitcom.',  (SELECT prof_id FROM professors WHERE department = 'Film Studies'));

INSERT INTO enrollments(student_id, course_id, enrollment_date) VALUES
    ((SELECT student_id FROM students WHERE first_name = 'Jeff' AND last_name = 'Winger'), (SELECT course_id FROM courses WHERE course_name = 'Film Studies 105'), '2009-09-15'),
    ((SELECT student_id FROM students WHERE first_name = 'Jeff' AND last_name = 'Winger'), (SELECT course_id FROM courses WHERE course_name = 'Spanish 101'), '2009-09-17'),
    ((SELECT student_id FROM students WHERE first_name = 'Britta' AND last_name = 'Perry'), (SELECT course_id FROM courses WHERE course_name = 'Spanish 101'), '2009-09-10'),
    ((SELECT student_id FROM students WHERE first_name = 'Troy' AND last_name = 'Barnes'), (SELECT course_id FROM courses WHERE course_name = 'Spanish 101'), '2009-09-12'),
    ((SELECT student_id FROM students WHERE first_name = 'Abid' AND last_name = 'Nadir'), (SELECT course_id FROM courses WHERE course_name = 'Spanish 101'), '2009-09-12'),
    ((SELECT student_id FROM students WHERE first_name = 'Pierce' AND last_name = 'Hawthorne'), (SELECT course_id FROM courses WHERE course_name = 'Spanish 101'), '2008-09-12'),
    ((SELECT student_id FROM students WHERE first_name = 'Pierce' AND last_name = 'Hawthorne'), (SELECT course_id FROM courses WHERE course_name = 'Mathematics 101'), '2008-09-11'),
    ((SELECT student_id FROM students WHERE first_name = 'Annie' AND last_name = 'Edison'), (SELECT course_id FROM courses WHERE course_name = 'Mathematics 101'), '2009-09-01'),
    ((SELECT student_id FROM students WHERE first_name = 'Annie' AND last_name = 'Edison'), (SELECT course_id FROM courses WHERE course_name = 'Film Studies 105'), '2009-09-01'),
    ((SELECT student_id FROM students WHERE first_name = 'Shirley' AND last_name = 'Bennett'), (SELECT course_id FROM courses WHERE course_name = 'Film Studies 105'), '2009-09-12');




