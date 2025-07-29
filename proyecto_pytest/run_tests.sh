#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..." 

#verificar si el entorno virutal existe
echo "activando el entorno virtual"
if [!"-d "venv" ]; then
    echo "Entorno virtual no encontrado. Creandolo..."
    python3 -m venv venv
fi

#Activar el entorno virtual correctamente
if [ -f "venv/bin/activate" ]; then
    source env/bin/activate
elif [ -f "venv/Scripts/activate" ]; then #Para Windows
    source venv/Scripts/activate
else
    echo "Error: No se pudo acitvar el entorni virtual."
    exit 1
fi

#VErificar si pip esta instalado correctamente
echo "instalando dependencias"
pip install --upgrade pip
pip install -r requirements.txt

#Ejecutar las pruebas
echo "Ejecutando pruebas con pytest..."
venv/bin/python -m pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "pruebas finalizadas resultados en reports"