-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ARTISTA', 'CLIENTE');

-- CreateTable
CREATE TABLE "Artista" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "biografia" TEXT NOT NULL,
    "fotoUrl" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "numeroTelefone" TEXT,
    "instagram" TEXT,
    "senhaHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ARTISTA',
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizadoEm" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Artista_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cliente" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "fotoUrl" TEXT,
    "email" TEXT NOT NULL,
    "numeroTelefone" TEXT,
    "senhaHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'CLIENTE',
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizadoEm" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ObraDeArte" (
    "id" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,
    "fotoUrl" TEXT NOT NULL,
    "legenda" TEXT,
    "dataDeCriacao" TIMESTAMP(3) NOT NULL,
    "dimensoes" TEXT NOT NULL,
    "artistaId" INTEGER NOT NULL,
    "compradorId" INTEGER,
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizadoEm" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ObraDeArte_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Artista_email_key" ON "Artista"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_email_key" ON "Cliente"("email");

-- AddForeignKey
ALTER TABLE "ObraDeArte" ADD CONSTRAINT "ObraDeArte_artistaId_fkey" FOREIGN KEY ("artistaId") REFERENCES "Artista"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ObraDeArte" ADD CONSTRAINT "ObraDeArte_compradorId_fkey" FOREIGN KEY ("compradorId") REFERENCES "Cliente"("id") ON DELETE SET NULL ON UPDATE CASCADE;
