use bd2_prac2;

#Pacientes 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Carga/Pacientes.csv'
INTO TABLE paciente
FIELDS TERMINATED BY ','
IGNORE 1 LINES;
SELECT * FROM bd2_prac2.paciente;
SELECT count(*) FROM bd2_prac2.paciente;

#Habitaciones
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Carga/Habitaciones.csv'
INTO TABLE habitacion
FIELDS TERMINATED BY ';'
IGNORE 1 LINES;
SELECT * FROM bd2_prac2.habitacion;
SELECT count(*) FROM bd2_prac2.habitacion;

#LogHabitaciones
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Carga/LogHabitacion.csv'
INTO TABLE log_habitacion
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(idHabitacion,timestampx,statusx);
SELECT * FROM bd2_prac2.`log_habitacion`;
SELECT count(*) FROM bd2_prac2.`log_habitacion`;

#LogActividades1
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Carga/LogActividades1.csv'
INTO TABLE log_actividad
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(timestampx, actividad, HABITACION_idHabitacion, PACIENTE_idPaciente)
;
SELECT * FROM bd2_prac2.log_actividad;
SELECT count(*) FROM bd2_prac2.log_actividad;

#LogActividades2
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Carga/LogActividades2.csv'
INTO TABLE log_actividad
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(timestampx, actividad, HABITACION_idHabitacion, PACIENTE_idPaciente);
SELECT * FROM bd2_prac2.log_actividad;
SELECT count(*) FROM bd2_prac2.log_actividad;
