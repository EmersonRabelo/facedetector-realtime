-- DropIndex
DROP INDEX "Student_classID_key";

-- CreateTable
CREATE TABLE "AttendanceList" (
    "teacherID" INTEGER NOT NULL,
    "studentID" INTEGER NOT NULL,
    "classID" INTEGER NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("teacherID", "studentID", "classID"),
    CONSTRAINT "AttendanceList_teacherID_fkey" FOREIGN KEY ("teacherID") REFERENCES "Teacher" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AttendanceList_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AttendanceList_classID_fkey" FOREIGN KEY ("classID") REFERENCES "Classe" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TeachersOnStudents" (
    "teacherID" INTEGER NOT NULL,
    "studentID" INTEGER NOT NULL,
    "classeId" INTEGER,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("teacherID", "studentID"),
    CONSTRAINT "TeachersOnStudents_teacherID_fkey" FOREIGN KEY ("teacherID") REFERENCES "Teacher" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeachersOnStudents_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeachersOnStudents_classeId_fkey" FOREIGN KEY ("classeId") REFERENCES "Classe" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_TeachersOnStudents" ("studentID", "teacherID") SELECT "studentID", "teacherID" FROM "TeachersOnStudents";
DROP TABLE "TeachersOnStudents";
ALTER TABLE "new_TeachersOnStudents" RENAME TO "TeachersOnStudents";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
