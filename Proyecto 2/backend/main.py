from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Configura la conexión a la base de datos MySQL
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="ArteGar0301$",
    database="BD2_P1"
)
cursor = db.cursor()

# Endpoint para consultas GET
@app.route('/data', methods=['GET'])
def get_data():
    query = "SELECT * FROM habitacion;"
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'idHabitacion' : row[0], 'habitacion' : row[1]})
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
        FROM Paciente
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
        COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
        FROM habitacion H
        LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
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
        SELECT
        genero,
        COUNT(*) AS total_pacientes
        FROM Paciente
        GROUP BY genero;
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
        SELECT
        edad,
        COUNT(*) AS total_atendidos
        FROM Paciente
        GROUP BY edad
        ORDER BY total_atendidos DESC
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
        SELECT
        edad,
        COUNT(*) AS total_atendidos
        FROM Paciente
        GROUP BY edad
        ORDER BY total_atendidos ASC
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
        H.habitacion,
        COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
        FROM habitacion H
        LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
        GROUP BY H.habitacion
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
        H.habitacion,
        COUNT(L.PACIENTE_idPaciente) AS pacientes_en_habitacion
        FROM Habitacion H
        LEFT JOIN log_actividad L ON H.idHabitacion = L.HABITACION_idHabitacion
        GROUP BY H.habitacion
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
        SELECT
        DATE(timestampx) AS fecha,
        COUNT(DISTINCT PACIENTE_idPaciente) AS pacientes
        FROM log_actividad
        GROUP BY fecha
        ORDER BY pacientes DESC
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
