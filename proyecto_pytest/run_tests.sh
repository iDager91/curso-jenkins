#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..."

# --- PASO DE DEPURACIÓN 1: VERIFICAR LA UBICACIÓN ACTUAL ---
echo "--- Depuración: Verificando ubicación actual ---"
echo "Directorio actual (pwd): $(pwd)"
echo "Contenido del directorio actual:"
ls -F

# --- PASO DE DEPURACIÓN 2: VERIFICAR LA EXISTENCIA DE LA CARPETA 'venv' ---
echo "--- Depuración: Buscando 'venv' ---"
if [ ! -d "venv" ]; then
    echo "Entorno virtual 'venv' no encontrado. Creándolo..."
    # Asegúrate de que 'python3' apunte a la versión correcta de Python
    python3 -m venv venv
    # Verificar si la creación fue exitosa
    if [ ! -d "venv" ]; then
        echo "Error: La creación del entorno virtual falló. No se encontró 'venv' después de intentar crearlo."
        exit 1
    fi
    echo "Entorno virtual 'venv' creado exitosamente."
else
    echo "La carpeta 'venv' ya existe."
fi

# --- PASO DE DEPURACIÓN 3: EXAMINAR EL CONTENIDO DE 'venv' ---
echo "--- Depuración: Contenido de la carpeta 'venv' ---"
if [ -d "venv/bin" ]; then
    echo "Contenido de 'venv/bin':"
    ls -F venv/bin
elif [ -d "venv/Scripts" ]; then
    echo "Contenido de 'venv/Scripts':"
    ls -F venv/Scripts
else
    echo "No se encontraron las subcarpetas 'venv/bin' ni 'venv/Scripts'. Esto es un problema."
    exit 1
fi

# --- PASO 4: INTENTAR ACTIVAR EL ENTORNO VIRTUAL ---
echo "--- Activando el entorno virtual ---"
if [ -f "venv/bin/activate" ]; then
    echo "Activando entorno virtual para Unix/Linux desde venv/bin/activate..."
    source venv/bin/activate
elif [ -f "venv/Scripts/activate" ]; then # Para Windows (con shell compatible con Bash como Git Bash)
    echo "Activando entorno virtual para Windows desde venv/Scripts/activate..."
    # En un shell tipo Bash (como "Execute Shell" en Jenkins con Git Bash), usar '.' es el equivalente a 'source'.
    # 'source' puede no funcionar correctamente para scripts de Windows.
    . venv/Scripts/activate
else
    echo "Error FINAL: No se pudo activar el entorno virtual. El script 'activate' no se encontró en 'venv/bin' ni en 'venv/Scripts'."
    exit 1
fi

# --- PASO 5: VERIFICAR LA ACTIVACIÓN ---
echo "--- Verificando activación del entorno virtual ---"
which python
python --version