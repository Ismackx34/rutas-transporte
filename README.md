# Proyecto-1 SQL Análisis de Trasporte 
# 🚌 Optimización de Redes de Transporte Urbano (SQL Project)
 
Este proyecto es parte del **Data Foundations Program**, específicamente del módulo de *Database SQL and Query Optimization*. El objetivo principal fue diseñar, normalizar y optimizar una base de datos relacional para gestionar y analizar la eficiencia de una red de transporte urbano.
 
## 📖 Descripción del Proyecto
El sistema gestiona la información operativa de rutas, horarios, flota y afluencia de pasajeros. A través de consultas SQL avanzadas, se busca identificar patrones de uso para mejorar la toma de decisiones, como la reasignación de unidades en horas pico y valle.
 
## 🎯 Problema de Negocio
Las redes de transporte urbano enfrentan desafíos como la congestión en horas pico y la subutilización de unidades en horarios valle. El proyecto busca responder preguntas clave:
* ¿Qué rutas tienen mayor ocupación (cuellos de botella)?
* ¿Cuáles son los horarios con menor uso para optimizar costos?
* ¿Cuáles son las paradas con mayor tasa de abordaje y descenso?
 
## 🛠 Solución Técnica
El desarrollo se dividió en tres fases:
1. **Modelado y Normalización:** Se llevó la base de datos hasta la **3ra Forma Normal (3NF)** para eliminar redundancias, separando entidades como `Rutas`, `Paradas`, `Horarios` y `Usuarios`.
2. **Consultas Analíticas:** Desarrollo de scripts SQL para calcular métricas de ocupación y tiempos de espera.
3. **Optimización de Consultas:** Refactorización de queries para mejorar el rendimiento.
 
## 🗂 Estructura de la Base de Datos
El modelo entidad-relación (ERD) incluye las siguientes tablas principales:
* **`Rutas` y `Paradas`:** Definen la infraestructura física.
* **`Horarios`:** Controla la frecuencia y tiempos de operación.
* **`Uso_Transporte_NEW`:** Tabla de hechos que registra cada viaje, conectando usuarios, rutas y horarios.
* **`Usuarios` y `Tipo_Usuario`:** Para segmentación demográfica.
 
*(Puedes ver el Diagrama ER en la carpeta `/docs`)*.
 
## 🚀 Optimización y Rendimiento
Como parte del módulo de optimización, se aplicaron las siguientes estrategias documentadas en el informe técnico:
* **Índices:** Creación de índices en columnas de alto filtrado como `id_ruta` y `fecha`.
* **CTEs (Common Table Expressions):** Reemplazo de subconsultas complejas por CTEs para mejorar la legibilidad y el plan de ejecución.
* **Selección Eficiente:** Eliminación de `SELECT *` en favor de columnas específicas para reducir la carga de I/O.
* **Filtros Pre-Join:** Aplicación de cláusulas `WHERE` antes de realizar `JOINs` masivos.
 
## 💻 Tecnologías Utilizadas
* **Lenguaje:** SQL (Structured Query Language).
* **Motor de Base de Datos:** MySQL.
* **Herramientas:** MySQL Workbench, Excel (para limpieza de datos preliminar).
