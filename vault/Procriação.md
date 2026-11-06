# Procriação

Forma de criar novos monstros a partir de dois pais. Parte de [[Visão geral]].

## Decidido

- Mistura a linhagem: stats e habilidades de batalha dos pais, ponderados.
- O filho herda a **facilidade de progresso** (taxa de ganho, ver [[Stats]]), não o poder acumulado.
- O filho herda **um aspecto de personalidade aleatório de cada pai**. O aspecto do pai não pode repetir o da mãe nem ser o oposto dele (ver [[Personalidade]]).
- O resultado da procriação é um [[Ovo]].
- É a **regra única** de criação: ovos de loja, expedição e torneio vêm de pais fictícios (ver [[Ovo]]).
- A [[Mutação]] não é herdada.
- Herança segue [[Aleatoriedade determinística]].
- Os pais precisam estar **vivos** e na fase **auge ou velho**. O jovem não procria. O monstro morto não procria. Ver [[Treino semanal]], seção "Tempo de vida".

## Genética da taxa de ganho: alelos

- Cada stat tem **2 alelos**. Cada alelo é um número na escala da taxa (ver [[Stats]]).
- A **taxa genética** do stat é a média dos 2 alelos.
- O filho recebe, para cada stat, **1 alelo sorteado de cada pai**.
- O jogador vê a taxa (letra) dos pais, mas **não vê os alelos**.

**Por quê alelos:** é a forma mais simples de "genética realista". Dois pais bons podem ter um filho mediano, e dois pais medianos podem ter um filho excelente, se carregarem alelos bons escondidos.

**Exemplo:** pai com Força (1,2 e 0,8) → taxa 1,0. Mãe com Força (1,1 e 1,1) → taxa 1,1. O filho pode receber (1,2 e 1,1) → 1,15, ou (0,8 e 1,1) → 0,95.

- O bônus da [[Palavra]] **não é genético**: vale só para o monstro que recebeu a palavra e não passa para os filhos. (Suposição: confirmar quando a procriação entre monstros do jogador for implementada.)

## Em aberto

- Os pais sofrem algum custo ao procriar?
- Pais de raças diferentes podem procriar? Qual raça nasce?
- Os stats iniciais do filho também vêm dos pais? (Hoje: base da raça ±10%.)
