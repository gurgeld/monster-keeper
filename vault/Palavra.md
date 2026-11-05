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

## Estudo de palavras

- O jogador paga um custo (tempo ou dinheiro) para testar uma palavra e aprender o efeito dela sem gastar um ovo.
- Cada palavra tem um **efeito recessivo**: o efeito diminui a cada uso. O desvio padrão dos bônus diminui e a soma dos efeitos tende a zero.

## Em aberto

- Efeito recessivo: "uso" significa cada ovo incubado com a palavra? O estudo também conta como uso? O desgaste vale por save?
- Como a palavra vira modificador? (hash da palavra + variável do save → modificador por stat?)
- Qual o tamanho dos modificadores na escala da taxa (0,5 a 1,5)? O "+2" das anotações é em qual unidade?
