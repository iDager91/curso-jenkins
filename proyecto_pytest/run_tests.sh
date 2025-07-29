#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..." 

#verificar si el entorno virutal existe
echo "activando el entorno virtual"
if [ ! -d "venv" ]; then
    echo "Entorno virtual no encontrado. Creandolo..."
    #sudo apt install python3.11-venv
    python3 -m venv venv
fi

#Activar el entorno virtual correctamente
# if [ -f "venv/bin/activate" ]; then
#     source venv/bin/activate
# elif [ -f "venv/Scripts/activate" ]; then #Para Windows
#     source venv/Scripts/activate
# else
#     echo "Error: No se pudo acitvar el entorno virtual."
#     exit 1
# fi
if [ -f "venv/bin/activate" ]; then
    echo "Activando entorno virtual para Unix/Linux..."
    source venv/bin/activate
elif [ -f "venv/Scripts/activate" ]; then
    echo "Activando entorno virtual para Windows (Shell con compatibilidad Unix como Git Bash)..."
    # El punto (.) es un alias de 'source' para Bash, que funciona bien para activar scripts de venv en Windows
    . venv/Scripts/activate
else
    echo "Error: No se pudo activar el entorno virtual. Asegúrate de que 'venv' exista y esté en la ubicación correcta."
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