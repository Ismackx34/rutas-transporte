
    /*
Esta consulta se centra en identificar la demanda real de los diferentes bloques de servicio que cada ruta ofrece.
Para el día específico '2025-09-11', lo que hace es agrupar todos los viajes individuales de los usuarios
(id_uso en Uso_Transporte_NEW) por la ruta a la que pertenecen (R.nombre_ruta) y por las características
de su horario (H.hora_inicio, H.hora_fin, H.unidades_en_servicio). Luego, cuenta cuántos viajes
(usuarios individuales) caen en cada uno de estos grupos.
*/

SELECT R.nombre_ruta, H.hora_inicio, H.hora_fin, H.unidades_en_servicio, 
COUNT(UT.id_uso) AS numero_usuarios_en_horario_y_ruta
FROM Uso_Transporte_NEW UT 
JOIN Rutas R ON UT.id_ruta = R.id_ruta 
JOIN Horarios H ON UT.id_horario = H.id_horario
WHERE UT.fecha = '2025-09-11' 
GROUP BY R.nombre_ruta, H.hora_inicio, H.hora_fin, H.unidades_en_servicio
ORDER BY numero_usuarios_en_horario_y_ruta DESC;

-- 4. Paradas donde más y menos usuarios abordan  (se suben)
/*
Esta consulta identifica las 10 paradas desde donde un mayor número de usuarios inician sus viajes
en el día '2025-09-11'. Esto es clave para identificar los puntos de origen más populares,
evaluar la infraestructura de esas paradas o planificar servicios adicionales.
*/
SELECT P.nombre_parada, P.direccion, COUNT(UT.id_uso) AS total_usuarios_abordajes
FROM Uso_Transporte_NEW UT
JOIN Paradas P ON UT.id_parada_abordaje = P.id_parada
WHERE UT.fecha = '2025-09-11'
GROUP BY P.nombre_parada, P.direccion
ORDER BY total_usuarios_abordajes DESC LIMIT 10;

SELECT P.nombre_parada, P.direccion, COUNT(UT.id_uso) AS total_usuarios_abordajes
FROM Uso_Transporte_NEW UT
JOIN Paradas P ON UT.id_parada_abordaje = P.id_parada
WHERE UT.fecha = '2025-09-11'
GROUP BY P.nombre_parada, P.direccion
ORDER BY total_usuarios_abordajes LIMIT 10;


-- 5. Paradas donde más y menos usuarios descienden (se bajan)
/*
Esta consulta identifica las 10 paradas donde un mayor número de usuarios finalizan sus viajes
en el día '2025-09-11'. Esto es esencial para detectar los principales destinos de los usuarios,
lo cual puede informar sobre la planificación urbana, centros de actividad o puntos de transbordo críticos.
*/
SELECT P.nombre_parada, P.direccion, COUNT(UT.id_uso) AS total_usuarios_descensos
FROM Uso_Transporte_NEW UT
JOIN Paradas P ON UT.id_parada_descenso = P.id_parada
WHERE UT.fecha = '2025-09-11'
GROUP BY P.nombre_parada, P.direccion
ORDER BY total_usuarios_descensos DESC LIMIT 10;

SELECT P.nombre_parada, P.direccion, COUNT(UT.id_uso) AS total_usuarios_descensos
FROM Uso_Transporte_NEW UT
JOIN Paradas P ON UT.id_parada_descenso = P.id_parada
WHERE UT.fecha = '2025-09-11'
GROUP BY P.nombre_parada, P.direccion
ORDER BY total_usuarios_descensos LIMIT 10;

