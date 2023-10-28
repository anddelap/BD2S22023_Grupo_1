from flask import Flask, request, jsonify
import mysql.connector
import pymongo
from flask_cors import CORS
from decouple import config

app = Flask(__name__)
CORS(app)
# Configura la conexión a la base de datos MySQL
db = mysql.connector.connect(
    host="localhost",
    user=config('MYSQL_USER'),
    password=config('MYSQL_PASSWORD'),
    database=config('MYSQL_DATABASE')
)
cursor = db.cursor()

# Configuracion conexion a MongoDB
mongodb_url = "mongodb+srv://admin:admin123@cluster0.i9abrxz.mongodb.net/"
# Establece la conexión a la base de datos
client = pymongo.MongoClient(mongodb_url)
# Selecciona la base de datos
dbMongo = client['Proyecto1']

# Endpoint para consultas GET


@app.route('/data/habitaciones', methods=['GET'])
def get_data_h():
    query = "SELECT * FROM habitacion;"
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'idHabitacion': row[0], 'habitacion': row[1]})
    return jsonify(rows)


@app.route('/data/pacientes', methods=['GET'])
def get_data_p():
    query = "SELECT * FROM paciente;"
    cursor.execute(query)
    result = cursor.fetchall()
    rows = []
    for row in result:
        rows.append({'idPaciente': row[0]})
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
        rows.append({'categoria': row[0], 'total_pacientes': row[1]})
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
        rows.append({'habitacion': row[0], 'pacientes_en_habitacion': row[1]})
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
        rows.append({'genero': row[0], 'total_pacientes': row[1]})
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
        rows.append({'edad': row[0], 'total_atendidos': row[1]})
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
        rows.append({'edad': row[0], 'total_atendidos': row[1]})
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
        rows.append({'habitacion': row[0], 'pacientes_en_habitacion': row[1]})
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
        rows.append({'habitacion': row[0], 'pacientes_en_habitacion': row[1]})
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
        rows.append({'fecha': row[0], 'pacientes': row[1]})
    return jsonify(rows)

# Endpoint para consultas POST

@app.route('/query', methods=['POST'])
def post_query():
    data = request.get_json()
    query = data.get('query')
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify(result)


# Reporte 1 - MongoDB
@app.route('/mongodb/reporte/1', methods=['GET'])
def get_mongo_reporte_1():
    coleccion = dbMongo['paciente']
    query = MongoC(1)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 2 - MongoDB
@app.route('/mongodb/reporte/2', methods=['GET'])
def get_mongo_reporte_2():
    coleccion = dbMongo['habitacion']
    query = MongoC(2)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 3 - MongoDB
@app.route('/mongodb/reporte/3', methods=['GET'])
def get_mongo_reporte_3():
    coleccion = dbMongo['paciente']
    query = MongoC(3)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 4 - MongoDB
@app.route('/mongodb/reporte/4', methods=['GET'])
def get_mongo_reporte_4():
    coleccion = dbMongo['paciente']
    query = MongoC(4)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 5 - MongoDB
@app.route('/mongodb/reporte/5', methods=['GET'])
def get_mongo_reporte_5():
    coleccion = dbMongo['paciente']
    query = MongoC(5)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 6 - MongoDB
@app.route('/mongodb/reporte/6', methods=['GET'])
def get_mongo_reporte_6():
    coleccion = dbMongo['habitacion']
    query = MongoC(6)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 7 - MongoDB
@app.route('/mongodb/reporte/7', methods=['GET'])
def get_mongo_reporte_7():
    coleccion = dbMongo['habitacion']
    query = MongoC(7)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))

# Reporte 8 - MongoDB
@app.route('/mongodb/reporte/8', methods=['GET'])
def get_mongo_reporte_8():
    coleccion = dbMongo['log_actividad']
    query = MongoC(8)
    resultados = coleccion.aggregate(query)
    return jsonify(list(resultados))


def MongoC(rep):
    print("Hola desde mi_funcion")
    pipeline = []
    # Defina la consulta
    if rep == 1:
        pipeline = [
            {
                '$group': {
                    '_id': {
                        '$switch': {
                            'branches': [
                                {
                                    'case': {
                                        '$lt': [
                                            '$edad', 18
                                        ]
                                    },
                                    'then': 'Pediátrico'
                                }, {
                                    'case': {
                                        '$and': [
                                            {
                                                '$gte': [
                                                    '$edad', 18
                                                ]
                                            }, {
                                                '$lte': [
                                                    '$edad', 60
                                                ]
                                            }
                                        ]
                                    },
                                    'then': 'Mediana Edad'
                                }, {
                                    'case': {
                                        '$gt': [
                                            '$edad', 60
                                        ]
                                    },
                                    'then': 'Geriátrico'
                                }
                            ],
                            'default': 'Desconocido'
                        }
                    },
                    'total': {
                        '$sum': 1
                    }
                }
            }
        ]
    elif rep == 2:
        pipeline = [
            {
                '$lookup': {
                    'from': 'log_actividad',
                    'localField': 'idHabitacion',
                    'foreignField': 'idHabitacion',
                    'as': 'actividades'
                }
            }, {
                '$project': {
                    '_id': 0,
                    'habitacion': 1,
                    'pacientes_en_habitacion': {
                        '$size': '$actividades'
                    }
                }
            }
        ]
    elif rep == 3:
        pipeline = [
            {
                '$group': {
                    '_id': '$genero',
                    'total': {
                        '$sum': 1
                    }
                }
            }
        ]
    elif rep == 4:
        pipeline = [
            {
                '$group': {
                    '_id': '$edad',
                    'total': {
                        '$sum': 1
                    }
                }
            }, {
                '$sort': {
                    'total': -1
                }
            }, {
                '$limit': 5
            }
        ]
    elif rep == 5:
        pipeline = [
            {
                '$group': {
                    '_id': '$edad',
                    'total': {
                        '$sum': 1
                    }
                }
            }, {
                '$sort': {
                    'total': 1
                }
            }, {
                '$limit': 5
            }
        ]
    elif rep == 6:
        pipeline = [
            {
                '$lookup': {
                    'from': 'log_actividad',
                    'localField': 'idHabitacion',
                    'foreignField': 'idHabitacion',
                    'as': 'actividades'
                }
            }, {
                '$project': {
                    '_id': 0,
                    'habitacion': 1,
                    'pacientes_en_habitacion': {
                        '$size': '$actividades'
                    }
                }
            }, {
                '$sort': {
                    'pacientes_en_habitacion': -1
                }
            }, {
                '$limit': 5
            }
        ]
    elif rep == 7:
        pipeline = [
            {
                '$lookup': {
                    'from': 'log_actividad',
                    'localField': 'idHabitacion',
                    'foreignField': 'idHabitacion',
                    'as': 'actividades'
                }
            }, {
                '$project': {
                    '_id': 0,
                    'habitacion': 1,
                    'pacientes_en_habitacion': {
                        '$size': '$actividades'
                    }
                }
            }, {
                '$sort': {
                    'pacientes_en_habitacion': 1
                }
            }, {
                '$limit': 5
            }
        ]
    elif rep == 8:
        pipeline = [
            {
                '$group': {
                    '_id': {
                        '$dateToString': {
                            'format': '%Y-%m-%d',
                            'date': '$timestamp'
                        }
                    },
                    'totalPacientes': {
                        '$sum': 1
                    }
                }
            }, {
                '$sort': {
                    'totalPacientes': -1
                }
            }, {
                '$limit': 1
            }, {
                '$project': {
                    '_id': 0,
                    'fecha': '$_id',
                    'totalPacientes': 1
                }
            }
        ]
    return pipeline


if __name__ == '__main__':
    app.run(debug=True)
