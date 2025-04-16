-- Archivo: 02_create_conveyors_table.sql
-- Ejecutar después de crear la base de datos y antes de crear la tabla Vehicle

-- Conectar a la base de datos envios_db
\c envios_db

-- 1. Crear tabla Conveyors con todas las columnas (incluyendo vehicleId)
CREATE TABLE IF NOT EXISTS "Conveyors" (
    "id" SERIAL PRIMARY KEY,
    "nombre" VARCHAR(255) NOT NULL,
    "identificacion" VARCHAR(255) NOT NULL UNIQUE,
    "telefono" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL UNIQUE,
    "empresa" VARCHAR(255),
    "licencia_transporte" VARCHAR(255),
    "vehicleId" INTEGER,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "deletedAt" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "email_unique" UNIQUE ("email"),
    CONSTRAINT "identificacion_unique" UNIQUE ("identificacion")
);

-- 2. Crear índices para búsquedas
CREATE INDEX "conveyors_email_idx" ON "Conveyors" ("email");
CREATE INDEX "conveyors_identificacion_idx" ON "Conveyors" ("identificacion");
CREATE INDEX "conveyors_vehicle_idx" ON "Conveyors" ("vehicleId");

-- 3. Agregar la FK a Vehicle (se ejecutará cuando exista Vehicle)
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'Vehicle') THEN
        ALTER TABLE "Conveyors" 
        ADD CONSTRAINT "fk_conveyor_vehicle" 
        FOREIGN KEY ("vehicleId") 
        REFERENCES "Vehicle" ("id")
        ON DELETE SET NULL
        ON UPDATE CASCADE;
    END IF;
END $$;

-- 4. Comentarios descriptivos
COMMENT ON TABLE "Conveyors" IS 'Tabla de transportistas o empresas de envío';
COMMENT ON COLUMN "Conveyors"."nombre" IS 'Nombre completo del transportista';
COMMENT ON COLUMN "Conveyors"."identificacion" IS 'Número de identificación único';
COMMENT ON COLUMN "Conveyors"."vehicleId" IS 'Vehículo asignado (opcional)';

