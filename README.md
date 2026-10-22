# Site Indeletra — Astro + Cloudflare Pages + Pages CMS

Nova versão do www.indeletra.com.br: site estático (rápido, sem WordPress, sem plugins para atualizar), hospedado gratuitamente na Cloudflare Pages e editável pelo painel do Pages CMS.

## Estrutura

```
src/content/produtos/*.md   → uma página por categoria (Transformadores, Estabilizadores…)
src/data/home.json          → textos e imagens da página inicial
src/data/site.json          → telefone, e-mails, WhatsApp, endereço, redes sociais
public/uploads/             → imagens (mesma estrutura de pastas do WordPress)
public/pdf/                 → manuais e catálogos em PDF
.pages.yml                  → o que o Pages CMS deixa editar
scripts/baixar-midia.sh     → baixa imagens e PDFs do site atual
```

## 1. Trazer as imagens e PDFs (uma vez só)

O servidor atual bloqueia downloads automáticos de fora, então rode no seu Mac, dentro da pasta do projeto:

```bash
bash scripts/baixar-midia.sh
```

São 76 arquivos (16 imagens principais, logos e ~45 PDFs de manuais/catálogos). A lista está em `scripts/midia.txt`.

## 2. Testar no computador (opcional)

Precisa do Node.js 18.20+ (recomendado 22).

```bash
npm install
npm run dev        # abre em http://localhost:4321
```

## 3. Publicar no GitHub

1. Crie um repositório (pode ser privado), ex.: `indeletra-site`.
2. Envie esta pasta:
   ```bash
   git init && git add . && git commit -m "Site Indeletra"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/indeletra-site.git
   git push -u origin main
   ```

## 4. Cloudflare Pages

1. Painel da Cloudflare → **Workers & Pages** → **Create** → **Pages** → **Connect to Git** → escolha o repositório.
2. Configuração de build:
   - Framework preset: **Astro**
   - Build command: `npm run build`
   - Output directory: `dist`
   - Variável de ambiente (opcional): `NODE_VERSION = 22`
3. Salve. Cada alteração no GitHub (inclusive as feitas pelo Pages CMS) publica o site sozinha em ~1 minuto.
4. **Custom domains** → adicione `www.indeletra.com.br` e `indeletra.com.br`. Se o DNS do domínio já estiver na Cloudflare, ela cria os registros; se não, mude os nameservers no Registro.br para os da Cloudflare.
5. Redirecione `indeletra.com.br` → `www.indeletra.com.br` (Rules → Redirect Rules) para ficar um endereço só.

> Antes de apontar o domínio, confira o site no endereço provisório `*.pages.dev`.
> Os e-mails @indeletra.com.br **não são afetados** desde que os registros MX atuais sejam mantidos no DNS — copie-os antes de trocar os nameservers.

## 5. Pages CMS (edição pelo navegador)

1. Acesse https://app.pagescms.org e entre com a conta do GitHub.
2. Autorize o acesso ao repositório `indeletra-site` e abra o projeto.
3. Aparecem três áreas no menu:
   - **Produtos** — textos, especificações (uma por linha), tabela de manuais e imagens de cada categoria. Para criar uma categoria nova, use "Adicionar" e defina a ordem.
   - **Página inicial** — apresentação, diferenciais, revenda, catálogos.
   - **Dados da empresa e contato** — telefone, WhatsApp, e-mails, endereço, redes.
   - **Mídia** — envio de imagens e PDFs.
4. Ao salvar, o Pages CMS faz um commit no GitHub e a Cloudflare republica o site.

Para dar acesso a outra pessoa da equipe, convide-a pelo próprio Pages CMS (Settings → Collaborators) — não precisa ter conta no GitHub.

## O que mudou em relação ao site antigo

- Visual renovado, responsivo, com menu de produtos, botão fixo de WhatsApp e botão "Pedir orçamento" em cada linha (já com a mensagem preenchida).
- Tabelas de manuais organizadas por potência e tensão; itens sem PDF aparecem como "Sob consulta".
- SEO: títulos e descrições por página, dados estruturados da empresa, links antigos `/wp-content/uploads/...` redirecionados.
- Mesmas URLs das páginas (`/transformadores/`, `/contato/` etc.), então links do Google continuam valendo.
- Pequenas correções de texto (acentos, "similares", "carregadores", faixa de potência da linha ER 2.000–5.000VA).
