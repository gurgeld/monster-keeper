# Treino semanal

Parte de [[Visão geral]].

## Decidido

- O tempo passa em semanas. O treino acontece por semana.
- Equipamentos melhoram o treino.
- Excesso de treino sem descanso gera doença, estresse e frustração.

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

## Em aberto

- Como a [[Ovo, palavra e incubação|palavra]] altera o ganho de cada treino?
- O monstro envelhece e morre? Qual o tempo de vida?
- Treinos leves e pesados (pesado sobe um stat e baixa outro, como no MR2)?
