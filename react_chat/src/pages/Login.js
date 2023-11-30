import React, { useState } from 'react';
import { useNavigate } from "react-router-dom";
import axios from 'axios'
import {
    MDBBtn,
    MDBContainer,
    MDBRow,
    MDBCol,
    MDBCard,
    MDBCardBody,
    MDBInput,
    MDBIcon,
    MDBCheckbox
}
    from 'mdb-react-ui-kit';
import AuthService from '../auth/AuthService';
function Login() {
    const navigate = useNavigate()
    const [userName, setUsername] = useState('')
    const [password, SetPassword] = useState('')
    async function login_user() {
        await AuthService.login(userName, password).then((res) => {
            if (res?.username) {

                navigate('/')
            }
        })
    }
    return (
        <MDBContainer fluid>

            <MDBRow className='d-flex justify-content-center align-items-center h-100'>
                <MDBCol col='12'>

                    <MDBCard className='bg-white my-5 mx-auto' style={{ borderRadius: '1rem', maxWidth: '500px' }}>
                        <MDBCardBody className='p-5 w-100 d-flex flex-column'>

                            <h2 className="fw-bold mb-2 text-center">Sign in</h2>
                            <p className="text-white-50 mb-3">Please enter your login and password!</p>

                            <MDBInput onInput={(e) => setUsername(e.target.value)} wrapperClass='mb-4 w-100' label='Username' id='formControlLg' type='email' size="lg" />
                            <MDBInput onInput={(e) => SetPassword(e.target.value)} wrapperClass='mb-4 w-100' label='Password' id='formControlLg' type='password' size="lg" />


                            <MDBBtn onClick={() => login_user()} size='lg'>
                                Login
                            </MDBBtn>

                        </MDBCardBody>
                    </MDBCard>

                </MDBCol>
            </MDBRow>

        </MDBContainer>
    );
}

export default Login;