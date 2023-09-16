#!/bin/bash

echo "   ____       _                         _                          ";
echo "  / __ \  ___| |__  _ __ ___   ___   __| |_ __ ___   __ _ _____  __";
echo " / / _\` |/ __| '_ \| '_ \` _ \ / _ \ / _\` | '_ \` _ \ / _\` / __\ \/ /";
echo "| | (_| | (__| | | | | | | | | (_) | (_| | | | | | | (_| \__ \>  < ";
echo " \ \__,_|\___|_| |_|_| |_| |_|\___/ \__,_|_| |_| |_|\__,_|___/_/\_\ ";
echo "  \____/                                                           ";
echo "En Dios confiamos | In God we trust"
echo "\n"

# Nombre del archivo Python
py_script_name="crear_carpeta_con_archivos_seleccionados.py"

# Contenido del archivo .py
py_script_content="#!/usr/bin/python3 -OOt
import sys
import os
import shutil

# Obtiene la carpeta común de los archivos seleccionados
common_path = os.path.commonpath(sys.argv[1:])

# Nombre de la nueva carpeta
new_folder_name = 'Nueva Carpeta'

# Ruta completa de la nueva carpeta
new_folder_path = os.path.join(common_path, new_folder_name)

# Encuentra un nombre único para la nueva carpeta
x = 1
while os.path.isdir(new_folder_path):
    x += 1
    new_folder_path = os.path.join(common_path, f'{new_folder_name} ({x})')

# Crea la nueva carpeta
os.makedirs(new_folder_path)

# Mueve los archivos seleccionados a la nueva carpeta
for file in sys.argv[1:]:
    shutil.move(file, new_folder_path)
"

# Nombre del archivo .nemo_action
nemo_action_name="crear_carpeta_con_archivos_seleccionados.nemo_action"

# Contenido del archivo .nemo_action
nemo_action_content="[Nemo Action]
Active=true
Name=Mover a nueva carpeta
Comment=Crea una nueva carpeta con los archivos seleccionados
Exec=<crear_carpeta_con_archivos_seleccionados.py %F>
Icon-Name=folder-new-symbolic
Selection=notnone
Extensions=nodirs;
Dependencies=/usr/bin/python3;
"

# Directorio de destino
dest_dir="/usr/share/nemo/actions"

# Ruta completa de los archivos de destino
py_script_dest="$dest_dir/$py_script_name"
nemo_action_dest="$dest_dir/$nemo_action_name"

# Crear el archivo .py y darle permisos de ejecución
echo "$py_script_content" | sudo tee "$py_script_dest" > /dev/null
sudo chmod +x "$py_script_dest"

# Crear el archivo .nemo_action
echo "$nemo_action_content" | sudo tee "$nemo_action_dest" > /dev/null

echo "Instalación completada"
