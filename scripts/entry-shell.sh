#!/usr/bin/env bash

# Проверяем, установлен ли xonsh
if command -v xonsh >/dev/null 2>&1; then
  exec xonsh
else
  echo "xonsh не найден. Убедитесь, что он установлен."
  exec bash
fi
