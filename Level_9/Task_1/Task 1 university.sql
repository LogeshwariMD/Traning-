
CREATE DATABASE university;
USE university;


CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);


CREATE TABLE Instructor (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);


CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);


CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('M', 'F'),
    dob DATE,
    email VARCHAR(100),
    phone VARCHAR(15)
);


CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY AUTO_INCREMENT,
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT
);


CREATE TABLE Section (
    section_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    instructor_id INT,
    classroom_id INT,
    semester ENUM('Spring', 'Summer', 'Fall', 'Winter'),
    year YEAR,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);


CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    section_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id)
);


INSERT INTO Department (department_name) VALUES ('Computer Science'), ('Mathematics'), ('Physics');


INSERT INTO Instructor (first_name, last_name, email, phone, department_id) VALUES
('John', 'Doe', 'john.doe@university.com', '1234567890', 1),
('Alice', 'Smith', 'alice.smith@university.com', '0987654321', 2);


INSERT INTO Course (course_name, credits, department_id) VALUES
('Database Systems', 3, 1),
('Algorithms', 4, 1),
('Calculus', 3, 2);


INSERT INTO Student (first_name, last_name, gender, dob, email, phone) VALUES
('Jane', 'Doe', 'F', '2000-05-10', 'jane.doe@university.com', '5555555555'),
('Mike', 'Johnson', 'M', '1999-09-20', 'mike.johnson@university.com', '4444444444');


INSERT INTO Classroom (building, room_number, capacity) VALUES
('Main', '101', 30),
('Annex', '202', 40);


INSERT INTO Section (course_id, instructor_id, classroom_id, semester, year) VALUES
(1, 1, 1, 'Fall', 2025),
(2, 2, 2, 'Spring', 2025);


INSERT INTO Enrollment (student_id, section_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'B');




SELECT 
    s.first_name AS Student,
    s.last_name AS LastName,
    c.course_name AS Course,
    i.first_name AS Instructor,
    e.grade
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Section sec ON e.section_id = sec.section_id
JOIN Course c ON sec.course_id = c.course_id
JOIN Instructor i ON sec.instructor_id = i.instructor_id;
