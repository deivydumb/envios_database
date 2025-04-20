-- Archivo: 05_create_shipments_table.sql
-- Ejecutar después de haber creado la tabla User

SET search_path TO envios_db, public;

-- Crear tipo ENUM para los estados de envío
CREATE TYPE envios_db.shipment_status AS ENUM (
    'preparacion',
    'transito',
    'en_reparto',
    'entregado',
    'cancelado'
);

-- Crear tabla Shipment
CREATE TABLE IF NOT EXISTS envios_db."Shipment" (
    "id" SERIAL PRIMARY KEY,
    "codigo_seguimiento" VARCHAR(255) NOT NULL UNIQUE,
    "fecha_envio" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "fecha_entrega_estimada" TIMESTAMP WITH TIME ZONE NOT NULL,
    "estado" envios_db.shipment_status DEFAULT 'preparacion',
    "costo" DECIMAL(10, 2) NOT NULL,
    "ciudad_origen" VARCHAR(255) NOT NULL,
    "direccion_origen" TEXT NOT NULL,
    "ciudad_destino" VARCHAR(255) NOT NULL,
    "direccion_destino" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "deletedAt" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "fk_user" FOREIGN KEY ("userId") 
        REFERENCES envios_db."User" ("id")
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Crear índices para mejor rendimiento
CREATE INDEX "shipment_codigo_seguimiento_idx" ON envios_db."Shipment" ("codigo_seguimiento");
CREATE INDEX "shipment_estado_idx" ON envios_db."Shipment" ("estado");
CREATE INDEX "shipment_user_idx" ON envios_db."Shipment" ("userId");
CREATE INDEX "shipment_fecha_envio_idx" ON envios_db."Shipment" ("fecha_envio");

-- Comentarios descriptivos
COMMENT ON TABLE envios_db."Shipment" IS 'Tabla de registros de envíos';
COMMENT ON COLUMN envios_db."Shipment"."codigo_seguimiento" IS 'Código único de seguimiento del envío';
COMMENT ON COLUMN envios_db."Shipment"."fecha_entrega_estimada" IS 'Fecha estimada de entrega';
COMMENT ON COLUMN envios_db."Shipment"."estado" IS 'Estado actual del envío';
COMMENT ON COLUMN envios_db."Shipment"."costo" IS 'Costo del envío con 2 decimales de precisión';
COMMENT ON COLUMN envios_db."Shipment"."userId" IS 'ID del usuario que creó el envío';
