# Save

Como o jogo guarda a partida. Parte de [[Visão geral]]. Decidido no mapa de design (ticket "Saves"). Como o Godot grava na web: ver [[Exportação web]].

## O que o save guarda

O save é uma **foto do estado atual**, em JSON. O jogo não guarda a lista de ações para repetir ao carregar.

**Guarda:**

- **Partida:** seed da partida (como texto), semana, dinheiro, vagas, calendário de torneios e loja.
- **Caderno de palavras:** usos de cada palavra normalizada. Ver [[Palavra]].
- **Monstros vivos:** ID fixo, sexo, raça, stats, alelos, taxas de ganho, aspectos, atributos de estado, idade, nível, habilidades liberadas, rotina, inscrição em torneio, vitórias, títulos, palavra e força da palavra. Na mãe, também a gestação e a recuperação. Ver [[Procriação]].
- **Ovos:** raça, sexo, seed, dados dos pais (cópia) e, se estiver em incubação, o estado da incubação.
- **Memorial:** os registros dos monstros mortos.
- **Relatório da semana:** o resultado que o jogador ainda não viu.

**Não guarda:**

- **Dados de design:** a raça fica só como um ID (ex.: `tatuco`). As regras vêm do jogo.
- **Valores calculados:** ex.: a letra da taxa de ganho.
- **Histórico de lutas:** só vitórias e títulos de cada monstro.

As listas de monstro e ovo crescem com as decisões seguintes. A obediência não entra, porque é um valor calculado. O monstro guarda a última estratégia usada, e a inscrição guarda a estratégia da edição.

**Por quê foto:** se o save repetisse as ações, uma mudança de balanceamento alteraria o passado. Um monstro poderia "renascer" com outros stats.

## Quando salva

- **Só salvamento automático.** Não há botão de salvar.
- O jogo salva depois de cada semana e de cada ação imediata: comprar, vender, lançar palavra, mudar rotina, inscrever em torneio.
- **Ordem da semana:** o jogo calcula a semana inteira, salva e só depois mostra o relatório. Se a aba fechar durante uma luta, o resultado não muda, e o relatório aparece quando o jogador voltar.

**Por quê sem salvamento manual:** o jogador poderia salvar, lançar uma palavra e carregar de novo se não gostasse do resultado. Isso anularia o Desgaste e a regra que impede a venda do ovo em incubação.

## Quantos saves e como recomeçar

- **1 save por navegador.**
- O botão **Novo jogo** pede confirmação, avisa que apaga o save atual e sorteia uma seed nova. O jogador não escolhe a seed.
- Nada passa da partida antiga para a nova. Os efeitos das palavras e a relação entre música e par também mudam.
- Não há fim de jogo. A partida continua enquanto o jogador quiser.

**Por quê 1 save:** vários saves exigem uma tela de escolha e não mudam o ciclo do jogo. Quem quiser outra partida pode exportar a atual.

## Exportar e Importar

- **Exportar** baixa um arquivo com o save.
- **Importar** valida o arquivo, pede confirmação e substitui o save atual.
- O arquivo não tem criptografia. O jogador pode editar o arquivo ou reimportar um save antigo. O risco é aceito, porque o jogo é para um jogador só.

**Por quê:** o save fica preso ao navegador e pode se perder. Exportar é a única forma de backup.

**A testar na implementação:** o envio de arquivo no Godot 4.7 web ainda não foi testado. Se falhar, a alternativa é copiar e colar o texto do save.

## Mudança de versão

- O save guarda `save_version`. Cada versão tem uma função que leva o save para a versão seguinte, em sequência.
- **Antes de migrar,** o jogo guarda uma cópia do save original.
- **Mudança de balanceamento:** os monstros existentes mantêm os valores. Só os sorteios futuros usam as regras novas.
- **Save mais novo que o jogo** (ex.: versão antiga no cache): o jogo não abre o save e não o altera.
- **Migração impossível:** o jogo mostra uma mensagem e oferece Exportar e Novo jogo. Ele nunca apaga o save sozinho.

## Proteção contra perda

- Ligar `use_custom_user_dir` com um nome fixo. **Por quê:** o caminho do save usa o nome do projeto. Se o nome mudar, o save antigo fica invisível.
- Mostrar um aviso quando `OS.is_userfs_persistent()` indicar que o save não fica guardado (ex.: aba anônima). A função pode dar falso positivo, então o aviso não é uma garantia.
- Manter o save anterior como cópia. Se o arquivo principal estiver inválido, o jogo carrega a cópia e avisa o jogador. **Por quê:** a gravação é assíncrona, e a aba pode fechar durante a gravação.
