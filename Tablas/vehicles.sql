-- Archivo: 07_create_vehicles_table.sql
-- Ejecutar después de haber creado la tabla Conveyors si existe relación


-- Crear tabla Vehicle
CREATE TABLE IF NOT EXISTS "Vehicle" (
    "id" SERIAL PRIMARY KEY,
    "placa" VARCHAR(20) NOT NULL UNIQUE,
    "marca" VARCHAR(100) NOT NULL,
    "modelo" VARCHAR(100) NOT NULL,
    "capacidad" DECIMAL(10, 2) NOT NULL,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Crear índices para mejor rendimiento
CREATE INDEX "vehicle_placa_idx" ON "Vehicle" ("placa");
CREATE INDEX "vehicle_marca_modelo_idx" ON "Vehicle" ("marca", "modelo");

-- Comentarios descriptivos
COMMENT ON TABLE "Vehicle" IS 'Tabla de vehículos de transporte';
COMMENT ON COLUMN "Vehicle"."placa" IS 'Número de placa/licencia del vehículo (único)';
COMMENT ON COLUMN "Vehicle"."marca" IS 'Marca/fabricante del vehículo';
COMMENT ON COLUMN "Vehicle"."modelo" IS 'Modelo específico del vehículo';
COMMENT ON COLUMN "Vehicle"."capacidad" IS 'Capacidad máxima de carga en kilogramos';

-- Si existe relación con Conveyors, agregar la columna vehicleId a Conveyors
-- (Esto debería estar en el script de modificación de Conveyors)
/*
ALTER TABLE "Conveyors" ADD COLUMN IF NOT EXISTS "vehicleId" INTEGER;
ALTER TABLE "Conveyors" ADD CONSTRAINT "fk_conveyor_vehicle" 
    FOREIGN KEY ("vehicleId") REFERENCES "Vehicle" ("id")
    ON DELETE SET NULL
    ON UPDATE CASCADE;
*/