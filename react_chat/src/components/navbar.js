import React, { useEffect, useState } from 'react';
import {
    MDBContainer,
    MDBNavbar,
    MDBNavbarBrand,
    MDBNavbarToggler,
    MDBNavbarNav,
    MDBNavbarItem,
    MDBNavbarLink,
    MDBCollapse,
    MDBIcon
} from 'mdb-react-ui-kit';
import AuthService from '../auth/AuthService';
import { useLocation, useNavigate } from 'react-router-dom';

export default function Navbar() {
    const [openNav, setOpenNav] = useState(false);
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const navigate = useNavigate()
    const location = useLocation()
    return (
        <MDBNavbar expand='lg' style={{ backgroundColor: "rgb(41 155 211)" }}>
            <MDBContainer fluid>
                <MDBNavbarBrand href='#'><span style={{ padding: "2px" }} class="material-symbols-outlined">
                    forum
                </span> Chat Application</MDBNavbarBrand>
                <MDBNavbarToggler
                    type='button'
                    aria-expanded='false'
                    aria-label='Toggle navigation'
                    onClick={() => setOpenNav(!openNav)}
                >
                    <MDBIcon icon='bars' fas />
                </MDBNavbarToggler>
                <MDBCollapse navbar open={openNav}>
                    <MDBNavbarNav>
                        {location.pathname == '/login' || location.pathname == '/signup' ?
                            <>
                                <MDBNavbarItem>
                                    <MDBNavbarLink href='/login'>Login</MDBNavbarLink>
                                </MDBNavbarItem>
                                <MDBNavbarItem>
                                    <MDBNavbarLink href='/signup' aria-current='page'>
                                        Signup
                                    </MDBNavbarLink>
                                </MDBNavbarItem>
                            </>

                            :
                            <>
                                <MDBNavbarItem className='home_button'>
                                    <MDBNavbarLink href='/'>
                                        Home
                                    </MDBNavbarLink>
                                </MDBNavbarItem>
                                <MDBNavbarItem>
                                    <MDBNavbarLink onClick={() => {
                                        AuthService.logout()
                                        navigate('/login')
                                    }}>logout</MDBNavbarLink>
                                </MDBNavbarItem>
                                <MDBNavbarItem className='ml-auto home_button' style={{ marginLeft: 'auto' }}>
                                    <MDBNavbarLink style={{ fontWeight: 'bold', textTransform: 'capitalize' }}>{user?.username}</MDBNavbarLink>
                                </MDBNavbarItem>

                            </>

                        }

                    </MDBNavbarNav>
                </MDBCollapse>
            </MDBContainer>
        </MDBNavbar>
    );
}