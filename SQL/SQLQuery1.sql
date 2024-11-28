CREATE TABLE Student (student_id INT,
					name VARCHAR(30),
					course_id INT
)
INSERT INTO Student
VALUES (1,'Alice', 101),
		(2, 'Bob', 102),
		(3, 'Charlie', 101),
		(4, 'Dave', 103)

SELECT * FROM Student

CREATE TABLE Course (course_id INT,
					course_name VARCHAR(30),
					teacher VARCHAR(30)
)
INSERT INTO Course
VALUES (101, 'Math', 'Mr. Brown'),
		(102, 'Physics', 'Dr. Green'),
		(103, 'Chemistry', 'Ms. White')

SELECT * FROM Course


SELECT cr.course_id, course_name, teacher, student_id, name
FROM Course cr
INNER JOIN Student st ON st.course_id = cr.course_id 