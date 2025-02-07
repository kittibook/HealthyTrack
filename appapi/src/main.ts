import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder, SwaggerDocumentOptions } from '@nestjs/swagger';
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('api/v1');

  const config = new DocumentBuilder()
    .setTitle('APPs example')
    .setDescription('The cats API description')
    .setVersion('1.0')
    .addTag('apps')
    .build();
    const options: SwaggerDocumentOptions =  {
      operationIdFactory: (
        controllerKey: string,
        methodKey: string
      ) => methodKey
    };
  const documentFactory = () => SwaggerModule.createDocument(app, config,options);
  SwaggerModule.setup('api', app, documentFactory); 
  // Enable CORS
  app.enableCors();
  await app.listen(3333);
}
bootstrap();
