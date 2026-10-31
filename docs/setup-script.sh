#!/usr/bin/env bash
# Cole este conteúdo em: menu do ambiente de nuvem (barra de título da sessão) > Edit > Setup script.
# Instala o Godot headless para validar o projeto e rodar testes na nuvem.
# Export templates (1,2 GB) NÃO são instalados: o build é feito no editor local.
set -euo pipefail

GODOT_VERSION="4.7.2-stable"   # manter igual ao editor local e a config/features do project.godot

if ! command -v godot >/dev/null 2>&1 || ! godot --headless --version | grep -q "^${GODOT_VERSION%-stable}"; then
  mkdir -p /opt/godot && cd /opt/godot
  curl -sSL -o godot.zip "https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/Godot_v${GODOT_VERSION}_linux.x86_64.zip"
  unzip -qo godot.zip && rm godot.zip
  ln -sf "/opt/godot/Godot_v${GODOT_VERSION}_linux.x86_64" /usr/local/bin/godot
fi
godot --headless --version
