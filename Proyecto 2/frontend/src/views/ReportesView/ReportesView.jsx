import React from 'react'
import GeneralLayout from '../../layouts/GeneralLayout'
import { Button, Container, Form, Row } from 'react-bootstrap'
import './ReportesView.scss'

export default function ReportesView() {
    const [reporte, setReporte] = React.useState('1')
    const [base, setBase] = React.useState('1')

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
                                <option value='1'>Elige una base de datos...</option>
                                <option value='1'>MySQL</option>
                                <option value='2'>MongoDB</option>
                                <option value='3'>Cassandra</option>
                                <option value='4'>Redis</option>
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
                                <option value='1'>Total de pacientes por edad</option>
                                <option value='2'>Cantidad de pacientes que pasan por cada habitación</option>
                                <option value='3'>Cantidad de pacientes que llegan a la clínica, agrupados por género</option>
                                <option value='4'>Top 5 edades más atendidas en la clínica</option>
                                <option value='5'>Top 5 edades menos atendidas en la clínica</option>
                                <option value='6'>Top 5 habitaciones más utilizadas</option>
                                <option value='7'>Top 5 habitaciones menos utilizadas</option>
                                <option value='8'>Día con más pacientes en la clínica</option>
                            </Form.Select>
                        </Form.Group>
                        <Button type="submit">Submit</Button>
                    </Form>
                </Row>
                <Row>
                    Reporte {reporte}
                </Row>
            </Container>
        </GeneralLayout >
    )
}
