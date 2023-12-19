import React, { useEffect, useRef, useState } from 'react';
import { useLocation, useParams } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';
import Avatar from 'react-avatar';
import InputEmoji from 'react-input-emoji'

export const ChatComponent = () => {

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
    useEffect(() => {

        console.log(reverced_messageHistory, "message history")
    }, [reverced_messageHistory])

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
            console.log(data, 'websocket triggered')
            switch (data.type) {
                case "welcome_message":
                    setWelcomeMessage(data.message);
                    break;
                case 'file':
                    console.log("file event triggered onMessage")
                    const fileUrlOrIdentifier = data.file_url_or_identifier;
                    break;
                case "chat_message_echo":
                    setMessageHistory((prev) => [data.message, ...prev]);
                    sendJsonMessage({ type: "read_messages" });
                    break;
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
        console.log(reverced_messageHistory[0], "message")
        let sample_message = messageHistory[0]
        const apiEndpoint = 'http://127.0.0.1:8000/documentUpload/';

        let path = location.pathname
        var convo = path.substring(6)
        const form_Data = new FormData()
        form_Data.append("image", fileName)
        form_Data.append("convo", convo)
        form_Data.append("from_user", sample_message.from_user.username)
        form_Data.append("to_user", sample_message.to_user.username)

        await fetch(apiEndpoint, {
            method: 'PUT',
            body: form_Data

        })
            .then(response => response.json())
            .then(data => {
                let file_url = data.response[0].file
                sendJsonMessage({
                    type: "file",
                    file_url
                })
            })
            .catch(error => {
                console.error('API Error:', error);
            });
    }

    return (
        <>
            <div className="chat" >
                <div className="chat-header clearfix" style={{ backgroundColor: "whitesmoke", height: '65px' }}>
                    <div className="row">
                        <div className="col-lg-6">
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                            </a>
                            <div className="chat-about" style={{ display: "flex" }}>
                                <Avatar
                                    name={GetName()}
                                    round={true} // Optional: Makes the avatar round
                                    size="30"   // Optional: Set the size of the avatar
                                />&nbsp;&nbsp;
                                <h6 style={{ padding: "5px", textTransform: 'uppercase' }} className="m-b-0">{GetName()}</h6>
                                {
                                    participants.includes(GetName()) ?
                                        <p style={{ color: 'green', fontSize: '11px' }}>active</p> : ""
                                }

                            </div>
                        </div>
                    </div>
                </div>
                {/* <p style={{ display: loading ? 'block' : 'none' }}>loading...</p> */}
                <div className="chat-history" ref={containerRef} style={{
                    height: '70vh',
                    width: '100%',
                    overflow: 'auto',
                    border: '1px solid #C0C0C0',
                    backgroundColor: '#e3e3e3',
                    // display: loading ? "none" : 'block'
                }}>
                    <ul className="m-b-0">
                        {reverced_messageHistory.map((message, index) => (
                            <li className="clearfix" key={index}>
                                <div>
                                    <div style={{ padding: "5px 20px", backgroundColor: message.from_user.username === user.username ? "rgb(133 196 235)" : "#f3f3f3" }} className={message.from_user.username === user.username ? "message other-message float-right" : "message my-message"}>
                                        {message.content == "" ?

                                            // <a href={'http://127.0.0.1:8000'+message.file} target="_blank" rel="noopener noreferrer">
                                            //     View Document
                                            // </a>
                                            <img style={{ height: "150px" }} src={'http://127.0.0.1:8000' + message.file} />
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


                <div className="input-group mb-0">
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
                    />
                    <div className="input-group-prepend" style={{ padding: '2px' }}>
                        <span
                            className="input-group-text rounded-circle"
                            style={{
                                backgroundColor: "white",
                                marginTop: '6px',
                                cursor: 'pointer',
                                border: 'none',
                            }}
                            onClick={() => {
                                fileInputRef.current.click();
                            }}
                        >
                            <i className="fa fa-paperclip" style={{ color: '#555' }}></i> {/* Adjust the color of the paperclip icon */}
                        </span>
                    </div>

                    <div className="input-group-prepend" style={{ padding: '2px' }}>
                        <span
                            className="input-group-text rounded-circle"  // Add the rounded-circle class
                            style={{ backgroundColor: "rgb(87 145 255)", marginTop: '6px', cursor: 'pointer' }}
                            onClick={() => { handleSubmit() }}
                        >
                            <i className="fa fa-send"></i>
                        </span>
                    </div>
                </div>
            </div>
        </>
    )
}