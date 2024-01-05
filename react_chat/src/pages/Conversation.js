import React, { useEffect, useState } from 'react';
import { Link, Outlet, useNavigate, useLocation } from 'react-router-dom';
import AuthService from '../auth/AuthService';
import '../style/chat.css'
import Avatar from 'react-avatar';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import InputGroup from 'react-bootstrap/InputGroup';
import Form from 'react-bootstrap/Form';
import InputEmoji from 'react-input-emoji'
import { useDispatch, useSelector } from 'react-redux';
import { fetchGroups } from '../store/chatListing';

export const Conversation = () => {
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const navigate = useNavigate()
    const [users, setUsers] = useState([]);
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const location = useLocation()
    const [groupList, setGroupList] = useState([])
    const dispatch = useDispatch()
    const GroupListResponse = useSelector((state) => state.groupList)
    const [activeChat, setActiveChat] = useState()
    const [selectedImage, setSelectedImage] = useState(null);

    function DispatchfetchGroups() {
        dispatch(fetchGroups(`Token ${user?.token}`))
    }
    useEffect(() => {
        if (GroupListResponse.status == 'succeeded') {
            setGroupList(GroupListResponse.data.res)
        }
    }, [GroupListResponse])

    useEffect(() => {
        DispatchfetchGroups();
    }, [user])

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
    useEffect(() => {
        fetchUsers();
    }, []);



    useEffect(() => {
        var inputString = location.pathname;
        var splitString = inputString.split('/');

        if (splitString.length > 2) {
            var result = splitString.slice(2).join('/');
            setActiveChat(result)
        } else {
            console.log("Not enough slashes in the string.");
        }

    }, [location])


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
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    const [groupNameInput, setGroupNameInput] = useState("")
    const [checkedUsers, setCheckedUsers] = useState([user?.username]);
    const handleCheckboxChange = (username) => {
        setCheckedUsers((prevCheckedUsers) =>
            prevCheckedUsers.includes(username)
                ? prevCheckedUsers.filter((u) => u !== username)
                : [...prevCheckedUsers, username]
        );
    };
    async function createGroup() {
        if (!user?.username) {
            navigate('/login')
        }
        const form_Data = new FormData()
        form_Data.append("name", groupNameInput)
        // form_Data.append("usernames", [checkedUsers])
        for (const username of checkedUsers) {
            form_Data.append('usernames', username);
        }
        form_Data.append("Created_by", user?.username)
        const res = await fetch(`http://${apiUrl}CreateGroup/`, {
            method: "POST",
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                usernames: checkedUsers,
                name: groupNameInput,
                Created_by: user.username
            })
        });
        const data = await res.json();
        handleImageUpload()
    }
    const handleSearch = (e) => {
        setSearchTerm(e.target.value);
    };

    // Filter array1
    const filteredGroup = groupList.filter((item) =>
        item.groupName.toLowerCase().includes(searchTerm.toLowerCase())
    );

    // Filter array2
    const filteredData = users?.filter((item) =>
        item.username.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        setSelectedImage(file);
    };
    const handleImageUpload = async () => {
        if (selectedImage) {
            const form_Data = new FormData()
            form_Data.append("image", selectedImage)
            fetch(`http://${apiUrl}UpdateGroupImage/${groupNameInput}`, {
                method: 'PUT',
                body: form_Data,
            })
                .then(response => response.json())
                .then(data => {
                    dispatch(fetchGroups(`Token ${user?.token}`))
                    DispatchfetchGroups()
                    handleClose()
                })
                .catch(error => {
                    console.error('Error uploading image', error);
                });
        }
    };

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
                        <Modal.Title>Create Group</Modal.Title>
                    </Modal.Header>
                    <div style={{ padding: '10px' }}>
                        <h6>Choose Group Icon</h6>
                        <input type="file" accept="image/*" onChange={handleImageChange} />
                    </div>
                    <InputGroup size="sm" className="mb-3">
                        <InputEmoji
                            cleanOnEnter
                            onChange={setGroupNameInput}
                            type="text"
                            className="form-control"
                            placeholder="Enter Group Name"
                            style={{ backgroundColor: 'white' }}
                        />
                    </InputGroup>
                    <Form style={{ padding: "10px" }}>
                        <h6>Participants</h6>
                        {users
                            .filter((u) => u.username !== user?.username)
                            .map((u) => (
                                <div key={`default-${u.username}`} className="mb-3">
                                    <Form.Check // prettier-ignore
                                        type={"checkbox"}
                                        label={u.username}
                                        disabled={u.username == user.username ? true : false}
                                        onChange={() => handleCheckboxChange(u.username)}
                                    />

                                </div>
                            ))}
                    </Form>

                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            Close
                        </Button>
                        <Button variant="primary" onClick={() => createGroup()}>Create Group</Button>
                    </Modal.Footer>
                </Modal>
                <div className="card chat-app" style={{ backgroundColor: "whitesmoke", display: "flex" }}>

                    <div id="plist" className="people-list"  >
                        <div>
                            <div className="input-group" style={{ flexWrap: 'inherit' }}>

                                {/* <span style={{ marginTop: '5px' }} class="material-symbols-outlined">
                                    search
                                </span> */}

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
                                {filteredGroup
                                    .map((group, index) => (
                                        <Link to={`groups/${group.groupName}`} onClick={() => { setActiveChat(group.groupName) }}>
                                            <div key={index}>
                                                <li className="clearfix" style={{ borderBottom: "1px solid #ddd", borderRadius: "40px", backgroundColor: activeChat == group.groupName ? "rgb(225 225 225)" : null }}>
                                                    <div className="about" style={{ display: "flex" }}>
                                                        {/* <Avatar
                                                            name={group.groupName}
                                                            round={true} // Optional: Makes the avatar round
                                                            size="30"   // Optional: Set the size of the avatar
                                                        /> */}
                                                        <img style={{ height: '40px', width: '40px' }} src={`http://${apiUrl}` + group.groupImage} />
                                                        &nbsp;&nbsp;
                                                        <p style={{ padding: "5px" }} className="name">{group.groupName}</p>
                                                    </div>
                                                </li>
                                            </div>
                                        </Link>
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
                                            <Link to={`user/${createConversationName(user.username)}`} onClick={() => { setActiveChat(user.username) }}>
                                                <div key={index}>
                                                    <li className="clearfix" style={{ borderBottom: "1px solid #ddd", borderRadius: "40px", backgroundColor: activeChat == createConversationName(user.username) ? "rgb(225 225 225)" : null }}>
                                                        <div className="about" style={{ display: "flex" }}>
                                                            {/* <Avatar
                                                                name={user.username}
                                                                round={true} // Optional: Makes the avatar round
                                                                size="30"   // Optional: Set the size of the avatar
                                                            /> */}
                                                            <img style={{ height: '40px', width: "40px" }} src={user.user_picture} />
                                                            &nbsp;&nbsp;
                                                            <p style={{ padding: "5px" }} className="name">{user.username}</p>
                                                        </div>
                                                    </li>
                                                </div>
                                            </Link>
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

