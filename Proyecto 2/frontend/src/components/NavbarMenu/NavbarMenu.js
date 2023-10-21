import React from 'react'
import { Nav, Navbar } from 'react-bootstrap'
import { Link, useNavigate } from 'react-router-dom';
import './NavbarMenu.scss'
export default function NavbarMenu() {
  const navigate = useNavigate();
  return (
    <Navbar bg="dark" className='nav-bar'>
      <Navbar.Brand onClick={() => navigate('/')} className='nav-brand'>
        <h2 className="brand">
          Proyecto 2
        </h2>
      </Navbar.Brand>
      <Nav className="justify-content-end">
        <Nav.Link >
          <Link to="/ingreso-datos" className='link'>
            Ingreso de datos
          </Link>
        </Nav.Link>
        <Nav.Link>
          <Link to="/" className='link'>
            Reportes
          </Link>
        </Nav.Link >
      </Nav>
    </Navbar>
  )
}
