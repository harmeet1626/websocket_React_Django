import { useEffect, useState, useRef } from "react"
import { useNavigate, useParams } from "react-router-dom"
import AuthService from '../auth/AuthService';
import InputEmoji from 'react-input-emoji'
import useWebSocket, { ReadyState } from "react-use-websocket";
import Modal from 'react-bootstrap/Modal';
import ListGroup from 'react-bootstrap/ListGroup';
import Tab from 'react-bootstrap/Tab';
import Tabs from 'react-bootstrap/Tabs';
import Accordion from 'react-bootstrap/Accordion';
import Form from 'react-bootstrap/Form';
import InputGroup from 'react-bootstrap/InputGroup';
import Dropdown from 'react-bootstrap/Dropdown';
import { BsTrash } from 'react-icons/bs';
import { BiSolidAddToQueue } from "react-icons/bi";
import Button from "react-bootstrap/esm/Button";
import { useDispatch } from "react-redux";
import { fetchGroups } from "../store/chatListing";
import { toast } from "react-toastify";

export const GroupChat = () => {
    const params = useParams()
    const navigate = useNavigate()
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const [messageHistory, setMessageHistory] = useState([]);
    const [message, setMessage] = useState("");
    const [user, setUser] = useState(() => AuthService.getCurrentUser())
    const reverced_messageHistory = [...messageHistory].reverse()
    const containerRef = useRef(null);
    const fileInputRef = useRef(null);
    const [participants, setParticipants] = useState([])
    const [users, setUsers] = useState()
    const [groupAdmin, setGroupAdmin] = useState('')
    const [createdBy, setCreatedBy] = useState('')
    const [createdOn, setCreatedOn] = useState('')
    const [groupImage, setGroupImage] = useState('')
    const [selectedImage, setSelectedImage] = useState(null);
    const dispatch = useDispatch()
    const { readyState, sendJsonMessage } = useWebSocket(user ? `ws://${apiUrl}groupChat/${params.groupName}/`
        : null, {
        queryParams: {
            token: user ? user.token : "",
        },
        onOpen: () => {
            console.log("Connected!");
        },
        onClose: () => {
            console.log("Disconnected!");
        },
        // onMessage handler
        onMessage: (e) => {
            const data = JSON.parse(e.data);
            switch (data.type) {
                case "welcome_message":
                    // setWelcomeMessage(data.message);
                    break;
                case 'file':
                    console.log("file event triggered onMessage")
                    // const fileUrlOrIdentifier = data.file_url_or_identifier;
                    break;
                case "chat_message_echo":
                    setMessageHistory(data.message)
                    // setMessageHistory((prev) => [data.message, ...prev]);
                    // sendJsonMessage({ type: "read_messages" });
                    break;
                case "last_50_messages":
                    setMessageHistory(data.messages);
                    // setHasMoreMessages(data.has_more);
                    break;
                case "user_join":
                    console.log('user join')
                    // setParticipants((pcpts) => {
                    //     if (!pcpts.includes(data.user)) {
                    //         return [...pcpts, data.user];
                    //     }
                    //     return pcpts;
                    // });
                    break;
                case "user_leave":
                    // setParticipants((pcpts) => {
                    //     const newPcpts = pcpts.filter((x) => x !== data.user);
                    //     return newPcpts;
                    // });
                    break;
                case "online_user_list":
                    // setParticipants(data.users);
                    break;

                case 'typing':
                    console.log('user typing')
                    // updateTyping(data);
                    break;

                default:
                    console.error("Unknown message type!");
                    break;
            }
        }
    });
    function formatTime(timestamp) {
        const date = new Date(timestamp);
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const formattedTime = `${hours}:${minutes}`;
        return formattedTime
    }
    const handleSubmit = () => {
        if (message.length === 0) return;
        if (message.length > 512) return;
        sendJsonMessage({
            type: "group_chat_message",
            message
        });
        setMessage("");
    };
    const handleKeyPress = (e) => {
        handleSubmit()
    };
    useEffect(() => {
        scrollToBottom()
        fetchUsers()
    }, [])
    useEffect(() => {
        scrollToBottom();
    }, [messageHistory]);
    const scrollToBottom = async () => {
        const containerHeight = containerRef.current.scrollHeight;
        await containerRef.current.scrollTo({
            top: containerHeight,
            behavior: 'instant',
        })
    };
    async function fetchParticipants() {
        const res = await fetch(`http://${apiUrl}GetGroupParticipants/${params?.groupName}`, {
            method: "GET",
        });
        const data = await res.json();
        setGroupAdmin(data?.admin)
        setCreatedOn(data?.created_on)
        setCreatedBy(data?.Created_by)
        setParticipants(data?.Participants)
        setGroupImage(`http://` + apiUrl + data.Group_image)
    }
    async function UpdateGroupAdmin(username) {
        const res = await fetch(`http://${apiUrl}UpdatedGroupAdmin/`, {
            method: "PUT",
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                group: params.groupName,
                user: username
            })
        });
        const data = await res.json();
        fetchParticipants()

    }
    useEffect(() => {
        fetchParticipants()
    }, [params.groupName])
    async function fetchUsers() {
        const res = await fetch(`http://${apiUrl}users/`, {
            headers: {
                Authorization: `Token ${user?.token}`
            }
        });
        const data = await res.json();
        setUsers(data);
    }
    const handleFileChange = async (e) => {
        const selectedFile = e.target.files[0];

        if (selectedFile) {
            let data = await uploadDocument(selectedFile)
            let file_url = data.response[0].file.file
            sendJsonMessage({
                type: "group_file",
                file_url
            })
        }
    };
    async function uploadDocument(fileName) {
        const apiEndpoint = `http://${apiUrl}documentUpload/`;

        const form_Data = new FormData()
        form_Data.append("image", fileName)

        const response = await fetch(apiEndpoint, {
            method: 'PUT',
            body: form_Data

        })
        let data = await response.json()
        return data
    }
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    async function removeFromGroup(event) {
        const apiEndpoint = `http://${apiUrl}RemoveUserFromGroup/`;
        const requestOptions = {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                user: event.user,
                group: event.group,
            }),
        };
        await fetch(apiEndpoint, requestOptions)
            .then(response => response.json())
            .then(data => {

                fetchParticipants()
                dispatch(fetchGroups(`Token ${user?.token}`))
            })
            .catch(error => {
                console.error('API Error:', error);
            });

    }
    async function addUserToGroup(event) {
        let user = event.username
        const apiEndpoint = `http://${apiUrl}AddParticipantInGroup/`;
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                user: user,
                group: params.groupName,
            }),
        };

        await fetch(apiEndpoint, requestOptions)
            .then(response => response.json())
            .then(data => {
                fetchParticipants()

            })
            .catch(error => {
                console.error('API Error:', error);
            });
    }
    const handleImageClick = (imageUrl) => {
        window.open(imageUrl, '_blank');
    };
    const handleImageChange = (e) => {
        const file = e.target.files[0];
        setSelectedImage(file);
    };
    const handleImageUpload = async () => {
        if (selectedImage) {
            const form_Data = new FormData()
            form_Data.append("image", selectedImage)
            await fetch(`http://${apiUrl}UpdateGroupImage/${params.groupName}`, {
                method: 'PUT',
                body: form_Data,
            })
                .then(response => response.json())
                .then(data => {
                    fetchParticipants()
                    dispatch(fetchGroups(`Token ${user?.token}`))
                })
                .catch(error => {
                    console.error('Error uploading image', error);
                });
        }
    };
    function RemoveSlash(str) {
        return str.slice(0, -1);
    }
    const handleDeleteGroup = async () => {
        try {
            const response = await fetch(`http://${apiUrl}DeleteGroup/${params.groupName}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    // Add any other headers if needed, such as authentication headers
                },
            });

            if (response.ok) {
                dispatch(fetchGroups(`Token ${user?.token}`))
                navigate('/')
                toast.success('Group Deleted.', {
                    position: 'top-right',
                    autoClose: 3000,
                    hideProgressBar: false,
                    closeOnClick: true,
                    pauseOnHover: true,
                    draggable: true,
                });
                console.log('Group deleted successfully');
            } else {
                console.error('Failed to delete group');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };
    function getFileName(filename) {
        const delimiter = "/";
        const parts = filename.split(delimiter);
        const lastPart = parts.pop();
        return lastPart
    }
    return (
        <>
            <div className="chat" >
                <Modal show={show} onHide={handleClose} animation={false}>
                    <Modal.Header closeButton>
                        <Modal.Title><img style={{ height: "50px", width: '50px', borderRadius: '40px' }} src={groupImage} />&nbsp;&nbsp;{params.groupName}</Modal.Title>
                    </Modal.Header>
                    <Tabs
                        defaultActiveKey="profile"
                        id="uncontrolled-tab-example"
                        className="mb-3"
                    >
                        <Tab eventKey="Participants" title={`Participants (${participants.length})`}>
                            <Accordion defaultActiveKey="0">
                                <Accordion.Item eventKey="0">
                                    <Accordion.Header>Members</Accordion.Header>
                                    <Accordion.Body>
                                        <ListGroup >
                                            {participants.map((u) => (
                                                <div key={u.username}>
                                                    <div style={{ textTransform: 'uppercase', padding: '10px' }}
                                                        key={u.username} className="d-flex justify-content-between align-items-center">
                                                        <span style={{ display: 'flex' }}>
                                                            <img style={{ height: '30px', width: "30px", borderRadius: '10px' }} src={`http://${apiUrl}` + u.user_image} /> &nbsp;&nbsp;
                                                            <p style={{ marginTop: "auto", color: u.username == user.username ? 'rgb(41, 155, 211)' : null }}>{u.username}</p>
                                                            {u.username === groupAdmin && <span style={{ fontSize: '10px', color: 'green' }}>&nbsp; admin</span>}
                                                            <span style={{ color: u.username === user.username ? 'green' : 'black', fontSize: u.username === groupAdmin ? 'small' : 'inherit' }}>
                                                                {user.username === groupAdmin && user.username !== u.username ?
                                                                    <Dropdown style={{ border: 'none', marginLeft: '5px' }}>
                                                                        <Dropdown.Toggle
                                                                            id="dropdown-basic-button"
                                                                            variant="transparent"
                                                                            style={{
                                                                                padding: '2px',
                                                                                border: 'none',
                                                                                background: 'none',
                                                                                cursor: 'pointer',
                                                                            }}
                                                                        >
                                                                        </Dropdown.Toggle>
                                                                        <Dropdown.Menu style={{ backgroundColor: 'rgb(227, 227, 227)', border: 'none' }}>
                                                                            <Dropdown.Item onClick={() => {
                                                                                removeFromGroup(u);
                                                                            }}>
                                                                                <div className="d-flex align-items-center">
                                                                                    <p style={{ margin: '0' }}>Remove From group</p>
                                                                                    <span
                                                                                        style={{
                                                                                            cursor: 'pointer',
                                                                                            borderRadius: '5px',
                                                                                            marginLeft: '10px', // Adjust margin as needed
                                                                                        }}
                                                                                        className="material-symbols-outlined"
                                                                                    >
                                                                                        <BsTrash />
                                                                                    </span>
                                                                                </div>
                                                                            </Dropdown.Item>
                                                                            <Dropdown.Item onClick={() => UpdateGroupAdmin(u.username)}>
                                                                                <div className="d-flex align-items-center">
                                                                                    <p style={{ margin: '0' }} >Make Group Admin</p>
                                                                                    <span className="material-symbols-outlined">
                                                                                        admin_panel_settings
                                                                                    </span>
                                                                                </div>
                                                                            </Dropdown.Item>
                                                                        </Dropdown.Menu>
                                                                    </Dropdown>
                                                                    :
                                                                    u.username == user.username ?
                                                                        <Dropdown style={{ border: 'none', marginLeft: '5px' }}>
                                                                            <Dropdown.Toggle
                                                                                id="dropdown-basic-button"
                                                                                variant="transparent"
                                                                                style={{
                                                                                    padding: '2px',
                                                                                    border: 'none',
                                                                                    background: 'none',
                                                                                    cursor: 'pointer',
                                                                                }}
                                                                            >
                                                                            </Dropdown.Toggle>
                                                                            <Dropdown.Menu style={{ backgroundColor: 'rgb(227, 227, 227)', border: 'none' }}>
                                                                                <Dropdown.Item disabled={u.username == groupAdmin ? true : false} onClick={() => {
                                                                                    removeFromGroup(u)
                                                                                    handleClose()
                                                                                }}>
                                                                                    <div className="d-flex align-items-center">
                                                                                        <p style={{ margin: '0' }}>Leave Group</p>
                                                                                        <span
                                                                                            style={{
                                                                                                cursor: 'pointer',
                                                                                                borderRadius: '5px',
                                                                                                marginLeft: '10px', // Adjust margin as needed
                                                                                            }}
                                                                                            className="material-symbols-outlined"
                                                                                        >
                                                                                            <BsTrash />
                                                                                        </span>
                                                                                    </div>
                                                                                </Dropdown.Item>
                                                                            </Dropdown.Menu>
                                                                        </Dropdown> :
                                                                        null
                                                                }
                                                            </span>
                                                        </span>
                                                        {u.username !== user.username && groupAdmin == user.username && (
                                                            <div>
                                                            </div>
                                                        )}
                                                    </div>
                                                </div>
                                            ))}
                                        </ListGroup>
                                    </Accordion.Body>
                                </Accordion.Item>
                                {user.username == groupAdmin ?
                                    <Accordion.Item eventKey="1">
                                        <Accordion.Header>Add Members</Accordion.Header>
                                        <Accordion.Body>
                                            <ListGroup >
                                                {users && users
                                                    .filter((u) => !participants.some((p) => p.username.includes(u.username)))
                                                    .map((u) => (
                                                        <div >
                                                            <div style={{ textTransform: 'uppercase', padding: '10px' }}
                                                                key={u.username} className="d-flex justify-content-between align-items-center">
                                                                <span style={{ display: 'flex' }}>
                                                                    <img style={{ height: '30px', width: "30px", borderRadius: '10px' }} src={`http://${apiUrl}` + u.user_picture} /> &nbsp;&nbsp;
                                                                    <p style={{ marginTop: "auto", color: u.username == user.username ? 'rgb(41, 155, 211)' : null }}>{u.username}</p>
                                                                    {u.username === groupAdmin && <span style={{ fontSize: '10px', color: 'green' }}>&nbsp; admin</span>}
                                                                    <span style={{ color: u.username === user.username ? 'green' : 'black', fontSize: u.username === groupAdmin ? 'small' : 'inherit' }}>
                                                                        {user.username === groupAdmin && user.username !== u.username ?
                                                                            <Dropdown style={{ border: 'none', marginLeft: '5px' }}>
                                                                                <Dropdown.Toggle
                                                                                    id="dropdown-basic-button"
                                                                                    variant="transparent"
                                                                                    style={{
                                                                                        padding: '2px',
                                                                                        border: 'none',
                                                                                        background: 'none',
                                                                                        cursor: 'pointer',
                                                                                    }}
                                                                                >
                                                                                </Dropdown.Toggle>
                                                                                <Dropdown.Menu style={{ backgroundColor: 'rgb(227, 227, 227)', border: 'none' }}>
                                                                                    <Dropdown.Item onClick={() => addUserToGroup(u)}>
                                                                                        <div className="d-flex align-items-center">
                                                                                            <p style={{ margin: '0' }}>
                                                                                                Add to group</p>
                                                                                            <span
                                                                                                style={{
                                                                                                    cursor: 'pointer',
                                                                                                    borderRadius: '5px',
                                                                                                    marginLeft: '10px',
                                                                                                }}
                                                                                                className="material-symbols-outlined"
                                                                                            >
                                                                                                <BiSolidAddToQueue />
                                                                                            </span>
                                                                                        </div>
                                                                                    </Dropdown.Item>
                                                                                </Dropdown.Menu>
                                                                            </Dropdown>
                                                                            :
                                                                            u.username == user.username ?
                                                                                <Dropdown style={{ border: 'none', marginLeft: '5px' }}>
                                                                                    <Dropdown.Toggle
                                                                                        id="dropdown-basic-button"
                                                                                        variant="transparent"
                                                                                        style={{
                                                                                            padding: '2px',
                                                                                            border: 'none',
                                                                                            background: 'none',
                                                                                            cursor: 'pointer',
                                                                                        }}
                                                                                    >
                                                                                    </Dropdown.Toggle>
                                                                                    <Dropdown.Menu style={{ backgroundColor: 'rgb(227, 227, 227)', border: 'none' }}>
                                                                                        <Dropdown.Item disabled={u.username == groupAdmin ? true : false} onClick={() => {
                                                                                            removeFromGroup(u)
                                                                                            handleClose()
                                                                                        }}>
                                                                                            <div className="d-flex align-items-center">
                                                                                                <p style={{ margin: '0' }}>Leave Group</p>
                                                                                                <span
                                                                                                    style={{
                                                                                                        cursor: 'pointer',
                                                                                                        borderRadius: '5px',
                                                                                                        marginLeft: '10px', // Adjust margin as needed
                                                                                                    }}
                                                                                                    className="material-symbols-outlined"
                                                                                                >
                                                                                                    <BsTrash />
                                                                                                </span>
                                                                                            </div>
                                                                                        </Dropdown.Item>
                                                                                    </Dropdown.Menu>
                                                                                </Dropdown> :
                                                                                null
                                                                        }
                                                                    </span>
                                                                </span>
                                                                {u.username !== user.username && groupAdmin == user.username && (
                                                                    <div>
                                                                    </div>
                                                                )}
                                                            </div>
                                                        </div>
                                                    ))}
                                            </ListGroup>
                                        </Accordion.Body>
                                    </Accordion.Item>
                                    : null}
                            </Accordion>
                        </Tab>
                        <Tab eventKey="profile" title="About">
                            <Accordion defaultActiveKey="0">
                                <Accordion.Item eventKey="0">
                                    <Accordion.Header>About Group</Accordion.Header>
                                    <Accordion.Body>
                                        <InputGroup className="mb-3">
                                            <InputGroup.Text id="basic-addon1">Created By</InputGroup.Text>
                                            <Form.Control
                                                placeholder="Username"
                                                aria-label="Username"
                                                aria-describedby="basic-addon1"
                                                value={createdBy}
                                                disabled={true}
                                            />
                                        </InputGroup>
                                        <InputGroup className="mb-3">
                                            <InputGroup.Text id="basic-addon1">Created On</InputGroup.Text>
                                            <Form.Control
                                                placeholder="Username"
                                                aria-label="Username"
                                                aria-describedby="basic-addon1"
                                                value={createdOn}
                                                disabled={true}
                                            />
                                        </InputGroup>
                                    </Accordion.Body>
                                </Accordion.Item>
                            </Accordion>
                        </Tab>
                        <Tab eventKey="media" title="media" style={{ padding: "10px" }}>
                            <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(80px, 1fr))", gap: "10px" }}>
                                {reverced_messageHistory
                                    .filter((u) => u.file !== "")
                                    .map((u, index) => (
                                        <div key={index} onClick={() => handleImageClick(`http://${RemoveSlash(apiUrl)}` + u.file)}>
                                            <img style={{ height: "50px", width: "80px", cursor: 'pointer' }} src={`http://${RemoveSlash(apiUrl)}` + u.file} alt={`Image ${index}`} />
                                        </div>
                                    ))}
                            </div>
                        </Tab>
                        {user.username == groupAdmin ?
                            <Tab eventKey="Settings" title="Settings">
                                <div style={{ padding: '10px' }}>
                                    <input type="file" accept="image/*" onChange={handleImageChange} />
                                    <Button onClick={handleImageUpload}>Update Image</Button>
                                    <div style={{ padding: '10px' }}>
                                        <Button variant="danger" onClick={() => handleDeleteGroup()}>Delete Group</Button>
                                    </div>
                                </div>
                            </Tab>
                            : ""}
                    </Tabs>
                </Modal>
                <div className="chat-header clearfix" style={{ backgroundColor: "whitesmoke", height: '65px' }}>
                    <div className="row">
                        <div className="col-lg-6" style={{ cursor: "pointer" }} onClick={handleShow}>
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                            </a>
                            <div className="chat-about" style={{ display: "flex" }}>
                                <img src={groupImage} />
                                &nbsp;&nbsp;
                                <h6 style={{ padding: "5px", textTransform: 'uppercase' }} className="m-b-0">{params.groupName}</h6>
                            </div>
                            <span style={{ padding: "3px" }} className="material-symbols-outlined">
                                list
                            </span>
                        </div>
                    </div>
                </div>
                <div className="chat-history" ref={containerRef} style={{
                    height: '70vh',
                    width: '100%',
                    overflow: 'auto',
                    border: '1px solid #C0C0C0',
                    backgroundColor: '#e3e3e3',
                    borderRadius: "30px"
                }}>
                    <ul className="m-b-0">
                        {reverced_messageHistory.map((message, index) => (
                            <li className="clearfix" key={index}>
                                <div>
                                    <div style={{ padding: "5px 20px", wordBreak: "break-word", backgroundColor: message.from_user_id === user.username ? "rgb(133 196 235)" : "#f3f3f3" }} className={message.from_user_id === user.username ? "message other-message float-right" : "message my-message"}>
                                        {message.from_user_id == user.username ? "" :
                                            <div style={{ fontWeight: "bold", color: 'maroon', textTransform: 'capitalize', fontSize: '12px', height: '20px' }}>{message.from_user_id}</div>
                                        }
                                        {message.content === "" ? (
                                            (message.file.split('.').pop().toLowerCase() === 'jpg' ||
                                                message.file.split('.').pop().toLowerCase() === 'jpeg' ||
                                                message.file.split('.').pop().toLowerCase() === 'png') ? (
                                                <img
                                                    onClick={() => handleImageClick(`http://${RemoveSlash(apiUrl)}` + message.file)}
                                                    style={{ height: "150px", cursor: "pointer" }}
                                                    src={`http://${RemoveSlash(apiUrl)}` + message.file}
                                                    alt="Image"
                                                />
                                            ) : (
                                                <div style={{ display: 'flex' }}>
                                                    <a href={`http://${RemoveSlash(apiUrl)}` + message.file} target="_blank" rel="noopener noreferrer">
                                                        <img style={{ height: '45px', width: '55px', borderRadius: '10px' }} src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAgVBMVEX///8AAAAgICAhHyC1tbUXFxcJCQmZmZnU1NQVExTR0dFqamoFAAB1dXUTExMbGxv39/fo6OhYWFg4ODje3t7FxcWIiIiCgoKkoqOqqqru7u7i4uIRDhD5+flHR0e2trZAQEAzMzNQUFBjY2PAvr+Uk5QnJyd2dHVVVVU2NjYnJCZ06P9MAAADqUlEQVR4nO3dbVOyQBSH8d1FVk0FH/IZCyu1+v4f8EZshi3R6j7nxJn6/142tdM1wAq6oDEAAAAAAAAAAAAAAAAAAAAAAAAAAADM1rc0m6YDrlvNtmnSpcgeVk1HXNPZ+9S5iCTLh01nXDaKY+fSmCAtErtbvYmHLHL2bkyQHxOzO6076spGkV2Shlj2I82JUxt1H2lDLMrCyCudblrW+TZtiKLQbb0rtqLKY/GepbDfmhd7ezbRmMizDYsjeVAkdnOFOypboZlbFyUKpxu+wjJR4YzKWGjKY1FdImdheSwm2k7gWAtP042yEzjewnJHVTajMhcqPBa5C8tEVS8a7IXqXjT4C087qp4ZVaDwNN2oOUeVKDwmOjUzqkihqhlVplBTolDh6QROxSWxVGH5otF9UZAoVqjmkpin0C9qfq7kWGQofLJRWnvEzbyGEziGwuHxiMvvp+fuUgVbkaHQtIvdMbXn+unprWKWf/S/fShctWfXdeoG6dmixZ15+9jG1v7Nj/lQOLbZVd6O6kbZRTZLzhz/oEi3Nz8VU+t94XCfnm+Kdy78u6PWbF4rT5Vtw1nN4fTOd6+KDpmyQtOpmRJD3/08+9DVVsht0HW/vTBBoTQUUqFQHgqpUCgPhVQolPehcN17pixxOxkE71uoK8w9ZZXiGxssI9NWuPn0Cvgr4rwaX1uhWXx2BfwlT9WA6grNakQXvg2gr5AbCuWhkAqF8lBIhUJ5f65w89SimwbjqyscsJyX7oIBlRUOX1PaTWyleFKNr63Q9Gyfzs6rAdUVDpdtulYwvrpCdiiUh0IqFMpDIRUK5f29ws2QLlxVpK6w5RkuLdLg8klb4WYbM3xukQQrSrUVmkmS0vnnakB1hZ2HlwnVdryuBlRXyA6F8lBIhUJ5KKRCoTwUUqkrHPXoi76w6uuHffe+p69QveqrzXABbH3wwYW6QvJzPo/CG/j0FXJDoTwUUqFQHgqpUCjv7xVOGVZ9hbfsqyucc5yX2nAZmbJCplVfeTW+tkIztp7ODqoB1RUOFzvyoq9d+EgldYXsUCgPhVQolIdCKhTKQyEVCuUxfIPHVcdnfTX7RLqpdUlPcPy7NLLrz39N0Mo6F94/z2x5fGhkw99Z9pg458c9GQ/9KPKzZgPNrS8u62PS165dFkcu3jf9iFYzTTKGdy4uSP3+tulAY0aHV89xy1qNbD9vfAuWVp0bGR0FT7sGAAAAAAAAAAAAAAAAAAAAAAAAAIBf5h8BJpOtPejX2gAAAABJRU5ErkJggg==' />
                                                    </a>
                                                    <p style={{ padding: '10px', marginBottom:'0px' }}>{getFileName(message.file)}</p>
                                                </div>

                                            )
                                        ) : (
                                            <div>{message.content}</div>
                                        )}
                                        <br />
                                        <span style={{ fontSize: "10px", alignSelf: "flex-end", width: '170px', textAlign: "end" }} className={message.from_user_id === user.username ? "message-data-time float-right" : "message-data-time float-right"}>
                                            <div style={{ display: "flex", float: 'right' }}>
                                                <span style={{ marginLeft: '5px', display: message.from_user_id === user.username ? "block" : "none" }}>✓</span>
                                                <span style={{ marginLeft: '-3px', color: 'green', float: 'right', display: message.read == true && message.from_user_id === user.username ? 'block' : 'none' }}>✓</span>
                                            </div>
                                            {formatTime(message.timestamp)}
                                        </span>
                                    </div>
                                </div>
                            </li>
                        ))}
                    </ul>
                </div>
                <div className="input-group mb-0" style={{ flexWrap: "unset" }}>
                    <InputEmoji
                        cleanOnEnter
                        onChange={setMessage}
                        onEnter={handleKeyPress}
                        value={message}
                        type="text"
                        className="form-control"
                        placeholder="Enter text here..."
                        style={{ backgroundColor: 'white' }}
                    />
                    <input
                        type="file"
                        ref={fileInputRef}
                        style={{ display: 'none' }}
                        onChange={handleFileChange}
                        accept="image/png, image/jpeg"
                    />
                    <div className="input-group-prepend" style={{ padding: '2px' }}>
                        <span style={{
                            backgroundColor: "white",
                            padding: "5px",
                            marginTop: '10px',
                            cursor: 'pointer',
                            border: 'none',
                        }}
                            onClick={() => {
                                fileInputRef.current.click();
                            }} className="material-symbols-outlined">
                            attachment
                        </span>
                    </div>
                    <div className="input-group-prepend" style={{ padding: '2px' }}>
                        <span style={{ marginTop: '10px', cursor: 'pointer', padding: "5px" }}
                            onClick={() => { handleSubmit() }} className="material-symbols-outlined">
                            send
                        </span>
                    </div>
                </div>
            </div>
        </>
    )
}