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


-- =========================
-- Companies
-- =========================

-- Add a new internship

-- View students registered in an internship

-- Assign a company supervisor to an internship


-- =========================
-- Teachers
-- =========================

-- View students in an internship

-- Add a grade

-- Update a student's grade


-- =========================
-- University Coordinators
-- =========================

-- Assign teachers to an internship

-- View all internships

-- View all companies


-- =========================
-- Reports
-- =========================

-- Calculate a student's average grade

-- Show the top students in an internship

-- Count students in each internship

-- Count internships offered by each company