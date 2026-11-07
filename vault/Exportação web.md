# Exportação web

Parte de [[Visão geral]]. O jogo é exportado em HTML e publicado no GitHub Pages.

## Decidido

- Preset de exportação **Web**, em `project/export_presets.cfg`. Saída em `etc/build/web/` (fora do git).
- **Thread Support desligado.**
  **Por quê:** builds com threads precisam de cabeçalhos HTTP especiais (COOP/COEP). O GitHub Pages não permite configurar esses cabeçalhos.
- Renderizador **Compatibility** (o único que funciona na web).
- Ordem: primeiro exportar e testar localmente; depois publicar automaticamente com GitHub Actions.

## Consequências

- Não usar threads no código do jogo.
- O save fica no armazenamento do navegador e pode se perder. Regras em [[Save]].
