import React, { useEffect } from 'react'
import GeneralLayout from '../../layouts/GeneralLayout'
import { Button, Container, Form, Row } from 'react-bootstrap'
import { getAllHabitacion, getAllPaciente } from '../../api/reportesApi'
import { useQuery } from 'react-query'
import { useSendLog } from '../../api/logApi'

export default function IngresoView() {
  const [base, setBase] = React.useState('1')
  const [log, setLog] = React.useState('')
  const [habitacion, setHabitacion] = React.useState('')
  const [paciente, setPaciente] = React.useState('')
  const [descripcion, setDescripcion] = React.useState('')

  const { isLoading: loadingPaciente, error: errorP, data: pacientes } = useQuery({
    queryKey: ['pacientes'],
    queryFn: () => getAllPaciente(),
  })

  const { isLoading: loadingHabitaciones, error: errorH, data: habitaciones } = useQuery({
    queryKey: ['habitaciones'],
    queryFn: () => getAllHabitacion(),
  })

  //console.log(habitaciones)

  function validateForm() {
    if (log === 'loghabitacion') {
      return habitacion === ''
    } else if (log === 'logactividad') {
      return habitacion === '' || paciente === ''
    }
    return true
  }

  const { mutate: mutSendLog, data, isLoading, isError, error } = useSendLog();

  useEffect(() => {
    setHabitacion('')
    setPaciente('')
    setDescripcion('')
  }, [log])


  const handleDescripcionChange = (event) => {
    setDescripcion(event.target.value);
  };


  const handleSubmit = (event) => {
    event.preventDefault()
    const data = {
      'base': base,
      'log': log,
      'habitacion': habitacion,
      'paciente': paciente,
      'descripcion': descripcion
    }
    mutSendLog(data)
    console.log(data)
  }

  //console.log(pacientes)

  if (loadingHabitaciones) return 'Loading...'
  if (errorH) return 'An error has occurred: ' + errorH.message

  return (
    <GeneralLayout title='Ingreso de datos'>
      <Container>
        <Row className='mb-4'>
          <Form onSubmit={handleSubmit}>
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
              <Form.Label>Tipo</Form.Label>
              <Form.Select
                onChange={
                  (event) => {
                    setLog(event.target.value)
                  }
                }>
                <option value=''>Elige un log...</option>
                <option value='loghabitacion'>LogHabitacion</option>
                <option value='logactividad'>LogActividad</option>
              </Form.Select>
            </Form.Group>
            {
              log === 'loghabitacion' ? (
                <Form.Group className="mb-3">
                  <Form.Label>Habitacion</Form.Label>
                  <Form.Select
                    onChange={
                      (event) => {
                        setHabitacion(event.target.value)
                      }
                    }>
                    <option value=''>Elige una habitacion...</option>
                    {
                      !loadingHabitaciones && habitaciones.map((habitacion, index) => (
                        <option key={index} value={habitacion.idHabitacion}>{habitacion.habitacion}</option>
                      ))
                    }

                  </Form.Select>
                </Form.Group>
              ) : (
                log === 'logactividad' && (
                  <>
                    <Form.Group className="mb-3">
                      <Form.Label>Habitacion</Form.Label>
                      <Form.Select
                        onChange={
                          (event) => {
                            setHabitacion(event.target.value)
                          }
                        }>
                        <option value=''>Elige una habitacion...</option>
                        {
                          !loadingHabitaciones && habitaciones.map((habitacion, index) => (
                            <option key={index} value={habitacion.idHabitacion}>{habitacion.habitacion}</option>
                          ))
                        }
                      </Form.Select>
                    </Form.Group>
                    <Form.Group className="mb-3">
                      <Form.Label>Paciente</Form.Label>
                      {/* <Form.Select
                        onChange={
                          (event) => {
                            setPaciente(event.target.value)
                          }
                        }>
                        <option value=''>Elige un paciente...</option>
                        {/* {
                          !loadingPaciente && pacientes.map((paciente,index) => (
                            <option key={index} value={paciente.idPaciente}>{paciente.idPaciente}</option>
                          ))
                        }
                      </Form.Select> */}
                      <Form.Control
                        type='number'
                        max={pacientes[pacientes.length - 1].idPaciente}
                        min={pacientes[0].idPaciente}
                        onChange={
                          (event) => {
                            setPaciente(event.target.value)
                          }
                        }
                        value={paciente}
                      />
                    </Form.Group>
                  </>
                )
              )

            }
            <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
              <Form.Label>Descripcion</Form.Label>
              <Form.Control as="textarea"
                onChange={handleDescripcionChange}
                value={descripcion}
              />
            </Form.Group>
            <Button type="submit" disabled={validateForm()}>Submit</Button>
          </Form>
        </Row>
      </Container>
    </GeneralLayout>
  )
}
