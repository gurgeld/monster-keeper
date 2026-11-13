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
- **Cada monstro tem 1 ação por semana:** treinar, descansar, lutar em um torneio ou procriar.
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

**Por quê as regras só leem fadiga e estresse:** o treino e o descanso mudam estes dois valores. Regras com fase de idade ou stats fariam o jogo quase jogar sozinho.

**Risco a testar:** o jogador pode encontrar uma rotina que serve para todos os monstros e deixar de pensar na fadiga. O protótipo jogável deve testar isso.

**Telas:** a rotina fica na ficha do monstro, e o jogador pode passar várias semanas com "Avançar até um aviso". Ver [[Fluxo de telas]].

### Semana de torneio

Decidido no mapa de design (ticket "Torneio e níveis"). Ver [[Batalha]], seção "Torneio".

- O torneio inteiro gasta **1 semana** e usa a ação dessa semana do monstro inscrito.
- A inscrição tem prioridade sobre as regras da rotina, porque o jogador escolheu lutar. A lista não anda nessa semana.
- O torneio soma **+20 de fadiga**, igual a um treino, e não dá ganho de stat. A fadiga muda só no fim do torneio.
- Os outros monstros seguem a rotina normal.

**Por quê:** lutar tem um custo real, porque o monstro perde uma semana de treino.

### Semana de concepção

Decidido no mapa de design (ticket "Procriação"). Ver [[Procriação]].

- A concepção usa a ação da semana dos 2 pais. Ela não soma fadiga.
- Como no torneio, a concepção tem prioridade sobre as regras da rotina, porque o jogador a escolheu. A lista não anda nessa semana.
- Um monstro inscrito em um torneio não pode procriar na mesma semana, porque só tem 1 ação.
- A gestação não usa ações. Durante a gestação, a mãe segue a rotina e pode lutar em torneios.

### Ordem dentro da semana

Decidido na spec da versão 3 do [[Protótipo jogável]]. Quando o jogador passa a semana, o jogo faz estes passos, nesta ordem:

1. **Decide a ação de cada monstro**, com os valores do início da semana: inscrição em torneio, depois concepção, depois a primeira regra verdadeira da rotina, depois o próximo passo da lista.
2. **Executa as ações:** treino, descanso, concepção e torneios. Prêmios, ovos de prêmio e subida de nível entram aqui.
3. **Idade:** cada monstro fica 1 semana mais velho. Troca de fase, queda da velhice e morte acontecem aqui. A morte cancela as inscrições futuras e devolve a taxa.
4. **Procriação:** a gestação e a recuperação andam. No fim da gestação, o ovo vai para os ovos guardados.
5. **Incubação:** a incubação anda. Depois da 4ª semana, o ovo choca.
6. **Mundo:** a semana do jogo sobe 1. A loja troca os ovos a cada 4 semanas. O jogo verifica a regra do ovo grátis.
7. **Relatório e save:** o jogo monta o relatório e salva. Só depois a tela mostra o relatório (ver [[Save]]).

**Por quê:** a ação usa o estado do início da semana, como as regras da rotina já pedem. A idade vem depois da ação, então o monstro na última semana de vida ainda faz a ação dessa semana.

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

| Fase | Semanas | Fator da fase | Efeito |
|---|---|---|---|
| Jovem | 1 a 40 | 1,25 | O treino rende mais. |
| Auge | 41 a 110 | 1,0 | O treino rende o normal. A força máxima fica no fim do auge. |
| Velho | 111 a 156 | 0,5 | O treino rende menos. Os stats caem devagar. |

- No fim das 156 semanas o monstro **morre e some**. O jogo avisa a partir da fase velha.
- Ao morrer, o jogador ganha um registro na tela "memorial": nome, raça, stats finais, vitórias (lutas ganhas) e títulos (torneios ganhos). O registro não tem efeito no jogo.
- Se o jogador fica sem monstro e sem ovo, ele compra um ovo na loja. Sem dinheiro para o ovo mais barato, recebe um ovo grátis de qualidade baixa (ver [[Economia]]). Assim o jogo nunca trava. A venda não pode abrir este caminho: ver [[Progressão]], seção "Venda".
- Só pode procriar quem está vivo e na fase auge ou velho. Ver [[Procriação]].

**Por quê:** a morte cria o prazo que faz o jogador procriar. A fase jovem curta e o auge longo dão tempo para competir. O número exato de cada fase e o tamanho do bônus ou da perda são números iniciais, para ajustar no balanceamento.

**Fora de escopo:** duração diferente por raça ou genética; bônus ou item depois da morte.

### Números das fases

Decidido no mapa de design (ticket "Números das fases de idade"). São valores iniciais, para ajustar no balanceamento.

- **Ganho do treino:**

  ```
  Ganho = 10 × taxa de ganho × fator de fadiga × (1 + efeitos dos aspectos) × fator da fase
  ```

  O resultado é arredondado. O fator da fase multiplica o ganho. Ele não entra na soma dos aspectos.
- **Troca de fase:** o fator muda de uma vez, nas semanas 41 e 111. Não há mudança gradual.
- **Queda da velhice:** na fase velha, a cada 4 semanas (semanas 114, 118 e assim por diante), cada stat perde **2%** do valor, com arredondamento normal. A queda acontece com qualquer ação da semana.
  - O stat continua a ser um número inteiro.
  - Um stat alto perde mais pontos que um stat baixo. Um stat muito baixo pode não cair (20 × 2% = 0,4, que arredonda para 0).
  - O stat nunca chega a zero, então não há valor mínimo.
  - Habilidades liberadas não se perdem (ver [[Raças]]).
- A fase não muda a fadiga nem o estresse. Na obediência, a fase jovem tira 10 (ver [[Atributos de estado]]).

Medido com o modelo da batalha (ver [[Batalha]], seção "Torneio"), com os scripts `age.js` e `age2.js` da branch `prototype/battle-balance`. O monstro luta só em edições com raça favorável ou espelho, e o treino é dividido por igual. O modelo não tem estresse, aspectos nem genética melhor.

| Medida (1ª geração) | Valor |
|---|---|
| Mundial abre (título do Nacional) | cerca da semana 56 |
| 1º título Mundial | semanas 96 a 108 |
| Título Mundial até a semana 110 | 67% a 78% dos monstros |
| Título Mundial até a semana 156 | 95% a 98% dos monstros |
| Chance de título Mundial por edição (raça favorável), semana 108 → 156, se treina | 80% a 93% → 50% a 82% |
| Mesma chance se só descansa na fase velha | 80% a 93% → 11% a 37% |
| Mesma chance no espelho, se treina | 51% a 66% → 23% a 25% |

Com taxas 20% maiores (próxima geração), o 1º título Mundial vem por volta da semana 84.

**Por quê 1,25 na fase jovem:** com ×1,0, só 40% a 57% ganham o Mundial até o fim do auge. Com ×2,0, a 1ª geração ganha o título nas semanas 72 a 84, e a próxima geração quase não mostra ganho.

**Por quê 0,5 e 2% a cada 4 semanas na fase velha:** os stats caem devagar mesmo com treino. O monstro velho ainda compete, mas a chance cai a cada edição, e isso cria pressão para procriar. Treinar na fase velha continua a valer a pena: na semana 156, a soma dos stats fica cerca de 110 pontos acima da soma de quem só descansa. Com platô (×0,5 e queda menor), a fase velha não perde força. Com queda forte (×0,25 e 0,8% por semana), a chance de título cai para 2% a 14% na semana 156.

**Por quê a cada 4 semanas, e não toda semana:** 0,5% por semana daria parte decimal nos stats. No teste, as 2 formas tiveram quase o mesmo resultado.

**Por quê multiplicar:** somar a fase aos aspectos mudaria o valor de um aspecto conforme a idade.

*Mudança:* antes, a nota dizia que o auge é a "melhor fase para competir". Na 1ª geração, a força máxima fica na troca entre auge e velho (semanas 108 a 120), e as primeiras edições da fase velha são quase iguais às últimas do auge.

## Em aberto

- Treinos leves e pesados (pesado sobe um stat e baixa outro, como no MR2)?
