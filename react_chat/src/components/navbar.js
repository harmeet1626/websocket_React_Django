import React, { useEffect, useRef, useState } from 'react';
import { toast } from 'react-toastify';

import Form from 'react-bootstrap/Form';
import InputGroup from 'react-bootstrap/InputGroup';
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
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import { useLocation, useNavigate } from 'react-router-dom';

export default function Navbar() {
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const [openNav, setOpenNav] = useState(false);
    const user = AuthService.getCurrentUser()
    const [userdetails, setUserdetails] = useState()
    const fileInputRef = useRef(null)
    const navigate = useNavigate()
    const location = useLocation()
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    const [selectedImage, setSelectedImage] = useState(null);
    async function getUserApi() {
        if (user && user?.token) {

            const res = await fetch(`http://${apiUrl}GetCurrentUser/`, {
                method: "GET",
                headers: {
                    Accept: "application/json",
                    "Content-Type": "application/json",
                    Authorization: `Token ${user?.token}`
                },
            });
            const data = await res.json();
            setUserdetails(data)
        }
    }
    useEffect(() => {
        getUserApi()
    }, [user?.token])

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        setSelectedImage(file);
    };
    useEffect(() => {
        if (selectedImage) {
            handleImageUpload();
        }
    }, [selectedImage]);
    const handleImageUpload = async () => {
        if (selectedImage) {
            const form_Data = new FormData()
            form_Data.append("image", selectedImage)
            await fetch(`http://${apiUrl}UpdateUserImage/${user?.username}`, {
                method: 'PUT',
                body: form_Data,
            })
                .then(response => response.json())
                .then(data => {
                    setSelectedImage(null)
                    getUserApi()
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
    return (
        <div>
            <Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>User Details</Modal.Title>
                </Modal.Header>
                <input ref={fileInputRef} type="file" accept="image/png, image/jpeg" style={{ display: 'none' }}
                    onChange={handleFileChange} />

                <div style={{ display: "flex", padding: '25px' }}>
                    <div style={{ position: 'relative', padding: '10px', height: 'fit-content' }}>
                        <img src={`http://${apiUrl}` + userdetails?.userimage} style={{ borderRadius: "40px", height: '90px', width: '90px' }} />
                        <div style={{ position: 'absolute', bottom: 0, right: 0 }}>
                            <span class="material-symbols-outlined" style={{ cursor: 'pointer' }} onClick={() => {
                                fileInputRef.current.click();
                            }}>
                                edit
                            </span>
                        </div>
                    </div>
                    <div style={{ padding: '10px' }}>
                        <InputGroup className="mb-3">
                            <InputGroup.Text id="basic-addon1">Username</InputGroup.Text>
                            <Form.Control
                                placeholder="Username"
                                aria-label="Username"
                                aria-describedby="basic-addon1"
                                value={userdetails?.username}
                                disabled={true}
                            />
                        </InputGroup>
                        <InputGroup className="mb-3">
                            <InputGroup.Text id="basic-addon1">Email</InputGroup.Text>
                            <Form.Control
                                placeholder="Username"
                                aria-label="Username"
                                aria-describedby="basic-addon1"
                                value={userdetails?.userEmail}
                                disabled={true}
                            />
                        </InputGroup>
                    </div>
                </div>
            </Modal>



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
                                    <MDBNavbarItem className='ml-auto home_button' style={{ marginLeft: 'auto', cursor: 'pointer' }} onClick={handleShow}>
                                        <MDBNavbarLink style={{ fontWeight: 'bold', textTransform: 'capitalize' }}>< img src={`http://${apiUrl}` + userdetails?.userimage} style={{ height: '35px', width: '35px', borderRadius: "20px" }} /></MDBNavbarLink>
                                    </MDBNavbarItem>

                                </>

                            }

                        </MDBNavbarNav>
                    </MDBCollapse>
                </MDBContainer>
            </MDBNavbar>
        </div>
    );
}