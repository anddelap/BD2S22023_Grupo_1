import React from 'react'
import { Table } from 'react-bootstrap'
import { getAllDataMysql } from '../api/dashboardApi'
import { useQuery } from 'react-query'

export default function RecopilationTable() {
    const { isLoading, error, data } = useQuery({
        queryKey: ['all-data-mysql'],
        queryFn: () => getAllDataMysql(),
        refetchInterval:1000,
    })
    //console.log(data)
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
