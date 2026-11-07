# Atributos de estado

Variáveis que mudam durante a vida do monstro e afetam o resultado de treinos e batalhas. Não são [[Stats]]. Parte de [[Visão geral]].

## Decidido

Esta versão tem **3 atributos de estado**. Outro atributo só entra com uma nova decisão.

| Atributo | Situação |
|---|---|
| **Fadiga** | Definida em [[Treino semanal]]. |
| **Estresse** | Definido abaixo. |
| **Obediência** | Em aberto. É um atributo próprio. Os aspectos só a modificam. Ver [[Batalha]]. |

Os aspectos de [[Personalidade]] mudam como esses atributos sobem e descem.

*Mudança (ticket "Satisfação"):* antes eram 4 atributos. A **satisfação** saiu desta versão. Sem regras próprias, ela seria o estresse invertido. As alternativas (variedade de treino ou gostos do monstro) trazem mais um valor para controlar, e o ciclo completo funciona sem ele. Se o protótipo jogável mostrar que uma rotina serve para todos os monstros (ver [[Treino semanal]]), os gostos do monstro voltam como nova decisão.

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
- **No torneio:** cada luta conta, mas o jogo aplica a soma só no fim do torneio. As 3 lutas usam o mesmo estresse inicial. O resultado vai de −30 (3 vitórias) a +45 (3 derrotas), antes dos aspectos. Ver [[Batalha]], seção "Torneio".
- **Efeito do estresse alto: só reduz a [[Batalha|obediência]].** Não muda o treino (a fadiga já faz isso) nem dano ou acerto. Quanto reduz, e a partir de qual valor, fica na decisão de obediência.
- Em 100 não há efeito extra: sem doença e sem recusa de treino.

**Por quê:** dois ponteiros com ritmos diferentes dão ao jogador uma segunda decisão (descansar mesmo sem fadiga alta). Limitar o efeito à obediência evita um segundo sistema igual à fadiga e liga o custo do excesso de treino à parte da luta que é do monstro. Derrota pesa mais que vitória para criar o ciclo "perdeu, estressou, desobedece, perde" que o descanso desfaz.

**Por quê aplicar no fim do torneio:** o estresse é pressão lenta. Uma sequência de derrotas fica entre torneios, não dentro de um torneio. O jogador ainda paga por inscrever um monstro fraco: +45 pede cerca de 5 semanas de descanso.

**Fora de escopo:** doença, frustração, recusa de treino por estresse, efeito do estresse no ganho do treino.

**Depende de outras decisões:** quanto o estresse reduz a obediência (ticket de estratégia e obediência).

## Em aberto

- Como a obediência muda durante a vida do monstro, o que a faz subir e como decide se ele segue a estratégia.
