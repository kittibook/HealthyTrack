import { Module } from '@nestjs/common';
import { LoginController } from './login&register/app.controller';
import { AuthService } from './login&register/auth.service';
import { JwtStrategy } from './login&register/jwt.stattegy';
import { ServeStaticModule } from '@nestjs/serve-static';
import { JwtModule } from '@nestjs/jwt';
import { join } from 'path';
import { ActivityController } from './activity/activityget.controller';
import { ActivityInsertController } from './activity/activityinsert.controller';
import { DatadayController } from './datadayuser/datadayget.controller';
import { DatadayInsertController } from './datadayuser/datadayinsert.controller';
import { EatController } from './eat/eatget.controller';
import { EatInsertController } from './eat/eatinsert.controller';
import { MeditateController } from './meditate/meditateget.controller';
import { MeditateInsertController } from './meditate/meditateinsert.controller';
import { MenuController } from './menu/menu.controller';
import { WalkController } from './walk/walkget.contronller';
import { WalkInsertController } from './walk/walkinsert.controller';
import { TargetController } from './target/target.contronller';
@Module({
  imports: [
    JwtModule.register({
      secret: 'Bxok_kittipon',
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'public'),  // โฟลเดอร์ที่เก็บไฟล์ static (เช่น HTML, CSS, JS)
    }),
  ],
  controllers: [
    LoginController,
    ActivityController,
    ActivityInsertController,
    DatadayController,
    DatadayInsertController,
    EatController,
    EatInsertController,
    MeditateController,
    MeditateInsertController,
    MenuController,
    WalkController,
    WalkInsertController,
    TargetController
  ],
  providers: [AuthService, JwtStrategy],
})
export class AppModule {}
