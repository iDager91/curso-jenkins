#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..."

# Preparar entorno virtual
rm -rf venv
python3 -m venv venv

echo "Instalando dependencias..."
venv/bin/python -m pip install --upgrade pip
venv/bin/python -m pip install -r requirements.txt

echo "estamos en el directorio: "
pwd
mkdir -p reports
ls
echo "Ejecutando pruebas con pytest..."
venv/bin/python -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "Pruebas finalizadas. Resultados en reports"

# Solo necesitas ajustar la configuración del paso “Publish HTML reports” en Jenkins:

# En la sección "HTML directory to archive", cambia la ruta de:

# reports
# a:

# proyecto_pytest/reports
# De esta forma, Jenkins bajará al subdirectorio donde realmente se encuentra el archivo HTML generado por Pytest.

# 💡 Bonus Tip
# Si quieres evitar problemas similares en el futuro, podrías modificar el script para guardar los reportes directamente en la raíz del workspace:

# bash
# mkdir -p ../reports
# venv/bin/python -m pytest tests/ --junitxml=../reports/test-results.xml --html=../reports/test-results.h