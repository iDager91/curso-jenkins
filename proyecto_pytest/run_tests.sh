#!/bin/bash
echo "Iniciando ejecucion de pruebas en Jenkins..."

# --- PASO DE DEPURACIÓN 1: VERIFICAR LA UBICACIÓN INICIAL ---
echo "--- Depuración: Verificando ubicación inicial ---"
echo "Directorio de trabajo actual (pwd): $(pwd)"
echo "Contenido del directorio actual (ls -F):"
ls -F

# --- PASO DE DEPURACIÓN 2: CREACIÓN DEL ENTORNO VIRTUAL ---
echo "--- Depuración: Intentando crear/verificar 'venv' ---"
if [ ! -d "venv" ]; then
    echo "Entorno virtual 'venv' no encontrado en $(pwd). Intentando crearlo..."
    # Intenta usar 'python' en lugar de 'python3' si 'python3' no está en el PATH de Jenkins en Windows.
    # O usa la ruta completa si la conoces, por ejemplo: /usr/bin/python3 -m venv venv
    # En Windows, podrías necesitar 'py -3 -m venv venv' o la ruta completa a python.exe
    python -m venv venv  # Prueba con 'python' primero
    # python3 -m venv venv # Si el anterior falla, descomenta este y comenta el de arriba

    # Verifica si el comando anterior fue exitoso
    if [ $? -ne 0 ]; then
        echo "ERROR CRÍTICO: La creación del entorno virtual falló con código de salida $?. Revisa el PATH de Python y los permisos."
        exit 1
    fi
    echo "Entorno virtual 'venv' creado (o se intentó crear)."
else
    echo "La carpeta 'venv' ya existe en $(pwd)."
fi

# --- PASO DE DEPURACIÓN 3: RE-VERIFICAR LA EXISTENCIA DE 'venv' Y SUS SUB-CARPETAS INMEDIATAMENTE DESPUÉS ---
echo "--- Depuración: Verificando el estado de 'venv' después de la creación/verificación ---"
if [ -d "venv" ]; then
    echo "La carpeta 'venv' existe."
    echo "Contenido de 'venv':"
    ls -F venv

    if [ -d "venv/Scripts" ]; then
        echo "¡ENCONTRADA: venv/Scripts!"
        echo "Contenido de 'venv/Scripts':"
        ls -F venv/Scripts
    else
        echo "ADVERTENCIA: Ni 'venv/bin' ni 'venv/Scripts' fueron encontrados dentro de 'venv'."
        echo "Esto significa que el entorno virtual no se creó correctamente o está dañado."
        echo "Asegúrate de que 'python -m venv venv' funcione fuera de Jenkins."
        exit 1 # Salir si las subcarpetas clave no existen
    fi
else
    echo "ERROR: La carpeta 'venv' NO existe después de intentar crearla. Fallo en la creación del venv."
    exit 1
fi

# --- PASO 4: INTENTAR ACTIVAR EL ENTORNO VIRTUAL ---
echo "--- Activando el entorno virtual ---"
if [ -f "venv/Scripts/activate" ]; then # Para Windows con Bash (Git Bash)
    echo "Activando entorno virtual (Windows con Bash/Git Bash)..."
    . venv/Scripts/activate # El punto '.' es el alias de 'source' para Bash
else
    echo "ERROR FINAL: No se pudo activar el entorno virtual. El script 'activate' no se encontró."
    exit 1
fi

# --- PASO 5: VERIFICAR LA ACTIVACIÓN ---
echo "--- Verificando activación ---"
which python
python --version

# Aquí irían tus comandos de ejecución de pruebas
# pip install -r requirements.txt
# pytest