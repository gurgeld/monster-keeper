# 0001 — Ambiente e plataforma

Data: 2026-10-31

## Decisões
- **Engine:** Godot **4.7.2-stable** (última estável). Mesma versão no editor local, na nuvem e em `project.godot`. Atualizar só de forma deliberada.
- **Linguagem:** GDScript.
- **Plataforma inicial:** PC (testado no editor local). Android depois, quando o jogo estiver satisfatório.
- **Renderer:** Compatibility (seguro para PC, web e Android).
- **Viewport:** retrato 1080x1920, stretch `canvas_items`, aspect `expand`. Janela de teste em 540x960.
- **Mouse emula toque** (`emulate_touch_from_mouse`).
- **Nuvem:** só Godot headless para validar e testar. Sem export templates e sem Android SDK por enquanto.

## Regras para facilitar o port Android
- UI com alvos grandes, sem hover, clique direito ou atalho obrigatório.
- Entrada isolada em uma camada própria (nada de teclado ou câmera direto na lógica).
- Saves em `user://`.

## Pendente
- Escolher framework de testes (GUT ou gdUnit4). Hoje só há `project/tests/smoke_test.gd`.
- Quando for ao Android: JDK 17, Android SDK, export templates, keystore (fora do git).

## Como rodar
- Editor local: abrir `project/project.godot` com o Godot 4.7.2 e apertar F5.
- Teste de fumaça: `godot --headless --path project --script res://tests/smoke_test.gd`
- Setup da nuvem: `docs/setup-script.sh`
