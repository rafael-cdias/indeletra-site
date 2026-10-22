import { defineConfig } from 'astro/config';

// Site estático: a Cloudflare Pages publica a pasta dist/ gerada pelo build.
export default defineConfig({
  site: 'https://www.indeletra.com.br',
  output: 'static',
  trailingSlash: 'ignore',
  build: { format: 'directory' },
});
