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

## Em aberto

- Quais estratégias o jogador pode escolher? (ticket de estratégia e obediência)
- Como a obediência muda e como decide a ação? Ela é um atributo próprio, e os aspectos de [[Personalidade]] só a modificam. Ver [[Atributos de estado]].
- O jogador vê os tipos e fraquezas do oponente antes da luta?
- Números: dano, acerto, esquiva, limite de ticks, tamanho das esperas. Ajustar depois do protótipo.
