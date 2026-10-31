# Referência MR2: envelhecimento, doenças, treino e batalha

Ticket: https://github.com/gurgeld/monster-keeper/issues/7 (filho do mapa #5).
Data da pesquisa: 2026-10-31.

Objetivo: descrever, ponto a ponto, como o Monster Rancher 2 (MR2) resolve envelhecimento e morte, doenças e lesões, treino e semana, e batalha. Os tickets de design (vida finita, treino, simulador de batalha) partem desta linha de base e divergem onde o dono decidir. Este arquivo descreve o MR2; não decide nada pelo Monster Keeper.

Vocabulário do projeto (de `CONTEXT.md`): usamos **Monstro**, **Treinador**, **Atributo**, **Semana**, **Fôlego** (o "Guts" do MR2), **Batalha**, **Torneio**, **Rank**, **Congelar**. Termos do MR2 aparecem entre parênteses quando divergem.

## Como ler as marcas

- **[V]** verificado: o fato aparece numa fonte primária (material da editora/desenvolvedora). Cada [V] cita a fonte e a página/URL.
- **[NV]** não verificado: só aparece em material de comunidade (guias de fãs, planilhas, fóruns). Útil como ordem de grandeza, mas não confirmado pela fonte que "possui" a regra. Quando duas fontes de comunidade concordam, isso é dito, mas continua [NV].
- **[INF]** inferência minha a partir de fontes; também não verificada.

## Fontes

### Primárias

| Id | Fonte | Observação |
|----|-------|-----------|
| P1 | Manual de instruções oficial do Monster Rancher 2 para PlayStation (Tecmo, NTSC-U, SLUS-00917, 1999). Escaneado em https://archive.org/details/image-20240809-0002 (imagens `Image_20240809_0002` a `_0013`). Li as páginas 1 a 24. | As páginas 25 e 26 ("Data from Monster Rancher 1" e "General Tips") não estão no scan. O manual é curto e qualitativo: quase não tem números. |
| P2 | Manual oficial online da versão "Monster Rancher 1 & 2 DX" (Koei Tecmo America), seção MR2: https://www.koeitecmoamerica.com/manual/mrdx/mr2/en/2200.html (Ranch), `2300.html` (Monster Data), `2400.html` (Training Hints), `2500.html` (Events), `3100.html` (Tournaments), `3200.html` (Battle Screen), `3300.html` (Battle Hints), `2100.html` (Town). | É o manual do relançamento (DX), não do disco original. Regras qualitativas coincidem com P1; o DX pode diferir em números (ver "Divergências de versão"). Também qualitativo. |

Não encontrei material do desenvolvedor (entrevistas, código, tabelas internas) acessível. Todo número concreto abaixo (semanas de vida, fadiga, estresse, probabilidades) vem de comunidade.

### Comunidade

| Id | Fonte | Observação |
|----|-------|-----------|
| C1 | Steam Community, "An In-depth Beginners Guide to Monster Rancher 2" (DX): https://steamcommunity.com/sharedfiles/filedetails/?id=2969204536 | Leitura integral. Guia detalhado, usa dados de ferramentas de terceiros. Escrito para o DX. |
| C2 | Steam Community, "Monster Lifespan": https://steamcommunity.com/sharedfiles/filedetails/?id=2677422880 | Leitura integral. Tabela de vida por espécie. |
| C3 | almarsguides.com, "Fatigue and Stress" (MR2 PS1): https://almarsguides.com/retro/walkthroughs/ps1/games/monsterrancher2/howtoraisemonster/fatigueandstress/ | Leitura integral. Números por ação. Sem citação de origem. |
| C4 | LegendCup (legendcup.com), fórum Monster Rancher Metropolis e FAQs | Servidor devolveu 403 ao meu acesso. Só vi trechos de resumo de busca. Usado apenas para conferência cruzada, sempre marcado como visto só em resumo. |

## 1. Envelhecimento e morte

### 1.1 Estrutura do tempo

- [V] O monstro obtido tem 0 anos (P1 p.10: "The monster you have just obtained is 0 years old"). A tela de dados mostra idade (P2 `2300.html`, "AGE") e o calendário mostra semana/mês (P1 p.13: "1wk May", "4th Week"). Isto confirma que a unidade de ação é a semana.
- [V] No início de cada mês o treinador escolhe a comida do mês (P1 p.11; P2 `2200.html`). Comida afeta o estresse (P2).
- [NV] 4 semanas por mês; o jogo começa na semana 1 de abril do ano 1000 (C1). Casa com o `CONTEXT.md` (4 semanas por mês).
- [NV] "Vida restante" ("lifespan") é contada em semanas: cada semana no rancho tira pelo menos 1; ao chegar a 0 o monstro morre de velhice (C1; C2). O valor não é exibido ao jogador.

### 1.2 Duração da vida por espécie

- [V] O manual não dá números de vida por espécie. P2 `2500.html` diz apenas: "Monsters also die from natural causes when they reach the end of their lifespan. You can extend your monster's lifespan by using certain items." P1 p.15 diz que quem cria "à rigor" (strict) tende a não viver muito, e quem mima vive mais, porém menos forte.
- [NV] Semanas máximas por espécie (valores da tabela de C2, que assumo ser o MR2 NTSC; ver divergências): Wracky 600; Kato, Mock, Plant 550; Ape, Arrowhead, Baku, Color Pandora, Durahan, Mew 500; Bajarl, Gaboo, Golem, Jell, Jill, Metalner, Mocchi, Niton, Phoenix, Suezo, Zilla, Zuum 450; Galaxy 410; Beacon, Centaur, Ducken, Ghost, Hare, Henger, Hopper, Pixie, Tiger, Undine, Worm 400; Joker, Monol, Naga 350; Sueki Suezo 1 (existe só para procriação). Fonte única; ordem de grandeza: 350 a 600 semanas (aproximadamente 7 a 12 anos de 4x12 semanas).
- [NV] C3 diz que a maioria das espécies é "pensada para viver até os 5 anos", algumas até 7 e raras acima de 10. Isso é incompatível com a tabela de C2 se um ano tem 48 semanas (350 a 600 semanas = 7 a 12 anos). Provável discordância de versão ou de definição; tratar ambos como não confirmados.
- [NV] Os valores são o máximo: valem para um monstro que só descansa; treino, batalha e estresse consomem vida adicional (C2).
- [NV] Espécie híbrida: vida = 60% da espécie principal + 40% da secundária. Exemplos de C1 (versão DX): Naga/Plant 330 e Plant/Naga 370, dado Naga 250 e Plant 450. A conta fecha (0,6x250+0,4x450 = 330). Regra geral: puras vivem mais; há exceções (Joker, Ducken). Fonte única.
- [NV] Espécies de vida curta tendem a ter ganhos de atributo maiores e vice-versa, "não é regra rígida" (C1).

### 1.3 Fases de idade

- [NV] 10 fases: Infant, Childhood, Adolescence 1, Adolescence 2, Prime, Sub-Prime, Elder 1, Elder 2, Old Age, Twilight (C1).
- [NV] A duração de cada fase é uma porcentagem da vida total, segundo o "life type" definido pela espécie secundária. Tabelas de C1 (por fase, na ordem acima):
  - Normal: 10, 10, 15, 15, 10, 5, 10, 5, 5, 15 (%)
  - Precocious: 5, 5, 10, 10, 5, 5, 15, 15, 10, 20
  - Late Bloom: 15, 15, 15, 15, 10, 10, 5, 5, 5, 5
  - Sustainable: 5, 5, 10, 10, 10, 5, 15, 15, 10, 15
  Exemplo: vida 400 e fase de 10% dura 40 semanas.
- [NV] O jogo avisa quando o monstro chega ao auge, com uma mensagem do assistente ("a partir de agora é um momento importante"). Só C1 cita; não está em P1 nem P2.
- [NV] Fora esse aviso, o jogo não mostra a fase atual; jogadores usam ferramentas externas (C1).

### 1.4 Efeito da idade nos atributos

- [NV] A idade não reduz atributos já ganhos; ela só muda quanto cada treino ou andança rende (C1: "Monsters do not lose stats as they grow older").
- [NV] Ganho cresce até o auge e cai depois. C1 dá: em Infant e Twilight, um ganho nível 5 rende cerca de 5 pontos num treino leve e 8 num pesado; em Prime/Sub-Prime, cerca de 15 e 20. Childhood e Old Age ficam no mesmo patamar uns dos outros (C1).
- [V] P1 p.13: o monstro de 0 anos "às vezes é teimoso e não segue instruções" mas "será forte se criado com amor". Qualitativo e não detalha idade.

### 1.5 Morte

- [V] Por velhice: ao fim da vida (P2 `2500.html`).
- [V] Por maus-tratos de rotina: sem descanso o monstro pode ficar "mau por estresse em excesso ou, no pior caso, morrer" (P1 p.13). Fadiga acumulada pode levar a doença e, no pior caso, morte (P2 `2200.html`, Rest).
- [V] Em batalha: "pode morrer ao perder uma batalha com fadiga pesada, ou ao receber dano demais"; às vezes é melhor desistir (P2 `2500.html`). P1 p.21: quando nocauteado (KO) o monstro pode se ferir ou, pior, morrer; a chance sobe quando está cansado ou luta contra um monstro forte. P2 `3300.html`: KO é mais provável quando a diferença de força é grande.
- [V] P1 p.14: quando a barra de vida (Lif) chega a 0 na batalha, o monstro "pode morrer".
- [V] Congelar: o monstro pode ser congelado no Lab, e só monstros congelados servem em modos de versus (P1 p.9, p.24; P2 `2100.html`, até 20 congelados no DX). O manual não diz que congelar pausa o envelhecimento.
- [NV] Congelar preserva a vida restante (C1; fonte secundária citando o jogo). Casa com o termo "Congelar" do `CONTEXT.md`.

### 1.6 Consumo de vida por estresse e fadiga

- [V] P2 `2400.html`: estresse "afeta muito" a vida. P1 p.15: estilo de criação rígido tende a encurtar a vida, mimo a alonga.
- [NV] Índice de vida ("Lifespan Index") = (Estresse x 2) + Fadiga, calculado toda semana; se atingir faixa, perde-se vida extra além da 1 semana normal (C1, tabela completa):

  | Índice | Semanas extras perdidas |
  |--------|------------------------|
  | 0 a 69 | 0 |
  | 70 a 104 | 1 |
  | 105 a 139 | 2 |
  | 140 a 174 | 3 |
  | 175 a 209 | 4 |
  | 210 a 244 | 5 |
  | 245 a 269 | 6 |
  | 270 a 300 | 7 |

  Resumo de busca de C4 concorda com as três primeiras faixas (70/105/140 com 1/2/3 semanas). Duas fontes de comunidade; ainda [NV].
- [NV] Estresse e fadiga são ocultos; só há avisos qualitativos do assistente no início da semana (C1; C3; P2 `2400.html` confirma o aviso semanal: "At the beginning of each week, you will learn about your monster's stress levels from Colt" [V]).

## 2. Doenças e lesões

### 2.1 Causas e tipos

- [V] Lesão (injury): se o monstro perde por KO em torneio, há chance de ficar ferido; cobra-se taxa médica (P2 `2500.html`; P1 p.16 "Injury/Sickness"; p.21).
- [V] Doença (sickness): quando a fadiga se acumula o monstro pode adoecer; cobra-se taxa médica (P2 `2500.html`). P1 p.16: "O monstro se fere ou adoece facilmente quando está cansado" e fica no descanso até melhorar.
- [V] Enquanto ferido, doente, fugido ou perdido, não se pode continuar o treino (P2 `2500.html`).
- [V] Outros eventos que custam dinheiro: fuga (por rigidez excessiva em treinos e andanças; custa busca e conserto do galpão) e perder-se numa andança/aventura (Int alta reduz a chance) (P2 `2500.html`). P1 p.16: o monstro foge se acumula estresse demais, sobretudo os "desonestos".
- [V] Contadores na tela de dados: nº de fugas, doenças, lesões e rebeliões (P1 p.14; P2 `2300.html`) e um parâmetro de "saúde geral" (RESISTANCE) (P1 p.14, p.15).
- [V] Fadiga também empurra a natureza para Bad/Worst (P2 `2200.html`).
- [NV] Não há lista de tipos de doença nem de lesão nas fontes primárias que li. Fontes de comunidade que consultei não os descrevem. Lacuna.

### 2.2 Chances e limiares

- [NV] Lesão em andança falha: chance (%) = INT((fadiga - 50) / 2), mínimo 0; tempo parado por lesão: 3 dias se fadiga >= 90, 2 se >= 70, 1 se < 70 (fórmula de planilha de fãs do LegendCup, vista só em resumo de busca, C4). Não confirmei na fonte; "dias" não bate com um jogo de semanas, desconfiar.
- [NV] Fórmula de chance de doença por fadiga: não encontrei. Lacuna.

### 2.3 Tratamento e custo

- [V] Tratamento: o monstro fica em repouso até melhorar; taxa médica é cobrada (P2 `2500.html`; P1 p.16). Valor da taxa: não consta em P1/P2.
- [NV] Custos de comunidade: não encontrei valores confiáveis. Lacuna.

### 2.4 Prevenção

- [V] Descanso reduz fadiga (P2 `2200.html`); descanso e brincar reduzem estresse; Mint Leaf reduz estresse (P2 `2400.html`, `2600.html`: brincar após o treino, quando o monstro pede, reduz estresse e fadiga).
- [NV] Itens de comunidade (C1): Nuts Oil reduz fadiga; Mint Leaf reduz estresse; Gemini Pot tira 1 de estresse por pote no início do mês; Artemis Statue tira 1 de fadiga por estátua. Peixe e Cup Jelly (se o monstro gosta) e Tablets (comprimidos mensais) servem de comida anti-estresse. Comida gostada, neutra ou desgostada altera estresse (tabela em C1).

## 3. Treino e semana

### 3.1 Ações por semana

- [V] Comandos do rancho: Treinar, Descansar, Batalha, Item, Arquivo, Cidade (P1 p.12). Treinar divide-se em Drill (exercício) e Errantry (andança) (P1 p.13; P2 `2200.html`). P2 DX acrescenta brincar (play) quando o monstro pede, após treino.
- [V] Drill dura uma semana; Errantry dura um mês (P1 p.13: "for a period of one month"; P2: "1 month"). Errantry custa dinheiro (P1 p.13) e não pode ser feita com atributos baixos em certos locais (P1 p.13).
- [NV] Depois de escolher uma ação a semana avança; um item por semana; uma comida por mês (C1).
- [NV] Preços: Errantry 2000G (1000G em mês de oferta); método inicial barato custa 4200G/ano; começa-se com 5000G (C1). Uma ação por semana, portanto o ciclo básico é 4 ações por mês.
- [V] O jogo termina se o dinheiro chega a 0 (P1 p.11; P2 `2200.html`).

### 3.2 Ganho de atributos

- [V] Seis atributos: Lif, Pow, Def, Ski, Spd, Int; mais Fame (P1 p.14; P2 `2300.html`). Efeito de cada um: Lif = vida em batalha; Pow = dano de golpes físicos e redução do dano recebido deles; Int = dano e defesa contra técnicas de Int; Ski = acurácia; Spd = esquiva; Def = redução de dano (P2 `2300.html`). Fame 0 a 100, sobe vencendo torneios fortes e aumenta crítico (P1 p.14; P2).
- [V] Ganho depende do tipo de treino e do local da andança (P1 p.13). Atributos podem subir ou cair no treino: "pode também causar queda em alguns atributos" (P2 `2200.html`).
- [V] Resultado de drill: 5 resultados possíveis (Great Success, Success, Success?, Failure, Slacking); a natureza influencia (P2 `2200.html`).
- [NV] 6 drills leves (um por atributo) e 4 pesados (sobem muito um atributo e baixam outro; ex.: Pull sobe Pow e baixa Spd). Cada espécie tem um nível de ganho 1 a 5 por atributo (C1).
- [NV] Soma de atributos: não achei teto no MR2; fontes falam em 999 por atributo (C1). O `CONTEXT.md` do projeto já diverge de propósito (soma base limitada).

### 3.3 Fadiga e estresse por ação

- [V] Drills aumentam fadiga (P2 `2200.html`); andanças acumulam "muita fadiga" (P2); aventuras acumulam "muita fadiga" (P2 `2500.html`); estresse acumula em drills, andanças, torneios e aventuras (P2 `2400.html`).
- [NV] Números de C3 (jogo PS1): drill leve +10 fadiga, +5 estresse; drill pesado +15, +12; andança (por semana) +18, +7; expedição +70 fadiga; descanso -33 a -47 fadiga, -5 a -10 estresse; vitória em torneio +37 fadiga, -75 estresse; derrota em torneio +50, -62; ir mal no torneio +62, -50. Fonte única, sem origem citada.
- [NV] Divergência: C1 lista estresse por drills, andanças, repreensão, recusar pedidos e promessas quebradas; C3 mostra torneios reduzindo estresse; P2 diz que torneios acumulam estresse. Conflito aberto.
- [NV] Custo de vida de eventos (C1): cada andança perde no mínimo 7 semanas de vida (4 + 3 extras do índice); se o monstro leva KO do monstro selvagem final, mais 6 (total 13); cada torneio custa no mínimo 4 semanas.
- [NV] Métodos de criação de comunidade (C1) usam ciclos de 4 semanas (drills leves, uma semana de descanso, itens redutores) para manter o índice abaixo de 70.

### 3.4 Lealdade e obediência

- [V] Lealdade vai de 0 a 100 e é mostrada no rancho; quanto maior, mais obediente (P1 p.15; P2 `2400.html`).
- [V] Estilo de criação: 7 estados, de Doting (mimado) a Spartan (espartano), Doting > Fond > Soft > Even > Strict > Harsh > Spartan. Mais gentil: vive mais, drills falham mais; mais duro: trabalha mais forte, vive menos (P2 `2400.html`; P1 p.15 diz o mesmo em termos gerais).
- [V] Lealdade sobe elogiando e com certos itens (P2 `2400.html`). Lealdade alta faz o monstro se esforçar mais em treino e andança; lealdade baixa deixa-o confuso em batalha (P2 `2400.html`, `3300.html`).
- [V] Natureza (Nature): Best > Good > Neutral > Bad > Worst; muda conforme o tratamento; afeta treino (Best tem mais sucesso; Bad tende a relaxar), batalha e técnicas aprendíveis (P2 `2400.html`; P1 p.21 "Good/Bad Monster").
- [NV] Lealdade = Medo + Mimo, cada um de 0 a 50 (ocultos). Repreender sobe medo e estresse e baixa mimo; elogiar um drill ótimo sobe mimo (C1). Estilo é a diferença Mimo - Medo (faixas de cerca de 20, 50 e 80) (C1).
- [NV] Chance de "foolery" em batalha por lealdade (C1): cerca de 25% com lealdade 30, 12% com 50 e 0% com 90 ou mais.

## 4. Batalha

### 4.1 Como o monstro escolhe o que faz

- [V] A batalha é automática ou guiada: antes de lutar o treinador pode ou não dar instruções (P1 p.18: "may or may not wish to give your Monster instructions"). Se não instruir, o monstro age sozinho; no manual DX, instruir e controlar diretamente "libera o potencial", salvo adversário muito fraco (P2 `3100.html`). Isto difere do `CONTEXT.md` ("o treinador não dá comandos durante a luta"): no MR2 o jogador pode dar comandos.
- [V] Técnicas dependem da distância: só se usa a técnica quando o oponente está no alcance dela (P2 `3100.html`, `3300.html`; P1 p.19 "Distance gauge"). Cada técnica tem custo de Fôlego e chance de acerto exibida (P1 p.19; P2 `3200.html`). Push/"Blow Back" afasta o oponente (P1 p.20).
- [NV] Alcances: 4 faixas de distância na tela; técnicas de tipos como Hit, Heavy, Sharp, Withering (esvazia Fôlego do alvo) e Special (C1).
- [NV] Regra da IA no original: só ataca com mais de 45 de Fôlego; teria sido removida no DX (C1). Fonte única, sobre a IA adversária.
- [V] Estados especiais: monstro acuado pode entrar em "Fury" e dar mais dano; quanto melhor a natureza, mais provável (P2 `3300.html`). Natureza Best pode reverter a luta e até contra-nocautear; Worst fica irado quando atacado e tem crítico maior (P2 `2400.html`; P1 p.21).
- [V] Lealdade baixa causa "foolery"/confusão: o monstro ignora comandos por instantes e fica mais fácil de acertar (P1 p.20; P2 `3300.html`).

### 4.2 Papel do fôlego (Guts)

- [V] Fôlego é gasto para usar técnicas; cada técnica tem custo fixo; sem fôlego suficiente não se usa a técnica (P1 p.20). Diminui também ao ser atingido (P1 p.20; P2 `3200.html`).
- [V] Toda luta começa com 50 de fôlego e ele sobe durante a luta (P2 `3200.html`).
- [V] Quanto mais fôlego, maior a chance de acerto (P2 `3200.html`, `3300.html`). Recomenda-se acumular fôlego e esperar a hora de atacar (P1 p.20; P2 `3300.html`).
- [NV] Teto de 99 de fôlego; velocidade de regeneração por espécie (quadros por ponto: de 6 em Metalner a 19 em Dragon); mais fôlego também aumenta dano causado, reduz dano recebido e melhora esquiva ("Guts Correction"). Há penalidade para quem regenera mais rápido que o oponente (C1). Fonte única.

### 4.3 Vitória e derrota

- [V] Perde quem zera a barra de vida; se o tempo acaba, ganha quem tem mais vida (barra mais cheia) (P1 p.19; P2 `3200.html`).
- [V] Derrota por KO pode causar lesão ou morte (ver 1.5 e 2.1). Pode-se desistir da luta (SELECT) (P1 p.5, p.21).
- [NV] Duração: 60 segundos; vida volta ao máximo após cada luta do torneio (C1).
- [V] Em torneio de pontos corridos, "Withdraw" abandona só a luta atual; em torneio regular conta como abandono do torneio (P1 p.18; P2 `3100.html` diz que em torneio oficial desistir encerra a participação). "Drop Out" sai do torneio e não dá prêmio (P1 p.18; P2).
- [NV] Formato mais comum: todos contra todos, vence quem tiver mais vitórias, desempate por luta extra (C1).

### 4.4 Ranks e torneios

- [V] Ranks: E, D, C, B, A, S, mais F (aberto a todos) (P1 p.18; P2 `3100.html`). Monstro novo só entra em E e D (P1 p.18). Vencer o torneio oficial do rank sobe o rank do monstro (P2). O que cada rank libera: E -> D-F; D -> C-F; C -> B-F; B -> A-F; A -> S-F; S -> todos, inclusive os "Major 4" (P2 `3100.html`).
- [V] Vencer os quatro grandes do rank S dá o título "The Master Trainer" (P1 p.18; P2: "Major 4").
- [V] Torneios oficiais ocorrem em março, junho, setembro e dezembro (P2 `3100.html`).
- [V] Vencer dá dinheiro e fama; sem inscrição, sem prêmio ao abandonar (P1 p.18). Fame aumenta chance de crítico (P2 `2300.html`).
- [NV] Torneios ocorrem numa semana e mês fixos por ano; os oficiais a cada 3 meses (C1). Rank F tem adversários de nível B a A (C1). Vencer rank já superado reduz Fame (C1). Cada crédito de Fame dá +0,1% de crítico, até 10% (C1). Prêmios típicos: 1000G em E, 2000G em D (C1).
- [NV] Participar custa pelo menos 4 semanas de vida (C1) e é gratuito em dinheiro.

## Divergências de versão e conflitos

1. **Disco original vs. relançamento.** P1 é o disco NTSC-U de 1999. P2 é o manual do "1 & 2 DX" (Switch/Steam). C1 e C2 afirmam que o DX parte da versão japonesa (Monster Farm 2) com 100 semanas a menos de vida que a versão NTSC-U. Isso explica por que a tabela de C2 (Naga 350) e o exemplo de C1 (Naga 250) diferem [INF: C2 = NTSC-U, C1 = DX]. C2 diz que não sabe qual versão o DX usa.
2. **Estresse em torneios**: P2 diz que acumula; C3 mostra queda grande de estresse em torneios. Não resolvido.
3. **Vida em anos**: C3 (5 a 7 anos) vs. tabela de C2 (350 a 600 semanas). Não resolvido.
4. **Comando em batalha**: no MR2 o treinador pode orientar o monstro (P1, P2); o `CONTEXT.md` define batalha sem comandos. É decisão de design do projeto, não achado de pesquisa.

## Lacunas (nada primário encontrado)

- Tabela oficial de vida por espécie e regras exatas de consumo.
- Tipos de doença e de lesão, probabilidades, duração do repouso e valor da taxa médica.
- Fórmula de dano, acerto e esquiva da batalha; lógica de decisão da IA.
- Páginas 25 e 26 do manual PS1 ("General Tips") não estão no scan.
- Material do desenvolvedor (código, entrevistas). Não achei acessível.
- C4 (LegendCup) bloqueou meu acesso; vale ler direto para validar números ([NV]) se o dono quiser mais rigor.

## Resumo comparável (para os tickets de design)

| Tema | Regra do MR2 | Confiança |
|------|--------------|-----------|
| Unidade de tempo | Semana; 4 por mês; ação de treino por semana; comida por mês | [V] semana/mês; [NV] números |
| Vida | Contador em semanas, espécie define; estresse e fadiga queimam mais | [V] existe e é afetado; [NV] números |
| Fases | 10 fases, % da vida por tipo de ciclo; ganho de treino cai com a idade, atributos não caem | [NV] |
| Morte | Velhice, doença/estresse/fadiga sem descanso, KO em batalha com fadiga | [V] |
| Doença | Surge com fadiga; repouso obrigatório; taxa médica | [V] regra; lacuna em números |
| Lesão | Surge após KO; repouso; taxa médica | [V] regra; lacuna em números |
| Treino | Drill (semana) e andança (mês, paga); ganho por espécie e idade; falhas por natureza | [V] regra; [NV] números |
| Lealdade | 0 a 100; estilo gentil/duro troca vida longa por ganho menor | [V] |
| Fôlego | Recurso de batalha: gasta, regenera, sobe acerto | [V] papel; [NV] números |
| Vitória | Zerar a vida do outro ou ter mais vida no fim do tempo | [V] |
| Ranks | E a S (+F aberto); vencer o oficial sobe de rank; S abre os Major 4 | [V] |
