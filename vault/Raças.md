# Raças

Parte de [[Visão geral]]. O ovo define a raça (ver [[Ovo]]).

## Decidido

- Tema visual: **animais fantásticos**.
- Primeiro protótipo: 3 raças, cada uma com um arquétipo claro.
- Cada raça tem um **conjunto de habilidades** de batalha. As habilidades de cada raça escalam mais com um stat do que com outro (ex.: uma raça usa Força como modificador; outra, Velocidade). Ver [[Batalha]].

| Raça | Animal | Arquétipo | Stats fortes |
|---|---|---|---|
| **Tatuço** | Tatu blindado: placas de metal, se enrola como bola | Tanque | Vida, Defesa |
| **Vulpi** | Raposa do vento: cauda dupla, se move como rajada de ar | Ágil | Velocidade, Precisão |
| **Runoxa** | Coruja de olhos rúnicos: olhos brilham com símbolos | Místico | Inteligência |

### Tipos de dano (proposta inicial)

Regras em [[Batalha]]. Cada raça tem 1 fraqueza, 1 resistência e 1 neutro. Formam um ciclo.

| Raça | Resiste (×0,5) | Neutro (×1,0) | Fraco (×1,5) |
|---|---|---|---|
| Tatuço | cortante | perfurante | impactante |
| Vulpi | impactante | cortante | perfurante |
| Runoxa | perfurante | impactante | cortante |

### Tipo principal e tipo secundário

Decidido no mapa de design (ticket "Habilidades das raças"). Cada raça usa só 2 tipos de dano:

| Raça | Tipo principal | Tipo secundário | Tipo que não usa |
|---|---|---|---|
| Tatuço | cortante | impactante | perfurante |
| Vulpi | impactante | perfurante | cortante |
| Runoxa | perfurante | cortante | impactante |

- O **tipo secundário** é a fraqueza da própria raça.
- A raça não usa o tipo que causa ×1,5 na raça que a vence.

**Por quê:** esta regra cria o ciclo Tatuço > Runoxa > Vulpi > Tatuço. Com os 3 tipos em toda raça, todas exploram a mesma fraqueza. O tipo secundário causa ×1,5 no espelho (mesma raça dos dois lados), que é comum porque 2 dos 3 oponentes são da raça predominante.

### Habilidades

Decidido no mapa de design (ticket "Habilidades das raças"). Os números vêm do ticket "Balanceamento numérico da batalha" e são iniciais.

Cada raça tem 4 habilidades, com a mesma estrutura de 4 posições:

| Posição | Tipo de dano | Stat de escala | Espera | Peso | Potência |
|---|---|---|---|---|---|
| 1. Básica | principal | stat da raça | 0 | 1 | 36 (Tatuço: 48) |
| 2. Forte | principal | stat forte da raça | 1 | 3 | 50 (Tatuço: 35) |
| 3. Cobertura | secundário | Força | 1 | 3 | 80 |
| 4. Precisa | principal | Precisão | 2 | 2 | 60 |

*Mudança (ticket "Balanceamento numérico da batalha"):* antes, a potência era 30 (Tatuço: 40), 45, 55 e 60, e as esperas eram 0, 2, 3 e 4.

**Por quê a Cobertura é forte:** no espelho, ela é o único golpe que não é resistido, e causa ×1,5. Contra outra raça, ela é neutra ou resistida. Com potência maior e espera menor, ela encurta principalmente o espelho.

**Por quê a Forte do Tatuço fica abaixo da básica:** ela escala com a Defesa, que é muito alta nessa raça.

| Raça | 1. Básica | 2. Forte | 3. Cobertura | 4. Precisa |
|---|---|---|---|---|
| Tatuço | Garrada (Força) | Rolo blindado (Defesa) | Cabeçada | Lâmina de placa |
| Vulpi | Rajada (Velocidade) | Vendaval (Velocidade) | Mordida | Ciclone certeiro |
| Runoxa | Dardo rúnico (Inteligência) | Lança de runas (Inteligência) | Garra de coruja | Olhar rúnico |

**Por quê 4 habilidades e estes pesos:** com 3 habilidades e pesos 5/3/2, a básica ficou em 71% a 74% das ações contra outra raça. Com a lista atual, ela fica em 10% a 38% das ações com 50 e 100 semanas de treino (ver [[Batalha]], seção "Números da luta"). Com 15 semanas, sobe para 51% a 72%, porque quase nada está liberado. A meta é ficar abaixo de 50% no monstro com todas as habilidades liberadas.

**Por quê a Cobertura usa Força:** a Força fica média em todas as raças, e assim tem uso em todas.

**Por quê a posição 4 usa Precisão:** em um espelho com 30% a mais de Precisão, as vitórias subiram de 65% a 67% para 70% a 84%. Um campo de "acerto próprio", com golpe forte que erra mais, não mudou esse valor (60% a 68%) e foi descartado.

**Por quê a Inteligência não escala em Tatuço e Vulpi:** isso enfraqueceria o arquétipo Místico da Runoxa. Nessas raças, a Inteligência age na escolha da habilidade e na obediência. Reavaliado com a fórmula de obediência: não recebe outros efeitos agora. Ver o risco em [[Atributos de estado]], seção "Obediência".

### Habilidade liberada

- O monstro nasce com a básica. As outras são liberadas quando o stat chega a um **mínimo fixo por raça**. Não há tela nem treino próprio para isso.
- Depois de liberada, a habilidade **não se perde**, mesmo se o stat cair na velhice.
- Os oponentes gerados recebem as habilidades da mesma forma, pelos próprios stats.
- A tela mostra as 4 habilidades, com tipo de dano e stat. As bloqueadas mostram o mínimo. Peso e potência ficam escondidos. O jogo avisa quando uma habilidade é liberada.

| Posição | Stat | Treinos desde a base | Tatuço | Vulpi | Runoxa |
|---|---|---|---|---|---|
| 2. Forte | stat de escala | cerca de 5 | Defesa 155 | Velocidade 145 | Inteligência 155 |
| 3. Cobertura | Força | cerca de 1 a 2 | Força 60 | Força 60 | Força 35 |
| 4. Precisa | Precisão | cerca de 10 | Precisão 120 | Precisão 200 | Precisão 185 |

Os mínimos usam a taxa de ganho da raça e o ganho de 10 × taxa por treino (ver [[Treino semanal]]), para que o esforço seja igual em toda raça.

*Mudança (ticket "Balanceamento numérico da batalha"):* antes, a Cobertura pedia cerca de 5 treinos (Força 100, 100 e 60). Sem ela, todo golpe do espelho é resistido, e o espelho do Tatuço passava de 120 ações no Regional.

**Por quê desbloqueio por stat:** mostra progresso na luta, dá um objetivo de treino e não cria uma regra nova na rotina.

**Por quê a habilidade não se perde:** perder golpes pioraria a fase velha sem criar uma decisão para o jogador.

## Proposta inicial de números (ajustar em teste)

### Taxa de ganho base

Escala e letras em [[Stats]]. Regra de balanceamento: **a soma das 6 taxas é 6,0 em todas as raças**. Nenhuma raça é melhor no total; só muda onde ela é forte.

| Raça | Vida | Força | Intel. | Precisão | Veloc. | Defesa |
|---|---|---|---|---|---|---|
| Tatuço | 1,4 (A) | 1,0 (C) | 0,7 (D) | 0,8 (D) | 0,7 (D) | 1,4 (A) |
| Vulpi | 0,8 (D) | 1,0 (C) | 0,9 (C) | 1,3 (A) | 1,4 (A) | 0,6 (E) |
| Runoxa | 0,8 (D) | 0,7 (D) | 1,4 (A) | 1,2 (B) | 1,0 (C) | 0,9 (C) |

### Stats iniciais base

Regra: **a soma dos stats iniciais é 300 em todas as raças**.

| Raça | Vida | Força | Intel. | Precisão | Veloc. | Defesa |
|---|---|---|---|---|---|---|
| Tatuço | 80 | 50 | 20 | 40 | 25 | 85 |
| Vulpi | 45 | 50 | 40 | 70 | 75 | 20 |
| Runoxa | 40 | 25 | 85 | 65 | 50 | 35 |

## Em aberto

- Força fica média em todas as raças. Uma 4ª raça futura pode ser a "bruta" (Força alta).
- A regra de soma igual é provisória. Talvez uma raça mais difícil de achar mereça soma maior.
