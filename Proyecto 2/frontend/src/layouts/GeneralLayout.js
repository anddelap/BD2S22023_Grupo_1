import React from 'react'
import { BsArrowLeft } from 'react-icons/bs';
import { Await, Link, useNavigate } from 'react-router-dom';
import Footer from '../components/Footer';
import '../styles/layouts/GeneralLayout.scss'
import NavbarMenu from '../components/NavbarMenu/NavbarMenu';

export default function GeneralLayout(props) {
    const {children,logout, back, title} = props
    const navigate = useNavigate();
    /*const queryClient = useQueryClient();

    const {refetch} = useQuery('user')
    function useHandleLogout(event) {
        event.preventDefault();
        const res = Await.refetch()
        //queryClient.invalidateQueries('user')
        navigate("/");
    } */
    return (
        <div className='gl-main'>
            {/* <Navbar bg="dark" className='nav-bar'>
                <Navbar.Brand onClick={handleHome} className='nav-brand'>
                    <h2 className="brand">
                      Proyecto
                    </h2>
                </Navbar.Brand>
                <Nav className="me-auto">
                    <Nav.Link onClick={handleLog}>Logs</Nav.Link>
                </Nav>
            </Navbar> */}
            <NavbarMenu/>
            <div className="gl-content">
                <h1 className="gl-title">
                    {title}
                </h1>
                {children}
            </div>
            <Footer/>
        </div>
    )
}
