-- =========================
-- Students
-- =========================

-- Search available internships
SELECT "internships"."id", "internships"."title", "internships"."type", "internships"."location",
       "companies"."title" AS "company", 
       "company_supervisors"."first_name" || ' ' || "company_supervisors"."last_name" AS "company_supervisor",
       "university_coordinators"."first_name" || ' ' || "university_coordinators"."last_name" AS "university_coordinator",
       "internships"."start_date", "internships"."total_hours"
FROM "internships"
JOIN "companies" ON "companies"."id" = "internships"."company_id"
JOIN "company_supervisors" ON "company_supervisors"."id" = "internships"."company_supervisor_id"
JOIN "university_coordinators" ON "university_coordinators"."id" = "internships"."university_coordinator_id"
ORDER BY "start_date" DESC;

-- Register student #1 in internship #1
INSERT INTO "student_internships" ("student_id", "internship_id")
VALUES (1, 1);

-- Withdraw a student #1 from an internship #1
DELETE FROM "student_internships" 
WHERE "student_id" = 1 AND "internship_id" = 1;

-- View all internships for a student #1
SELECT "internships"."id", "internships"."title", "internships"."type", "internships"."location",
       "companies"."title" AS "company", 
       "company_supervisors"."first_name" || ' ' || "company_supervisors"."last_name" AS "company_supervisor",
       "university_coordinators"."first_name" || ' ' || "university_coordinators"."last_name" AS "university_coordinator",
       "internships"."start_date", "internships"."total_hours"
FROM "internships"
JOIN "student_internships" ON "student_internships"."internship_id" = "internships"."id"
JOIN "companies" ON "companies"."id" = "internships"."company_id"
JOIN "company_supervisors" ON "company_supervisors"."id" = "internships"."company_supervisor_id"
JOIN "university_coordinators" ON "university_coordinators"."id" = "internships"."university_coordinator_id"
WHERE "student_internships"."student_id" = 1
ORDER BY "internships"."start_date" DESC;

-- View all grades for a student
SELECT "grades"."id", "grades"."title", 
       "grades"."type", "grades"."student_grade", 
       "grades"."total_grade", "internships"."title" AS "internship",
       "teachers"."first_name" || ' ' || "teachers"."last_name" AS "teacher"
FROM "grades"
JOIN "internships" ON "internships"."id" = "grades"."internship_id"
JOIN "teachers" ON "teachers"."id" = "grades"."teacher_id"  
WHERE "grades"."student_id" = 1
ORDER BY "grades"."id" DESC;

-- =========================
-- Companies
-- =========================

-- Add a new internship
INSERT INTO "internships" ("title", "type", "location", "company_id", "company_supervisor_id", "university_coordinator_id", "start_date", "total_hours")
VALUES ('Introduction in AI', 'summer', 'Remote', 1, 1, 3, '2026-07-06', 120);

-- View students registered in an internship
SELECT * FROM "students"
WHERE "id" IN (
    SELECT "student_id" FROM "student_internships"
    WHERE "internship_id" = 1
);

-- =========================
-- Teachers
-- =========================

-- View students in an  #2 internship
SELECT "id", "first_name" || ' ' || "last_name" AS "name", "phone_number", "college", "stage", "university_id"
FROM "students"
WHERE "id" IN (
    SELECT "student_id" FROM "student_internships"
    WHERE "internship_id" = 2
);

-- Add a grade
INSERT INTO "grades" ("title", "type", "student_id", "student_grade", "total_grade", "internship_id", "teacher_id")
VALUES ('Quiz 2', 'quiz', 6, 8, 10, 2, 6);

-- Update a student's grade
UPDATE "grades" SET "student_grade" = 9 
WHERE "id" = 7;


-- =========================
-- University Coordinators
-- =========================

-- View all internships
SELECT "internships"."id", "internships"."title", "internships"."type", "internships"."location",
       "companies"."title" AS "company", 
       "company_supervisors"."first_name" || ' ' || "company_supervisors"."last_name" AS "company_supervisor",
       "university_coordinators"."first_name" || ' ' || "university_coordinators"."last_name" AS "university_coordinator",
       "internships"."start_date", "internships"."total_hours"
FROM "internships"
JOIN "companies" ON "companies"."id" = "internships"."company_id"
JOIN "company_supervisors" ON "company_supervisors"."id" = "internships"."company_supervisor_id"
JOIN "university_coordinators" ON "university_coordinators"."id" = "internships"."university_coordinator_id"
ORDER BY "start_date" DESC;

-- View all companies
SELECT "id", "title", "specialization", "email", "location"
FROM "companies";


-- =========================
-- Reports
-- =========================

-- Calculate a student's average grade
SELECT "students"."id", "students"."first_name", "students"."last_name",
       ROUND(AVG("grades"."student_grade"), 2) AS "Average student grade",
       ROUND(AVG("grades"."total_grade"), 2) AS "Average total grade",
       ROUND(AVG("grades"."student_grade") / AVG("grades"."total_grade") * 100,2) AS "%"
FROM "students"
JOIN "grades" ON "grades"."student_id" = "students"."id"
GROUP BY "grades"."student_id";


-- Show the top students in an internship
SELECT "students"."id", "students"."first_name", "students"."last_name",
       ROUND(AVG("grades"."student_grade"), 2) AS "Average student grade",
       ROUND(AVG("grades"."total_grade"), 2) AS "Average total grade",
       ROUND(AVG("grades"."student_grade") / AVG("grades"."total_grade") * 100,2) AS "%"
FROM "students"
JOIN "grades" ON "grades"."student_id" = "students"."id"
WHERE "grades"."internship_id" = 1
GROUP BY "grades"."student_id"
ORDER BY "%" DESC
LIMIT 10;

-- Count students in each internship
SELECT "internships"."id", "internships"."title", COUNT("student_internships"."student_id") AS "Number of students" 
FROM "internships"
JOIN "student_internships" ON "student_internships"."internship_id" = "internships"."id"
GROUP BY "student_internships"."internship_id";

-- Count internships offered by each company
SELECT "companies"."id", "companies"."title", COUNT("internships"."company_id") AS "number of internship"
FROM "companies"
JOIN "internships" ON "internships"."company_id" = "companies"."id"
GROUP BY "internships"."company_id";