# Personalidade

Inclui a incubação, que é a parte da criação de monstro que molda a personalidade. Junto com [[Ovo]] e [[Palavra]]. Parte de [[Visão geral]].

**Papel no design:** o cuidado na incubação **molda a personalidade**.

## Decidido

- O monstro nasce com **3 aspectos de personalidade**:
  - um definido pelo cuidado na incubação;
  - um herdado da mãe;
  - um herdado do pai.
- Na [[Procriação]], o aspecto herdado de cada pai é escolhido ao acaso entre os aspectos permitidos dele (ver [[Aleatoriedade determinística]]).
- Cada aspecto tem **custo e benefício**. Pode agir em várias áreas da vida do monstro: treino, descanso e [[Atributos de estado]]. **Não muda dano nem acerto de forma direta**: na batalha, age só por meio dos atributos de estado.
  *Mudança:* antes o aspecto afetava "batalha e crescimento" sem detalhe. A luta já usa os 6 stats; o aspecto muda como o monstro é criado e como obedece.
- O aspecto **não tem intensidade**: é igual em todo monstro que o tem.
- O aspecto **fica fixo** por toda a vida do monstro.
  *Mudança:* antes, os aspectos podiam ser encorajados ou desencorajados durante a criação. Saiu desta versão: a semana tem só 1 ação, e um segundo sistema competiria com ela.

## Lista de aspectos

Números iniciais, para ajustar no balanceamento. O tamanho dos efeitos em estresse (±50%) e em obediência (±15) está em [[Atributos de estado]].

| Aspecto | Benefício | Custo | Oposto |
|---|---|---|---|
| **Esforçado** | Treino rende +10% | Treino soma +5 de fadiga | Preguiçoso |
| **Preguiçoso** | Descanso tira +15 de fadiga | Treino rende −10% | Esforçado |
| **Rebelde** | Treino rende +10% | Obediência menor | Leal |
| **Leal** | Obediência maior | Treino rende −5% | Rebelde |
| **Calmo** | Estresse sobe mais devagar | Treino rende −5% | Ansioso |
| **Ansioso** | Treino rende +10% | Estresse sobe mais rápido | Calmo |
| **Robusto** | Treino soma −5 de fadiga | Descanso tira −10 de fadiga | nenhum |
| **Sensível** | Estresse desce mais rápido | Estresse sobe mais rápido | nenhum |

- Efeitos iguais **somam**: Esforçado + Rebelde dá +20% no treino, não +21%. O ganho do treino é multiplicado por (1 + soma dos efeitos). Ver [[Treino semanal]].
- O descanso sempre usa 1 semana. O aspecto muda só quanta fadiga ele tira.

**Por quê somar:** é mais fácil de mostrar e explicar ao jogador.

**Por quê o descanso não muda de duração:** cada semana é uma decisão do jogador. Um descanso de 2 semanas tiraria o controle dele.

## Como os 3 aspectos são escolhidos

Todo monstro tem 3 aspectos **diferentes e sem opostos**. Isso vale também para os [[Ovo|pais fictícios]], que recebem 3 aspectos sorteados da lista pela seed.

1. **Incubação:** a balança leva a 1 dos 8 aspectos. Nenhum aspecto fica bloqueado.
2. **Mãe:** quando o ovo choca, sorteia 1 entre os aspectos dela, sem o aspecto da incubação e sem o oposto dele.
3. **Pai:** quando o ovo choca, sorteia 1 entre os aspectos dele, sem o aspecto da incubação, sem o aspecto da mãe e sem os opostos deles.

A regra sempre tem saída: em todos os 27.360 casos possíveis, a mãe tem pelo menos 2 opções e o pai pelo menos 1. Se a lista mudar, esta conta precisa ser verificada de novo.

*Mudança:* antes a ordem era mãe, pai e incubação, e a incubação tinha só de 4 a 6 aspectos livres. Se o jogador tentasse um aspecto bloqueado, a cor dava uma pista da herança escondida. Com a incubação primeiro, os 8 aspectos ficam livres e não há essa pista.

**Tática:** a incubação pode impedir uma herança. Incubar Leal impede que um pai passe Rebelde. O custo é igual para aspectos bons: incubar Esforçado impede que um pai passe Esforçado ou Preguiçoso.

*Decisão do Daniel:* opostos não existem no mesmo monstro. A alternativa era somar os efeitos sem regra especial.

## O que o jogador vê

- Os 3 aspectos do monstro, com benefício e custo.
- No ovo, os 3 aspectos de cada pai. Só sabe qual aspecto cada pai passou quando o ovo choca.

**Por quê:** o [[Ovo]] dá previsibilidade com resultado probabilístico, e o jogador precisa dessa informação para escolher pais na [[Procriação]].

## Incubação

### Tempo e ajustes

- A incubação dura **4 semanas**.
- O jogador pode fazer **1 ajuste por semana**. Se não ajustar, o ovo mantém os valores, e a semana passa normalmente.
- **Só os valores da última semana decidem o aspecto.** As semanas 1 a 3 servem como testes, sem custo.
- O ovo começa com temperatura e umidade no meio da escala. A seed do ovo sorteia a música inicial.

*Decisão do Daniel:* só a última semana conta. A alternativa era somar pontos a cada semana.

### Balança

- **Música:** Ninar, Marcha, Tambores ou Harpa. Cada estilo leva a 1 par: Esforçado/Preguiçoso, Rebelde/Leal, Calmo/Ansioso ou Robusto/Sensível.
- A seed da partida sorteia a relação entre música e par **uma vez por save**. O jogo não mostra essa relação. O jogador descobre testando.
- **Temperatura:** muito frio, frio, morno, quente, muito quente.
- **Umidade:** muito seco, seco, médio, úmido, muito úmido.
- Temperatura e umidade formam uma grade de 25 combinações e escolhem o lado do par.

**Por quê a relação é por save:** o jogador aprende ao longo da partida, como acontece com a [[Palavra]]. Se a relação mudasse em cada ovo, encontrar o par certo poderia gastar todos os testes.

### Perfil do ovo

- A seed de cada ovo sorteia o **perfil**: 2 zonas pequenas na grade, 1 para cada aspecto do par. Cada zona é uma combinação central e as vizinhas diretas (até 5 combinações).
- As 2 zonas têm a mesma regra de tamanho e não se sobrepõem. Nenhum aspecto do par é mais raro por regra.
- **Fora das zonas**, o ovo fica **Indefinido**. Se a última semana terminar assim, a seed do ovo sorteia 1 aspecto do par da música.
- O filho **não herda** o perfil dos pais. O perfil não depende da origem do ovo.

**Por quê:** uma zona pequena para só um aspecto deixaria o outro com o resto da grade, e o Daniel não quer aspecto raro. Se valesse a zona mais próxima, qualquer teste já mostraria um aspecto e o acerto seria muito fácil. Se o perfil fosse herdado, uma linhagem levaria a resposta pronta.

### O que o jogador vê

- Quando a semana passa, o ovo mostra a **cor e o nome** do aspecto que nasceria com os valores daquela semana.
- Valores iguais no mesmo ovo sempre dão o mesmo resultado.
- O jogo **não mostra o histórico de testes** e não guarda dicas de um ovo para o próximo.

| Aspecto | Cor | Aspecto | Cor |
|---|---|---|---|
| Esforçado | Laranja | Preguiçoso | Azul-claro |
| Rebelde | Vermelho | Leal | Azul-escuro |
| Calmo | Verde | Ansioso | Amarelo |
| Robusto | Marrom | Sensível | Rosa |
| Indefinido | Cinza | | |

**Por quê a cor só aparece quando a semana passa:** com a cor na hora, o jogador testaria todas as combinações sem custo.

**Por quê o nome aparece junto:** com 8 cores, algumas ficam parecidas, e pessoas com daltonismo podem não distinguir todas.

*Decisão do Daniel:* sem histórico de testes, para a incubação não ficar fácil demais.

### Dificuldade medida

Com a música certa já conhecida, em 3 testes e 1 decisão final:

- jogador atento: **83%** de chance de conseguir o aspecto desejado;
- jogador ao acaso: **72%**.

A descoberta das músicas deixa os primeiros ovos mais difíceis. Esse efeito não entrou na medição.

**Fora de escopo:** encorajar ou desencorajar um aspecto depois do nascimento; intensidade de aspecto.
