-- Archivo: 06_create_packages_table.sql
-- Ejecutar después de haber creado las tablas Shipment y Journey


-- Crear tabla Package
CREATE TABLE IF NOT EXISTS "Package" (
    "id" SERIAL PRIMARY KEY,
    "tipo" VARCHAR(255),
    "descripcion" VARCHAR(255),
    "peso" FLOAT NOT NULL,
    "largo" FLOAT NOT NULL,
    "alto" FLOAT,
    "ancho" FLOAT,
    "unidades" INTEGER NOT NULL,
    "shipmentId" INTEGER NOT NULL,
    "journeyId" INTEGER,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    
    -- Claves foráneas
    CONSTRAINT "fk_package_shipment" 
        FOREIGN KEY ("shipmentId") 
        REFERENCES "Shipment" ("id")
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    CONSTRAINT "fk_package_journey" 
        FOREIGN KEY ("journeyId") 
        REFERENCES "Journey" ("id")
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Crear índices para mejor rendimiento
CREATE INDEX "package_shipment_idx" ON "Package" ("shipmentId");
CREATE INDEX "package_journey_idx" ON "Package" ("journeyId");

-- Comentarios descriptivos
COMMENT ON TABLE "Package" IS 'Tabla de paquetes incluidos en envíos';
COMMENT ON COLUMN "Package"."peso" IS 'Peso del paquete en kilogramos';
COMMENT ON COLUMN "Package"."largo" IS 'Largo del paquete en centímetros';
COMMENT ON COLUMN "Package"."unidades" IS 'Cantidad de unidades/idénticos paquetes';
COMMENT ON COLUMN "Package"."shipmentId" IS 'ID del envío al que pertenece el paquete';
COMMENT ON COLUMN "Package"."journeyId" IS 'ID del viaje asignado (puede ser nulo inicialmente)';
