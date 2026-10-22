import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const manual = z.object({
  potencia: z.string(),
  entrada: z.string().optional().default(''),
  saida: z.string().optional().default(''),
  arquivo: z.string().optional().nullable(),
});

const linha = z.object({
  nome: z.string(),
  logo: z.string().optional().nullable(),
  descricao: z.string().optional().default(''),
  especificacoes: z.array(z.string()).optional().default([]),
  manuais: z.array(manual).optional().default([]),
  fotos: z.array(z.string()).optional().default([]),
});

const produtos = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/produtos' }),
  schema: z.object({
    title: z.string(),
    menu: z.string().optional(),
    ordem: z.number().default(99),
    imagem: z.string(),
    resumo: z.string().optional().default(''),
    linhas: z.array(linha).optional().default([]),
  }),
});

export const collections = { produtos };
