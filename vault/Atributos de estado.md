# Atributos de estado

Variáveis que mudam durante a vida do monstro e afetam o resultado de treinos e batalhas. Não são [[Stats]]. Parte de [[Visão geral]].

## Decidido

Esta versão tem **3 atributos de estado**. Outro atributo só entra com uma nova decisão.

| Atributo | Situação |
|---|---|
| **Fadiga** | Definida em [[Treino semanal]]. |
| **Estresse** | Definido abaixo. |
| **Obediência** | Definida abaixo. É calculada na hora, sem valor guardado. |

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
- **Efeito do estresse: só reduz a obediência.** Não muda o treino (a fadiga já faz isso) nem dano ou acerto. Ver a seção "Obediência".
- Em 100 não há efeito extra: sem doença e sem recusa de treino.

**Por quê:** dois ponteiros com ritmos diferentes dão ao jogador uma segunda decisão (descansar mesmo sem fadiga alta). Limitar o efeito à obediência evita um segundo sistema igual à fadiga e liga o custo do excesso de treino à parte da luta que é do monstro. Derrota pesa mais que vitória para criar o ciclo "perdeu, estressou, desobedece, perde" que o descanso desfaz.

**Por quê aplicar no fim do torneio:** o estresse é pressão lenta. Uma sequência de derrotas fica entre torneios, não dentro de um torneio. O jogador ainda paga por inscrever um monstro fraco: +45 pede cerca de 5 semanas de descanso.

**Fora de escopo:** doença, frustração, recusa de treino por estresse, efeito do estresse no ganho do treino.

## Obediência

Decidido no mapa de design (ticket "Estratégia antes da luta e obediência"). Números iniciais, para ajustar no balanceamento. O efeito na luta está em [[Batalha]], seção "Estratégia e obediência".

O jogo calcula a obediência na hora, sem guardar o valor. O resultado vai de 0 a 100 e é arredondado.

```
Obediência = 40
           + Inteligência ÷ 5 (no máximo +40)
           − 10 se o monstro está na fase jovem
           + 15 se é Leal, − 15 se é Rebelde
           − estresse ÷ 4
           − (fadiga − 60) ÷ 2, só com fadiga acima de 60
```

- **No torneio:** as 3 lutas usam o mesmo valor, calculado com o estado inicial. Ver [[Batalha]], seção "Torneio".
- **O que o jogador vê:** o número, as partes da conta e um aviso abaixo de 50. O aviso diz que o monstro pode parar durante a luta. Exemplo: "Obediência 32: Inteligência +4, estresse −12".

Monstro no auge, sem aspecto de obediência e com fadiga até 60:

| Raça e Inteligência | Sem estresse | Estresse 50 | Estresse 100 |
|---|---|---|---|
| Tatuço, Int 20 (sem treino) | 44, pula 3% | 32, pula 9% | 19, pula 15,5% |
| Vulpi, Int 40 (sem treino) | 48, pula 1% | 36, pula 7% | 23, pula 13,5% |
| Runoxa, Int 85 (sem treino) | 57, não pula | 45, pula 2,5% | 32, pula 9% |
| Tatuço, Int 125 (com treino) | 65, não pula | 52, não pula | 40, pula 5% |
| Vulpi, Int 175 (com treino) | 75, não pula | 62, não pula | 50, não pula |
| Runoxa, Int 295 (com treino) | 80, não pula | 68, não pula | 55, não pula |

**Por quê calculada na hora:** o jogador sobe a obediência com decisões que já existem: treinar Inteligência e descansar. Um valor acumulado subiria sozinho, sem decisão do jogador, e seria mais um número para controlar.

**Por quê a fadiga entra na obediência:** o jogador vê um só número antes de lutar. A alternativa era uma chance própria de pular a ação por fadiga.

**Por quê a Inteligência pesa assim:** quem não treina Inteligência paga pelo estresse, e quem treina fica quase protegido. Isso dá uma razão para gastar semanas com esse stat.

**Risco a testar:** a Inteligência quase não muda a luta de Tatuço e Vulpi quando o monstro já obedece. Com +30% e sem estresse, as vitórias no espelho ficam em 51%. Com estresse 100, o Tatuço sobe para 60%, e o Vulpi fica em 51%. Ela não recebe outros efeitos agora. O protótipo jogável deve verificar se o jogador treina esse stat.
