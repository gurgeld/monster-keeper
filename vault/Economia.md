# Economia

De onde vem e para onde vai o dinheiro. Parte de [[Visão geral]].

Decidido no mapa de design (ticket "Economia") e revisto com as chances reais de título (ticket "Rever a economia com as chances reais de título"). Os números são iniciais, para ajustar no balanceamento.

## Fontes e saídas

- **Fontes:** só prêmios de torneio e vendas. Não existe renda semanal.
- **Saídas:** ovos da loja, vagas, taxas de inscrição e estudo de palavras (ver [[Palavra]]).
- **Sem manutenção:** o rancho não custa dinheiro por semana.

**Por quê só estas fontes:** todo dinheiro vem de uma decisão do jogador, e o calendário fixo limita a renda. O Regional grátis garante uma fonte para quem não tem dinheiro.

**Por quê sem manutenção:** a vaga já limita o tamanho do rancho, e a idade já cria o prazo. A manutenção pode deixar o saldo negativo, e isso exige uma regra para dívida.

## Início do jogo

- O jogo começa com **1000** de dinheiro. Em geral, o jogador compra 1 ovo, e o primeiro objetivo é conseguir o segundo.

**Por quê 1000:** com este valor, a escolha do preço pesa desde o início, porque um ovo barato deixa mais dinheiro para o segundo. A alternativa era 1500, que compra um par em quase toda loja que tem um. O custo de 1000 é um atraso: com as chances reais, o dinheiro chega a cerca de 370 na semana 60, e o segundo ovo vem entre as semanas 60 e 90. O segundo monstro chega ao auge perto da semana 110, quando o primeiro fica velho. Os dois ainda podem procriar, porque a procriação vale do auge até a morte (ver [[Procriação]]).
  *Mudança (ticket "Rever a economia"):* antes, o texto dizia que os dois se encontravam no auge. A alternativa de começar com 1500 traz o segundo ovo mais cedo, mas aumenta a sobra no fim (ver "Riscos a testar").

## Loja

- A loja mostra **5 ovos**. A fórmula de preço fica em [[Ovo]].
- O jogador compra quantos ovos quiser, se tiver dinheiro.
- A cada **4 semanas**, a loja troca os ovos não comprados, pela [[Aleatoriedade determinística|seed]]. Um ovo comprado não volta.
- A loja não garante um par.

**Por quê 5 ovos:** com 3, a loja tem um par (mesma raça e sexos diferentes) só em 42% das vezes. Com 5, tem em 80%.

**Por quê sem par garantido:** cada troca tem cerca de 60% de chance de trazer a raça certa com o outro sexo, e em duas trocas a chance é de cerca de 84%. Esperar custa semanas de vida do monstro, então a espera é uma decisão real.

## Torneios

| Nível | Taxa de inscrição | Campeão | Vice |
|---|---|---|---|
| Regional | 0 | 120 | 50 |
| Nacional | 150 | 600 | 250 |
| Mundial | 400 | 1500 | 600 |

- O 3º e o 4º lugares não recebem prêmio e perdem a taxa de inscrição.
- O campeão recebe um ovo só quando luta no **nível atual** dele. Ver [[Batalha]], seção "Prêmio".

**Por quê o prêmio do Regional é baixo:** um monstro forte pode voltar a lutar nele.

**Por quê ovo só no nível atual:** em um modelo simples, a venda de ovos de prêmio foi a maior fonte de renda, com cerca de 13 mil em 312 semanas, contra 7 a 9 mil de cada nível de torneio. Com esta regra, a venda rende cerca de 4 mil. A alternativa era dar ovo em todo título e vender por 10% do preço de loja, mas a venda ainda rendia cerca de 6,7 mil.

## Vagas

| Vaga | Preço |
|---|---|
| 4ª | 1000 |
| 5ª | 2000 |
| 6ª | 4000 |

**Por quê estes preços:** com as chances reais, a 4ª vaga chega por volta da semana 125, quando a procriação começa e o jogador precisa de espaço para os filhos. A 5ª chega por volta da 166 e a 6ª por volta da 211, na 2ª geração. Cada vaga aumenta o trabalho e a renda possível de venda, então ela deve vir devagar.
  *Mudança (ticket "Rever a economia"):* antes, os preços eram 1500, 3000 e 6000. Com as chances reais, a 6ª vaga chegava na semana 243, depois do alvo (semanas 152 a 204).

## Venda

- **Ovo guardado:** 20% do preço de loja, com o limite de 400 a 900 da fórmula. Assim, ele vale de 80 a 180. A regra é a mesma para toda origem, e o ovo de procriação usa as taxas dos pais.
- **Monstro:** depende só do nível. Na fase velha, vale a metade.

| Nível do monstro | Preço de venda |
|---|---|
| Regional | 100 |
| Nacional | 300 |
| Mundial | 800 |

As regras que limitam a venda ficam em [[Progressão]], seção "Venda".

**Por quê o ovo vale pouco:** o ovo do Mundial vale muito mais na linhagem do que na venda. No pior caso (1 macho e 5 fêmeas), a venda rende no máximo cerca de 75 por semana.

**Por quê o monstro depende só do nível:** se stats e títulos contassem, treinar para vender viraria uma fonte de renda. Um monstro Mundial vale menos que 1 título Mundial. O jogador pode vender antes da morte, mas o monstro vendido não entra no memorial.

## Ovo grátis

- O jogador recebe 1 ovo grátis quando não tem monstro, não tem ovo e o dinheiro é **menor que o preço do ovo mais barato da loja**.
- A raça é sorteada pela seed. Os alelos ficam de **−10% a 0%** da base. Ver [[Ovo]].

**Por quê:** o jogo não trava em nenhuma loja, mesmo quando o jogador tem algum dinheiro, mas não pode comprar. A regra que bloqueia a última venda impede o abuso (ver [[Progressão]]).

## Riscos a testar

- **Modelo de renda:** o modelo usa as chances medidas na batalha ([[Batalha]], seção "Torneio") e as fases de idade ([[Treino semanal]]). O monstro luta só no nível atual, só com raça predominante favorável ou espelho. Um monstro da 1ª geração rende cerca de 3400 líquidos na vida (de 1500 a 5500), e um da geração seguinte cerca de 5200. Mais da metade chega na fase velha, com títulos do Mundial. As taxas levam cerca de 40% do bruto, mas a inscrição ainda dá lucro. O modelo não inclui a venda de ovos de prêmio, a volta ao Regional para ganhar dinheiro nem o estudo de palavras. Protótipo na branch `prototype/battle-balance`.
- **Dinheiro sobrando:** no modelo, o jogador acumula de 11 a 23 mil até a semana 312, porque depois da 6ª vaga sobram poucas saídas. O estudo de palavras custa 100, sem limite, o que dá de 110 a 230 estudos com esta sobra (ver [[Palavra]]). Nada obriga o jogador a estudar, então o protótipo jogável deve medir se o dinheiro ainda sobra.
