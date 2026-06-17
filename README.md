# PGBen Docs

Documentacao Mintlify do PGBen para producao.

A fonte de verdade e:

- codigo atual de `pgben-front`;
- codigo atual de `pgben-server`;
- orientacoes operacionais da SEMTAS e do time do projeto.

O repositorio ja esta conectado ao Mintlify. Push em `main` dispara publicacao conforme configuracao da conta.

## Setup

```bash
npm i -g mint
cd pgben-mintlify-docs
mint dev
```

Preview local padrao: `http://localhost:3000`.

## Estrutura

```text
pgben-mintlify-docs/
├── docs.json
├── index.mdx
├── sumario.mdx
├── comecar/
├── trilhas/
├── operacao/
├── gestao/
├── changelog/
├── suporte/
├── producao/
├── apendice/
├── images/
├── logo/
└── convert.ps1
```

## Comandos uteis

```bash
mint dev
mint broken-links
mint update
git diff --check
```

## Configuracao de producao

- Sistema: `https://semtas-natal.pgben.com.br`
- OpenAPI: `https://api-semtas-natal.pgben.com.br/openapi.json`
- Posicionamento: documentacao de usuario final, com trilhas por papel.
- Changelog: entregas recentes auditadas nas ultimas duas semanas.

## Manutencao editorial

1. Audite primeiro o codigo de `pgben-front` e `pgben-server`.
2. Documente o efeito operacional, nao nomes internos de DTO, permissao ou entidade.
3. Quando uma acao depender de perfil, use linguagem como "depende de acesso liberado".
4. Quando uma acao depender de status, cite o status antes de orientar a acao.
5. Antes de publicar screenshots, aplique as regras em `producao/screenshots.mdx`.
6. Rode `mint broken-links` antes de commit.

## Script legado

`convert.ps1` existe para reconverter conteudo antigo de VitePress. Ele nao e a fonte canonica atual.

Use esse script apenas quando a equipe decidir recuperar conteudo legado e sempre revise o diff, porque ele pode sobrescrever edicoes manuais em MDX.

## Screenshots

Capturas devem usar dados ficticios ou anonimizados. Nunca publique CPF, NIS, telefone, endereco, dados bancarios, documentos, tokens ou links publicos sensiveis sem mascara.

## Deploy

O deploy e feito pelo Mintlify a partir do repositorio GitHub conectado.

Referencias oficiais:

- https://www.mintlify.com/docs/organize/navigation
- https://www.mintlify.com/docs/organize/settings
- https://www.mintlify.com/docs/cli/commands
