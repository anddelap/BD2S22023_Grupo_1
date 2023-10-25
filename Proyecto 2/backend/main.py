from flask import Flask, request, jsonify
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
# Configura la conexión a la base de datos MySQL
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="140620",
    database="bd2_prac2"
)
cursor = db.cursor()

# Endpoint para consultas GET
@app.route('/data/habitaciones', methods=['GET'])
def get_data_h():
    query = "SELECT * FROM habitacion;"
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'idHabitacion' : row[0], 'habitacion' : row[1]})
    return jsonify(rows)

@app.route('/data/pacientes', methods=['GET'])
def get_data_p():
    query = "SELECT * FROM paciente;"
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'idPaciente' : row[0]})
    return jsonify(rows)

# Reporte 1 - MYSQL
@app.route('/mysql/reporte/1', methods=['GET'])
def get_mysql_reporte_1():
    query = """
        SELECT
        CASE
            WHEN edad < 18 THEN 'Pediátrico'
            WHEN edad >= 18 AND edad <= 60 THEN 'Mediana edad'
            ELSE 'Geriátrico'
        END AS categoria,
        COUNT(*) AS total_pacientes
        FROM PACIENTE
        GROUP BY categoria;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'categoria' : row[0], 'total_pacientes' : row[1]})
    return jsonify(rows)

# Reporte 2 - MYSQL
@app.route('/mysql/reporte/2', methods=['GET'])
def get_mysql_reporte_2():
    query = """
        SELECT
        H.habitacion,
        COUNT(L.idPaciente) AS pacientes_en_habitacion
        FROM HABITACION H
        LEFT JOIN LOG_ACTIVIDAD L ON H.idHabitacion = L.idHabitacion
        GROUP BY H.habitacion;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'habitacion' : row[0], 'pacientes_en_habitacion' : row[1]})
    return jsonify(rows)

# Reporte 3 - MYSQL
@app.route('/mysql/reporte/3', methods=['GET'])
def get_mysql_reporte_3():
    query = """
        SELECT p.genero, COUNT(p.idPaciente) AS 'Cantidad de pacientes'
        FROM PACIENTE AS p JOIN LOG_ACTIVIDAD AS L
        ON p.idPaciente = L.idPaciente
        GROUP BY p.genero;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'genero' : row[0], 'total_pacientes' : row[1]})
    return jsonify(rows)

# Reporte 4 - MYSQL
@app.route('/mysql/reporte/4', methods=['GET'])
def get_mysql_reporte_4():
    query = """
        SELECT EDAD, COUNT(*) AS 'Atendidos'
        FROM (
        SELECT L.idPaciente, P.EDAD
        FROM LOG_ACTIVIDAD L
        JOIN PACIENTE P ON P.idPaciente = L.idPaciente
        ) AS Subconsulta
        GROUP BY EDAD
        ORDER BY Atendidos DESC
        LIMIT 5;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'edad' : row[0], 'total_atendidos' : row[1]})
    return jsonify(rows)

# Reporte 5 - MYSQL
@app.route('/mysql/reporte/5', methods=['GET'])
def get_mysql_reporte_5():
    query = """
        SELECT EDAD, COUNT(*) AS 'Atendidos'
        FROM (
        SELECT L.idPaciente, P.EDAD
        FROM LOG_ACTIVIDAD L
        JOIN PACIENTE P ON P.idPaciente = L.idPaciente
        ) AS Subconsulta
        GROUP BY EDAD
        ORDER BY Atendidos ASC
        LIMIT 5;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'edad' : row[0], 'total_atendidos' : row[1]})
    return jsonify(rows)

# Reporte 6 - MYSQL
@app.route('/mysql/reporte/6', methods=['GET'])
def get_mysql_reporte_6():
    query = """
        SELECT
        H.HABITACION,
        COUNT(L.idPaciente) AS pacientes_en_habitacion
        FROM HABITACION H
        LEFT JOIN LOG_ACTIVIDAD L ON H.idHabitacion = L.idHabitacion
        GROUP BY H.HABITACION
        ORDER BY pacientes_en_habitacion DESC
        LIMIT 5;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'habitacion' : row[0], 'pacientes_en_habitacion' : row[1]})
    return jsonify(rows)

# Reporte 7 - MYSQL
@app.route('/mysql/reporte/7', methods=['GET'])
def get_mysql_reporte_7():
    query = """
        SELECT
        H.HABITACION,
        COUNT(L.idPaciente) AS pacientes_en_habitacion
        FROM HABITACION H
        LEFT JOIN LOG_ACTIVIDAD L ON H.idHabitacion = L.idHabitacion
        GROUP BY H.HABITACION
        ORDER BY pacientes_en_habitacion ASC
        LIMIT 5;
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'habitacion' : row[0], 'pacientes_en_habitacion' : row[1]})
    return jsonify(rows)

# Reporte 8 - MYSQL
@app.route('/mysql/reporte/8', methods=['GET'])
def get_mysql_reporte_8():
    query = """
        SELECT DATE_FORMAT(L.timestampx, "%m-%d-%Y") AS Fecha, COUNT(L.idPaciente) AS Cantidad_pacientes
        FROM LOG_ACTIVIDAD AS L JOIN PACIENTE AS p
        ON p.idPaciente = L.idPaciente
        GROUP BY Fecha
        ORDER BY Cantidad_pacientes DESC
        LIMIT 1;    
    """
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'fecha' : row[0], 'pacientes' : row[1]})
    return jsonify(rows)

# Endpoint para consultas POST
@app.route('/query', methods=['POST'])
def post_query():
    data = request.get_json()
    query = data.get('query')
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
