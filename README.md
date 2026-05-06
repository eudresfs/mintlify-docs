# PGBen Docs (Mintlify)

Documentação Mintlify do PGBen. Estrutura paralela à versão VitePress em `docs/`. Conteúdo idêntico, formato MDX.

## Setup

```bash
npm i -g mint
cd pgben-mintlify-docs
mint dev
```

Preview local em `http://localhost:3000`.

## Estrutura

```
pgben-mintlify-docs/
├── docs.json          # config (theme, navigation, brand)
├── index.mdx          # landing
├── sumario.mdx        # sumário canônico
├── style.css          # custom CSS (Outfit + JetBrains Mono + ledger)
├── AGENTS.md          # instruções para AI agents
├── favicon.ico
├── logo/
│   ├── light.png
│   └── dark.png
├── comecar/           # 1-Introdução, 2-Primeiros passos, 3-Glossário
├── operacao/          # 4-Beneficiários, 5-Solicitações, 6-Concessões/Pagamentos, 7-Monitoramento
├── gestao/            # 8-Administração, 9-Relatórios, 10-Fornecedor
├── suporte/           # 11-FAQ, 12-Troubleshooting
├── apendice/          # Índice remissivo
└── convert.ps1        # script de conversão VitePress→Mintlify (re-roda se houver mudanças no docs/)
```

## Comandos úteis

```bash
mint dev              # preview local com hot reload
mint broken-links     # valida links internos
mint update           # atualiza CLI Mintlify
```

## Manutenção

A fonte canônica do conteúdo é `docs/usuario-final/*.md` (VitePress). Para sincronizar mudanças:

```powershell
cd C:\Users\eudre\dev\pgben\pgben-mintlify-docs
.\convert.ps1
```

Re-converte todos os capítulos. Frontmatter (title/description) é mantido conforme `convert.ps1`. Edições manuais em `.mdx` serão sobrescritas — edite a fonte VitePress + reconverter.

## Diferenças vs VitePress

| Aspecto | VitePress | Mintlify |
|---|---|---|
| Hospedagem | Self-hosted (Nginx/Docker) | SaaS Mintlify |
| Custo | Gratuito | Free tier limitado; Pro $150/mês |
| Custom CSS | Total | Limitado a `style.css` |
| Search | Local (FlexSearch) | AI search built-in |
| Componentes | Vue | MDX + Mintlify components (Card, Tip, Warning, Note) |
| Domínio custom | Livre | Plano pago |

## Deploy

Conecte repositório GitHub à conta Mintlify; push em `main` triggers deploy automático.

Detalhes: https://www.mintlify.com/docs/quickstart
