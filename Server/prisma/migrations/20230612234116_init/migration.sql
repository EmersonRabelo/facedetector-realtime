/*
  Warnings:

  - You are about to drop the `AttendanceList` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `assignedAt` on the `TeachersOnStudents` table. All the data in the column will be lost.
  - You are about to drop the column `classeId` on the `TeachersOnStudents` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "AttendanceList";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TeachersOnStudents" (
    "teacherID" INTEGER NOT NULL,
    "studentID" INTEGER NOT NULL,

    PRIMARY KEY ("teacherID", "studentID"),
    CONSTRAINT "TeachersOnStudents_teacherID_fkey" FOREIGN KEY ("teacherID") REFERENCES "Teacher" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeachersOnStudents_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_TeachersOnStudents" ("studentID", "teacherID") SELECT "studentID", "teacherID" FROM "TeachersOnStudents";
DROP TABLE "TeachersOnStudents";
ALTER TABLE "new_TeachersOnStudents" RENAME TO "TeachersOnStudents";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
