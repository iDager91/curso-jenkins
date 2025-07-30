#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..."

# Preparar entorno virtual
rm -rf venv
python3 -m venv venv

echo "Instalando dependencias..."
venv/bin/python -m pip install --upgrade pip
venv/bin/python -m pip install -r requirements.txt
mkdir -p reports
echo "Ejecutando pruebas con pytest..."
venv/bin/python -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "Pruebas finalizadas. Resultados en reports"