import React, { useEffect, useRef, useState } from 'react';
import { useLocation, useParams } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';
import Avatar from 'react-avatar';
import InputEmoji from 'react-input-emoji'

export const ChatComponent = (props) => {

    const [welcomeMessage, setWelcomeMessage] = useState("");
    const [messageHistory, setMessageHistory] = useState([]);
    const reverced_messageHistory = [...messageHistory].reverse()
    const [message, setMessage] = useState("");
    const [user, setUser] = useState(() => AuthService.getCurrentUser())

    const [page, setPage] = useState(2);
    const [hasMoreMessages, setHasMoreMessages] = useState(false);

    const [participants, setParticipants] = useState([]);

    const [conversation, setConversation] = useState(null);

    const [typing, setTyping] = useState(false);

    const [userActive, setUserActive] = useState(false)
    const location = useLocation()

    const { conversationName } = useParams();
    const [userImage, setUserImage] = useState('')

    const [loading, setLoading] = useState(true)
    function GetName() {
        const fullName = conversationName;
        const nameArray = fullName.split("__");
        const filteredNameArray = nameArray.filter(part => part.trim() !== "");
        if (filteredNameArray[1] == user?.username) {
            return filteredNameArray[0]

        } else {
            return filteredNameArray[1]
        }
    }
    const apiUrl = process.env.REACT_APP_API_BASE_URL;
    const { readyState, sendJsonMessage } = useWebSocket(user ? `ws://${apiUrl}chats/${conversationName}/` : null, {
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
                    setWelcomeMessage(data.message);
                    break;
                case 'file':
                    console.log("file event triggered onMessage")
                    const fileUrlOrIdentifier = data.file_url_or_identifier;
                    break;
                case "chat_message_echo":
                    console.log('chat_message_echo', data.message)
                    setMessageHistory((prev) => [data.message, ...prev]);
                    sendJsonMessage({ type: "read_messages" });
                    break;
                case "read_messages":
                    console.log("read_messages")
                case "last_50_messages":
                    setMessageHistory(data.messages);
                    setHasMoreMessages(data.has_more);
                    break;
                case "user_join":
                    setParticipants((pcpts) => {
                        if (!pcpts.includes(data.user)) {
                            return [...pcpts, data.user];
                        }
                        return pcpts;
                    });
                    break;
                case "user_leave":
                    setParticipants((pcpts) => {
                        const newPcpts = pcpts.filter((x) => x !== data.user);
                        return newPcpts;
                    });
                    break;
                case "online_user_list":
                    setParticipants(data.users);
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
    async function fetchConversation() {
        const apiRes = await fetch(`http://${apiUrl}conversations/${conversationName}/`, {
            method: "GET",
            headers: {
                Accept: "application/json",
                "Content-Type": "application/json",
                Authorization: `Token ${user?.token}`
            }
        });
        if (apiRes.status === 200) {
            const data = await apiRes.json();
            setConversation(data);
        }
    }
    useEffect(() => {
        fetchConversation();
        fetchUser()
    }, [conversationName, user]);

    const connectionStatus = {
        [ReadyState.CONNECTING]: "Connecting",
        [ReadyState.OPEN]: "Open",
        [ReadyState.CLOSING]: "Closing",
        [ReadyState.CLOSED]: "Closed",
        [ReadyState.UNINSTANTIATED]: "Uninstantiated"
    }[readyState];
    useEffect(() => {
        if (connectionStatus === "Open") {
            sendJsonMessage({
                type: "read_messages"
            });
        }
    }, [connectionStatus, sendJsonMessage]);
    const containerRef = useRef(null);

    useEffect(() => {
        scrollToBottom();
    }, []);

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

    const handleSubmit = () => {
        if (message.length === 0) return;
        if (message.length > 512) return;
        sendJsonMessage({
            type: "chat_message",
            message
        });
        setMessage("");
    };
    const handleKeyPress = (e) => {
        handleSubmit()
    };
    function formatTime(timestamp) {
        const date = new Date(timestamp);
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const formattedTime = `${hours}:${minutes}`;
        return formattedTime
    }
    const fileInputRef = useRef(null);
    const handleFileChange = (e) => {
        const selectedFile = e.target.files[0];

        if (selectedFile) {
            uploadDocument(selectedFile)
        }
    };
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
                    type: "file",
                    file_url
                })
            })
            .catch(error => {
                console.error('API Error:', error);
            });
    }

    async function fetchUser() {
        let name = GetName()
        const res = await fetch(`http://${apiUrl}GetSingleUser/${name}`, {
            headers: {
                Authorization: `Token ${user?.token}`
            },
        });
        const data = await res.json();
        setUserImage(`http://` + apiUrl + data.user_image)
    }
    const handleImageClick = (imageUrl) => {
        window.open(imageUrl, '_blank');
    };
    return (
        <>
            <div className="chat" >
                <div className="chat-header clearfix" style={{ backgroundColor: "whitesmoke", height: '65px' }}>
                    <div className="row">
                        <div className="col-lg-6">
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                            </a>
                            <div className="chat-about" style={{ display: "flex" }}>
                                {/* <Avatar
                                    name={GetName()}
                                    round={true} // Optional: Makes the avatar round
                                    size="30"   // Optional: Set the size of the avatar
                                /> */}
                                <img src={userImage} />

                                &nbsp;&nbsp;
                                <h6 style={{ padding: "5px", textTransform: 'uppercase' }} className="m-b-0">{GetName()}</h6>

                                {
                                    participants.includes(GetName()) ?
                                        <p style={{
                                            position: "abselute",
                                            width: "10px",
                                            height: "10px",
                                            backgroundColor: "rgb(41 122 40)",
                                            borderRadius: "50%",
                                            marginTop: '8%'
                                        }}></p> : ""
                                }

                            </div>
                        </div>
                    </div>
                </div>
                <div className="chat-history" ref={containerRef} style={{
                    height: '70vh',
                    width: '100%',
                    overflow: 'auto',
                    border: '1px solid #C0C0C0',
                    backgroundColor: '#e3e3e3',
                    borderRadius: "30px",
                }}>
                    <ul className="m-b-0">
                        {reverced_messageHistory.map((message, index) => (
                            <li className="clearfix" key={index}>
                                <div>
                                    <div style={{ padding: "5px 20px", wordBreak: "break-word", backgroundColor: message.from_user.username === user.username ? "rgb(133 196 235)" : "#f3f3f3" }} className={message.from_user.username === user.username ? "message other-message float-right" : "message my-message"}>
                                        {message.content == "" ?
                                            <img onClick={() => handleImageClick('http://web-chatapplication.softprodigyphp.in' + message.file)} style={{ height: "150px", cursor: "pointer" }} src={'http://web-chatapplication.softprodigyphp.in/' + message.file} />
                                            :
                                            message.content}

                                        <br />
                                        <span style={{ fontSize: "10px", alignSelf: "flex-end", width: '170px', textAlign: "end" }} className={message.from_user.username === user.username ? "message-data-time float-right" : "message-data-time float-right"}>
                                            <div style={{ display: "flex", float: 'right' }}>
                                                <span style={{ marginLeft: '5px', display: message.from_user.username === user.username ? "block" : "none" }}>✓</span>
                                                <span style={{ marginLeft: '-3px', color: 'green', float: 'right', display: message.read == true && message.from_user.username === user.username ? 'block' : 'none' }}>✓</span>
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