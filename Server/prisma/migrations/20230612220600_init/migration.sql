-- CreateTable
CREATE TABLE "Classe" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "dt_update" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dt_created" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Teacher" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fullName" TEXT NOT NULL,
    "login" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "dt_update" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dt_created" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Student" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fullName" TEXT NOT NULL,
    "images_path" TEXT NOT NULL,
    "classID" INTEGER NOT NULL,
    CONSTRAINT "Student_classID_fkey" FOREIGN KEY ("classID") REFERENCES "Classe" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TeachersOnClasses" (
    "classID" INTEGER NOT NULL,
    "teacherID" INTEGER NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("classID", "teacherID"),
    CONSTRAINT "TeachersOnClasses_classID_fkey" FOREIGN KEY ("classID") REFERENCES "Classe" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeachersOnClasses_teacherID_fkey" FOREIGN KEY ("teacherID") REFERENCES "Teacher" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TeachersOnStudents" (
    "teacherID" INTEGER NOT NULL,
    "studentID" INTEGER NOT NULL,
    "classeId" INTEGER,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("teacherID", "studentID"),
    CONSTRAINT "TeachersOnStudents_teacherID_fkey" FOREIGN KEY ("teacherID") REFERENCES "Teacher" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeachersOnStudents_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TeachersOnStudents_classeId_fkey" FOREIGN KEY ("classeId") REFERENCES "Classe" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

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

-- CreateIndex
CREATE UNIQUE INDEX "Teacher_login_key" ON "Teacher"("login");

-- CreateIndex
CREATE UNIQUE INDEX "Student_classID_key" ON "Student"("classID");
