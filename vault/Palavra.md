# Palavra

Parte da criação de monstro, junto com [[Ovo]] e [[Personalidade|incubação]]. Parte de [[Visão geral]].

**Papel no design:** a palavra **exige exploração**. O jogador procura palavras boas para cada tipo de monstro.

**Lore:** a palavra é um encantamento lançado sobre o ovo.

## Decidido

- A palavra define um bônus ou penalidade na **taxa de ganho** de cada stat (ver [[Stats]]). Ela não muda os stats diretamente.
- Texto livre de **3 a 7 letras**. Aceita sequências aleatórias de letras.
- **Toda palavra tem trade-off**: efeito positivo em um stat e negativo em outro.
- A soma dos modificadores **nem sempre é zero**. Ex.: uma palavra dá +2 Força e −2 Inteligência; outra dá +2 Força e só −1 Inteligência. Palavras de soma positiva são raras; quanto melhor, mais rara.
- O efeito depende de uma **variável gerada na primeira execução** e guardada no save (ver [[Aleatoriedade determinística]]). A mesma palavra gera sempre o mesmo efeito no mesmo save, mas outro efeito em outro save.
  **Por quê:** impede o compartilhamento de listas de palavras.
- O jogador escolhe a palavra no **início da incubação**. Ela não pode mudar depois. O jogador só vê o resultado no nascimento.
- O perfil de cada palavra favorece certos tipos de monstro. Por isso o jogador quer várias palavras boas, uma para cada tipo que pretende criar.

## Regras numéricas (versão 2 do protótipo)

- **1 ponto = 0,05** na taxa de ganho. O efeito soma à taxa genética (ver [[Procriação]]).
- Cada palavra afeta **exatamente 2 stats diferentes**: um positivo e um negativo.
- **Soma** (positivo − negativo), sorteada:

  | Soma | Chance |
  |---|---|
  | 0 | 80% |
  | +1 | 15% |
  | +2 | 4% |
  | +3 | 1% |

  Não existem palavras de soma negativa.
- Negativo: de 1 a 3 pontos (até 4 − soma). Positivo = negativo + soma. Máximo: **+4 (0,20)** e **−3 (0,15)**.
  **Por quê +4:** com soma +3 e trade-off obrigatório (pelo menos −1), o positivo precisa chegar a +4.
- **Como a palavra vira efeito:** hash da palavra junto com a variável do save → seed de um sorteio determinístico.
- Normalização: o jogo ignora maiúsculas ("Fogo" = "fogo"). Aceita só letras (com acento).
- Por enquanto, a "variável do save" é a seed da partida (ainda não existe save).

## Estudo de palavras

- O jogador paga um custo (tempo ou dinheiro) para testar uma palavra e aprender o efeito dela sem gastar um ovo.
- Cada palavra tem um **efeito recessivo**: o efeito diminui a cada uso. O desvio padrão dos bônus diminui e a soma dos efeitos tende a zero.

## Em aberto

- Efeito recessivo: "uso" significa cada ovo incubado com a palavra? O estudo também conta como uso? O desgaste vale por save?
- Estudo de palavras e efeito recessivo ainda não estão no protótipo.
