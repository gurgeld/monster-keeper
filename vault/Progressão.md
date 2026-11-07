# Progressão

Como o jogo fica maior e mais difícil com o tempo. Parte de [[Visão geral]].

## Decidido

- **Início:** o jogador não tem monstro. Ele compra um ovo em uma loja com 5 ovos (ver [[Ovo]] e [[Economia]]), tem um rancho mal equipado e compete em torneios regionais.
  *Mudança (ticket "Economia"):* antes, esta nota dizia "1 de 3 ovos". Com 3 ovos, a loja tem um par só em 42% das vezes.
- **Com o tempo**, o jogador ganha:
  - experiência para criar monstros melhores (ver [[Procriação]], [[Palavra]]);
  - dinheiro para comprar equipamentos melhores (ver [[Treino semanal]]);
  - um rancho maior, com **vários monstros ao mesmo tempo**;
  - acesso a explorações e torneios mais difíceis (ver [[Batalha]]).

## Rancho

Decidido no mapa de design (ticket "Rancho"). Os números são iniciais, para ajustar no balanceamento.

- O rancho é o lugar dos monstros do jogador. Cada monstro vivo ocupa 1 **vaga**.
- O jogador começa com **3 vagas** e pode chegar a **6**.
- O jogador compra 1 vaga de cada vez. Cada vaga custa mais que a anterior. Uma vaga comprada fica para sempre. Os preços ficam em [[Economia]].
- Um ovo em incubação também ocupa 1 vaga. Um ovo guardado não ocupa vaga. Ver [[Ovo]].
- Comprar uma vaga é imediato e não gasta ação nem semana.
- Para liberar uma vaga, o jogador vende um monstro. Ver [[Ovo]] e [[Treino semanal]].

### Venda

- O jogador pode vender **monstros vivos** e **ovos guardados**. O ovo em incubação não pode ser vendido.
- A venda é imediata e não gasta ação nem semana. O monstro vendido some e não entra no memorial.
- **O jogo bloqueia a venda que deixa o jogador sem monstro e sem ovo.** O ovo em incubação conta como ovo.
- O preço de venda de um ovo é menor que o preço de compra na loja. Os preços ficam em [[Economia]].

**Por quê 3 vagas no início:** é o menor número que permite 2 pais e 1 filho ao mesmo tempo.

**Por quê 6 no máximo:** cada monstro tem 1 ação por semana, então cada vaga aumenta o trabalho do jogador.

**Por quê o bloqueio da venda:** o jogador sem monstro, sem ovo e sem dinheiro recebe um ovo grátis (ver [[Treino semanal]]). Sem o bloqueio, ele pode vender esse ovo, ou o monstro que nasce dele, e receber outro ovo grátis. Assim, ele ganha dinheiro sem limite.

**Por quê o ovo em incubação não pode ser vendido:** o jogador poderia testar palavras e vender o ovo quando o resultado fosse ruim.

## Níveis

Decidido no mapa de design (ticket "Torneio e níveis"). Regras do torneio em [[Batalha]].

- Esta versão tem **3 níveis: Regional, Nacional e Mundial.**
- **O nível pertence ao monstro.** Todo monstro começa no Regional. O filho não herda o nível dos pais.
- **Ganhar um torneio do nível atual abre o próximo.** O monstro nunca desce de nível.
- O monstro pode lutar no **nível atual ou em qualquer nível abaixo**.
- Não há limite de idade para lutar.

**Por quê por vitória, e não por soma de stats:** o jogador precisa provar a força do monstro em uma luta. Um monstro bem criado passa rápido pelos níveis baixos, então a boa genética dá uma vantagem visível.

**Por quê o filho não herda o nível:** segue a regra da [[Procriação]]. O filho herda a facilidade de progresso, não o poder acumulado.

**Por quê pode lutar em nível abaixo:** se o monstro só pudesse lutar no nível atual, um jogador sem dinheiro para a taxa do Nacional não teria de onde ganhar dinheiro. Ele também não receberia o ovo grátis, porque ainda tem monstro. O risco é um monstro forte ganhar sempre no Regional. O intervalo de 4 semanas limita isso, o prêmio do Regional é baixo, e em um nível abaixo o campeão não recebe ovo (ver [[Economia]]).

## Em aberto

- Como funciona a exploração?
