# Batalha

Parte de [[Visão geral]].

## Decidido

- O jogador é o **treinador**, não o lutador. A batalha é uma simulação. O monstro decide as ações.
- O jogador só define a estratégia antes da batalha.
- Se o monstro segue a estratégia depende de **obediência, Inteligência, estresse, fadiga** e outros atributos.
- As habilidades de cada raça escalam com stats diferentes (ver [[Raças]]).

## Formato da simulação

Decidido no mapa de design (ticket "Formato da simulação de batalha").

- **Tempo em ticks.** Cada monstro tem uma barra que enche a cada tick, mais rápido com mais Velocidade. Quando a barra enche, o monstro age e a barra zera.
- **1 contra 1.** Times ficam fora desta versão.
- **Fim da luta:** Vida zero, ou limite de ticks. No limite, vence quem tem mais Vida em %. Empate exato é sorteado pela seed ([[Aleatoriedade determinística]]).
- **Vida não persiste.** Cada luta começa com Vida cheia. Não há ferimento entre lutas.

### Ações

- O monstro só usa **habilidades**. Todo golpe é uma habilidade.
- Cada raça tem 1 **habilidade básica sem espera**. As outras têm **espera em ticks** depois do uso. Assim o monstro nunca fica sem opção.
- O monstro escolhe a habilidade por **sorteio com pesos**, pela seed. A estratégia do jogador muda os pesos. A Inteligência define quanto o monstro segue os pesos e se escolhe a habilidade que explora o ponto fraco do oponente.
- O monstro **pode pular a ação** por fadiga ou desobediência. A fórmula fica no ticket de obediência.
- **Defesa e esquiva são passivas**: reagem ao golpe do oponente. Não existe ação "Defender".

### Papel dos stats

| Stat | Papel na luta |
|---|---|
| Vida | Pontos de vida. |
| Força | Aumenta o dano dos golpes que escalam com ela. |
| Inteligência | Escolha da habilidade e obediência. Escala habilidades da Runoxa. |
| Precisão | Chance de acertar. |
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
- O jogador sabe a raça predominante antes da luta. O que mais ele vê sobre os oponentes fica no ticket de estratégia e obediência.

### Inscrição

- O jogador inscreve **1 monstro por edição**. Em semanas com mais de um nível, monstros diferentes podem lutar em níveis diferentes.
- O prazo vai até o clique que passa a semana do torneio.
- O Regional é **grátis**. Nacional e Mundial cobram taxa na inscrição.
- Cancelar antes desse clique, ou vender o monstro inscrito, devolve a taxa.

### Prêmio

- O campeão e o vice recebem dinheiro. Os valores ficam na decisão de economia.
- Só o campeão recebe ovo, de pais fictícios. A qualidade do ovo sobe com o nível. Ver [[Ovo]].

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

## Em aberto

- Quais estratégias o jogador pode escolher? (ticket de estratégia e obediência)
- Como a obediência muda e como decide a ação? Ela é um atributo próprio, e os aspectos de [[Personalidade]] só a modificam. Ver [[Atributos de estado]].
- O jogador vê os tipos e fraquezas do oponente antes da luta?
- Números: dano, acerto, esquiva, limite de ticks, tamanho das esperas. Ajustar depois do protótipo.
