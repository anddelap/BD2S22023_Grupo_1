import React from 'react'
import { Table } from 'react-bootstrap'
import { useQuery } from 'react-query'
import { getLastRedis } from '../api/dashboardApi'

export default function LastRedisTable() {
    const { isLoading, error, data } = useQuery({
        queryKey: ['last-data-redis'],
        queryFn: () => getLastRedis(),
        refetchInterval:1000,
    })
    if (isLoading) return 'Loading...'
    if (error) return 'An error has occurred: ' + error.message
    return (
        <Table striped bordered variant="dark">
            <thead>
                <tr>
                    <th>Sede</th>
                    <th>municipio</th>
                    <th>Departamento</th>
                    <th>Papeleta</th>
                    <th>Partido</th>
                </tr>
            </thead>
            <tbody>
                {data.resultado.map((item, index) => (
                    <tr key={index}>
                        <td>{item.sede}</td>
                        <td>{item.municipio}</td>
                        <td>{item.departamento}</td>
                        <td>{item.papeleta}</td>
                        <td>{item.partido}</td>
                    </tr>
                ))}

            </tbody>
        </Table>
    )
}
