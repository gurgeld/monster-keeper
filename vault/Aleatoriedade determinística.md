# Aleatoriedade determinística

Parte de [[Visão geral]].

## Decidido

Toda mecânica com aleatoriedade (rolagem de ovo, efeito de palavra, mutação, herança) usa uma **seed guardada no save**. Com a mesma seed e as mesmas ações, o resultado é igual.

**Por quê:** permite testes automáticos e reproduzir bugs.

## Seed por evento

Decidido no mapa de design (ticket "Saves"). Ver [[Save]].

- Cada sorteio calcula a própria seed a partir da seed da partida, da semana, do ID do monstro (ou do ovo) e do tipo de sorteio.
- O save não guarda a posição de um gerador. Carregar o save não muda nenhum resultado.
- Todo monstro tem um ID fixo.
- O save guarda a seed da partida como texto, porque o JSON transforma números em decimais e pode alterar uma seed de 64 bits.

**Por quê:** com um único gerador, uma mecânica nova muda a ordem e altera todos os sorteios seguintes. Com a seed por evento, um sorteio não afeta o outro.

**Mudança no código:** hoje, `game.gd` usa um único gerador. Isso muda quando o save for implementado.

Usado em: [[Ovo]], [[Palavra]], [[Personalidade]], [[Mutação]], [[Procriação]], [[Economia]] (troca da loja).
