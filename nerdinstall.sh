#!/bin/bash

echo "INSTALACION DE NERD FONTS"
echo "---------------------------------"
echo "Este script instalará las fuentes Nerd Fonts en tu sistema."
echo "Asegúrate de tener wget y unzip instalados."
echo "---------------------------------"
echo "Se instalarán las siguientes fuentes: Agave, CascadiaCode, CodeNewRoman, DejaVuSansMono, DroidSansMono, FiraCode, FiraMono, Hack, Iosevka, JetBrainsMono, LiberationMono, Meslo, Monoid, NerdFontsSymbolsOnly, Ubuntu, UbuntuMono y VictorMono."
read -p "¿Deseas continuar? [s/N]: " choice
if [[ ! "$choice" =~ ^[sS]$ ]]; then
  echo "Instalación cancelada."
  exit 0
fi

declare -a fonts=(
  Agave
  CascadiaCode
  CodeNewRoman
  DejaVuSansMono
  DroidSansMono
  FiraCode
  FiraMono
  Hack
  Iosevka
  JetBrainsMono
  LiberationMono
  Meslo
  Monoid
  NerdFontsSymbolsOnly
  Ubuntu
  UbuntuMono
  VictorMono
)

version='3.4.0'
fonts_dir="${HOME}/.local/share/fonts"

mkdir -p "$fonts_dir"

for font in "${fonts[@]}"; do
  zip_file="${font}.zip"
  font_path="${fonts_dir}/${font}"

  if [[ -d "$font_path" ]]; then
    read -p "La fuente '$font' ya está instalada. ¿Deseas sobrescribirla? [s/N]: " choice
    case "$choice" in
    [sS]*)
      echo "Sobrescribiendo $font..."
      rm -rf "$font_path"
      ;;
    *)
      echo "Omitiendo $font."
      continue
      ;;
    esac
  fi

  download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
  echo "Descargando $font desde $download_url"
  wget -q --show-progress "$download_url"
  unzip -q "$zip_file" -d "$font_path" -x "*.txt/*" -x "*.md/*"
  rm "$zip_file"
done

# Elimina archivos no necesarios y actualiza la caché de fuentes
find "$fonts_dir" -name '*Windows Compatible*' -delete
fc-cache -fv
