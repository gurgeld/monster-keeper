# Treino semanal

Parte de [[Visão geral]].

## Decidido

- O tempo passa em semanas. A cada semana o jogador decide o treino de **cada monstro** do rancho (ver [[Progressão]]).
- Alguns treinos **dependem de equipamentos especiais**. Quanto melhor o equipamento, melhor o treino.
- Excesso de treino sem descanso gera doença, estresse, frustração etc.
- A [[Palavra]] age sobre a taxa de ganho, e a taxa multiplica o ganho do treino (ver [[Stats]]).

## Protótipo jogável (versão 1)

Regras simples para a primeira versão jogável. Ver [[Protótipo jogável]].

- **1 ação por semana**: treinar ou descansar.
- **6 treinos**, um por stat. Cada treino sobe só o seu stat.
- **Ganho do treino** = 10 × taxa de ganho do stat × fator de fadiga, arredondado. Ver [[Stats]].
- **Fadiga** (0 a 100):
  - treinar soma 20;
  - descansar tira 40;
  - fator de fadiga = 1 − fadiga ÷ 200. Com fadiga 0 o treino rende 100%; com fadiga 100, rende 50%.
  - O fator usa a fadiga **antes** do treino.
- Stats têm teto de 999.
- Ainda **sem doença, estresse e frustração**. Entram numa versão futura.

**Por quê esses números (proposta, ajustar jogando):** treinar sempre leva a fadiga a 100 e o ganho cai pela metade. Alternar treino e descanso (ex.: 3 treinos, 1 descanso) rende mais no total. Isso cria a primeira decisão do jogador.

## Tempo de vida

Decidido no mapa de design (ticket "Tempo de vida"). Substitui o limite fixo de 52 semanas do protótipo.

- O monstro vive **156 semanas** (3 anos de jogo), contadas a partir do dia em que o ovo choca. Igual para todos: sem diferença por raça ou genética.
- A idade tem **3 fases**:

| Fase | Semanas | Efeito |
|---|---|---|
| Jovem | 1 a 40 | O treino rende mais. |
| Auge | 41 a 110 | O treino rende o normal. Melhor fase para competir. |
| Velho | 111 a 156 | O treino rende menos. Os stats caem devagar. |

- No fim das 156 semanas o monstro **morre e some**. O jogo avisa a partir da fase velha.
- Ao morrer, o jogador ganha um registro na tela "memorial": nome, raça, stats finais e vitórias. O registro não tem efeito no jogo.
- Se o jogador fica sem monstro e sem ovo, ele compra um ovo na loja. Sem dinheiro, recebe um ovo grátis de qualidade baixa. Os valores ficam na decisão de economia. Assim o jogo nunca trava.
- Só pode procriar quem está vivo e na fase auge ou velho. Ver [[Procriação]].

**Por quê:** a morte cria o prazo que faz o jogador procriar. A fase jovem curta e o auge longo dão tempo para competir. O número exato de cada fase e o tamanho do bônus ou da perda são números iniciais, para ajustar no balanceamento.

**Fora de escopo:** duração diferente por raça ou genética; bônus ou item depois da morte.

## Em aberto

- Treinos leves e pesados (pesado sobe um stat e baixa outro, como no MR2)?
