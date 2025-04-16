CREATE TABLE IF NOT EXISTS "User" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "identificacion" VARCHAR(255) NOT NULL UNIQUE,
    "telefono" VARCHAR(255),
    "email" VARCHAR(255) NOT NULL,
    "rol" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    CONSTRAINT "user_identificacion_unique" UNIQUE ("identificacion")
);

-- Crear índice para búsquedas por email
CREATE INDEX "user_email_idx" ON "User" ("email");

-- Crear índice para búsquedas por identificación
CREATE INDEX "user_identificacion_idx" ON "User" ("identificacion");

-- Comentarios sobre las columnas
COMMENT ON TABLE "User" IS 'Tabla de usuarios del sistema';
COMMENT ON COLUMN "User"."name" IS 'Nombre completo del usuario';
COMMENT ON COLUMN "User"."identificacion" IS 'Número de identificación único';
COMMENT ON COLUMN "User"."telefono" IS 'Número de contacto (opcional)';
COMMENT ON COLUMN "User"."email" IS 'Correo electrónico del usuario';
COMMENT ON COLUMN "User"."rol" IS 'Rol del usuario en el sistema';