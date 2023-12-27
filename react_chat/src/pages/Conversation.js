import React, { useEffect, useState } from 'react';
import { Link, Outlet, useNavigate, useLocation } from 'react-router-dom';
import AuthService from '../auth/AuthService';
import '../style/chat.css'
import Avatar from 'react-avatar';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';


export const Conversation = () => {
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const navigate = useNavigate()
    const [users, setUsers] = useState([]);
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const location = useLocation()
    const [groupList, setGroupList] = useState([])
    useEffect(() => {
        async function fetchUsers() {
            if (!user?.username) {
                navigate('/login')
            }
            const res = await fetch(`http://${apiUrl}UserGroup/`, {
                headers: {
                    Authorization: `Token ${user?.token}`
                }
            });
            const data = await res.json();
            if (data?.detail == "Invalid token.") {
                navigate('/login')
            }
            // setUsers(data);
            setGroupList(data.res)
        }
        fetchUsers();
    }, [user])
    useEffect(() => {
        async function fetchUsers() {
            if (!user?.username) {
                navigate('/login')
            }
            const res = await fetch(`http://${apiUrl}users/`, {
                headers: {
                    Authorization: `Token ${user?.token}`
                }
            });
            const data = await res.json();
            setUsers(data);
        }
        fetchUsers();
    }, []);

    const [homepage, setHomepage] = useState()
    useEffect(() => {
        if (location.pathname == '/') {
            setHomepage(true)
        }
        else {
            setHomepage(false)
        }
    }, [location])

    function createConversationName(username) {
        const namesAlph = [user?.username, username].sort();
        return `${namesAlph[0]}__${namesAlph[1]}`;
    }
    const inputStyle = {
        padding: '10px',
        fontSize: '16px',
        border: '2px solid #ccc',
        borderRadius: '30px',
        outline: 'none',
        width: '100%',
        height: "40px"
    };

    const [searchTerm, setSearchTerm] = useState('');
    const filteredData = users?.filter((item) =>
        item.username.toLowerCase().includes(searchTerm.toLowerCase())
    );
    const handleSearch = (e) => {
        setSearchTerm(e.target.value);
    };
    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    return (

        <div className="row clearfix" >
            <div className="col-lg-12">
                <Modal
                    show={show}
                    onHide={handleClose}
                    backdrop="static"
                    keyboard={false}
                >
                    <Modal.Header closeButton>
                        <Modal.Title>Modal title</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        I will not close if you click outside me. Do not even try to press
                        escape key.
                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            Close
                        </Button>
                        <Button variant="primary">Understood</Button>
                    </Modal.Footer>
                </Modal>
                <div className="card chat-app" style={{ backgroundColor: "whitesmoke", display: "flex" }}>

                    <div id="plist" className="people-list"  >
                        <div>
                            <div className="input-group" style={{ flexWrap: 'inherit' }}>

                                <span style={{ marginTop: '5px' }} class="material-symbols-outlined">
                                    search
                                </span>

                                <input style={inputStyle} placeholder='search user' value={searchTerm}
                                    onChange={handleSearch} />

                            </div>
                            <ul className="list-unstyled chat-list mt-2 mb-0" >
                                <div style={{ display: "flex", marginTop: "3vh" }}>
                                    <p>Groups</p>
                                    <span style={{ paddingLeft: "5px" }} class="material-symbols-outlined">
                                        groups
                                    </span>
                                    <span onClick={handleShow} style={{ marginLeft: '20vh', cursor: 'pointer' }} class="material-symbols-outlined">
                                        add_box
                                    </span>
                                </div>
                                {groupList
                                    .map((group, index) => (
                                        <div key={index}>
                                            <li className="clearfix" style={{ borderBottom: "1px solid #ddd" }}>
                                                <Link to={`groups/${group}`}>
                                                    <div className="about" style={{ display: "flex" }}>
                                                        <Avatar
                                                            name={group}
                                                            round={true} // Optional: Makes the avatar round
                                                            size="30"   // Optional: Set the size of the avatar
                                                        />&nbsp;&nbsp;
                                                        <p style={{ padding: "5px" }} className="name">{group}</p>
                                                    </div>
                                                </Link>
                                            </li>
                                        </div>
                                    ))}
                                <div style={{ display: "flex" }}>
                                    <p style={{ margin: 'revert' }}>Direct Mssages</p>
                                    <span style={{ paddingLeft: '5px', paddingTop: "15px" }} class="material-symbols-outlined">
                                        group
                                    </span>
                                </div>
                                {users &&
                                    filteredData
                                        .filter((u) => u.username !== user?.username)
                                        .map((user, index) => (
                                            <div key={index}>
                                                <li className="clearfix" style={{ borderBottom: "1px solid #ddd" }}>
                                                    <Link to={`user/${createConversationName(user.username)}`}>
                                                        <div className="about" style={{ display: "flex" }}>
                                                            <Avatar
                                                                name={user.username}
                                                                round={true} // Optional: Makes the avatar round
                                                                size="30"   // Optional: Set the size of the avatar
                                                            />&nbsp;&nbsp;
                                                            <p style={{ padding: "5px" }} className="name">{user.username}</p>
                                                        </div>
                                                    </Link>
                                                </li>
                                            </div>
                                        ))}
                            </ul>
                        </div>

                    </div>
                    <div>
                        {homepage ?
                            <div style={{ marginLeft: '20%', }}>
                                <img style={{ height: '100%', width: '100%' }} src='https://plus.unsplash.com/premium_photo-1661521092142-b03326bcc8bc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' />
                            </div> :
                            <Outlet />
                        }
                    </div>
                </div>
            </div>
        </div>

    );
};

