// Arquivo de teste gerado com auxílio de Inteligência Artificial.
// Como este arquivo foi utilizado apenas para testar o funcionamento
// do Prisma Client, não vimos problema em criá-lo dessa forma.

import prisma from './prisma/client.js';

// 1. Lista os artistas antes
const artistasAntes = await prisma.artista.findMany();
console.log('Artistas antes:', artistasAntes);

// 2. Cria um artista de teste
const novoArtista = await prisma.artista.create({
  data: {
    nome: 'Maria Silva',
    biografia: 'Artista apaixonada por pintura e arte contemporânea.',
    fotoUrl: 'https://exemplo.com/maria.jpg',
    email: 'maria.artista@email.com',
    numeroTelefone: '999999999',
    instagram: '@mariasilva',
    senhaHash: 'hash_temporario_123',
  },
});

console.log('Novo artista criado:', novoArtista);

// 3. Cria um cliente de teste
const novoCliente = await prisma.cliente.create({
  data: {
    nome: 'João Santos',
    fotoUrl: 'https://exemplo.com/joao.jpg',
    email: 'joao.cliente@email.com',
    numeroTelefone: '988888888',
    senhaHash: 'hash_temporario_456',
  },
});

console.log('Novo cliente criado:', novoCliente);

// 4. Cria uma obra vinculada ao artista
const novaObra = await prisma.obraDeArte.create({
  data: {
    titulo: 'Paisagem de Salinas',
    preco: 1500.00,
    fotoUrl: 'https://exemplo.com/paisagem.jpg',
    legenda: 'Uma paisagem inspirada em Salinas.',
    dataDeCriacao: new Date('2026-08-10'),
    dimensoes: '50x70',
    artistaId: novoArtista.id,
  },
});

console.log('Nova obra criada:', novaObra);

// 5. Busca todas as obras incluindo artista e comprador
const obras = await prisma.obraDeArte.findMany({
  include: {
    artista: true,
    comprador: true,
  },
});

console.log('Obras cadastradas:', obras);

// 6. Atualiza a obra colocando um comprador
const obraAtualizada = await prisma.obraDeArte.update({
  where: {
    id: novaObra.id,
  },
  data: {
    compradorId: novoCliente.id,
  },
});

console.log('Obra após compra:', obraAtualizada);

// 7. Busca o cliente incluindo as obras compradas
const clienteComObras = await prisma.cliente.findUnique({
  where: {
    id: novoCliente.id,
  },
  include: {
    obrasCompradas: true,
  },
});

console.log('Cliente com obras:', clienteComObras);

// 8. Fecha a conexão com o banco
await prisma.$disconnect();