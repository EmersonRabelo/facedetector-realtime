import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {

    const res = await createTecher()

    console.log(res)
}

async function createTecher (){
    return await prisma.teacher.create({
        data: {
            fullName: "adminGlobal",
            login: 'adminG',
            password: '#adminMaster#999888G',
        }
    })
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    });