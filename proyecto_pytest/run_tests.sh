#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..." 

#verificar si el entorno virutal existe
echo "activando el entorno virtual"
if [ ! -d "venv" ]; then
    echo "Entorno virtual no encontrado. Creandolo..."
    python3 -m venv venv
fi

#Activar el entorno virtual correctamente
if [ -f "venv/bin/activate" ]; then
    echo "bin"
    source venv/bin/activate
elif [ -f "C:\Users\Lalo\Documents\Jenkins\ARCHIVOS\curso-jenkins\proyecto_pytest\venv\Scripts\activate" ]; then #Para Windows
    echo "Scrpits"
    source C:\Users\Lalo\Documents\Jenkins\ARCHIVOS\curso-jenkins\proyecto_pytest\venv\Scripts\activate
else
    echo "Error: No se pudo acitvar el entorno virtual."
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