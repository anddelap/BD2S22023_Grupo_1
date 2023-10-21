import React from 'react'
import { Col, Container, Row } from 'react-bootstrap'
import { useQuery } from 'react-query'
import { getAllCircularMysql } from '../api/dashboardApi'
import Circular from './Circular'

export default function CircularRep() {
    const { isLoading, error, data } = useQuery({
        queryKey: ['circular-data'],
        queryFn: () => getAllCircularMysql(),
        refetchInterval:1000,
    })
    if (isLoading) return 'Loading...'
    if (error) return 'An error has occurred: ' + error.message
    return (
        <Container>
            <h3 className='p-subtitle'>Segun Departamento</h3>
            <Row className='p-row'>
                <Col lg={7} >
                    <Circular datos={data.votosDepartamento}/>
                </Col>
            </Row>
            <h3 className='p-subtitle'>Segun Municipio</h3>
            <Row className='p-row'>
                <Col lg={7} >
                    <Circular datos={data.votosMunicipio}/>
                </Col>
            </Row>
        </Container>
    )
}
