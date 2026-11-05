# Ovo

Parte da criação de monstro, junto com [[Palavra]] e [[Personalidade|incubação]]. Os três substituem o CD do original. Parte de [[Visão geral]].

**Papel no design:** o ovo dá **previsibilidade e agência**. O jogador sabe de antemão o que pode nascer.

## Decidido

- O ovo define a **raça**. Ver [[Raças]].
- O jogador consegue ovos de 5 formas:
  - escolhe 1 de 3 ovos no início do jogo;
  - compra em uma loja;
  - encontra em expedições;
  - ganha em torneios;
  - gera procriando monstros (ver [[Procriação]]).
- **Todo ovo tem pai e mãe.** Ovos que não vêm de procriação (comprados, achados, ganhos) são gerados a partir de um pai e uma mãe **fictícios**. Assim existe uma regra só para criar monstros: a [[Procriação]].
- O jogador vê só as informações dos pais do ovo (raça, personalidades, stats etc.). O resultado é probabilístico.
- A rolagem do ovo também decide a [[Mutação]].
- Primeiro protótipo: **3 raças**.

## Implementação atual (provisória)

O código ainda não tem pais. O ovo é a base da raça com variação de ±10% (ver [[Stats]]). Isso fica até a [[Procriação]] ser implementada; depois, o ovo comprado vira uma procriação de pais fictícios.

## Em aberto

- Como gerar os pais fictícios? (ex.: base da raça + variação, e a loja vende ovos de "qualidade" diferente?)
