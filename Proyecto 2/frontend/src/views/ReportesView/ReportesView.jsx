import React, { useEffect } from 'react'
import GeneralLayout from '../../layouts/GeneralLayout'
import { Button, Container, Form, Row } from 'react-bootstrap'
import './ReportesView.scss'
import { getReporte } from '../../api/reportesApi'
import Circular from '../../components/Circular'

export default function ReportesView() {
    const [reporte, setReporte] = React.useState('1')
    const [base, setBase] = React.useState('mysql')
    const [data, setData] = React.useState([])
    const [reporteInfo, setReporteInfo] = React.useState(null)
    const [backgroundColors, setBackgroundColors] = React.useState([])
    const [borderColors, setBorderColors] = React.useState([])

    /* function generateRandomColor() {
        const minBrightness = 150; // Valor mínimo para los componentes RGB
        const r = Math.floor(Math.random() * (256 - minBrightness) + minBrightness);
        const g = Math.floor(Math.random() * (256 - minBrightness) + minBrightness);
        const b = Math.floor(Math.random() * (256 - minBrightness) + minBrightness);
        const alpha = (Math.random() * 0.8 + 0.2).toFixed(1); // Valores de opacidad entre 0.2 y 1
        return `rgba(${r}, ${g}, ${b}, ${alpha})`;
      } */
    function generateRandomColor() {
        const r = Math.floor(Math.random() * 256);
        const g = Math.floor(Math.random() * 256);
        const b = Math.floor(Math.random() * 256);
        const alpha = (Math.random() * 0.8 + 0.2).toFixed(1); // Valores de opacidad entre 0.2 y 1
        return `rgba(${r}, ${g}, ${b}, ${alpha})`;
    }

    const backgroundColor = [];
    const borderColor = [];

    useEffect(() => {
        for (let i = 0; i < 20; i++) {
            backgroundColor.push(generateRandomColor());
            borderColor.push(generateRandomColor());
        }
        setBackgroundColors(backgroundColor);
        setBorderColors(borderColor);
    }, []);

    useEffect(() => {
        // Llama a la función getReporte aquí.
        getReporte(base, reporte)
            .then(data => {
                // Realiza acciones adicionales con los datos obtenidos si es necesario.
                console.log('Datos del reporte: ', data);
                setData(data)
            })
            .catch(error => {
                console.error('Error al obtener el reporte: ', error);
            });
    }, [reporte, base]);

    useEffect(() => {
        if (data.length > 0) {
            switch (reporte) {
                case '1':
                    const labels = []
                    const datos = []
                    data.map((item) => {
                        labels.push(item.categoria)
                        datos.push(item.total_pacientes)
                    })
                    setReporteInfo({
                        title: 'Total de pacientes por edad',
                        labels: labels,
                        datasets: [
                            {
                                label: 'Total de pacientes',
                                data: datos,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '2':
                    const labels2 = []
                    const datos2 = []
                    data.map((item) => {
                        labels2.push(item.habitacion)
                        datos2.push(item.pacientes_en_habitacion)
                    })
                    setReporteInfo({
                        title: 'Cantidad de pacientes que pasan por cada habitación',
                        labels: labels2,
                        datasets: [
                            {
                                label: 'Total de pacientes',
                                data: datos2,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '3':
                    const labels3 = []
                    const datos3 = []
                    data.map((item) => {
                        labels3.push(item.genero)
                        datos3.push(item.total_pacientes)
                    })
                    setReporteInfo({
                        title: 'Cantidad de pacientes que llegan a la clínica, agrupados por género',
                        labels: labels3,
                        datasets: [
                            {
                                label: 'Total de pacientes',
                                data: datos3,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '4':
                    const labels4 = []
                    const datos4 = []
                    data.map((item) => {
                        labels4.push(item.edad+' años')
                        datos4.push(item.total_atendidos)
                    })
                    setReporteInfo({
                        title: 'Top 5 edades más atendidas en la clínica',
                        labels: labels4,
                        datasets: [
                            {
                                label: 'Total atendidos',
                                data: datos4,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '5':
                    const labels5 = []
                    const datos5 = []
                    data.map((item) => {
                        labels5.push(item.edad+' años')
                        datos5.push(item.total_atendidos)
                    })
                    setReporteInfo({
                        title: 'Top 5 edades menos atendidas en la clínica',
                        labels: labels5,
                        datasets: [
                            {
                                label: 'Total atendidos',
                                data: datos5,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '6':
                    const labels6 = []
                    const datos6 = []
                    data.map((item) => {
                        labels6.push(item.habitacion)
                        datos6.push(item.pacientes_en_habitacion)
                    })
                    setReporteInfo({
                        title: 'Top 5 habitaciones más utilizadas',
                        labels: labels6,
                        datasets: [
                            {
                                label: 'Total de pacientes',
                                data: datos6,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '7':
                    const labels7 = []
                    const datos7 = []
                    data.map((item) => {
                        labels7.push(item.habitacion)
                        datos7.push(item.pacientes_en_habitacion)
                    })
                    setReporteInfo({
                        title: 'Top 5 habitaciones menos utilizadas',
                        labels: labels7,
                        datasets: [
                            {
                                label: 'Total de pacientes',
                                data: datos7,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                case '8':
                    const labels8 = []
                    const datos8 = []
                    data.map((item) => {
                        labels8.push(item.fecha)
                        datos8.push(item.pacientes)
                    })
                    setReporteInfo({
                        title: 'Día con más pacientes en la clínica',
                        labels: labels8,
                        datasets: [
                            {
                                label: 'Total de pacientes',
                                data: datos8,
                                backgroundColor: backgroundColors,
                                borderColor: borderColors,
                                borderWidth: 1,
                            },
                        ],
                    })
                    break;
                default:
                    break;
            }
        }
    }, [data]);

    return (
        <GeneralLayout title='Reportes'>
            <Container>
                <Row className='mb-4'>
                    <Form>
                        <Form.Group className="mb-3">
                            <Form.Label>Base de datos</Form.Label>
                            <Form.Select
                                onChange={
                                    (event) => {
                                        setBase(event.target.value)
                                    }
                                }>
                                <option value=''>Elige una base de datos...</option>
                                <option value='mysql'>MySQL</option>
                                <option value='mongodb'>MongoDB</option>
                                <option value='cassandra'>Cassandra</option>
                                <option value='redis'>Redis</option>
                            </Form.Select>
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>Reporte</Form.Label>
                            <Form.Select
                                onChange={
                                    (event) => {
                                        setReporte(event.target.value)
                                    }
                                }>
                                <option value='1'>Elige un reporte...</option>
                                <option value='1'>1. Total de pacientes por edad</option>
                                <option value='2'>2. Cantidad de pacientes que pasan por cada habitación</option>
                                <option value='3'>3. Cantidad de pacientes que llegan a la clínica, agrupados por género</option>
                                <option value='4'>4. Top 5 edades más atendidas en la clínica</option>
                                <option value='5'>5. Top 5 edades menos atendidas en la clínica</option>
                                <option value='6'>6. Top 5 habitaciones más utilizadas</option>
                                <option value='7'>7. Top 5 habitaciones menos utilizadas</option>
                                <option value='8'>8. Día con más pacientes en la clínica</option>
                            </Form.Select>
                        </Form.Group>
                        {/* <Button type="submit">Submit</Button> */}
                    </Form>
                </Row>
                <div className='reporte-content d-flex align-items-center flex-column'>
                    {reporteInfo &&
                        <h2 className='reporte-title'>
                            {reporteInfo.title}
                        </h2>
                    }
                    {
                        reporte === '1' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '2' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '3' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '4' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '5' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '6' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '7' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                    {
                        reporte === '8' && reporteInfo &&
                        <Circular
                            data={reporteInfo}
                        />
                    }
                </div>
            </Container>
        </GeneralLayout >
    )
}
