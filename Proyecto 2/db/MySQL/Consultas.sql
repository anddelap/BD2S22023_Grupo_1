-- Total de pacientes por edad
SELECT
  CASE
    WHEN edad < 18 THEN 'Pediátrico'
    WHEN edad >= 18 AND edad <= 60 THEN 'Mediana edad'
    ELSE 'Geriátrico'
  END AS categoria,
  COUNT(*) AS total_pacientes
FROM Paciente
GROUP BY categoria;


-- Cantidad de pacientes por habitación
SELECT
  H.habitacion,
  COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
FROM habitacion H
LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
GROUP BY H.habitacion;

-- Cantidad de pacientes por género
SELECT p.genero, COUNT(p.idPaciente) AS 'Cantidad de pacientes'
FROM paciente AS p JOIN Log_actividad AS L
ON p.idPaciente = L.idPaciente
GROUP BY p.genero;

-- Top 5 edades más atendidas
SELECT
  edad,
  COUNT(*) AS total_atendidos
FROM Paciente
GROUP BY edad
ORDER BY total_atendidos DESC
LIMIT 5;

-- Top 5 edades menos atendidas
SELECT
  edad,
  COUNT(*) AS total_atendidos
FROM Paciente
GROUP BY edad
ORDER BY total_atendidos ASC
LIMIT 5;

-- Top 5 habitaciones más utilizadas
SELECT
  H.habitacion,
  COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
FROM habitacion H
LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
GROUP BY H.habitacion
ORDER BY pacientes_en_habitacion DESC
LIMIT 5;

-- Top 5 habitaciones menos utilizadas
SELECT
  H.habitacion,
  COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
FROM Habitacion H
LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
GROUP BY H.habitacion
ORDER BY pacientes_en_habitacion ASC
LIMIT 5;

-- Día con más pacientes
SELECT DATE_FORMAT(L.timestamp, "%m-%d-%Y") AS Fecha, COUNT(L.idPaciente) AS Cantidad_pacientes
FROM Log_actividad AS L JOIN paciente AS p
ON p.idPaciente = L.idPaciente
GROUP BY Fecha
ORDER BY Cantidad_pacientes DESC
LIMIT 1;

