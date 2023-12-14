import React, { useEffect, useRef, useState } from 'react';
import { useParams } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';
import Avatar from 'react-avatar';
import 'emoji-picker-element';
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

    const { conversationName } = useParams();

    function GetName() {
        const fullName = conversationName;

        // Split the string using "__" as the delimiter
        const nameArray = fullName.split("__");

        // Filter out any empty strings resulting from consecutive "__" occurrences
        const filteredNameArray = nameArray.filter(part => part.trim() !== "");

        // Log the result
        console.log(filteredNameArray, 'test')
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
                    // updateTyping(data);
                    break;

                default:
                    console.error("Unknown message type!");
                    break;
            }
        }
    });



    useEffect(() => {
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

    function handleChangeMessage(e) {
        setMessage(e.target.value);
        // onType();
    }
    const containerRef = useRef(null)


    useEffect(() => {
        // Get the height of the container
        console.log(messageHistory)
        const containerHeight = containerRef.current.scrollHeight;
        containerRef.current.scrollTo({
            top: containerHeight,
            behavior: 'smooth', // You can use 'auto' for instant scrolling
        });
    }, [messageHistory])
    const handleSubmit = () => {
        if (message.length === 0) return;
        if (message.length > 512) return;
        sendJsonMessage({
            type: "chat_message",
            message
        });
        setMessage("");


    };
    const listMessage = messageHistory.map((message) =>
        <h1>{message.content}</h1>
    )

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
    function handleOnEnter(message) {
        console.log('enter', message)
    }
    return (
        <>
            <div className="chat" >
                <div className="chat-header clearfix" style={{ backgroundColor: "whitesmoke" }}>
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
                                <h6 style={{ padding: "5px" }} className="m-b-0">{GetName()}</h6>
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
                    // overflow:"hidden"
                }}>
                    <ul className="m-b-0">
                        {reverced_messageHistory.map((message) => (
                            <li className="clearfix">
                                <div>
                                    <div style={{ padding: "5px 20px", backgroundColor: message.from_user.username === user.username ? "#bcedb4" : "#f3f3f3;" }} className={message.from_user.username === user.username ? "message other-message float-right" : "message my-message"}>
                                        {message.content}
                                        <br />
                                        <span style={{ fontSize: "10px", alignSelf: "flex-end", width: '170px', textAlign: "end" }} className={message.from_user.username === user.username ? "message-data-time float-right" : "message-data-time float-right"}>
                                            {formatTime(message.timestamp)}
                                            <span style={{ marginLeft: '5px', color: 'green', float: 'right', display: message.read == true && message.from_user.username === user.username ? 'block' : 'none' }}>✓✓</span>
                                        </span>
                                    </div>
                                </div>
                            </li>
                        ))}
                    </ul>
                </div>
                <div className="chat-message clearfix" style={{ backgroundColor: '#e5e5e5' }}>
                    <div className="input-group mb-0">
                        {/* <ReactQuill
                            style={{ width: '100%' }}
                            theme="snow"
                            defaultValue={message}
                            onChange={handleQuillChange}
                            onKeyPress={ha
                                ndleKeyPress}
                        /> */}
                        <InputEmoji
                            cleanOnEnter
                            onChange={setMessage}
                            onEnter={handleKeyPress} value={message} type="text" className="form-control" placeholder="Enter text here..."
                        />
                        {/* <input onKeyPress={handleKeyPress} value={message} onChange={(e) => setMessage(e.target.value)} type="text" className="form-control" placeholder="Enter text here..." /> */}
                        {/* <emoji-picker></emoji-picker> */}

                        <div className="input-group-prepend" >
                            <span className="input-group-text" style={{ backgroundColor: "rgb(88 143 80)", marginTop:'6px' }} onClick={() => { handleSubmit() }}>
                                <i className="fa fa-send"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}