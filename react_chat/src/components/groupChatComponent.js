import { useEffect, useState, useRef } from "react"
import { useParams } from "react-router-dom"
import Avatar from 'react-avatar';
import AuthService from '../auth/AuthService';
import InputEmoji from 'react-input-emoji'
import useWebSocket, { ReadyState } from "react-use-websocket";
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import ListGroup from 'react-bootstrap/ListGroup';
import Tab from 'react-bootstrap/Tab';
import Tabs from 'react-bootstrap/Tabs';
import Accordion from 'react-bootstrap/Accordion';
import Form from 'react-bootstrap/Form';
import InputGroup from 'react-bootstrap/InputGroup';




export const GroupChat = () => {
    const params = useParams()
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

    const { readyState, sendJsonMessage } = useWebSocket(user ? `ws://${apiUrl}groupChat/${params.groupName}/` : null, {
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
    const handleFileChange = (e) => {
        const selectedFile = e.target.files[0];

        if (selectedFile) {
            uploadDocument(selectedFile)
        }
    };
    async function fetchParticipants() {
        const res = await fetch(`http://${apiUrl}GetGroupParticipants/${params.groupName}`, {
            method: "GET",
        });
        const data = await res.json();
        setGroupAdmin(data?.admin)
        setCreatedOn(data?.created_on)
        setCreatedBy(data?.Created_by)
        setParticipants(data?.Participants)

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

    async function uploadDocument(fileName) {
        const apiEndpoint = `http://${apiUrl}documentUpload/`;

        const form_Data = new FormData()
        form_Data.append("image", fileName)

        await fetch(apiEndpoint, {
            method: 'PUT',
            body: form_Data

        })
            .then(response => response.json())
            .then(data => {
                let file_url = data.response[0].file.file
                sendJsonMessage({
                    type: "group_file",
                    file_url
                })
            })
            .catch(error => {
                console.error('API Error:', error);
            });
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
    return (
        <>
            <div className="chat" >
                <Modal show={show} onHide={handleClose} animation={false}>
                    <Modal.Header closeButton>
                        <Modal.Title>{params.groupName}</Modal.Title>
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
                                                <div >
                                                    <ListGroup.Item style={{ textTransform: 'uppercase', }}
                                                        key={u.username} className="d-flex justify-content-between align-items-center">
                                                        <span>
                                                            <span style={{ color: u.username === user.username ? 'green' : 'black', fontSize: u.username === groupAdmin ? 'small' : 'inherit' }}>
                                                                {u.username}
                                                                {u.username === groupAdmin && <span style={{ fontSize: 'small' }}> (admin)</span>}
                                                            </span>
                                                        </span>

                                                        {u.username !== user.username && groupAdmin == user.username && (
                                                            <span
                                                                onClick={() => removeFromGroup(u)}
                                                                style={{
                                                                    cursor: 'pointer',
                                                                    borderRadius: '5px',
                                                                }}
                                                                className="material-symbols-outlined"
                                                            >
                                                                close
                                                            </span>
                                                        )}
                                                    </ListGroup.Item>
                                                </div>
                                            ))}
                                        </ListGroup>
                                    </Accordion.Body>
                                </Accordion.Item>
                                {user.username == groupAdmin ?
                                    <Accordion.Item eventKey="1">
                                        <Accordion.Header>Add Members</Accordion.Header>
                                        <Accordion.Body>
                                            {users && users
                                                .filter((u) => !participants.some((p) => p.username.includes(u.username)))
                                                .map((u) => (
                                                    <div>
                                                        <ListGroup.Item style={{ textTransform: 'uppercase' }} key={u.username} className="d-flex justify-content-between align-items-center">
                                                            <span>{u.username} {u.username === user.username ? "(You)" : null}</span>
                                                            {u.username !== user.username && (
                                                                <span
                                                                    onClick={() => addUserToGroup(u)}
                                                                    style={{
                                                                        cursor: 'pointer',
                                                                        borderRadius: '5px',
                                                                    }}
                                                                    className="material-symbols-outlined"
                                                                >
                                                                    add
                                                                </span>
                                                            )}
                                                        </ListGroup.Item>
                                                    </div>
                                                ))}
                                        </Accordion.Body>
                                    </Accordion.Item>
                                    : ""}


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
                                {/* <Accordion.Item eventKey="1">
                                    <Accordion.Header>Created By</Accordion.Header>
                                    <Accordion.Body>
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                                        eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
                                        minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                                        aliquip ex ea commodo consequat. Duis aute irure dolor in
                                        reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
                                        pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
                                        culpa qui officia deserunt mollit anim id est laborum.
                                    </Accordion.Body>
                                </Accordion.Item> */}

                            </Accordion>
                        </Tab>
                        <Tab eventKey="media" title="media" style={{ padding: "10px" }}>
                            <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(80px, 1fr))", gap: "10px" }}>
                                {reverced_messageHistory
                                    .filter((u) => u.file !== "")
                                    .map((u, index) => (
                                        <div key={index}>
                                            <img style={{ height: "50px", width: "80px" }} src={'http://127.0.0.1:8000' + u.file} alt={`Image ${index}`} />
                                        </div>
                                    ))}
                            </div>
                        </Tab>

                        <Tab eventKey="Settings" title="Settings">
                            Tab content for Contact
                        </Tab>
                    </Tabs>

                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            Close
                        </Button>
                        {/* <Button variant="danger" onClick={handleClose}>
                            Leave Group
                        </Button> */}
                    </Modal.Footer>
                </Modal>
                <div className="chat-header clearfix" style={{ backgroundColor: "whitesmoke", height: '65px' }}>
                    <div className="row">
                        <div className="col-lg-6">
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                            </a>
                            <div className="chat-about" style={{ display: "flex" }}>
                                <Avatar
                                    name={params.groupName}
                                    round={true}
                                    size="30"
                                />&nbsp;&nbsp;
                                <h6 style={{ padding: "5px", textTransform: 'uppercase' }} className="m-b-0">{params.groupName}</h6>
                            </div>
                            <span style={{ padding: "3px", cursor: "pointer" }} onClick={handleShow} class="material-symbols-outlined">
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
                                        {message.content == "" ?
                                            <img style={{ height: "150px" }} src={'http://127.0.0.1:8000' + message.file} />
                                            :
                                            message.content
                                        }

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
                            }} class="material-symbols-outlined">
                            attachment
                        </span>
                    </div>

                    <div className="input-group-prepend" style={{ padding: '2px' }}>
                        <span style={{ marginTop: '10px', cursor: 'pointer', padding: "5px" }}
                            onClick={() => { handleSubmit() }} class="material-symbols-outlined">
                            send
                        </span>
                    </div>
                </div>
            </div>
        </>
    )
}