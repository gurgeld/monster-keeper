# Personalidade

Inclui a incubação, que é a parte da criação de monstro que molda a personalidade. Junto com [[Ovo]] e [[Palavra]]. Parte de [[Visão geral]].

**Papel no design:** o cuidado na incubação **molda a personalidade**.

## Decidido

- O monstro nasce com **3 aspectos de personalidade**:
  - um herdado da mãe;
  - um herdado do pai;
  - um definido pelo cuidado na incubação.
- Na [[Procriação]], o aspecto herdado de cada pai é escolhido ao acaso entre os aspectos dele (ver [[Aleatoriedade determinística]]).
- Cada aspecto tem **custo e benefício**. Pode agir em várias áreas da vida do monstro: treino, descanso e [[Atributos de estado]]. **Não muda dano nem acerto de forma direta**: na batalha, age só por meio dos atributos de estado.
  *Mudança:* antes o aspecto afetava "batalha e crescimento" sem detalhe. A luta já usa os 6 stats; o aspecto muda como o monstro é criado e como obedece.
- O aspecto **não tem intensidade**: é igual em todo monstro que o tem.
- O aspecto **fica fixo** por toda a vida do monstro.
  *Mudança:* antes, os aspectos podiam ser encorajados ou desencorajados durante a criação. Saiu desta versão: a semana tem só 1 ação, e um segundo sistema competiria com ela.

## Lista de aspectos

Números iniciais, para ajustar no balanceamento. O tamanho dos efeitos em estresse (±50%) está em [[Atributos de estado]]. O de obediência fica na decisão de obediência.

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

1. **Mãe:** sorteia 1 entre os 3 dela.
2. **Pai:** sorteia 1 entre os 3 dele, sem o aspecto da mãe e sem o oposto desse aspecto.
3. **Incubação:** a balança só leva a aspectos fora dos 2 herdados e dos opostos deles.

A regra sempre tem saída. O pai não tem um aspecto e o oposto dele ao mesmo tempo, então a mãe bloqueia no máximo 1 dos 3 aspectos dele. Na incubação, sobram sempre de 4 a 6 aspectos. Se a lista mudar, esta conta precisa ser verificada de novo.

*Decisão do Daniel:* opostos não existem no mesmo monstro. A alternativa era somar os efeitos sem regra especial.

## O que o jogador vê

- Os 3 aspectos do monstro, com benefício e custo.
- No ovo, os 3 aspectos de cada pai. Só sabe qual aspecto cada pai passou quando o ovo choca.

**Por quê:** o [[Ovo]] dá previsibilidade com resultado probabilístico, e o jogador precisa dessa informação para escolher pais na [[Procriação]].

## Incubação

- Funciona como uma **balança sensível**: o jogador controla variáveis como temperatura, umidade e música.
- Cada ovo tem um **perfil de combinação**, definido na rolagem, que leva a aspectos diferentes.
- O ovo **muda de tonalidade** conforme o aspecto que está se formando (ex.: rebeldia = vermelho). Assim o jogador sabe se os ajustes estão funcionando.

## Em aberto

- Como as variáveis de incubação levam a cada aspecto?
- A incubação dura 4 semanas do calendário no protótipo (ver [[Protótipo jogável]]). É a duração final?

**Fora de escopo:** encorajar ou desencorajar um aspecto depois do nascimento; intensidade de aspecto.
