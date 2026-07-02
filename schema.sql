PRAGMA foreign_keys = ON;

-- students table
CREATE TABLE "students" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL UNIQUE,
    "college" TEXT NOT NULL,
    "stage" INTEGER NOT NULL CHECK("stage" > 0 AND "stage" <= 7),
    "university_id" INTEGER NOT NULL UNIQUE
);

-- teachers table
CREATE TABLE "teachers" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "national_id" TEXT NOT NULL UNIQUE,
    "phone_number" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE CHECK("email" LIKE '%@%'),
    "general_specialization" TEXT NOT NULL,
    "fine_specialization" TEXT NOT NULL,
    "birth_date" TEXT NOT NULL CHECK("birth_date" > '1920-01-01' AND "birth_date" < CURRENT_DATE AND "birth_date" LIKE '____-__-__')
);

-- companies table
CREATE TABLE "companies" (
    "id" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "specialization" TEXT,
    "email" TEXT NOT NULL UNIQUE CHECK("email" LIKE '%@%'),
    "location" TEXT NOT NULL
);

-- company_supervisors table
CREATE TABLE "company_supervisors" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "company_id" INTEGER NOT NULL,
    "national_id" TEXT NOT NULL UNIQUE,
    "phone_number" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE CHECK("email" LIKE '%@%'),
    "department" TEXT NOT NULL,
    "role_title" TEXT NOT NULL,
    "birth_date" TEXT NOT NULL CHECK("birth_date" > '1920-01-01' AND "birth_date" < CURRENT_DATE AND "birth_date" LIKE '____-__-__'),
    FOREIGN KEY("company_id") REFERENCES "companies"("id") 
);

-- university_coordinators table
CREATE TABLE "university_coordinators" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "national_id" TEXT NOT NULL UNIQUE,
    "phone_number" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE CHECK("email" LIKE '%@%'),
    "department" TEXT NOT NULL,
    "coordinator_role" TEXT NOT NULL,
    "birth_date" TEXT NOT NULL CHECK("birth_date" > '1920-01-01' AND "birth_date" < CURRENT_DATE AND "birth_date" LIKE '____-__-__')
);

-- internships table
CREATE TABLE "internships" (
    "id" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "location" TEXT NOT NULL CHECK("location" IN ('Remote', 'Hybrid', 'Onsite')),
    "company_id" INTEGER NOT NULL,
    "company_supervisor_id" INTEGER NOT NULL,
    "university_coordinator_id" INTEGER NOT NULL,
    "start_date" TEXT NOT NULL CHECK("start_date" LIKE '____-__-__'),
    "total_hours" INTEGER NOT NULL CHECK("total_hours" > 0),
    FOREIGN KEY("company_id") REFERENCES "companies"("id"),
    FOREIGN KEY("company_supervisor_id") REFERENCES "company_supervisors"("id"),
    FOREIGN KEY("university_coordinator_id") REFERENCES "university_coordinators"("id")
);

-- student_internships table
CREATE TABLE "student_internships" (
    "student_id" INTEGER,
    "internship_id" INTEGER,
    PRIMARY KEY("student_id", "internship_id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("internship_id") REFERENCES "internships"("id")
);

-- teacher_internships table
CREATE TABLE "teacher_internships" (
    "teacher_id" INTEGER,
    "internship_id" INTEGER,
    PRIMARY KEY("teacher_id", "internship_id"),
    FOREIGN KEY("teacher_id") REFERENCES "teachers"("id"),
    FOREIGN KEY("internship_id") REFERENCES "internships"("id")
);

CREATE TABLE "audit_log" (
    "id" INTEGER PRIMARY KEY,
    "grade_id" INTEGER NOT NULL,
    "action" TEXT NOT NULL CHECK("action" IN ('insert', 'delete', 'update')),
    "action_date" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "student_id" INTEGER NOT NULL,
    "teacher_id" INTEGER NOT NULL,
    FOREIGN KEY("grade_id") REFERENCES "grades"("id"),
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("teacher_id") REFERENCES "teachers"("id")
);

-- grades table
CREATE TABLE "grades" (
    "id" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('assignment', 'quiz', 'final_exam')),
    "student_id" INTEGER NOT NULL,
    "student_grade" INTEGER NOT NULL CHECK("student_grade" >= 0),
    "total_grade" INTEGER NOT NULL CHECK("total_grade" >= "student_grade" AND "total_grade" > 0),
    "internship_id" INTEGER NOT NULL,
    "teacher_id" INTEGER NOT NULL,
    FOREIGN KEY("student_id") REFERENCES "students"("id"),
    FOREIGN KEY("internship_id") REFERENCES "internships"("id"),
    FOREIGN KEY("teacher_id") REFERENCES "teachers"("id")
);


-- internship_details view
CREATE VIEW "internship_details" AS
SELECT "internships"."id", "internships"."title", "internships"."type", "internships"."location",
       "companies"."title" AS "company", 
       "company_supervisors"."first_name" || ' ' || "company_supervisors"."last_name" AS "company_supervisor",
       "university_coordinators"."first_name" || ' ' || "university_coordinators"."last_name" AS "university_coordinator",
       "internships"."start_date", "internships"."total_hours"
FROM "internships"
JOIN "companies" ON "companies"."id" = "internships"."company_id"
JOIN "company_supervisors" ON "company_supervisors"."id" = "internships"."company_supervisor_id"
JOIN "university_coordinators" ON "university_coordinators"."id" = "internships"."university_coordinator_id";

-- Student Average Grades
CREATE VIEW "student_average_grades" AS
SELECT "students"."id", "students"."first_name", "students"."last_name",
       ROUND(AVG("grades"."student_grade"), 2) AS "Average student grade",
       ROUND(AVG("grades"."total_grade"), 2) AS "Average total grade",
       ROUND(AVG("grades"."student_grade") / AVG("grades"."total_grade") * 100,2) AS "%"
FROM "students"
JOIN "grades" ON "grades"."student_id" = "students"."id"
GROUP BY "grades"."student_id";

-- Internship Statistics
CREATE VIEW "internship_statistics" AS
SELECT "internships"."id", "internships"."title", COUNT("student_internships"."student_id") AS "Number of students" 
FROM "internships"
LEFT JOIN "student_internships" ON "student_internships"."internship_id" = "internships"."id"
GROUP BY "student_internships"."internship_id";

-- Grades Details view
CREATE VIEW "grades_details" AS
SELECT "grades"."id", "grades"."title", "grades"."type", 
       "students"."first_name" || ' ' || "students"."last_name" AS "student_name",
       "grades"."student_grade", "grades"."total_grade",
       "internships"."title" AS "internship", 
       "teachers"."first_name" || ' ' || "teachers"."last_name" AS "teacher_name"
FROM "grades"
JOIN "students" ON "students"."id" = "grades"."student_id"
JOIN "internships" ON "internships"."id" = "grades"."internship_id"
JOIN "teachers" ON "teachers"."id" = "grades"."teacher_id";

-- Audit Log insert triggers
CREATE TRIGGER "log_grade_insert"
AFTER INSERT ON "grades"
FOR EACH ROW
BEGIN
    INSERT INTO "audit_log" ("grade_id", "action", "student_id", "teacher_id")
    VALUES (NEW."id", 'insert', NEW."student_id", NEW."teacher_id");
END;

-- Audit Log Delete Trigger
CREATE TRIGGER "log_grade_delete"
BEFORE DELETE ON "grades"
FOR EACH ROW
BEGIN
    INSERT INTO "audit_log" ("grade_id", "action", "student_id", "teacher_id")
    VALUES (OLD."id", 'delete', OLD."student_id", OLD."teacher_id");
END;

-- Audit Log UPDATE Trigger
CREATE TRIGGER "log_grade_update"
AFTER UPDATE ON "grades"
FOR EACH ROW
BEGIN
    INSERT INTO "audit_log" ("grade_id", "action", "student_id", "teacher_id")
    VALUES (NEW."id", 'update', NEW."student_id", NEW."teacher_id");
END;
