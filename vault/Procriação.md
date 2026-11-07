# Procriação

Forma de criar novos monstros a partir de dois pais. Parte de [[Visão geral]].

## Decidido

- As **habilidades não são herdadas**. A raça define a lista (ver [[Raças]]). A linhagem age de forma indireta: um filho com taxa de ganho alta chega mais cedo ao stat mínimo de uma habilidade.
  *Mudança (ticket "Habilidades das raças"):* antes, a procriação misturava as habilidades dos pais com pesos. No teste, alelos de peso quase não mudaram a luta: com ±10% não houve mudança de uso, e com ±50% a habilidade favorecida ganhou só de 1 a 3 pontos. Herdar a habilidade já liberada contraria a regra de não herdar poder acumulado.
- O filho herda a **facilidade de progresso** (taxa de ganho, ver [[Stats]]), não o poder acumulado.
- Os **stats iniciais não vêm dos pais**: o filho usa a base da raça ±10%, igual a qualquer ovo (ver [[Stats]]).
- O filho herda **um aspecto de personalidade aleatório de cada pai**, sorteado quando o ovo choca. A incubação vem primeiro: a mãe não pode passar o aspecto da incubação nem o oposto dele. O pai também não pode passar esses aspectos, nem o aspecto da mãe ou o oposto dele (ver [[Personalidade]]).
- O **perfil do ovo não é herdado**: cada ovo sorteia o próprio perfil (ver [[Personalidade]]).
- O resultado da procriação é um [[Ovo]].
- É a **regra única** de criação: ovos de loja, expedição e torneio vêm de pais fictícios (ver [[Ovo]]).
- A [[Mutação]] não é herdada.
- Herança segue [[Aleatoriedade determinística]].
- Os pais precisam estar **vivos** e na fase **auge ou velho**. O jovem não procria. O monstro morto não procria. Ver [[Treino semanal]], seção "Tempo de vida".

## Par

Decidido no mapa de design (ticket "Procriação").

- O par vem **só do rancho**. Não existe parceiro externo.
- Os 2 monstros são da **mesma raça**. A raça do ovo é a raça dos pais.
- O par tem **1 macho e 1 fêmea**. A fêmea é a mãe, e o macho é o pai.
- O sexo é sorteado na criação do ovo, com 50% para cada lado, e o jogador o vê sempre: na loja, nos ovos guardados e nos prêmios (ver [[Ovo]]).
- **Parentes podem procriar**, sem penalidade.

**Por quê só no rancho:** *decisão do Daniel.* A alternativa era um parceiro pago, gerado como pai fictício. Sem ele, o jogador precisa planejar a linhagem.

**Por quê mesma raça:** as letras dos pais podem ser comparadas, e a raça mantém a identidade. Com alelos de raças diferentes, o filho poderia juntar o melhor de cada raça. A soma das taxas chegaria a cerca de 8,7, com taxa A em quase tudo.

**Por quê o sexo é visível:** dois ovos da mesma raça têm 50% de chance de não formar um par. O ovo dá previsibilidade, então o jogador precisa ver isso antes de investir semanas nos monstros.

**Por quê parentes sem penalidade:** os alelos são só números, e não existem defeitos escondidos. Uma penalidade seria uma regra nova, sem base na genética do jogo.

## Concepção, gestação e recuperação

- **Concepção:** cada pai gasta a ação da semana (ver [[Treino semanal]]). A concepção sempre dá certo. Não há custo em fadiga, stats ou dinheiro.
- **Gestação:** a mãe fica grávida por **9 semanas**. Ela pode treinar e competir, sem mudança no ganho do treino ou na luta. No fim, o ovo vai para os ovos guardados e não ocupa vaga.
- **Recuperação:** depois do ovo, a mãe espera **3 semanas** para procriar de novo. Assim, ela faz no máximo 9 ovos na vida.
- O pai **não tem espera**. Ele pode procriar de novo na semana seguinte.
- **A mãe precisa de 9 semanas de vida** para a concepção. A última semana de vida possível é a 147. O jogo bloqueia a concepção depois disso.
- **O jogador pode vender a mãe grávida.** O jogo avisa, e o ovo se perde.
- **A concepção fixa** a seed do ovo e uma cópia dos dados dos pais (letras, aspectos e alelos). A venda ou a morte do pai não muda a gestação, e o ovo guardado continua válido depois que os pais morrem.

**Por quê há um limite:** sem limite, um par no auge faz 70 ovos em 70 semanas, e o jogador pode vender esses ovos.

**Por quê o limite fica na mãe:** *decisão do Daniel.* O tempo da gestação dá o limite, e a mãe continua útil durante esse tempo. O número de fêmeas e de vagas limita a quantidade de ovos do rancho: com 1 macho e 5 fêmeas, são no máximo 5 ovos a cada 12 semanas.

**Por quê sem custo de fadiga:** *decisão do Daniel.* O custo é a semana de treino que os pais perdem e o tempo da gestação.

**Por quê bloquear no fim da vida:** o jogador nunca perde um ovo por causa de uma conta de semanas.

**Por quê a venda é livre:** vender a mãe não dá vantagem, porque o jogador perde o ovo. Um bloqueio prenderia a vaga por até 9 semanas.

## Genética da taxa de ganho: alelos

- Cada stat tem **2 alelos**. Cada alelo é um número na escala da taxa (ver [[Stats]]).
- A **taxa genética** do stat é a média dos 2 alelos.
- O filho recebe, para cada stat, **1 alelo sorteado de cada pai**.
- O jogador vê a taxa (letra) dos pais, mas **não vê os alelos**.

**Por quê alelos:** é a forma mais simples de "genética realista". Dois pais bons podem ter um filho mediano, e dois pais medianos podem ter um filho excelente, se carregarem alelos bons escondidos.

**Exemplo:** pai com Força (1,2 e 0,8) → taxa 1,0. Mãe com Força (1,1 e 1,1) → taxa 1,1. O filho pode receber (1,2 e 1,1) → 1,15, ou (0,8 e 1,1) → 0,95.

- O bônus da [[Palavra]] **não é genético**: vale só para o monstro que recebeu a palavra e não passa para os filhos. Cada ovo recebe a própria palavra.

### Limite da linhagem

Os alelos do rancho só vêm dos pais, e a procriação só escolhe entre valores que já existem. Por isso, a qualidade do ovo de torneio é a **faixa dos alelos** dos pais fictícios (ver [[Ovo]]). Os números são iniciais, para ajustar no balanceamento.

| Origem do ovo | Faixa do alelo | Soma máxima das 6 taxas |
|---|---|---|
| Loja e Regional | −10% a +10% da base | 6,6 |
| Nacional | 0% a +20% da base | 7,2 |
| Mundial | +10% a +30% da base | 7,8 |

**Por quê:** com ±10% em todo ovo, a melhor linhagem fica só 10% acima da base. Com esta tabela, ganhar um torneio dá um ovo melhor, e a procriação junta os melhores alelos na linhagem. Uma variação a cada herança daria progresso sem limite claro, mas ficaria parecida com a [[Mutação]], que está fora desta versão.
