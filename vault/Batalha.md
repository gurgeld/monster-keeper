# Batalha

Parte de [[Visão geral]].

## Decidido

- O jogador é o **treinador**, não o lutador. A batalha é uma simulação. O monstro decide as ações.
- O jogador só define a estratégia antes da batalha.
- Se o monstro segue a estratégia depende de **obediência, Inteligência, estresse, fadiga** e outros atributos.
- As habilidades de cada raça escalam com stats diferentes (ver [[Raças]]).

## Formato da simulação

Decidido no mapa de design (ticket "Formato da simulação de batalha").

- **Tempo em ticks.** Cada monstro tem uma barra que enche a cada tick, mais rápido com mais Velocidade. Quando a barra enche, o monstro age, e a sobra passa para a próxima ação.
  *Mudança (ticket "Balanceamento numérico da batalha"):* antes, a barra zerava. Com isso, a Velocidade agia em degraus: um ponto a mais podia não mudar nada ou dar uma ação a mais.
- **1 contra 1.** Times ficam fora desta versão.
- **Fim da luta:** Vida zero, ou limite de ticks. No limite, vence quem tem mais Vida em %. Empate exato é sorteado pela seed ([[Aleatoriedade determinística]]).
- **Vida não persiste.** Cada luta começa com Vida cheia. Não há ferimento entre lutas.

### Ações

- O monstro só usa **habilidades**. Todo golpe é uma habilidade.
- A lista de habilidades de cada raça e a regra para liberar cada uma estão em [[Raças]].
- Cada raça tem 1 **habilidade básica sem espera**. As outras têm **espera** depois do uso, contada em **ações do próprio monstro**. Assim o monstro nunca fica sem opção.
  *Mudança (protótipo de batalha):* antes, a espera era em ticks. Com ticks, o monstro rápido agia mais vezes durante a mesma espera e usava menos as habilidades fortes, e a variedade caía conforme ele treinava Velocidade.
- O monstro escolhe a habilidade por **sorteio com pesos**, pela seed. Os pesos são fixos. A Inteligência define se ele escolhe a habilidade que explora o ponto fraco do oponente.
  *Mudança (ticket "Estratégia antes da luta e obediência"):* antes, a estratégia mudava os pesos. Ver a seção "Estratégia e obediência".
- O monstro **pode pular a ação** por desobediência. A fadiga age por meio da obediência. Ver a seção "Estratégia e obediência".
- **Defesa e esquiva são passivas**: reagem ao golpe do oponente. Não existe ação "Defender".

### Papel dos stats

| Stat | Papel na luta |
|---|---|
| Vida | Pontos de vida: stat Vida + 90. |
| Força | Aumenta o dano dos golpes que escalam com ela. |
| Inteligência | Escolha da habilidade e obediência. Escala habilidades da Runoxa. |
| Precisão | Chance de acertar. Escala a 4ª habilidade de toda raça. |
| Velocidade | Frequência de ação. Entra também na esquiva. |
| Defesa | Reduz o dano recebido. |

- **Esquiva** não é stat. Vem da Velocidade do defensor contra a Precisão do atacante.
- Cada habilidade escala com um stat. O stat que a fortalece e o tipo de dano são escolhas separadas da habilidade.

### Tipos de dano

- 3 tipos: **cortante, perfurante, impactante**. Todo golpe tem 1 tipo.
- Cada raça tem 1 resistência, 1 fraqueza e 1 tipo neutro, **fixos pela raça** (sem herança). Fraco ×1,5, neutro ×1,0, resistente ×0,5.
- Valores iniciais por raça: ver [[Raças]].

**Por quê tipos de dano e não stats do alvo:** o Daniel quis fraquezas naturais que deem sentido a escolher a raça certa para cada torneio. Com 3 tipos só, o ciclo fica simples de aprender.

**Por quê perfil fixo por raça:** a genética já cuida da taxa de ganho. Um segundo sistema de herança só para resistência complicaria sem ganho claro.

**Por quê Vida não persiste:** ferimento entre lutas exigiria doença e cura, que estão fora de escopo.

**Fora de escopo:** elementos e tabela de tipos estilo Pokémon; times; ferimento persistente.

### Decisões do protótipo

Decidido no mapa de design (ticket "Protótipo de batalha simulada no terminal"). As habilidades e fórmulas do protótipo eram provisórias, então os percentuais mostram só tendências.

- **Duração:** o alvo é de **9 a 30 ações por luta**, somando os dois monstros.
  *Mudança (ticket "Balanceamento numérico da batalha"):* antes, o alvo era de 13 a 25 ações. Esse intervalo não cabe nas regras de tipo: no espelho, os golpes principais recebem ×0,5, e contra outra raça o lado favorecido causa ×1,5. Com os valores escolhidos, 10 das 18 combinações testadas ficam em 13 a 25, e todas ficam em 9 a 30.
- **Sem sistema de sorte:** o monstro mais treinado deve vencer. A surpresa vem da desobediência, não de uma rolagem extra.
- **Multiplicadores de tipo:** ficam em ×1,5 e ×0,5.

**Por quê lutas longas:** com 4 a 8 ações, um único golpe podia tirar quase toda a Vida. O jogador vê poucas lutas por torneio, então cada luta precisa ter o que acompanhar.

**Por quê sem sistema de sorte:** no teste, 10% a mais em todos os stats venceu 89% a 100% das lutas, mesmo com variação de dano de ±50%. Em 20 ações, a variação de dano se compensa. Já pular 25% das ações reduziu as vitórias a 4% a 15%. A desobediência também liga o estresse à luta.

**Por quê manter ×1,5 e ×0,5:** com pesos menores, o ciclo entre as raças se quebrou no teste, e o Tatuço passou a vencer a Runoxa e a empatar com o Vulpi. Isso tira o sentido de escolher a raça certa. O custo é que a raça errada quase sempre perde com o mesmo treino: a raça favorecida vence de 85% a 100%. Com 25% a mais em todos os stats, a raça em desvantagem vence cerca de 55% a 75% (ver "Números da luta"). O jogador vê a raça predominante no calendário e pode se preparar.

## Estratégia e obediência

Decidido no mapa de design (ticket "Estratégia antes da luta e obediência"). Os números são iniciais, para ajustar no balanceamento. A fórmula da obediência está em [[Atributos de estado]].

### Estratégia

- O jogador escolhe **1 estratégia por edição**, na inscrição, e pode mudar até o clique que passa a semana. O jogo sugere a última estratégia usada pelo monstro.
- Há 3 estratégias: **Equilibrada**, **Ataque** e **Guarda**.

| Estratégia | Efeito |
|---|---|
| Equilibrada | Nenhum. |
| Ataque | +15% de dano, −30% de Defesa. |
| Guarda | −15% de dano. A fraqueza recebida passa de ×1,5 para ×1,0. |

*Mudança (ticket "Balanceamento numérico da batalha"):* antes, a Guarda dava +40% de Defesa, e o Ataque dava +20% de dano e −40% de Defesa. Só com dano e Defesa, a melhor estratégia dependia mais da raça do próprio monstro do que do oponente.

**Por quê a Guarda age na fraqueza:** o jogador vê os tipos dos oponentes na inscrição, então a escolha usa uma informação que ele tem. Em vantagem, o Ataque é melhor. Em desvantagem, a Guarda é melhor. No espelho, depende da raça.

| Confronto (50 semanas de treino, obediência 100) | Equilibrada | Ataque | Guarda |
|---|---|---|---|
| Espelho do Tatuço | 50% | 51% | **72%** |
| Espelho do Vulpi | 49% | 56% | **65%** |
| Espelho da Runoxa | 51% | **62%** | 61% |
| Vulpi x Runoxa (desvantagem) | 9% | 17% | **22%** |
| Runoxa x Vulpi (vantagem) | 91% | **92%** | 78% |

**Limite aceito:** Tatuço x Vulpi fica em 0% e Vulpi x Tatuço fica perto de 100% com qualquer estratégia, quando o treino é igual.

**Por quê não pesos:** o teste com as 4 habilidades de [[Raças]] mostrou que os pesos quase não mudam a luta, porque a espera decide o que está pronto. Com peso ×1000, a Forte do Tatuço sobe só de 25% para 31% de uso, e as vitórias mudam no máximo cerca de 8 pontos. Com esperas menores (0/1/1/2), o foco ×3 leva a Cobertura a cerca de 50% de uso, mas as vitórias mudam no máximo 11 pontos, e na maioria dos casos bem menos. Essa opção também mudaria a decisão das habilidades.

**Por quê 1 estratégia por edição:** a decisão é preparar o monstro para a raça predominante e aceitar o risco do terceiro oponente.

**Fora desta versão:** estratégias de Velocidade e Precisão. As 3 estratégias já criam a decisão. A revisão ficou para o balanceamento, porque antes a Velocidade dominava a luta. Agora ela não domina, e mesmo assim essas estratégias não são necessárias.

### O que acontece a cada ação

O jogo verifica a obediência quando chega a vez do monstro, pela seed ([[Aleatoriedade determinística]]):

1. **Segue a estratégia?** A chance em % é igual à obediência. O resultado vale até a próxima ação do monstro. Se ele ignora a estratégia, usa os valores normais nesse período, sem bônus e sem penalidade.
2. **Pula a ação?** Só acontece com obediência abaixo de 50. A chance em % é (50 − obediência) ÷ 2, com máximo de 25%.

- **Ação pulada conta para a espera,** porque continua a ser uma vez do monstro.
- O registro da luta mostra as 2 formas de desobediência: "ignora a estratégia" e "ignora a ordem e não faz nada".

**Por quê 2 níveis:** ignorar a estratégia custa pouco (muda as vitórias em no máximo 9 pontos). Pular custa muito: em um espelho, pular 10% das ações leva a 31% a 39% de vitórias, e pular 25% leva a 14% a 26%. Só pular castigaria demais a obediência média. Só ignorar deixaria a obediência quase sem efeito.

**Por quê a ação pulada conta para a espera:** o monstro já perde a ação. Atrasar também as habilidades dobraria o castigo.

### Oponentes

- Os oponentes **não têm obediência**. Sempre usam a Equilibrada e nunca pulam ações.
- Na inscrição, o jogador vê a **raça e os tipos de dano dos 3 oponentes**, e a faixa de stats do nível. Os stats de cada oponente ficam escondidos.

**Por quê sem obediência:** o jogador não veria esses valores, então eles só dariam variação sem explicação. A dificuldade vem da faixa de stats do nível.

**Por quê mostrar os tipos:** o tipo é fixo por raça. Esconder só obrigaria o jogador a decorar uma tabela.

**Por quê esconder os stats:** com os stats visíveis, o jogador pode calcular o resultado antes da luta.

**Fora de escopo:** foco em uma habilidade escolhida pelo jogador; uma estratégia para cada oponente.

## Torneio

Decidido no mapa de design (ticket "Torneio e níveis"). Os números são iniciais, para ajustar no balanceamento. Os níveis ficam em [[Progressão]].

### Formato

- **Pontos corridos com 4 monstros:** o monstro do jogador e 3 oponentes. Todos lutam contra todos, então o monstro do jogador faz 3 lutas.
- **Lutas entre oponentes:** o jogo simula estas lutas pela seed ([[Aleatoriedade determinística]]). O jogador vê só o resultado na tabela.
- **Tabela:** cada vitória vale 1 ponto. O desempate usa a maior soma de Vida restante em %. Se o empate continuar, a seed decide.

### Calendário

- O calendário é **fixo** e o jogador vê as próximas edições com antecedência.
- Cada nível tem seu intervalo: Regional a cada 4 semanas, Nacional a cada 8, Mundial a cada 12.
- Cada edição tem uma **raça predominante**, que aparece no calendário. 2 dos 3 oponentes são dessa raça. O terceiro é sorteado pela seed entre todas as raças.

### Oponentes

- O jogo gera os oponentes pela seed. Cada nível tem uma faixa fixa de stats, que não acompanha a força do jogador.
- O jogador sabe a raça predominante pelo calendário. O que mais ele vê sobre os oponentes está na seção "Estratégia e obediência".
- Cada oponente é gerado com a base e a taxa da raça, mais um número de **semanas de treino** sorteado na faixa do nível (ver "Números da luta"). A faixa que o jogador vê é a soma dos stats.

| Nível | Semanas de treino | Soma dos stats | Título com raça favorável |
|---|---|---|---|
| Regional | 5 a 25 | 330 a 450 | 36% a 52% com 10 semanas |
| Nacional | 40 a 65 | 540 a 690 | 41% a 68% com 50 semanas |
| Mundial | 80 a 110 | 780 a 960 | 38% a 73% com 90 semanas |

**Por quê estas faixas:** com elas, a 1ª geração chega ao Mundial no fim do auge. A próxima geração deve chegar antes, porque as taxas de ganho sobem, mas isso não foi simulado. O modelo não tem o efeito das fases de idade.

### Inscrição

- O jogador inscreve **1 monstro por edição**. Em semanas com mais de um nível, monstros diferentes podem lutar em níveis diferentes.
- O prazo vai até o clique que passa a semana do torneio.
- O Regional é **grátis**. Nacional e Mundial cobram taxa na inscrição.
- Cancelar antes desse clique, ou vender o monstro inscrito, devolve a taxa.

### Prêmio

- O campeão e o vice recebem dinheiro. Os valores e as taxas de inscrição ficam em [[Economia]].
- Só o campeão recebe ovo, de pais fictícios, e só quando luta no **nível atual** dele. Em um nível abaixo, ele recebe só o dinheiro.
  *Mudança (ticket "Economia"):* antes, todo título dava ovo. Com isso, a venda de ovos virava a maior fonte de renda.
- O ovo tem a **raça do monstro campeão** e o sexo sorteado. A qualidade do ovo sobe com o nível. Ver [[Ovo]].

### Efeito no tempo e no estado

- O torneio inteiro gasta 1 semana e usa a ação da semana. Ver [[Treino semanal]].
- As 3 lutas usam o mesmo estado inicial. A fadiga e o estresse mudam só no fim do torneio. Ver [[Atributos de estado]].

**Por quê pontos corridos:** escolha do Daniel. Todo monstro faz as 3 lutas, mesmo quando perde a primeira.

**Por quê 4 monstros:** o jogador vê poucas lutas por torneio, e o torneio continua curto.

**Por quê calendário fixo:** no modo livre, o jogador pode lutar toda semana no nível mais fácil para ganhar dinheiro. A data fixa também obriga a preparar o monstro para ela.

**Por quê raça predominante:** as fraquezas existem para dar sentido a escolher a raça certa para cada torneio. Com oponentes sempre aleatórios, essa razão não tem efeito. Com 3 de 3, uma raça ganharia quase sem risco.

**Por quê faixa fixa de stats:** se a faixa acompanhar o jogador, treinar mais não dá vantagem clara.

**Por quê 1 monstro por edição:** 2 monstros do mesmo jogador se enfrentariam, e ele poderia combinar o resultado na tabela.

**Por quê o Regional é grátis:** um jogador sem dinheiro precisa de um modo de ganhar dinheiro. Ver [[Progressão]], seção "Níveis".

**Por quê a raça do campeão:** o par precisa ser da mesma raça, então os alelos melhores só chegam à linhagem por um ovo da raça dela. A raça predominante não serve, porque o monstro que vence costuma ter vantagem contra ela. A primeira vitória também pode dar o par, com 50% de chance de o ovo ter o outro sexo.

## Números da luta

Decidido no mapa de design (ticket "Balanceamento numérico da batalha"). São valores iniciais: um script buscou os valores, e eles foram arredondados à mão. Protótipo na branch `prototype/battle-balance`. Potência e espera das habilidades: ver [[Raças]].

**Semana de treino** é a medida usada no balanceamento. Com a rotina de 3 treinos e 1 descanso, 1 semana sobe cada stat em cerca de 1 × a taxa de ganho, se o treino for dividido por igual. A soma dos stats é 300 + 6 × semanas.

```
Barra por tick = 20 + Velocidade × 0,05 (cheia em 100; a sobra continua)
Limite da luta = 600 ticks
Vida na luta   = stat Vida + 90
Acerto         = 0,85 + 0,35 × (Precisão − Velocidade do alvo) ÷ (Precisão + Velocidade do alvo), de 35% a 98%
Dano           = S × potência ÷ 100 × S ÷ (S + 0,4 × Defesa do alvo) × tipo × 0,5 × variação
```

- **S** é o stat que escala a habilidade. A **variação** é de ±10%. O dano é arredondado, com mínimo de 1.
- **Escolha do ponto fraco:** a chance é Inteligência ÷ (Inteligência + 100). Nesse caso, o monstro sorteia só entre as habilidades prontas que têm o melhor tipo contra o alvo.

Medido com treino dividido por igual:

| Medida | Antes | Agora |
|---|---|---|
| Espelho do Tatuço, em ações | 58 a 60 (mais de 120 no Regional) | 21 a 30 |
| Runoxa x Vulpi, em ações | 11 a 12 | 9 a 17 |
| +30% de Velocidade no espelho (50 semanas) | 72% a 96% | 70% a 73% |

**Por quê a Defesa pesa 0,4:** com peso 1,0, o espelho do Tatuço ficava muito longo. A Defesa dele também aumenta o dano do Rolo blindado.

**Por quê Vida + 90:** a soma fixa reduz a diferença de duração entre raças de muita e de pouca Vida.

**Riscos a testar:**

- **Força:** agora é o stat mais forte na maioria dos espelhos: +30% vence de 68% a 92%. O protótipo jogável deve medir se ela pesa demais.
- **Inteligência:** em Tatuço e Vulpi, +30% fica em cerca de 50%. Ver [[Atributos de estado]].
- **Limites do modelo:** o treino está sempre dividido por igual. Monstros especializados foram medidos só em parte. A genética melhor e as fases de idade não foram medidas.
- **Golpe grande:** o maior golpe medido nas lutas entre raças diferentes tira 38% da Vida. Monstros especializados podem passar disso.
