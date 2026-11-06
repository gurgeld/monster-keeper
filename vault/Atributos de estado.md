# Atributos de estado

Variáveis que mudam durante a vida do monstro e afetam o resultado de treinos e batalhas. Não são [[Stats]]. Parte de [[Visão geral]].

## Decidido

Esta versão tem **4 atributos de estado**. Outro atributo só entra com uma nova decisão.

| Atributo | Situação |
|---|---|
| **Fadiga** | Definida em [[Treino semanal]]. |
| **Estresse** | Definido abaixo. |
| **Satisfação** | Em aberto. |
| **Obediência** | Em aberto. É um atributo próprio. Os aspectos só a modificam. Ver [[Batalha]]. |

Os aspectos de [[Personalidade]] mudam como esses atributos sobem e descem.

**Por quê uma lista fechada:** cada atributo precisa de regras para subir e descer e de um efeito no jogo.

**Por quê "atributo de estado" e não "estado mental":** a fadiga também é física.

## Estresse

Decidido no mapa de design (ticket "Estresse"). Números iniciais, para ajustar no balanceamento.

- Vai de **0 a 100**. O monstro nasce com 0 e não herda nada dos pais. Fica preso entre 0 e 100.
- É a **pressão acumulada**: sobe e desce devagar. A [[Treino semanal|fadiga]] é o cansaço desta semana; o estresse é o que o jogador pagou nas últimas semanas.
- **O que muda o estresse:**

| Evento | Mudança |
|---|---|
| Treinar com fadiga **antes do treino** de 60 ou mais | +10 |
| Treinar com fadiga abaixo de 60 | 0 |
| Descansar | −10 |
| Perder uma luta | +15 |
| Ganhar uma luta | −10 |

- **Aspectos:** o aspecto muda a velocidade de **cada** mudança, de qualquer fonte (treino, descanso, derrota, vitória). A mudança é multiplicada por (1 + soma dos efeitos), como no treino. Ver [[Personalidade]].

| Aspecto | Efeito no que sobe | Efeito no que desce |
|---|---|---|
| Calmo | −50% | nenhum |
| Ansioso | +50% | nenhum |
| Sensível | +50% | +50% |

  O resultado é arredondado ao inteiro mais próximo (0,5 sobe). Ex.: Calmo perde uma luta: +8. Sensível perde: +23.
- **Efeito do estresse alto: só reduz a [[Batalha|obediência]].** Não muda o treino (a fadiga já faz isso) nem dano ou acerto. Quanto reduz, e a partir de qual valor, fica na decisão de obediência.
- Em 100 não há efeito extra: sem doença e sem recusa de treino.

**Por quê:** dois ponteiros com ritmos diferentes dão ao jogador uma segunda decisão (descansar mesmo sem fadiga alta). Limitar o efeito à obediência evita um segundo sistema igual à fadiga e liga o custo do excesso de treino à parte da luta que é do monstro. Derrota pesa mais que vitória para criar o ciclo "perdeu, estressou, desobedece, perde" que o descanso desfaz.

**Fora de escopo:** doença, frustração, recusa de treino por estresse, efeito do estresse no ganho do treino.

**Depende de outras decisões:** se a luta usa a ação da semana (ticket de torneio); quanto o estresse reduz a obediência (ticket de estratégia e obediência).

## Em aberto

- Como a satisfação sobe e desce, e o que faz. Ela é diferente do estresse e não é a frustração, que está fora de escopo.
- Como a obediência muda durante a vida do monstro, e como decide se ele segue a estratégia.
