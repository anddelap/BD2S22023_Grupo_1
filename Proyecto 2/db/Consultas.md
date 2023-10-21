# CONSULTAS MySQL

### 1. Total de pacientes que llegan a la clínica por edad 
```
SELECT
  CASE
    WHEN edad < 18 THEN 'Pediátrico'
    WHEN edad >= 18 AND edad <= 60 THEN 'Mediana edad'
    ELSE 'Geriátrico'
  END AS categoria,
  COUNT(*) AS total_pacientes
FROM Paciente
GROUP BY categoria;

```

### 2. Cantidad de pacientes que pasan por cada habitación
```
SELECT
  H.habitacion,
  COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
FROM habitacion H
LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
GROUP BY H.habitacion;
```

### 3. Cantidad de pacientes que llegan a la clínica, agrupados por género
```
SELECT p.genero, COUNT(p.idPaciente) AS 'Cantidad de pacientes'
FROM paciente AS p JOIN Log_actividad AS L
ON p.idPaciente = L.PACIENTE_idPaciente
GROUP BY p.genero;
```

### 4. Top 5 edades más atendidas en la clínica
```
SELECT EDAD, COUNT(*) AS 'Atendidos'
FROM (
  SELECT L.PACIENTE_IDPACIENTE, P.EDAD
  FROM LOG_ACTIVIDAD L
  JOIN PACIENTE P ON P.IDPACIENTE = L.PACIENTE_IDPACIENTE
) AS Subconsulta
GROUP BY EDAD
ORDER BY Atendidos DESC
LIMIT 5;
```

### 5. Top 5 edades menos atendidas en la clínica
```
SELECT EDAD, COUNT(*) AS 'Atendidos'
FROM (
  SELECT L.PACIENTE_IDPACIENTE, P.EDAD
  FROM LOG_ACTIVIDAD L
  JOIN PACIENTE P ON P.IDPACIENTE = L.PACIENTE_IDPACIENTE
) AS Subconsulta
GROUP BY EDAD
ORDER BY Atendidos ASC
LIMIT 5;
```

### 6. Top 5 habitaciones más utilizadas
```
SELECT
  H.habitacion,
  COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
FROM habitacion H
LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
GROUP BY H.habitacion
ORDER BY pacientes_en_habitacion DESC
LIMIT 5;

```

### 7. Top 5 habitaciones menos utilizadas
```
SELECT
  H.habitacion,
  COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
FROM Habitacion H
LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
GROUP BY H.habitacion
ORDER BY pacientes_en_habitacion ASC
LIMIT 5;
```

### 8. Día con más pacientes en la clínica 
Falta Probar
```
SELECT DATE_FORMAT(L.timestampx, "%m-%d-%Y") AS Fecha, COUNT(L.PACIENTE_idPaciente) AS Cantidad_pacientes
FROM Log_actividad AS L JOIN paciente AS p
ON p.idPaciente = L.PACIENTE_idPaciente
GROUP BY Fecha
ORDER BY Cantidad_pacientes DESC
LIMIT 1;
```


# CONSULTAS MongoDB

### 1. Total de pacientes que llegan a la clínica por edad 
```
{
  _id: {
    $switch: {
      branches: [
        {
          case: {
            $lt: ["$edad", 18],
          },
          then: "Pediátrico",
        },
        {
          case: {
            $and: [
              {
                $gte: ["$edad", 18],
              },
              {
                $lte: ["$edad", 60],
              },
            ],
          },
          then: "Mediana Edad",
        },
        {
          case: {
            $gt: ["$edad", 60],
          },
          then: "Geriátrico",
        },
      ],
      default: "Desconocido",
    },
  },
  total: {
    $sum: 1,
  },
}
```

### 2. Cantidad de pacientes que pasan por cada habitación
```
[
  {
    $lookup: {
      from: "log_actividad",
      localField: "idHabitacion",
      foreignField: "idHabitacion",
      as: "actividades",
    },
  },
  {
    $project: {
      habitacion: 1,
      pacientes_en_habitacion: {
        $size: "$actividades",
      },
    },
  },
]
```

### 3. Cantidad de pacientes que llegan a la clínica, agrupados por género
```
[
  {
    $group: {
      _id: "$genero",
      total: { $sum: 1 },
    },
  },
]
```

### 4. Top 5 edades más atendidas en la clínica
```
[
  {
    $group: {
      _id: "$edad",
      total: { $sum: 1 },
    },
  },
  {
    $sort: { total: -1 },
  },
  {
    $limit: 5,
  },
]
```

### 5. Top 5 edades menos atendidas en la clínica
```
```

### 6. Top 5 habitaciones más utilizadas
```
[
  {
    $lookup: {
      from: "log_actividad",
      localField: "idHabitacion",
      foreignField: "idHabitacion",
      as: "actividades",
    },
  },
  {
    $project: {
      habitacion: 1,
      pacientes_en_habitacion: {
        $size: "$actividades",
      },
    },
  },
  {
    $sort: {
      pacientes_en_habitacion: -1,
    },
  },
  {
    $limit: 5,
  },
]
```

### 7. Top 5 habitaciones menos utilizadas
```
[
  {
    $lookup: {
      from: "log_actividad",
      localField: "idHabitacion",
      foreignField: "idHabitacion",
      as: "actividades",
    },
  },
  {
    $project: {
      habitacion: 1,
      pacientes_en_habitacion: {
        $size: "$actividades",
      },
    },
  },
  {
    $sort: {
      pacientes_en_habitacion: 1,
    }, // Orden ascendente
  },
  {
    $limit: 5,
  },
]
```

### 8. Día con más pacientes en la clínica
```
[
  {
    $group: {
      _id: {
        $dateToString: {
          format: "%Y-%m-%d",
          date: "$timestamp",
        },
      },
      totalPacientes: {
        $sum: 1,
      },
    },
  },
  {
    $sort: {
      totalPacientes: -1,
    },
  },
  {
    $limit: 1,
  },
  {
    $project: {
      _id: 0,
      fecha: "$_id",
      totalPacientes: 1,
    },
  },
]
```

# CONSULTAS CASSANDRA

### 1. Total de pacientes que llegan a la clínica por edad 
```
```

### 2. Cantidad de pacientes que pasan por cada habitación
```
```

### 3. Cantidad de pacientes que llegan a la clínica, agrupados por género
```
```

### 4. Top 5 edades más atendidas en la clínica
```
```

### 5. Top 5 edades menos atendidas en la clínica
```
```

### 6. Top 5 habitaciones más utilizadas
```
```

### 7. Top 5 habitaciones menos utilizadas
```
```

### 8. Día con más pacientes en la clínica
```
```

# REDISSSS

❖ Consulta que se realizó
❖ Fecha de la consulta

```
```