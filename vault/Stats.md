# Stats

Parte de [[Visão geral]].

## Decidido

- O monstro tem 6 stats, iguais ao Monster Rancher 2: **Vida, Força, Inteligência, Precisão, Velocidade, Defesa**. Escala de 0 a 999.
- Cada stat tem uma **taxa de ganho**: diz quanto o treino aumenta aquele stat. Ver [[Treino semanal]].
- A taxa de ganho vem de duas partes:
  1. **Base da raça**: nota fixa por stat (E a A), igual para todos da mesma raça.
  2. **Variação individual**: vem dos **alelos herdados dos pais** (ver [[Procriação]]). Pais fictícios têm alelos em uma faixa em torno da base (ver [[Ovo]]).
     *Mudança (versão 2):* antes, cada ovo rolava ±10% direto sobre a base. Trocado para alelos para que todo ovo siga a mesma regra da procriação.
- O jogo guarda a taxa como **número**. A tela mostra uma **letra** (E a A).
- Faixa da taxa: **0,5 a 1,5**. O número multiplica o ganho do treino (1,0 = ganho normal). Letras (limite inferior incluso):

  | Letra | Faixa |
  |---|---|
  | E | 0,5 a 0,7 |
  | D | 0,7 a 0,9 |
  | C | 0,9 a 1,1 |
  | B | 1,1 a 1,3 |
  | A | 1,3 a 1,5 |

- Valores base de cada raça: ver [[Raças]].
- Os **stats iniciais** do recém-nascido também vêm da base da raça mais uma variação de **±10%** rolada no ovo.
- A variação **pode passar** dos limites 0,5 e 1,5 (ex.: 1,4 × 1,1 = 1,54). Não há corte.
  **Por quê:** abre espaço para monstros excepcionais, sobretudo via [[Procriação]].
- A [[Palavra]] aplica bônus e penalidades sobre essa taxa.
- Na [[Procriação]], o filho herda a taxa de ganho, não os stats acumulados.

**Por quê variação individual:** combina com a ideia de "genética realista". Dois monstros da mesma raça podem ter potencial diferente.

**Por quê número interno:** a [[Procriação]] precisa misturar taxas dos pais. A média de duas letras não existe; a média de dois números existe.

## Letra fora da faixa

Decidido no mapa de design (ticket "Fluxo de telas do ciclo completo").

- Taxa de **1,5 ou mais**: letra **S**. Com ovos do Mundial, a taxa genética chega a cerca de 1,82 (ver [[Procriação]]).
- Taxa **abaixo de 0,5**: letra **F**. Isso acontece com o ovo grátis e uma palavra ruim (ex.: 0,6 × 0,9 − 0,15 ≈ 0,39).

**Por quê:** são só 2 letras novas, e o jogador já conhece o padrão S de outros jogos. As alternativas foram A+ e E−; S e SS (a partir de 1,7), que faz a taxa S parecer comum; e a letra com o número ao lado, que mostra a genética escondida de forma muito direta.
