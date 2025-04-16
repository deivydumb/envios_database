-- Archivo: 09_create_journeys_table.sql
-- Ejecutar después de crear la tabla Conveyors

-- Conectar a la base de datos envios_db
\c envios_db

-- 1. Crear tipo ENUM para los estados de viaje
CREATE TYPE journey_status AS ENUM (
    'pendiente',
    'en_progreso',
    'completado',
    'cancelado'
);

-- 2. Crear tabla Journey
CREATE TABLE IF NOT EXISTS "Journey" (
    "id" SERIAL PRIMARY KEY,
    "fecha_inicio" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "fecha_fin_estimada" TIMESTAMP WITH TIME ZONE NOT NULL,
    "estado" journey_status DEFAULT 'pendiente',
    "origen" VARCHAR(255) NOT NULL,
    "destino" VARCHAR(255) NOT NULL,
    "transportistaId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "deletedAt" TIMESTAMP WITH TIME ZONE,
    
    -- Clave foránea a Conveyors
    CONSTRAINT "fk_journey_conveyor" 
        FOREIGN KEY ("transportistaId") 
        REFERENCES "Conveyors" ("id")
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 3. Crear índices para mejor rendimiento
CREATE INDEX "journey_status_idx" ON "Journey" ("estado");
CREATE INDEX "journey_transportista_idx" ON "Journey" ("transportistaId");
CREATE INDEX "journey_fechas_idx" ON "Journey" ("fecha_inicio", "fecha_fin_estimada");

-- 4. Comentarios descriptivos
COMMENT ON TABLE "Journey" IS 'Tabla de viajes/rutas de transporte';
COMMENT ON COLUMN "Journey"."fecha_inicio" IS 'Fecha y hora de inicio del viaje';
COMMENT ON COLUMN "Journey"."fecha_fin_estimada" IS 'Fecha estimada de finalización';
COMMENT ON COLUMN "Journey"."estado" IS 'Estado actual del viaje';
COMMENT ON COLUMN "Journey"."transportistaId" IS 'ID del transportista asignado';
