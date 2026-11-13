# Protótipo jogável

Versão jogável do jogo, que cresce em etapas. Parte de [[Visão geral]].

## Versão 3 (próxima): ciclo completo

Objetivo: jogar um ciclo inteiro, que é criar, treinar, competir em torneios e procriar a próxima geração, com save no navegador. Todas as regras de design vêm do mapa de design (DAN-5) e das notas deste vault. O monstro ainda aparece só como texto e números.

Spec: [DAN-27](https://linear.app/daniel-gurgel-space/issue/DAN-27/spec-prototipo-jogavel-versao-3-ciclo-completo). A spec tem as user stories, os módulos e os testes. Os tickets de implementação saem dela.

O protótipo deve medir estes riscos: uma rotina que serve para todos os monstros ([[Treino semanal]]), Força forte demais ([[Batalha]]), Inteligência sem uso ([[Atributos de estado]]) e dinheiro sobrando ([[Economia]]).

## Versão 2: ovo, palavra e incubação

Objetivo: testar a criação de monstro com genética e palavra.

1. O jogador começa com 1000 de dinheiro e compra 1 de 5 ovos na loja ([[Ovo]]). Cada ovo mostra os pais fictícios.
2. Na semana 1, começa a incubação: o jogador digita uma [[Palavra]].
3. A incubação dura **4 semanas**, dentro das 52. O jogador passa cada semana com um clique.
4. O ovo choca na semana 5. A tela revela o efeito da palavra. A taxa do filho vem dos alelos dos pais ([[Procriação]]).
5. Da semana 5 à 52 (48 semanas), o jogador treina ([[Treino semanal]]).
6. No fim, a tela mostra os stats finais.

**Por quê 4 semanas sem ação:** a incubação ainda não tem personalidade (temperatura, umidade, música). Essas semanas ganham conteúdo quando a [[Personalidade]] entrar.

## Versão 1

Escolher 1 de 3 raças, chocar na hora (base da raça ±10%) e treinar 52 semanas.

## Fora do protótipo (ainda)

- Arte: o monstro aparece só como texto e números.
- Personalidade, mutação, estudo de palavras, procriação entre monstros do jogador, batalha, exploração.
- Save.

## Em aberto

- A tela mostra "A" ou "E" para taxa fora de 0,5 a 1,5. A regra decidida é S e F (ver [[Stats]]). As telas do ciclo completo estão em [[Fluxo de telas]].
