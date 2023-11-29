import React, { useState } from 'react';
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
import { useNavigate } from 'react-router-dom';

export default function Navbar() {
    const [openNav, setOpenNav] = useState(false);
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const navigate = useNavigate()
    return (
        <MDBNavbar expand='lg' light bgColor='light'>
            <MDBContainer fluid>
                <MDBNavbarBrand href='#'>Navbar</MDBNavbarBrand>
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
                        <MDBNavbarItem>
                            <MDBNavbarLink active aria-current='page' href='/'>
                                Home
                            </MDBNavbarLink>
                        </MDBNavbarItem>
                        {/* <MDBNavbarItem>
                            <MDBNavbarLink href='#'>Features</MDBNavbarLink>
                        </MDBNavbarItem> */}
                        <MDBNavbarItem>
                            {user && user?.token ?
                                <MDBNavbarLink onClick={() => {
                                    AuthService.logout()
                                    navigate('/login')
                                }}>logout</MDBNavbarLink>
                                :
                                <MDBNavbarLink href='/login'>Login</MDBNavbarLink>

                            }
                        </MDBNavbarItem>

                        <MDBNavbarItem>
                            {/* <MDBNavbarLink disabled href='#' tabIndex={-1} aria-disabled='true'>
                                Disabled
                            </MDBNavbarLink> */}
                        </MDBNavbarItem>
                    </MDBNavbarNav>
                </MDBCollapse>
            </MDBContainer>
        </MDBNavbar>
    );
}