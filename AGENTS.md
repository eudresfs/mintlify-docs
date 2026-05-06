# PGBen Docs — Agent Instructions

Documentação Mintlify do PGBen (Plataforma de Gestão de Benefícios Eventuais). MDX com frontmatter YAML. Configuração em `docs.json`. Preview local via `mint dev`. Validação de links via `mint broken-links`.

## Brand & Tom

- **Brand**: Municipal Teal `#137f93` (institucional, não-vibrante).
- **Tom**: Institucional, técnico, direto. Sem emojis, sem informal, sem hedging.
- **Referência positiva**: Gov.br / Serpro.
- **Anti-referências**: SaaS startup genérico, sistema legado de prefeitura, app de consumidor.

## Style Guidelines

- Voz ativa, segunda pessoa.
- Frases concisas, um conceito por vez.
- Sentence case em headers (`## Por papel`, não `## Por Papel`).
- Negrito para elementos de UI: clique em **Aprovar**.
- Código para referências técnicas: `/solicitacoes/em-analise`.

## Estrutura

```
pgben-mintlify-docs/
├── docs.json          # config (theme almond, navigation, colors)
├── index.mdx          # landing
├── sumario.mdx        # sumário canônico
├── style.css          # custom CSS (Outfit + JetBrains Mono + ledger overrides)
├── favicon.ico
├── logo/
│   ├── light.svg
│   └── dark.svg
├── comecar/           # 3 capítulos
├── operacao/          # 4 capítulos
├── gestao/            # 3 capítulos
├── suporte/           # 2 capítulos
└── apendice/          # índice remissivo
```

## Boundaries

- **Não usar**: emojis, gradientes, glassmorphism, hero metrics, identical card grids.
- **Não documentar**: nomes literais de permissões internas (`cidadao.criar` etc.). Use linguagem abstrata: "perfil com acesso a beneficiários".
- **Não afirmar**: features que não existem no código real (ver auditoria contra `pgben-server` e `pgben-front`).

## Setup

```bash
npm i -g mint
mint dev
```

Mintlify CLI roda preview local em `http://localhost:3000`.
