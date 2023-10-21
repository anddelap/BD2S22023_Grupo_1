import React from 'react'
import '../styles/components/Top3Table.css'
import { getDepartamentosPresidentes } from '../api/dashboardApi'
import { useQuery } from 'react-query'
export default function Top3Table() {
  const { isLoading, error, data } = useQuery({
    queryKey: ['top3'],
    queryFn: () => getDepartamentosPresidentes(),
    refetchInterval: 1000,
  })
  //console.log(data)
  if (isLoading) return 'Loading...'
  if (error) return 'An error has occurred: ' + error.message
  if (data.resultado.length < 3) return 'Los datos apareceran cuando se hayan registrado mas de 3 lugares con votos de presidentes'
  if(data.resultado.length >= 3)
  return (
    <div className='podium'>
      <div className='position'>
        <div>
          <div className='department'>
            {data.resultado[1].departamento}
          </div>
          <div className='cant'>
            {data.resultado[1].count_presidente} votos
          </div>
        </div>
        <div className='second'>
          2
        </div>
      </div>
      <div className='position'>
        <div>
          <div className='department'>
            {data.resultado[0].departamento}
          </div>
          <div className='cant'>
            {data.resultado[0].count_presidente} votos
          </div>
        </div>
        <div className='first'>
          1
        </div>
      </div>
      <div className='position'>
        <div>
          <div className='department'>
            {data.resultado[2].departamento}
          </div>
          <div className='cant'>
            {data.resultado[2].count_presidente} votos
          </div>
        </div>
        <div className='third'>
          3
        </div>
      </div>
    </div>
  )
}
