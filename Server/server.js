const express = require('express');
const { PrismaClient } = require('@prisma/client');

const app = express();
const port = 3000;
const prisma = new PrismaClient();

app.use(express.json());

//CRUD TEACHERS
app.post('/teachers', async (req, res) => {
    try {
        const { fullName, login, password } = req.body;
        const teacher = await prisma.teacher.create({
            data: {
                fullName,
                login,
                password
            }
        });
        res.status(201).json(teacher);
    } catch (e) {
        console.error('Failed to create teacher:', error);
        res.status(500).json({ error: 'Failed to create teacher' });
    }
});

app.get('/teachers', async (req, res) => {
    try {
        const teachers = await prisma.teacher.findMany();
        res.status(200).json(teachers);
    } catch (error) {
        console.error('Failed to get teachers:', error);
        res.status(500).json({ error: 'Failed to get teachers' });
    }
});

// TODO: COrrir, não funciona
app.put('/teachers/:login', async (req, res) => {
    try {
        const { login } = req.params;
        const { newFullName, newLogin, newPassword } = req.body;

        const teacher = await prisma.teacher.update({
            where: {
                login,
            },
            data: {
                fullName: newFullName,
                login: newLogin,
                password: newPassword,
            },
        });

        res.status(200).json(teacher);
    } catch (error) {
        console.error('Failed to update teacher:', error);
        res.status(500).json({ error: 'Failed to update teacher' });
    }
});

app.delete('/teachers/:login', async (req, res) => {
    try {
        const { login } = req.params;
        const teacher = await prisma.teacher.delete({
            where: {
                login,
            },
        });
        res.status(200).json(teacher);
    } catch (error) {
        console.error('Failed to delete teacher:', error);
        res.status(500).json({ error: 'Failed to delete teacher' });
    }
});

// CRUD STUDENTS
app.post('/students', async (req, res) => {
    try {
        const { fullName, classID } = req.body;
        const students = await prisma.student.create({
            data: {
                fullName,
                images_path: `./labels/${fullName}/`,
                classID
            }
        });
        res.status(201).json(students);
    } catch (e) {
        console.error('Failed to create students:', error);
        res.status(500).json({ error: 'Failed to create students' });
    }
});

app.get('/students', async (req, res) => {
    try {
        const students = await prisma.student.findMany();
        res.status(200).json(students);
    } catch (error) {
        console.error('Failed to get students:', error);
        res.status(500).json({ error: 'Failed to get students' });
    }
});

//CRUD CLASSES
app.post('/classes', async (req, res) => {
    try {
        const { title } = req.body;
        const classes = await prisma.classe.create({
            data: {
                title
            }
        });
        res.status(201).json(classes);
    } catch (e) {
        console.error('Failed to create classes:', error);
        res.status(500).json({ error: 'Failed to create classes' });
    }
});

app.get('/classes', async (req, res) => {
    try {
        const classes = await prisma.classe.findMany();
        res.status(200).json(classes);
    } catch (error) {
        console.error('Failed to get classes:', error);
        res.status(500).json({ error: 'Failed to get classes' });
    }
});










app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
