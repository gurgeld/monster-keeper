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
- O jogador escolhe a palavra no **início da incubação**. Ela não pode mudar depois.
- Uma palavra fora do [[#Caderno de palavras|caderno]] é um risco: o jogador só vê o resultado no nascimento. Quando ele digita uma palavra do caderno, o jogo mostra o efeito com a força atual.
  *Mudança (ticket "Efeito recessivo"):* antes, a regra do nascimento valia para todas as palavras. O caderno criou a exceção, porque o jogador já conhece o efeito dessas palavras.
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
- A "variável do save" é a seed da partida. Ver [[Save]].

## Estudo de palavras

Decidido no mapa de design (ticket "Estudo de palavras"). O preço é um número inicial, para ajustar no balanceamento.

- O jogador paga para aprender o efeito de uma palavra sem gastar um ovo.
- O estudo **não conta como uso**. Ele mostra o efeito na força atual e coloca a palavra no [[#Caderno de palavras|caderno]].
- Uma palavra que já está no caderno não precisa de estudo, e o jogo não cobra por ela.
- **Custo:** **100** de dinheiro, sempre o mesmo valor.
- **Fluxo:** o efeito aparece na hora. O estudo não usa a ação de um monstro, e a semana não passa. O jogador não precisa ter monstro nem ovo.
- **Sem limite:** o dinheiro é o único limite. Não há limite por semana.
- **Telas:** o jogador estuda no caderno, para planejar, e na tela de lançar a palavra, antes de decidir. Nesta tela, uma palavra fora do caderno mostra "efeito desconhecido" e 2 botões: Estudar e Lançar sem estudar. Depois do estudo, o jogador ainda pode digitar outra palavra.
- O botão de estudo fica desligado se a palavra for inválida ou se o dinheiro não chegar a 100. O saldo nunca fica negativo.

**Por quê só dinheiro:** o dinheiro sobra no fim do jogo (ver [[Economia]]), e só um custo em dinheiro reduz esta sobra. Com 6 monstros, 1 ação custa pouco. Um custo em ação também exigiria um passo novo na rotina (ver [[Treino semanal]]) e impediria o estudo sem monstro.

**Por quê 100 fixo:** o preço pesa no início, porque depois do primeiro ovo sobram de 100 a 600. Ele continua a pesar no fim do jogo, porque uma palavra boa é rara e o [[#Desgaste|desgaste]] faz o jogador procurar palavras novas. Custo médio com 100:

| Palavra procurada | Chance por estudo | Em qualquer stat | No stat que o jogador quer |
|---|---|---|---|
| Soma +1 ou melhor | 20% | 500 | 3.000 |
| Soma +2 ou melhor | 5% | 2.000 | 12.000 |
| Soma +3 | 1% | 10.000 | 60.000 |

As alternativas foram 50 fixo (o jogador poderia digitar centenas de palavras, uma por vez) e um preço que sobe a cada estudo (castiga a exploração no fim do jogo, quando as palavras já estão gastas, e exige mais um contador no save).

**Por quê sem limite:** um limite faz o jogador passar semanas só para estudar mais, e reduz a saída de dinheiro.

**Por quê gastar tudo em estudos não é um problema:** a regra do ovo grátis impede que o jogo trave (ver [[Economia]]). Ela não vira vantagem, porque o ovo grátis é de qualidade baixa e o jogador já gastou o dinheiro.

## Desgaste

Decidido no mapa de design (ticket "Efeito recessivo"). Substitui o nome "efeito recessivo", que fazia pensar em genética.

- **Uso** é cada ovo em que o jogador lança a palavra, no início da incubação.
- O desgaste vale no **save inteiro**, com um contador por palavra normalizada. Vale para todas as raças.
- O primeiro uso tem força total. Cada uso seguinte multiplica a força por **0,75** (número inicial, para ajustar no balanceamento): força = 0,75 ^ (usos anteriores).
- A força multiplica os 2 lados do efeito. O sorteio da palavra não muda. Exemplo: +4/−1 → +3/−0,75 → +2,25/−0,56.
- A palavra **não recupera força**. Não existe corte: o efeito fica cada vez menor, sem chegar a zero.
- O ovo **fixa a força** no início da incubação, e o monstro fica com ela por toda a vida. O desgaste não muda monstros que já nasceram.

**Por quê desgaste:** sem ele, o jogador acha uma palavra boa, usa essa palavra em todos os ovos e para de explorar.

**Por quê queda proporcional:** os 2 lados caem juntos, então o trade-off continua e a soma tende a zero. Uma queda de 1 ponto por uso eliminaria o lado negativo.

**Por quê sem recuperação:** a palavra rara vira um recurso limitado, e o jogador decide em qual ovo usá-la. Com recuperação, bastaria esperar.

## Caderno de palavras

- Lista cada palavra já usada ou estudada, com os 2 stats afetados, o número de usos e a força atual.

**Por quê:** a regra do desgaste é fixa, então esconder o desgaste não cria mistério. O jogador só teria de anotar tudo em um papel.

## Em aberto

- Estudo de palavras, desgaste e caderno ainda não estão no protótipo.
