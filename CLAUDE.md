# CLAUDE.md

Diretrizes de comportamento para reduzir erros comuns de LLMs ao programar. Combine com as instruções específicas do projeto conforme necessário.

**Compromisso:** estas diretrizes priorizam cautela em vez de velocidade. Em tarefas triviais, use o bom senso.

## 1. Pense Antes de Codar

**Não presuma. Não esconda dúvidas. Exponha os trade-offs.**

Antes de implementar:
- Declare suas suposições explicitamente. Se estiver incerto, pergunte.
- Se existirem várias interpretações, apresente-as. Não escolha em silêncio.
- Se existir uma abordagem mais simples, diga. Questione quando fizer sentido.
- Se algo não estiver claro, pare. Diga o que está confuso. Pergunte.

## 2. Simplicidade Primeiro

**O mínimo de código que resolve o problema. Nada especulativo.**

- Nenhuma funcionalidade além do que foi pedido.
- Nenhuma abstração para código de uso único.
- Nenhuma "flexibilidade" ou "configurabilidade" que não foi pedida.
- Nenhum tratamento de erro para cenários impossíveis.
- Se você escreveu 200 linhas e poderiam ser 50, reescreva.

Pergunte-se: "Um engenheiro sênior diria que isso está complicado demais?" Se sim, simplifique.

## 3. Mudanças Cirúrgicas

**Mexa apenas no que for necessário. Limpe apenas a sua própria bagunça.**

Ao editar código existente:
- Não "melhore" código, comentários ou formatação adjacentes.
- Não refatore o que não está quebrado.
- Siga o estilo existente, mesmo que você faria diferente.
- Se notar código morto sem relação com a tarefa, mencione. Não apague.

Quando suas mudanças gerarem órfãos:
- Remova imports, variáveis e funções que as SUAS mudanças deixaram sem uso.
- Não remova código morto preexistente, a menos que peçam.

O teste: toda linha alterada deve ter relação direta com o pedido do usuário.

## 4. Execução Orientada a Metas

**Defina critérios de sucesso. Itere até verificar.**

Transforme tarefas em metas verificáveis:
- "Adicionar validação" → "Escrever testes para entradas inválidas e fazê-los passar"
- "Corrigir o bug" → "Escrever um teste que reproduz o bug e fazê-lo passar"
- "Refatorar X" → "Garantir que os testes passam antes e depois"

Em tarefas com vários passos, declare um plano curto:
```
1. [Passo] → verificar: [checagem]
2. [Passo] → verificar: [checagem]
3. [Passo] → verificar: [checagem]
```

Critérios de sucesso fortes permitem que você itere sozinho. Critérios fracos ("faça funcionar") exigem esclarecimentos constantes.

---

**Estas diretrizes estão funcionando se:** houver menos mudanças desnecessárias nos diffs, menos reescritas por excesso de complicação, e as perguntas de esclarecimento vierem antes da implementação, e não depois dos erros.

Use o modelo ASD-STE100 para fazer explicações

---

# Projeto

Jogo de criação de monstros feito em Godot, inspirado em Monster Rancher 2 ("Monster Rancher 2, mas com genética realista"). Não é um clone fiel. O jogo será exportado em HTML e publicado no GitHub Pages.

O dono do projeto é o Daniel, que tem experiência em engenharia de dados mas **nenhuma em desenvolvimento de jogos**. Explique conceitos de Godot e de game design em linguagem simples quando surgirem, sem enrolar. Responda sempre em português do Brasil. Código, nomes de arquivos e identificadores ficam em inglês, por convenção da engine e das ferramentas.

## Estrutura do repositório

```
project/   código do jogo (projeto Godot)
vault/     vault do Obsidian: documentação e design
etc/       todo o restante (assets brutos, referências, scripts auxiliares, exports)
```

- Código vai **somente** em `project/`. Documentação vai em `vault/`. Qualquer outra coisa vai em `etc/`.
- Não crie arquivos na raiz do repositório além do `CLAUDE.md` e de arquivos de configuração do git.

## Design do jogo

A fonte de verdade do design está em `vault/`. Antes de implementar qualquer mecânica, leia a nota correspondente. Se a nota não existir ou estiver ambígua, pergunte ao Daniel e registre a decisão no vault antes de codar.

Resumo do loop: criar monstro → treinar e cuidar → competir e explorar → criar novos monstros para progredir. Pilares de design (detalhes no vault):

- **Ovo + palavra + incubação** substituem o CD do original. O ovo define a raça; a palavra (3 a 7 letras) define bônus e penalidades na facilidade de ganhar stats e depende de uma variável gerada por save; a incubação (temperatura, umidade, música) molda os aspectos de personalidade.
- **Procriação** mistura linhagem (stats e habilidades ponderados) e herda a facilidade de progresso, não o poder acumulado.
- **Batalha** é simulação: o monstro decide, o jogador só define a estratégia antes, e a obediência depende de atributos do monstro.
- **Treino semanal** com equipamentos que melhoram o treino; excesso sem descanso gera doença, estresse e frustração.

Mecânicas com aleatoriedade (rolagem de ovo, efeito de palavra, mutação, herança) devem ser **determinísticas a partir de uma seed guardada no save**, para serem testáveis e reproduzíveis.

## Ferramentas disponíveis

**MCPs**
- **PixelLab**: geração de pixel art (sprites, animações, tilesets). Use para assets; salve os resultados finais em `project/` e referências/brutos em `etc/`.
- **godot-mcp** (`@coding-solo/godot-mcp`): controla o editor/projeto Godot (rodar o projeto, ler a saída de debug, manipular cenas). Prefira-o a comandos manuais do Godot quando fizer sentido.

**Skills (plugins)**
- `godot@awesome-gamedev-agent-skills`: convenções e boas práticas de Godot. Consulte antes de escrever código Godot.
- `mattpocock-skills@claude-plugins-official`: skills de engenharia (TDD, diagnóstico de bugs, planejamento etc.). Use quando a tarefa se encaixar.

**Obsidian**: está instalado na máquina do Daniel e abre a pasta `vault/`. Para você, o vault é só uma pasta de arquivos Markdown: edite com as ferramentas de arquivo normais.

## Código (`project/`)

- Godot 4.x, GDScript por padrão. Não introduza C# nem GDExtension sem perguntar: o alvo é exportação web, e isso limita as opções.
- Todo recurso novo deve funcionar na exportação HTML. Se algo depender de recurso não suportado na web (threads, acesso a arquivos arbitrários etc.), avise antes de seguir.
- A lógica de jogo (genética, stats, rolagens, batalha) fica separada de cena/UI, em scripts ou resources testáveis sem abrir a interface. É onde os testes mais valem.
- Dados de design (raças, palavras, personalidades, equipamentos, treinos) ficam em resources ou arquivos de dados, não espalhados no código.

## Documentação (`vault/`)

- Notas em Markdown, uma ideia por nota, com `[[wikilinks]]` entre notas relacionadas.
- Nome de arquivo e título em português.
- Quando uma decisão de design mudar, atualize a nota existente em vez de criar uma duplicada, e registre brevemente o motivo da mudança.
- Não documente o que o código já deixa óbvio. O vault serve para decisões, regras de design e o porquê das coisas.

## Git

- Commits pequenos, uma mudança lógica por commit, mensagem curta no imperativo.
- Não faça push, force push nem reescreva o histórico sem pedido explícito.
