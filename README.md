
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
cd appapi
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
DATABASE_URL="mysql://username:password@localhost:5432/your_database_name"
```
7. คำสั่งสร้างฐานข้อมูล
```bash
npx prisma migrate dev --create-only
npx prisma migrate dev --name init
npx prisma generate
```

# คำสั่ง build project

### ขั้นตอนที่ 1: สร้าง Keystore

ใช้คำสั่งใน Command Prompt เพื่อสร้าง Keystore ไฟล์
```bash
keytool -genkey -v -keystore %userprofile%\upload-keystore.jks ^ -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 ^ -alias upload
```

 คำอธิบาย:
-  `%userprofile%\upload-keystore.jks`: กำหนดตำแหน่งที่ไฟล์ Keystore จะถูกสร้าง
-   `-keyalg RSA`: กำหนดอัลกอริธึมที่ใช้ในการเข้ารหัส
-   `-keysize 2048`: กำหนดขนาดคีย์ (2048 บิต)
-   `-validity 10000`: กำหนดอายุของคีย์ (10000 วัน)
-   `-alias upload`: กำหนดชื่อของ alias สำหรับคีย์ (ในที่นี้ชื่อว่า `upload`)

### ขั้นตอนที่ 2: สร้างไฟล์ `key.properties`
หลังจากที่สร้าง Keystore แล้ว, สร้างไฟล์ `key.properties` ในโฟลเดอร์ `[project]/android/key.properties` และใส่ข้อมูลดังนี้
```bash
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

ตัวอย่าง
```bash
storePassword=123456
keyPassword=123456
keyAlias=upload
storeFile=C:/Users/YourUserName/upload-keystore.jks
```

### ขั้นตอนที่ 3: แก้ไขไฟล์ `build.gradle` ในโปรเจกต์ Android
ในไฟล์ `android/app/build.gradle`, เพิ่มโค้ดนี้

 1. โหลดข้อมูลจาก `key.properties`
 ```bash
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```
 2. ตั้งค่า signing configuration
 ```bash
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

### ขั้นตอนที่ 4: การสร้างไฟล์สำหรับการอัปโหลด


 - สร้าง App Bundle (แนะนำ)
  ```bash
flutter build appbundle
   ```
   
 - สร้าง APK
  ```bash
flutter build apk
   ```

# การรัน emulator หรือโทรศัพท์ android


### การรันโปรเจกต์บน **Emulator**

**ติดตั้ง Android Studio**: หากยังไม่ได้ติดตั้ง Android Studio, คุณสามารถดาวน์โหลดและติดตั้งจาก [เว็บไซต์ Android Studio](https://developer.android.com/studio)


**ตั้งค่า Android Emulator**:

-   เปิด **Android Studio**.
-   ไปที่ **AVD Manager** (Android Virtual Device Manager) ที่สามารถหาได้จาก Toolbar หรือเมนู `Tools` > `AVD Manager`.
-   เลือก **Create Virtual Device**.
-   เลือกอุปกรณ์ที่ต้องการ เช่น Pixel 4 หรืออุปกรณ์ที่เหมาะสมกับแอปของคุณ.
-   เลือกเวอร์ชันของ **Android** ที่ต้องการ.
-   ตั้งค่าคุณสมบัติของ Emulator และคลิก **Finish**.

**รัน Emulator**:
-   หลังจากสร้าง Emulator แล้ว คุณสามารถคลิก **Play** หรือ **Start** ที่ Emulator เพื่อเริ่มการทำงานของ Emulator.

**รันแอปบน Emulator**: เปิด **เทอร์มินัล** หรือ **Command Prompt** ในโฟลเดอร์โปรเจกต์ของคุณและใช้คำสั่ง

  ```bash
flutter run
   ```

### การรันโปรเจกต์บน **โทรศัพท์ Android จริง**
-   **เปิด Developer Options บนโทรศัพท์ Android**:
    
    -   ไปที่ **Settings** > **About phone**.
    -   ค้นหาคำว่า **Build number** และแตะ 7 ครั้งจนได้รับข้อความว่า` "ตอนนี้คุณเป็นนักพัฒนาแล้ว"`.

-  **เปิด USB Debugging**:

	-   ไปที่ **Settings** > **Developer options**.
	-   เปิด **USB debugging**.
-   **เชื่อมต่อโทรศัพท์กับคอมพิวเตอร์**: ใช้สาย USB เชื่อมต่อโทรศัพท์กับคอมพิวเตอร์.
    
-   **อนุญาตการเชื่อมต่อจากคอมพิวเตอร์**: เมื่อเชื่อมต่อสำเร็จจะมีข้อความปรากฏบนโทรศัพท์เพื่อให้คุณอนุญาตให้การเชื่อมต่อนั้นๆ ผ่าน **USB debugging** ให้คลิก "Allow".
    
-   **รันแอปบนโทรศัพท์ Android**: เปิด **เทอร์มินัล** หรือ **Command Prompt** ในโฟลเดอร์โปรเจกต์ Flutter ของคุณแล้วใช้คำสั่ง:
 ```bash
flutter run
   ```

### การตรวจสอบอุปกรณ์ที่เชื่อมต่อ

คุณสามารถตรวจสอบว่าโทรศัพท์หรือ Emulator พร้อมใช้งานหรือไม่โดยใช้คำสั่ง
 ```bash
flutter devices
   ```
