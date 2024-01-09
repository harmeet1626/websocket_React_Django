import React, { useState, useRef } from 'react';
import { toast } from 'react-toastify';
import axios from 'axios';
import {
    MDBBtn,
    MDBContainer,
    MDBRow,
    MDBCol,
    MDBCard,
    MDBCardBody,
    MDBCardImage,
    MDBInput,
} from 'mdb-react-ui-kit';
import { useNavigate } from 'react-router-dom';

function SignUp() {
    const [username_input, setUsername_input] = useState('')
    const [email_input, setEmail_input] = useState('')
    const [password_input, setPassword_input] = useState('')
    const navigate = useNavigate()
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const [image, setImage] = useState()
    const [selectedImage, setSelectedImage] = useState(null);


    async function createUser() {
        try {
            const response = await axios.post(`http://${apiUrl}create-user/`, {
                username: username_input,
                email: email_input,
                password: password_input,
            }, {
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            handleImageUpload();


        } catch (error) {

            console.error('Error creating user:', error);
            toast.error(error, {
                position: 'top-right',
                autoClose: 3000,
                hideProgressBar: false,
                closeOnClick: true,
                pauseOnHover: true,
                draggable: true,
            });
        }
    }

    const handleImageUpload = async () => {
        if (selectedImage) {
            const form_Data = new FormData()
            form_Data.append("image", selectedImage)
            await fetch(`http://${apiUrl}UpdateUserImage/${username_input}`, {
                method: 'PUT',
                body: form_Data,
            })
                .then(response => response.json())
                .then(data => {
                    navigate('/login');
                    toast.success('You have signed up successfully!', {
                        position: 'top-right',
                        autoClose: 3000,
                        hideProgressBar: false,
                        closeOnClick: true,
                        pauseOnHover: true,
                        draggable: true,
                    });
                })
                .catch(error => {
                    console.error('Error uploading image', error);
                    toast.error('Some error occured ', {
                        position: 'top-right',
                        autoClose: 3000,
                        hideProgressBar: false,
                        closeOnClick: true,
                        pauseOnHover: true,
                        draggable: true,
                    });
                });
        }
    };
    const fileInputRef = useRef(null);
    const handleImageChange = (e) => {
        const file = e.target.files[0];
        setSelectedImage(file);
    };

    return (
        <MDBContainer fluid>
            <MDBCard className='text-black m-5' style={{ borderRadius: '25px' }}>
                <MDBCardBody>
                    <MDBRow>
                        <MDBCol md='10' lg='6' className='order-2 order-lg-1 d-flex flex-column align-items-center'>

                            <p classNAme="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign up</p>
                            <div className="d-flex flex-row align-items-center mb-4 ">
                                <MDBInput value={username_input} onChange={(e) => setUsername_input(e.target.value)} label='Username' id='form1' type='text' className='w-100' />
                            </div>

                            <div className="d-flex flex-row align-items-center mb-4">
                                <MDBInput value={email_input} onChange={(e) => setEmail_input(e.target.value)} label='Your Email' id='form2' type='email' />
                            </div>

                            <div className="d-flex flex-row align-items-center mb-4">
                                <MDBInput value={password_input} onChange={(e) => setPassword_input(e.target.value)} label='Password' id='form3' type='password' />
                            </div>
                            <div className="d-flex flex-row align-items-center mb-4 ">

                                <div className="" style={{ paddingLeft: "50px" }}>
                                    <h6 for="file-input"> Profile Picture</h6><br></br>
                                    <input type="file" accept="image/*" onChange={handleImageChange} />
                                </div>
                            </div>
                            <MDBBtn onClick={() => createUser()} className='mb-4' size='lg'>Register</MDBBtn>
                        </MDBCol>

                        <MDBCol md='10' lg='6' className='order-1 order-lg-2 d-flex align-items-center'>
                            <MDBCardImage src='https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp' fluid />
                        </MDBCol>

                    </MDBRow>
                </MDBCardBody>
            </MDBCard>

        </MDBContainer>
    );
}

export default SignUp;