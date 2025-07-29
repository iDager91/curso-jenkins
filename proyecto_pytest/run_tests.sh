#!/bin/bash

echo "activando el entorno virtual"
if [!"-d env" ]; then
    python3 -m venv env
fi
source env/bin/activate

echo "instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "ejecutando pruevas con pytest"
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"