# Converte docs VitePress (docs/usuario-final/*.md) → Mintlify MDX
# Mapeia paths, transforma callouts, gera frontmatter.

$src = "C:\Users\eudre\dev\pgben\docs\usuario-final"
$dst = "C:\Users\eudre\dev\pgben\pgben-mintlify-docs"

# Mapeamento: arquivo origem → destino + título + descrição
$mapping = @(
  @{ src = "01-introducao.md";          dst = "comecar\introducao.mdx";              title = "Introdução ao PGBen";       desc = "O que é o PGBen, perfis de usuário, categorias de benefício e ciclo de vida do benefício." }
  @{ src = "02-primeiros-passos.md";    dst = "comecar\primeiros-passos.mdx";        title = "Primeiros passos";          desc = "Login, primeiro acesso, navegação pela interface, perfil de usuário e notificações." }
  @{ src = "03-glossario.md";           dst = "comecar\glossario.mdx";               title = "Glossário";                 desc = "Termos do domínio da assistência social usados no PGBen, em ordem alfabética." }
  @{ src = "04-beneficiarios.md";       dst = "operacao\beneficiarios.mdx";          title = "Beneficiários";             desc = "Cadastro, busca, edição e transferência de cidadãos atendidos." }
  @{ src = "05-solicitacoes.md";        dst = "operacao\solicitacoes.mdx";           title = "Solicitações de benefício"; desc = "Criar, analisar, aprovar, indeferir e acompanhar solicitações." }
  @{ src = "06-concessoes-pagamentos.md"; dst = "operacao\concessoes-pagamentos.mdx"; title = "Concessões e pagamentos"; desc = "Gerenciar benefícios ativos, liberar parcelas, suspender, cessar e reativar concessões." }
  @{ src = "07-monitoramento.md";       dst = "operacao\monitoramento.mdx";          title = "Monitoramento e visitas técnicas"; desc = "Planejamento, registro de visitas e gestão de advertências." }
  @{ src = "08-administracao.md";       dst = "gestao\administracao.mdx";            title = "Administração do sistema";  desc = "Usuários, perfis, unidades, tipos de benefício, orçamento, ofígios e integrações." }
  @{ src = "09-relatorios-downloads.md"; dst = "gestao\relatorios-downloads.mdx";    title = "Relatórios e downloads";    desc = "Relatórios sob demanda, agendados e central de downloads em lote." }
  @{ src = "10-fornecedor.md";          dst = "gestao\fornecedor.mdx";               title = "Portal do fornecedor";      desc = "Para parceiros que entregam serviços e produtos aos beneficiários." }
  @{ src = "11-faq.md";                 dst = "suporte\faq.mdx";                     title = "Perguntas frequentes";      desc = "Respostas rápidas para dúvidas comuns sobre o PGBen." }
  @{ src = "12-troubleshooting.md";     dst = "suporte\troubleshooting.mdx";         title = "Solução de problemas";      desc = "Problemas comuns e como resolver. Como reportar bugs ao suporte." }
  @{ src = "indice-remissivo.md";       dst = "apendice\indice-remissivo.mdx";       title = "Índice remissivo";          desc = "Lista alfabética de termos com link direto para a seção relevante." }
  @{ src = "index.md";                  dst = "sumario.mdx";                          title = "Sumário canônico";          desc = "Lista completa de capítulos do manual." }
)

# Mapeamento de paths nos links
$pathMap = @{
  './usuario-final/01-introducao' = '/comecar/introducao'
  './usuario-final/02-primeiros-passos' = '/comecar/primeiros-passos'
  './usuario-final/03-glossario' = '/comecar/glossario'
  './usuario-final/04-beneficiarios' = '/operacao/beneficiarios'
  './usuario-final/05-solicitacoes' = '/operacao/solicitacoes'
  './usuario-final/06-concessoes-pagamentos' = '/operacao/concessoes-pagamentos'
  './usuario-final/07-monitoramento' = '/operacao/monitoramento'
  './usuario-final/08-administracao' = '/gestao/administracao'
  './usuario-final/09-relatorios-downloads' = '/gestao/relatorios-downloads'
  './usuario-final/10-fornecedor' = '/gestao/fornecedor'
  './usuario-final/11-faq' = '/suporte/faq'
  './usuario-final/12-troubleshooting' = '/suporte/troubleshooting'
  './usuario-final/indice-remissivo' = '/apendice/indice-remissivo'
  './usuario-final/' = '/sumario'
  './01-introducao' = '/comecar/introducao'
  './02-primeiros-passos' = '/comecar/primeiros-passos'
  './03-glossario' = '/comecar/glossario'
  './04-beneficiarios' = '/operacao/beneficiarios'
  './05-solicitacoes' = '/operacao/solicitacoes'
  './06-concessoes-pagamentos' = '/operacao/concessoes-pagamentos'
  './07-monitoramento' = '/operacao/monitoramento'
  './08-administracao' = '/gestao/administracao'
  './09-relatorios-downloads' = '/gestao/relatorios-downloads'
  './10-fornecedor' = '/gestao/fornecedor'
  './11-faq' = '/suporte/faq'
  './12-troubleshooting' = '/suporte/troubleshooting'
  './indice-remissivo' = '/apendice/indice-remissivo'
}

foreach ($entry in $mapping) {
  $srcPath = Join-Path $src $entry.src
  $dstPath = Join-Path $dst $entry.dst
  if (-not (Test-Path $srcPath)) { Write-Warning "Missing: $srcPath"; continue }

  $c = Get-Content -Raw -Path $srcPath -Encoding UTF8

  # Remove chapter-mark div
  $c = $c -replace '(?s)<div class="pgb-chapter-mark">.*?</div>\s*', ''

  # Remove h1 (será frontmatter)
  $c = $c -replace '(?m)^# .+\r?\n', ''

  # Remove pgb-home-content wrapper / pgb-papel-section
  $c = $c -replace '(?s)<div class="pgb-home-content[^"]*"[^>]*>', ''
  $c = $c -replace '(?s)<section class="pgb-papel-section"[^>]*>', ''
  $c = $c -replace '(?s)<div class="pgb-papel-eyebrow">[^<]*</div>', ''
  $c = $c -replace '</section>', ''
  $c = $c -replace '(?m)^</div>\s*$', ''

  # Remove pgb-chapter-list / chapter-section / chapter-row HTML
  $c = $c -replace '(?s)<nav class="pgb-chapter-list"[^>]*>.*?</nav>', ''
  $c = $c -replace '(?s)<div class="pgb-chapter-section">.*?</div>', ''

  # Convert ::: tip Title \n ... ::: → <Tip>...</Tip>
  $c = [regex]::Replace($c, '(?s):::\s*tip\s*([^\r\n]*)?\r?\n(.*?)\r?\n:::', {
    param($m)
    $title = $m.Groups[1].Value.Trim()
    $body = $m.Groups[2].Value.Trim()
    if ($title) { "<Tip>`n**$title** — $body`n</Tip>" }
    else { "<Tip>`n$body`n</Tip>" }
  })

  $c = [regex]::Replace($c, '(?s):::\s*warning\s*([^\r\n]*)?\r?\n(.*?)\r?\n:::', {
    param($m)
    $title = $m.Groups[1].Value.Trim()
    $body = $m.Groups[2].Value.Trim()
    if ($title) { "<Warning>`n**$title** — $body`n</Warning>" }
    else { "<Warning>`n$body`n</Warning>" }
  })

  $c = [regex]::Replace($c, '(?s):::\s*info\s*([^\r\n]*)?\r?\n(.*?)\r?\n:::', {
    param($m)
    $title = $m.Groups[1].Value.Trim()
    $body = $m.Groups[2].Value.Trim()
    if ($title) { "<Note>`n**$title** — $body`n</Note>" }
    else { "<Note>`n$body`n</Note>" }
  })

  $c = [regex]::Replace($c, '(?s):::\s*danger\s*([^\r\n]*)?\r?\n(.*?)\r?\n:::', {
    param($m)
    $title = $m.Groups[1].Value.Trim()
    $body = $m.Groups[2].Value.Trim()
    if ($title) { "<Warning>`n**$title** — $body`n</Warning>" }
    else { "<Warning>`n$body`n</Warning>" }
  })

  # Remap path links
  foreach ($key in $pathMap.Keys) {
    $value = $pathMap[$key]
    $c = $c.Replace($key, $value)
  }

  # Remove trailing "Próximo capítulo:" navigation (Mintlify gera auto)
  $c = $c -replace '(?s)\r?\n---\r?\n\s*\*\*Pr[óo]ximo cap[íi]tulo:\*\*[^\r\n]+\r?\n?', ''
  $c = $c -replace '(?s)\r?\n\*Vers[ãa]o da documenta[çc][ãa]o[^\r\n]+\r?\n?', ''

  # Frontmatter
  $title = $entry.title
  $desc = $entry.desc
  $frontmatter = "---`ntitle: $title`ndescription: $desc`n---`n`n"
  $c = $frontmatter + $c.TrimStart()

  # Cria diretório dst se necessário
  $dstDir = Split-Path -Parent $dstPath
  if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Path $dstDir -Force | Out-Null }

  Set-Content -Path $dstPath -Value $c -NoNewline -Encoding UTF8
  Write-Host "Converted: $($entry.src) -> $($entry.dst)"
}

Write-Host "Done."
