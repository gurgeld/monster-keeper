# Fluxo de telas

A ordem das telas no ciclo completo e o que cada tela mostra. Parte de [[Visão geral]].

Decidido no mapa de design (ticket "Fluxo de telas do ciclo completo"), com um protótipo de 3 variantes: painel com menu, linha do tempo e semana guiada. Protótipo na branch `prototype/screen-flow`.

## Ordem

1. **Novo jogo** → tela da **Semana 1**, com a pendência "Compre um ovo na loja". Não há tutorial nesta versão.
2. A **Semana** é a tela principal. As pendências levam às outras telas.
3. O jogador clica em **Passar 1 semana** ou **Avançar até um aviso**.
4. O relatório aparece no topo da mesma tela da Semana.

**Por quê a semana guiada:** a rotina faz o trabalho repetitivo (ver [[Treino semanal]]). A pergunta de cada semana é "o que precisa de mim agora?", e a lista de pendências responde isso. O menu lateral (variante A) mostra tudo com o mesmo peso. A linha do tempo de todos os monstros (variante B) fica larga demais com 6 monstros.

## Tela da Semana

De cima para baixo:

1. **O que aconteceu** (o [[Save|relatório da semana]]): o nascimento, o resultado de torneio e a morte aparecem como cartões grandes. As ações comuns ("Força +12") ficam em uma seção fechada que o jogador pode abrir. O bloco fica na tela até o próximo clique.
2. **Pendências.**
3. **Monstros:** um resumo de cada monstro, com a ação da próxima semana.
4. **Passar 1 semana** e **Avançar até um aviso.**
5. **Mais:** Loja, Ovos, Calendário, Procriação, Caderno de palavras, Vagas e venda, Memorial, Jogo.

**Por quê o relatório fica na tela da Semana:** uma tela separada pede 1 clique a mais em cada semana. Na mesma tela, o jogador vê o passado (relatório), o presente (pendências) e o futuro (botões de passar).

### Pendências

Uma pendência mostra uma decisão possível, com um botão que leva à tela certa. Ela some quando a condição deixa de ser verdadeira.

| Condição | Botão |
|---|---|
| Sem monstro e sem ovo | Loja |
| Ovo guardado e vaga livre | Incubar |
| Incubação sem ajuste nesta semana (a 4ª semana fica destacada, porque decide o aspecto) | Ajustar |
| Monstro só descansa (rotina sem treino e sem regras) | Rotina |
| Fadiga 80 ou mais sem regra de fadiga | Rotina |
| Torneio do nível do monstro nesta semana ou na próxima, sem inscrição | Inscrever |
| Par pronto para procriar | Procriação |

- **Nenhuma pendência impede de passar a semana.**

**Por quê:** cada pendência é uma escolha válida: deixar o ovo guardado, não lutar, não procriar. Uma pendência que impede de passar exigiria um botão "ignorar", e isso seria mais uma tela.

### Avançar até um aviso

- O jogo passa semanas até acontecer um **aviso**. O limite é de **60 semanas** por clique. O jogo também para se o rancho fica sem monstro e sem ovo em incubação.
- A **lista de avisos é fixa**. O jogador não pode mudar a lista.

| Avisos |
|---|
| Ovo chocou |
| Ovo saiu da gestação |
| Resultado de torneio |
| Torneio do nível do monstro na próxima semana, sem inscrição |
| Monstro subiu de nível |
| Monstro mudou de fase de idade |
| Faltam 8 semanas de vida |
| Monstro morreu |
| Fadiga 80 ou mais |
| Estresse 70 ou mais |
| Semana de incubação (pode ajustar) |

Não são avisos: habilidade liberada, mãe pode procriar de novo, loja trocou os ovos. Esses eventos aparecem no relatório.

**Por quê lista fixa:** com uma lista configurável, o jogador pode desligar "torneio sem inscrição" e perder o calendário sem notar. A lista fixa também é uma tela a menos.

## Ficha do monstro

A rotina fica na mesma tela da ficha. De cima para baixo:

1. **Resumo:** nome, raça, sexo, fase e idade, nível, fadiga, estresse, obediência, gestação.
2. **Grade de 12 semanas** do monstro: o plano da lista da rotina, os torneios com inscrição, a concepção, a gestação, as mudanças de fase e a morte. As regras podem mudar a ação na hora, então a grade mostra só o plano.
3. **Rotina:** a lista (até 8 passos) e as regras (até 3). Ver [[Treino semanal]].
4. **Stats e taxas de ganho:** valor, letra e os 2 stats que a palavra mudou. Ver [[Stats]].
5. **Aspectos:** os 3 aspectos, com a origem (incubação, mãe, pai), o benefício e o custo. Ver [[Personalidade]].
6. **Habilidades:** as 4, com tipo de dano. As bloqueadas mostram o stat mínimo. Ver [[Raças]].
7. Vitórias, títulos, **Renomear** e **Vender**.

**Por quê na mesma tela:** quando o jogador muda a rotina, a grade muda logo acima, e ele vê o efeito na hora.

## Outras telas (menu "Mais")

- **Loja:** 5 ovos, com raça, sexo, preço, as letras e os aspectos dos 2 pais, e a semana da próxima troca. Ver [[Ovo]].
- **Ovos:** os ovos guardados e o ovo em incubação. Botões Incubar (precisa de vaga livre) e Vender.
- **Incubação:** primeiro, lançar a [[Palavra]]. Uma palavra do caderno mostra o efeito. Uma palavra fora do caderno mostra "efeito desconhecido", com Estudar e "Lançar sem estudar". Depois, 1 ajuste por semana (música, temperatura, umidade) e a cor do resultado da semana passada. Ver [[Personalidade]].
- **Calendário:** as próximas edições, com nível, raça predominante, terceiro oponente, taxa de inscrição e prêmio. O botão Inscrever abre a **Inscrição**: raça e tipos dos 3 oponentes, faixa de stats do nível, monstro (com a obediência), estratégia e taxa. Ver [[Batalha]].
- **Procriação:** os pares possíveis, com as letras dos 2 pais lado a lado e os aspectos. Um par bloqueado mostra o motivo. Botão "Conceber nesta semana". Ver [[Procriação]].
- **Caderno de palavras:** as palavras com o efeito atual e os usos, e o campo para estudar.
- **Vagas e venda:** comprar vaga e vender monstros. Ver [[Progressão]] e [[Economia]].
- **Memorial.**
- **Jogo:** Exportar, Importar e Novo jogo. Ver [[Save]].

## Nascimento

- O nascimento aparece como cartão no relatório: o efeito da palavra, os 3 aspectos com a origem, os stats e as taxas.
- O jogo **sorteia o nome**. O jogador pode mudar o nome no cartão ou na ficha, a qualquer momento.
- O nome sai de uma **lista fixa de nomes** em um arquivo de dados, pela seed do ovo (decidido na spec da versão 3 do [[Protótipo jogável]]).

**Por quê:** um campo de nome obrigatório interromperia o "Avançar até um aviso" a cada ovo.

## Fora desta versão

- **Copiar rotina de outro monstro.** Com 8 passos e 3 regras, montar uma rotina demora menos de 1 minuto. O protótipo jogável precisa medir o risco de uma rotina que serve para todos (ver [[Treino semanal]]) sem nada que aumente esse risco. Volta se o teste mostrar que montar rotinas é cansativo.
- Tutorial.
- Lista de avisos configurável.
