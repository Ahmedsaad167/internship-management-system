-- seed.sql
PRAGMA foreign_keys=ON;

INSERT INTO companies VALUES
(1,'Google Egypt','Software','google.eg@example.com','Cairo'),
(2,'Microsoft Egypt','Cloud','microsoft.eg@example.com','Giza'),
(3,'Valeo','Embedded','valeo@example.com','Cairo'),
(4,'ITI','Training','iti@example.com','Smart Village'),
(5,'Orange Digital Center','AI','odc@example.com','Alexandria');

INSERT INTO company_supervisors VALUES
(1,'Omar','Ali',1,'2901','0100000001','omar@google.com','Engineering','Lead','1985-01-10'),
(2,'Mona','Ibrahim',2,'2902','0100000002','mona@microsoft.com','Cloud','Manager','1986-02-12'),
(3,'Khaled','Hassan',3,'2903','0100000003','khaled@valeo.com','Embedded','Senior','1984-03-15'),
(4,'Sara','Mahmoud',4,'2904','0100000004','sara@iti.gov','Training','Coordinator','1988-04-20'),
(5,'Youssef','Adel',5,'2905','0100000005','youssef@orange.com','AI','Supervisor','1987-05-18');

INSERT INTO university_coordinators VALUES
(1,'Ahmed','Saeed','3901','0111111111','a@uni.edu','CS','Coordinator','1979-01-01'),
(2,'Hany','Mostafa','3902','0111111112','h@uni.edu','IS','Coordinator','1980-02-02'),
(3,'Nour','Ali','3903','0111111113','n@uni.edu','IT','Coordinator','1981-03-03');

INSERT INTO teachers VALUES
(1,'Ali','Saleh','1901','0120000001','ali@uni.edu','Software','Backend','1980-01-01'),
(2,'Mariam','Samy','1902','0120000002','mariam@uni.edu','Software','Frontend','1983-02-02'),
(3,'Hossam','Fathy','1903','0120000003','hossam@uni.edu','AI','ML','1982-03-03'),
(4,'Nada','Kamal','1904','0120000004','nada@uni.edu','Embedded','ARM','1984-04-04'),
(5,'Yara','Nabil','1905','0120000005','yara@uni.edu','Cloud','DevOps','1985-05-05'),
(6,'Tamer','Adel','1906','0120000006','tamer@uni.edu','Security','Cyber','1981-06-06');

INSERT INTO students VALUES
(1,'Ahmed','Saad','0151000001','Engineering',3,2023001),
(2,'Mohamed','Ali','0151000002','Engineering',2,2023002),
(3,'Youssef','Hassan','0151000003','Engineering',4,2023003),
(4,'Omar','Khaled','0151000004','Engineering',1,2023004),
(5,'Mina','Nader','0151000005','Engineering',3,2023005),
(6,'Sara','Maher','0151000006','Engineering',2,2023006),
(7,'Nour','Ashraf','0151000007','Engineering',4,2023007),
(8,'Fatma','Sayed','0151000008','Engineering',3,2023008),
(9,'Ali','Ehab','0151000009','Engineering',2,2023009),
(10,'Salma','Tarek','0151000010','Engineering',1,2023010);

INSERT INTO internships VALUES
(1,'Backend Internship','summer','Hybrid',1,1,1,'2025-06-01',120),
(2,'AI Internship','summer','Remote',5,5,2,'2025-06-05',100),
(3,'Embedded Internship','summer','Onsite',3,3,3,'2025-06-10',140),
(4,'Cloud Internship','winter','Hybrid',2,2,1,'2025-12-01',110);

INSERT INTO teacher_internships VALUES
(1,1),(2,1),(3,2),(4,3),(5,4),(6,2);

INSERT INTO student_internships VALUES
(1,1),(2,1),(3,2),(4,3),(5,4),(6,2),(7,3),(8,1),(9,4),(10,2);

INSERT INTO grades VALUES
(1,'Assignment 1','assignment',1,18,20,1,1),
(2,'Quiz 1','quiz',1,9,10,1,2),
(3,'Final Exam','final_exam',1,55,70,1,1),
(4,'Assignment 1','assignment',2,20,20,1,1),
(5,'Quiz 1','quiz',2,10,10,1,2),
(6,'Final Exam','final_exam',2,68,70,1,1),
(7,'Assignment 1','assignment',3,15,20,2,3),
(8,'Quiz 1','quiz',3,7,10,2,3),
(9,'Final Exam','final_exam',3,60,70,2,6),
(10,'Assignment 1','assignment',4,12,20,3,4),
(11,'Final Exam','final_exam',4,45,70,3,4),
(12,'Assignment 1','assignment',5,19,20,4,5),
(13,'Final Exam','final_exam',5,66,70,4,5);
