import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import useWebSocket, { ReadyState } from "react-use-websocket";
import AuthService from '../auth/AuthService';
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

    const { readyState, sendJsonMessage } = useWebSocket(user ? `ws://127.0.0.1:8000/chats/${conversationName}/` : null, {
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
            console.log('message sent', data)
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
            console.log(user)
            const apiRes = await fetch(`http://127.0.0.1:8000/conversations/${conversationName}/`, {
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

    const handleSubmit = () => {
        sendJsonMessage({
            type: "chat_message",
            message
        });
        setMessage("");

    };
    function test() {
        console.log(messageHistory, 33333)
    }
    const listMessage = messageHistory.map((message) =>
        <h1>{message.content}</h1>
    )
    function convertTimestampToHHMM(timestamp) {
        const date = new Date(timestamp);

        const hours = date.getUTCHours();
        const minutes = date.getUTCMinutes();

        // Format the hours and minutes with leading zeros if needed
        const formattedHours = hours < 10 ? '0' + hours : hours;
        const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;

        return `${formattedHours}:${formattedMinutes}`;
    }

    return (
        <>
            <div className="chat">
                {/* <button onClick={() => test()}>Test</button> */}
                <div className="chat-header clearfix">
                    <div className="row">
                        <div className="col-lg-6">
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar" />
                            </a>
                            <div className="chat-about">
                                <h6 className="m-b-0">{user.username}</h6>
                                {/* <small>Last seen: 2 hours ago</small> */}
                            </div>
                        </div>
                        {/* <div className="col-lg-6 hidden-sm text-right">
                            <a href="javascript:void(0);" className="btn btn-outline-secondary"><i className="fa fa-camera"></i></a>
                            <a href="javascript:void(0);" className="btn btn-outline-primary"><i className="fa fa-image"></i></a>
                            <a href="javascript:void(0);" className="btn btn-outline-info"><i className="fa fa-cogs"></i></a>
                            <a href="javascript:void(0);" className="btn btn-outline-warning"><i className="fa fa-question"></i></a>
                        </div> */}
                    </div>
                </div>
                <div className="chat-history">
                    <ul className="m-b-0">
                        {reverced_messageHistory.map((message) => (
                            <li className="clearfix">
                                <div className={message.from_user.username == user.username ? "message-data text-right" : "message-data"}>
                                    {/* <span className="message-data-time">{convertTimestampToHHMM(message.timestamp)}</span> */}
                                    {/* <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar" /> */}
                                </div>
                                <div className={message.from_user.username == user.username ? "message other-message float-right" : "message my-message"}   > {message.content}<br></br>

                                </div>
                            </li>
                        ))}

                        {/* <li className="clearfix">
                            <div className="message-data text-right">
                                <span className="message-data-time">10:10 AM, Today</span>
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar" />
                            </div>
                            <div className="message other-message float-right"> Hi Aiden, how are you? How is the project coming along? </div>
                        </li>
                        <li className="clearfix">
                            <div className="message-data">
                                <span className="message-data-time">10:12 AM, Today</span>
                            </div>
                            <div className="message my-message">Are we meeting today?</div>
                        </li>
                        <li className="clearfix">
                            <div className="message-data">
                                <span className="message-data-time">10:15 AM, Today</span>
                            </div>
                            <div className="message my-message">Project has been already finished and I have results to show you.</div>
                        </li> */}
                    </ul>
                </div>
                <div className="chat-message clearfix">
                    <div className="input-group mb-0">
                        <div className="input-group-prepend">
                            <span className="input-group-text" onClick={() => { handleSubmit() }}><i className="fa fa-send"></i></span>
                        </div>
                        <input value={message} onChange={(e) => setMessage(e.target.value)} type="text" className="form-control" placeholder="Enter text here..." />
                    </div>
                </div>
            </div>
        </>
    )
}