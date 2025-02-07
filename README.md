
<p align="center">
<img width="150" height="150" src="https://apipic.bxoks.online/public/uploads/dMSNqtLW6fEl_WCFyd3zc.png" alt="Material UI logo"></a>
</p>
<h1 align="center">Healthy Track</h1>


**Healthy Track**   เป็นแอปพลิเคชันที่ช่วยในการติดตามจำนวนก้าวที่ผู้ใช้(พระ)เดินในแต่ละวัน โดยใช้เทคโนโลยี [Flutter](https://flutter.dev/) สำหรับการพัฒนาแอปบนมือถือ แอปนี้ช่วยให้ผู้ใช้สามารถตั้งเป้าหมายจำนวนก้าวในแต่ละวันและแสดงข้อมูลการเดินในกราฟที่เข้าใจง่าย นอกจากนี้ยังมีการแจ้งเตือนเมื่อผู้ใช้ใกล้ถึงเป้าหมาย 


## **ฟีเจอร์หลัก**
 - ติดตามจำนวนก้าวที่เดิน 
 - บันทึกการเผาผลาญผลังงาน
 - บันทึกการฉันอาหาร
 - บันทึกการบิณฑบาตร
 - ดูสถิติการเดินในแต่ละวัน 

# ขั้นตอนการเตรียมโปรเจกต์

## การ import project

### ขั้นตอนที่ 1: Clone โปรเจกต์จาก GitHub
สามารถใช้คำสั่ง `git clone` เพื่อนำโปรเจกต์เข้ามายังเครื่องของคุณ
1. เปิด `Terminal` หรือ `Command Prompt` บนเครื่องของคุณ


2. ใช้คำสั่ง `git clone` ตามด้วย URL ของ repository
```bash
git clone https://github.com/kittibook/HealthyTrack.git
```
3. เมื่อทำการ `clone` เสร็จแล้ว ให้เข้าไปที่โฟลเดอร์โปรเจกต์
```bash
cd app
```

### ขั้นตอนที่ 2: ติดตั้ง Dependencies
1. เปิดโปรเจกต์ในโฟลเดอร์ที่คุณดาวน์โหลดหรือ clone มาที่ VS Code (หรือ IDE ที่คุณใช้งาน)

2. **ติดตั้ง dependencies**: ในโฟลเดอร์โปรเจกต์ ให้ เปิด `Terminal` หรือ `Command Prompt` บนเครื่องของคุณ แล้วพิมพ์คำสั่งต่อไปนี้

```bash
flutter pub get
```

3. **รันแอปใน Emulator หรือ Device**: ใช้คำสั่งนี้เพื่อรันโปรเจกต์บน Emulator หรือโทรศัพท์ Android
```bash
flutter run
```
## การเตรียมฐานข้อมูล
### ขั้นตอนที่ 1: การติดตั้ง Prisma 
1. เปิด `Terminal` หรือ `Command Prompt` บนเครื่องของคุณ


2. ใช้คำสั่ง `git clone` ตามด้วย URL ของ repository
```bash
git clone https://github.com/kittibook/HealthyTrack.git
```
3. เมื่อทำการ `clone` เสร็จแล้ว ให้เข้าไปที่โฟลเดอร์โปรเจกต์
```bash
cd api
npm install
```
4. ติดตั้ง Prisma ในโปรเจกต์ของคุณ: 
```bash 
npm install @prisma/client 
```
```bash
npm install prisma --save-dev
```

5. สร้างไฟล์ Prisma configuration (`prisma/schema.prisma`) และใส่ข้อมูลการเชื่อมต่อฐานข้อมูล
```bash
datasource db {
  provider = "mysql"  // ใช้ฐานข้อมูล mysql (หรือเปลี่ยนเป็นฐานข้อมูลอื่นที่คุณใช้)
  url      = env("DATABASE_URL")
}
```
6. กำหนดค่า **DATABASE_URL** ในไฟล์ `.env`

```bash
DATABASE_URL="postgresql://username:password@localhost:5432/your_database_name"
```
7. คำสั่งสร้างฐานข้อมูล
```bash
npx prisma migrate dev --create-only
npx prisma migrate dev --name init
npx prisma generate
```



