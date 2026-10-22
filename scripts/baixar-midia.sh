#!/usr/bin/env bash
# Baixa imagens e PDFs do site atual (WordPress) para dentro do projeto.
# Uso (na pasta do projeto):  bash scripts/baixar-midia.sh
set -u
cd "$(dirname "$0")/.."
ORIGEM="https://indeletra.com.br"
ok=0; falha=0
while IFS= read -r caminho; do
  [ -z "$caminho" ] && continue
  case "$caminho" in
    /uploads/*) url="$ORIGEM/wp-content$caminho" ;;
    /pdf/*)     url="$ORIGEM$caminho" ;;
    *) continue ;;
  esac
  destino="public$caminho"
  mkdir -p "$(dirname "$destino")"
  if [ -s "$destino" ]; then ok=$((ok+1)); continue; fi
  if curl -fsSL -A "Mozilla/5.0" -o "$destino" "$url"; then
    echo "ok     $caminho"; ok=$((ok+1))
  else
    echo "FALHOU $caminho"; rm -f "$destino"; falha=$((falha+1))
  fi
done < scripts/midia.txt
echo
echo "Concluído: $ok arquivos ok, $falha com falha."
[ "$falha" -gt 0 ] && echo "Os que falharam podem ser baixados pelo painel do WordPress (Mídia) ou pelo FTP da hospedagem atual."
exit 0
