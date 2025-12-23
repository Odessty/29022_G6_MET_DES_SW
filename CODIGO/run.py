#!/usr/bin/env python
"""
Script de inicio para Admin Panel
Ejecutar desde la carpeta app/
"""
import sys
import os

# Agregar src al path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

# Importar y ejecutar
from app import main

if __name__ == "__main__":
    main()
