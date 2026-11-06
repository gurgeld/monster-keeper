# Treino semanal

Parte de [[Visão geral]].

## Decidido

- O tempo passa em semanas. A cada semana o jogador decide o treino de **cada monstro** do rancho (ver [[Progressão]]).
- Alguns treinos **dependem de equipamentos especiais**. Quanto melhor o equipamento, melhor o treino.
- Excesso de treino sem descanso gera doença, estresse, frustração etc.
- A [[Palavra]] age sobre a taxa de ganho, e a taxa multiplica o ganho do treino (ver [[Stats]]).
- Os aspectos de [[Personalidade]] mudam o ganho do treino e a fadiga. O ganho é multiplicado por (1 + soma dos efeitos dos aspectos). A fadiga que o treino soma e a que o descanso tira também mudam conforme o aspecto. O descanso sempre usa 1 semana.

## Semana e rotina

Decidido no mapa de design (ticket "Rancho"). Os limites são iniciais, para ajustar no balanceamento.

- **Relógio único:** todos os monstros usam a mesma semana e envelhecem juntos.
- **Cada monstro tem 1 ação por semana:** treinar ou descansar.
- **Cada clique passa 1 semana.** O jogo executa a rotina de todos os monstros.
- Cada monstro tem uma **rotina** com 2 partes:
  - uma **lista** de até 8 passos, que se repete; cada passo é um treino ou um descanso;
  - até 3 **regras**, na forma "se a fadiga (ou o estresse) for N ou mais, fazer a ação X". O jogador escolhe N e a ação.
- **Como o jogo escolhe a ação:**
  1. O jogo lê os valores antes da ação da semana.
  2. A primeira regra verdadeira, em ordem, decide a ação. Nesta semana, a lista não anda.
  3. Se nenhuma regra é verdadeira, o jogo usa o próximo passo da lista.
- Se o jogador muda a lista, ela recomeça do passo 1.
- Um monstro novo começa com a rotina "descansar".

**Exemplo:** a lista é Força, Velocidade. A regra é "se a fadiga for 60 ou mais, descansar". Depois de Força, a fadiga é 60. O monstro descansa nesta semana. Na semana seguinte, a fadiga é menor, e o monstro treina Velocidade.

**Por quê relógio único:** o prazo de 156 semanas só cria pressão para procriar se ninguém puder parar o tempo.

**Por quê 1 ação por monstro:** uma quantidade pequena de ações para dividir castiga quem tem mais monstros, porque a idade continua a contar.

**Por quê rotina:** com 6 monstros durante 156 semanas, o jogador teria cerca de 936 decisões.

**Por quê as regras só leem fadiga e estresse:** o treino e o descanso mudam estes dois valores. Regras com fase de idade ou stats fariam o jogo quase jogar sozinho. A satisfação pode entrar se a decisão dela der um motivo.

**Risco a testar:** o jogador pode encontrar uma rotina que serve para todos os monstros e deixar de pensar na fadiga. O protótipo jogável deve testar isso.

**Fica para outras decisões:** como a luta usa a semana, e o que acontece com a rotina nessa semana (ticket de torneio); a tela da rotina e a opção "avançar até um aviso" (fluxo de telas).

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
- Se o jogador fica sem monstro e sem ovo, ele compra um ovo na loja. Sem dinheiro, recebe um ovo grátis de qualidade baixa. Os valores ficam na decisão de economia. Assim o jogo nunca trava. A venda não pode abrir este caminho: ver [[Progressão]], seção "Venda".
- Só pode procriar quem está vivo e na fase auge ou velho. Ver [[Procriação]].

**Por quê:** a morte cria o prazo que faz o jogador procriar. A fase jovem curta e o auge longo dão tempo para competir. O número exato de cada fase e o tamanho do bônus ou da perda são números iniciais, para ajustar no balanceamento.

**Fora de escopo:** duração diferente por raça ou genética; bônus ou item depois da morte.

## Em aberto

- Treinos leves e pesados (pesado sobe um stat e baixa outro, como no MR2)?
