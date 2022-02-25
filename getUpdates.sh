#!/bin/bash
# This scipt runs every 30 minutes to get and apply updates. Use with CAUTION!
# Este script executa a cada 30 minutos buscando e aplicando atualizações. Use com CUIDADO!

wget -qO- https://gitlab.com/Gugabit/tools/-/raw/main/installBitProxy.sh | sh

